From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Wed, 23 Dec 2009 03:35:57 -0500
Subject: [PATCH 1/2] gpio add interrupt support on pca953x
In-Reply-To: <20091222205947.39a1f53d@taxman.wild-wind.fr.eu.org>
References: <771cded00912220429k141600c7yffc7d3955f220934@mail.gmail.com>
	<f17812d70912220541g33cdfcffs6b2e51af805ae7b9@mail.gmail.com>
	<20091222205947.39a1f53d@taxman.wild-wind.fr.eu.org>
Message-ID: <771cded00912230035j2b8b0da3p323e704ea93cc3d@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 22, 2009 at 2:59 PM, Marc Zyngier <maz@misterjones.org> wrote:
> On Tue, 22 Dec 2009 21:41:51 +0800
> Eric Miao <eric.y.miao@gmail.com> wrote:
>
> Eric, Haojian,
>
>> Marc Zyngier was doing the similar thing, and submitted a patch to
>> Andrew Morton already, but I prefer a full-functional IRQ chip based
>> solution, so you may want to work with him together on this.
>>
>> Marc,
>>
>> Do you have the link to your patch?
>
> Here's the current state of my tree, quickly rebased to 2.6.33-rc1.
> To summarize, the main differences with Haojian's patch:
> - uses threaded irqs/nested irqs
> - setup is slightly more complicated (interrupt source mask and base
> ?interrupt number), but more correct (no dependency on gpio_to_irq()
> ?being a linear mapping, which is not always the case)
>
> From d8dc00d1ebedcc889c41add70cceb8f15f106261 Mon Sep 17 00:00:00 2001
> From: Marc Zyngier <maz@misterjones.org>
> Date: Tue, 22 Dec 2009 17:38:29 +0100
> Subject: [PATCH] Add interrupt handling capability to pca953x.
>
> Most of the GPIO expanders controlled by the pca953x driver are
> able to report changes on the input pins through an *INT pin.
>
> This patch implements the irq_chip functionality (edge detection
> only).
>
> The driver has been tested on an Arcom Zeus.
>
> Signed-off-by: Marc Zyngier <maz@misterjones.org>
> ---
> ?drivers/gpio/pca953x.c ? ? ?| ?207 ++++++++++++++++++++++++++++++++++++++++---
> ?include/linux/i2c/pca953x.h | ? ?5 +
> ?2 files changed, 199 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/gpio/pca953x.c b/drivers/gpio/pca953x.c
> index 6a2fb3f..06c34a0 100644
> --- a/drivers/gpio/pca953x.c
> +++ b/drivers/gpio/pca953x.c
> @@ -14,6 +14,8 @@
> ?#include <linux/module.h>
> ?#include <linux/init.h>
> ?#include <linux/gpio.h>
> +#include <linux/interrupt.h>
> +#include <linux/irq.h>
> ?#include <linux/i2c.h>
> ?#include <linux/i2c/pca953x.h>
> ?#ifdef CONFIG_OF_GPIO
> @@ -26,23 +28,28 @@
> ?#define PCA953X_INVERT ? ? ? ? 2
> ?#define PCA953X_DIRECTION ? ? ?3
>
> +#define PCA953X_GPIOS ? ? ? ? 0x00FF
> +#define PCA953X_INT ? ? ? ? ? 0x0100
> +
> ?static const struct i2c_device_id pca953x_id[] = {
> - ? ? ? { "pca9534", 8, },
> - ? ? ? { "pca9535", 16, },
> + ? ? ? { "pca9534", 8 ?| PCA953X_INT, },
> + ? ? ? { "pca9535", 16 | PCA953X_INT, },
> ? ? ? ?{ "pca9536", 4, },
> - ? ? ? { "pca9537", 4, },
> - ? ? ? { "pca9538", 8, },
> - ? ? ? { "pca9539", 16, },
> - ? ? ? { "pca9554", 8, },
> - ? ? ? { "pca9555", 16, },
> + ? ? ? { "pca9537", 4 ?| PCA953X_INT, },
> + ? ? ? { "pca9538", 8 ?| PCA953X_INT, },
> + ? ? ? { "pca9539", 16 | PCA953X_INT, },
> + ? ? ? { "pca9554", 8 ?| PCA953X_INT, },
> + ? ? ? { "pca9555", 16 | PCA953X_INT, },
> ? ? ? ?{ "pca9556", 8, },
> ? ? ? ?{ "pca9557", 8, },
>
> ? ? ? ?{ "max7310", 8, },
> - ? ? ? { "max7315", 8, },
> - ? ? ? { "pca6107", 8, },
> - ? ? ? { "tca6408", 8, },
> - ? ? ? { "tca6416", 16, },
> + ? ? ? { "max7312", 16 | PCA953X_INT, },
> + ? ? ? { "max7313", 16 | PCA953X_INT, },
> + ? ? ? { "max7315", 8 ?| PCA953X_INT, },
> + ? ? ? { "pca6107", 8 ?| PCA953X_INT, },
> + ? ? ? { "tca6408", 8 ?| PCA953X_INT, },
> + ? ? ? { "tca6416", 16 | PCA953X_INT, },
> ? ? ? ?/* NYET: ?{ "tca6424", 24, }, */
> ? ? ? ?{ }
> ?};
> @@ -53,6 +60,15 @@ struct pca953x_chip {
> ? ? ? ?uint16_t reg_output;
> ? ? ? ?uint16_t reg_direction;
>
> + ? ? ? struct mutex irq_lock;
> + ? ? ? uint16_t irq_interrupt;
> + ? ? ? uint16_t irq_mask;
> + ? ? ? uint16_t irq_stat;
> + ? ? ? uint16_t irq_trig_raise;
> + ? ? ? uint16_t irq_trig_fall;
> +
> + ? ? ? int ? ? ?irq_base;
> +
> ? ? ? ?struct i2c_client *client;
> ? ? ? ?struct pca953x_platform_data *dyn_pdata;
> ? ? ? ?struct gpio_chip gpio_chip;
> @@ -202,6 +218,121 @@ static void pca953x_setup_gpio(struct pca953x_chip *chip, int gpios)
> ? ? ? ?gc->names = chip->names;
> ?}
>
> +static int pca953x_gpio_to_irq(struct gpio_chip *gc, unsigned off)
> +{
> + ? ? ? struct pca953x_chip *chip;
> +
> + ? ? ? chip = container_of(gc, struct pca953x_chip, gpio_chip);
> + ? ? ? if (chip->irq_interrupt & (1 << off))
> + ? ? ? ? ? ? ? return chip->irq_base + off;
> +
> + ? ? ? return -ENXIO;
> +}
> +
> +static void pca953x_irq_mask(unsigned int irq)
> +{
> + ? ? ? struct pca953x_chip *chip = get_irq_chip_data(irq);
> +
> + ? ? ? chip->irq_mask &= ~(1 << (irq - chip->irq_base));
> +}
> +
> +static void pca953x_irq_unmask(unsigned int irq)
> +{
> + ? ? ? struct pca953x_chip *chip = get_irq_chip_data(irq);
> +
> + ? ? ? chip->irq_mask |= 1 << (irq - chip->irq_base);
> +}
> +
> +static void pca953x_irq_bus_lock(unsigned int irq)
> +{
> + ? ? ? struct pca953x_chip *chip = get_irq_chip_data(irq);
> +
> + ? ? ? mutex_lock(&chip->irq_lock);
> +}
> +
> +static void pca953x_irq_bus_sync_unlock(unsigned int irq)
> +{
> + ? ? ? struct pca953x_chip *chip = get_irq_chip_data(irq);
> +
> + ? ? ? mutex_unlock(&chip->irq_lock);
> +}
> +
> +static int pca953x_irq_set_type(unsigned int irq, unsigned int type)
> +{
> + ? ? ? struct pca953x_chip *chip = get_irq_chip_data(irq);
> + ? ? ? uint16_t mask = 1 << (irq - chip->irq_base);
> +
> + ? ? ? if (!(type & IRQ_TYPE_EDGE_BOTH)) {
> + ? ? ? ? ? ? ? dev_err(&chip->client->dev, "unsupported irq type %d\n", type);
> + ? ? ? ? ? ? ? return -EINVAL;
> + ? ? ? }
> +
> + ? ? ? if (type & IRQ_TYPE_EDGE_FALLING)
> + ? ? ? ? ? ? ? chip->irq_trig_fall |= mask;
> + ? ? ? else
> + ? ? ? ? ? ? ? chip->irq_trig_fall &= ~mask;
> +
> + ? ? ? if (type & IRQ_TYPE_EDGE_RISING)
> + ? ? ? ? ? ? ? chip->irq_trig_raise |= mask;
> + ? ? ? else
> + ? ? ? ? ? ? ? chip->irq_trig_raise &= ~mask;
> +
> + ? ? ? return 0;
> +}
> +
> +static struct irq_chip pca953x_irq_chip = {
> + ? ? ? .name ? ? ? ? ? ? ? ? ? = "pca953x",
> + ? ? ? .mask ? ? ? ? ? ? ? ? ? = pca953x_irq_mask,
> + ? ? ? .unmask ? ? ? ? ? ? ? ? = pca953x_irq_unmask,
> + ? ? ? .bus_lock ? ? ? ? ? ? ? = pca953x_irq_bus_lock,
> + ? ? ? .bus_sync_unlock ? ? ? ?= pca953x_irq_bus_sync_unlock,
> + ? ? ? .set_type ? ? ? ? ? ? ? = pca953x_irq_set_type,
> +};
> +
> +static irqreturn_t pca953x_irq_handler(int irq, void *devid)
> +{
> + ? ? ? struct pca953x_chip *chip = devid;
> + ? ? ? uint16_t cur_stat;
> + ? ? ? uint16_t old_stat;
> + ? ? ? uint16_t pending;
> + ? ? ? int ret;
> +
> + ? ? ? ret = pca953x_read_reg(chip, PCA953X_INPUT, &cur_stat);
> + ? ? ? if (ret)
> + ? ? ? ? ? ? ? return IRQ_HANDLED;
> +
> + ? ? ? cur_stat &= (chip->irq_interrupt & chip->reg_direction);
> + ? ? ? old_stat = chip->irq_stat;
> + ? ? ? pending = (cur_stat ^ old_stat) & chip->irq_mask;
> +
> + ? ? ? if (!pending)
> + ? ? ? ? ? ? ? return IRQ_HANDLED;
> +
> + ? ? ? chip->irq_stat = cur_stat;
> +
> + ? ? ? do {
> + ? ? ? ? ? ? ? uint16_t level;
> + ? ? ? ? ? ? ? uint16_t level_mask;
> + ? ? ? ? ? ? ? int trigger = 0;
> +
> + ? ? ? ? ? ? ? level = __ffs(pending);
> + ? ? ? ? ? ? ? level_mask = 1 << level;
> +
> + ? ? ? ? ? ? ? if (old_stat & level_mask & chip->irq_trig_fall)
> + ? ? ? ? ? ? ? ? ? ? ? trigger = 1;
> +
> + ? ? ? ? ? ? ? if (cur_stat & level_mask & chip->irq_trig_raise)
> + ? ? ? ? ? ? ? ? ? ? ? trigger = 1;
> +
> + ? ? ? ? ? ? ? if (trigger)
> + ? ? ? ? ? ? ? ? ? ? ? handle_nested_irq(level + chip->irq_base);

I suggest not to use handle_nested_irq(). I think that we can use
generic_handle_irq() instead. The illustration is in below.

> +
> + ? ? ? ? ? ? ? pending &= ~level_mask;
> + ? ? ? } while (pending);
> +
> + ? ? ? return IRQ_HANDLED;
> +}
> +
> ?/*
> ?* Handlers for alternative sources of platform_data
> ?*/
> @@ -286,7 +417,7 @@ static int __devinit pca953x_probe(struct i2c_client *client,
> ? ? ? ?/* initialize cached registers from their original values.
> ? ? ? ? * we can't share this chip with another i2c master.
> ? ? ? ? */
> - ? ? ? pca953x_setup_gpio(chip, id->driver_data);
> + ? ? ? pca953x_setup_gpio(chip, id->driver_data & PCA953X_GPIOS);
>
> ? ? ? ?ret = pca953x_read_reg(chip, PCA953X_OUTPUT, &chip->reg_output);
> ? ? ? ?if (ret)
> @@ -301,10 +432,57 @@ static int __devinit pca953x_probe(struct i2c_client *client,
> ? ? ? ?if (ret)
> ? ? ? ? ? ? ? ?goto out_failed;
>
> + ? ? ? if (pdata->interrupt && (id->driver_data & PCA953X_INT)) {
> + ? ? ? ? ? ? ? int lvl;
> +
> + ? ? ? ? ? ? ? ret = pca953x_read_reg(chip, PCA953X_INPUT,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?&chip->irq_stat);
> + ? ? ? ? ? ? ? if (ret)
> + ? ? ? ? ? ? ? ? ? ? ? goto out_failed;
> +
> + ? ? ? ? ? ? ? /*
> + ? ? ? ? ? ? ? ?* There is no way to know which GPIO line generated the
> + ? ? ? ? ? ? ? ?* interrupt. ?We have to rely on the previous read for
> + ? ? ? ? ? ? ? ?* this purpose.
> + ? ? ? ? ? ? ? ?*/
> + ? ? ? ? ? ? ? chip->irq_stat &= chip->irq_interrupt & chip->reg_direction;

chip->irq_interrupt isn't assigned in probe function. It only results
chip->irq_stat is always zero. The IRQ event is got from comparing
between previous state and current state of input value. So it would
trigger unpected IRQ event on another input pin if one input pin
asserts IRQ.

> + ? ? ? ? ? ? ? chip->irq_interrupt = pdata->interrupt;

I think that pdata->interrupt or chip->irq_interrupt is unnecessary.
chip->irq_trigger_fall and chip->irq_trigger_rise is already enough.

> + ? ? ? ? ? ? ? chip->irq_base = pdata->irq_base;
> + ? ? ? ? ? ? ? mutex_init(&chip->irq_lock);
> +
> + ? ? ? ? ? ? ? /* FIXME: Error handling? */
> + ? ? ? ? ? ? ? for (lvl = 0; lvl < chip->gpio_chip.ngpio; lvl++) {
> + ? ? ? ? ? ? ? ? ? ? ? if (chip->irq_interrupt & (1 << lvl)) {
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? int irq = lvl + chip->irq_base;
> +
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? set_irq_chip_data(irq, chip);
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? set_irq_chip_and_handler(irq, &pca953x_irq_chip,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?handle_edge_irq);
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? set_irq_nested_thread(irq, 1);

set_irq_nested_thread(irq, 1) will only mark IRQ_NESTED_THREAD on irq
descriptor. It results that driver have to invoke request_thread_irq()
with thread_fn parameter to declare IRQ. Device could be linked to
GPIO directly or GPIO expander. We should keep to use request_irq()
for compatible. set_irq_nested_thread() shouldn't use at here.

> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? set_irq_flags(irq, IRQF_VALID);
> + ? ? ? ? ? ? ? ? ? ? ? }
> + ? ? ? ? ? ? ? }
> +
> + ? ? ? ? ? ? ? ret = request_threaded_irq(client->irq,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?NULL,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?pca953x_irq_handler,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?dev_name(&client->dev), chip);
> + ? ? ? ? ? ? ? if (ret) {
> + ? ? ? ? ? ? ? ? ? ? ? dev_err(&client->dev, "failed to request irq %d\n",
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? client->irq);
> + ? ? ? ? ? ? ? ? ? ? ? goto out_failed;
> + ? ? ? ? ? ? ? }
> +
> + ? ? ? ? ? ? ? chip->gpio_chip.to_irq = pca953x_gpio_to_irq;
> + ? ? ? }
>
> ? ? ? ?ret = gpiochip_add(&chip->gpio_chip);
> - ? ? ? if (ret)
> + ? ? ? if (ret) {
> + ? ? ? ? ? ? ? if (pdata->interrupt)
> + ? ? ? ? ? ? ? ? ? ? ? free_irq(client->irq, chip);
> ? ? ? ? ? ? ? ?goto out_failed;
> + ? ? ? }
>
> ? ? ? ?if (pdata->setup) {
> ? ? ? ? ? ? ? ?ret = pdata->setup(client, chip->gpio_chip.base,
> @@ -345,6 +523,9 @@ static int pca953x_remove(struct i2c_client *client)
> ? ? ? ? ? ? ? ?return ret;
> ? ? ? ?}
>
> + ? ? ? if (chip->irq_interrupt)
> + ? ? ? ? ? ? ? free_irq(client->irq, chip);
> +
> ? ? ? ?kfree(chip->dyn_pdata);
> ? ? ? ?kfree(chip);
> ? ? ? ?return 0;
> diff --git a/include/linux/i2c/pca953x.h b/include/linux/i2c/pca953x.h
> index 81736d6..6a2c8a6 100644
> --- a/include/linux/i2c/pca953x.h
> +++ b/include/linux/i2c/pca953x.h
> @@ -7,6 +7,11 @@ struct pca953x_platform_data {
> ? ? ? ?/* initial polarity inversion setting */
> ? ? ? ?uint16_t ? ? ? ?invert;
>
> + ? ? ? /* input bitmask to trigger the interrupt */
> + ? ? ? uint16_t ? ? ? ?interrupt;

interrupt field is unnecessary to the driver.
> +
> + ? ? ? int ? ? ? ? ? ? irq_base;
> +
> ? ? ? ?void ? ? ? ? ? ?*context; ? ? ? /* param to setup/teardown */
>
> ? ? ? ?int ? ? ? ? ? ? (*setup)(struct i2c_client *client,
> --
> 1.6.0.4
>
>
> --
> I'm the slime oozin' out from your TV set...
>

Hi Marc,

I appended my comments.

Thanks
Haojian
