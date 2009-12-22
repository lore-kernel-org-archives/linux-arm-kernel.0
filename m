From: eric.y.miao@gmail.com (Eric Miao)
Date: Tue, 22 Dec 2009 21:41:51 +0800
Subject: [PATCH 1/2] gpio add interrupt support on pca953x
In-Reply-To: <771cded00912220429k141600c7yffc7d3955f220934@mail.gmail.com>
References: <771cded00912220429k141600c7yffc7d3955f220934@mail.gmail.com>
Message-ID: <f17812d70912220541g33cdfcffs6b2e51af805ae7b9@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Haojian,

Marc Zyngier was doing the similar thing, and submitted a patch to
Andrew Morton already, but I prefer a full-functional IRQ chip based
solution, so you may want to work with him together on this.

Marc,

Do you have the link to your patch?

- eric

On Tue, Dec 22, 2009 at 8:29 PM, Haojian Zhuang
<haojian.zhuang@gmail.com> wrote:
> From b8cc5f82ae9a1883ee4d6fa453bed63d4431b9e4 Mon Sep 17 00:00:00 2001
> From: Haojian Zhuang <haojian.zhuang@marvell.com>
> Date: Tue, 22 Dec 2009 15:08:41 -0500
> Subject: [PATCH] gpio: add interrupt support on pca953x
>
> Support interrupt on pca953x gpio expander.
>
> Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
> ---
> ?drivers/gpio/pca953x.c | ?121 +++++++++++++++++++++++++++++++++++++++++++++++-
> ?1 files changed, 119 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpio/pca953x.c b/drivers/gpio/pca953x.c
> index 6a2fb3f..2d6b9e8 100644
> --- a/drivers/gpio/pca953x.c
> +++ b/drivers/gpio/pca953x.c
> @@ -16,6 +16,7 @@
> ?#include <linux/gpio.h>
> ?#include <linux/i2c.h>
> ?#include <linux/i2c/pca953x.h>
> +#include <linux/irq.h>
> ?#ifdef CONFIG_OF_GPIO
> ?#include <linux/of_platform.h>
> ?#include <linux/of_gpio.h>
> @@ -50,12 +51,19 @@ MODULE_DEVICE_TABLE(i2c, pca953x_id);
>
> ?struct pca953x_chip {
> ? ? ? ?unsigned gpio_start;
> + ? ? ? unsigned irq_start;
> ? ? ? ?uint16_t reg_output;
> ? ? ? ?uint16_t reg_direction;
> + ? ? ? uint16_t irq_mask;
> + ? ? ? uint16_t irq_falling_edge;
> + ? ? ? uint16_t irq_rising_edge;
> + ? ? ? uint16_t last_input;
>
> - ? ? ? struct i2c_client *client;
> ? ? ? ?struct pca953x_platform_data *dyn_pdata;
> - ? ? ? struct gpio_chip gpio_chip;
> + ? ? ? struct i2c_client ? ? ? *client;
> + ? ? ? struct gpio_chip ? ? ? ?gpio_chip;
> + ? ? ? struct mutex ? ? ? ? ? ?irq_lock;
> + ? ? ? struct work_struct ? ? ?irq_work;
> ? ? ? ?char **names;
> ?};
>
> @@ -250,11 +258,113 @@ pca953x_get_alt_pdata(struct i2c_client *client)
> ?}
> ?#endif
>
> +#define PCA953X_NUM_IRQ ? ? ? ? ? ? ? ? ? ? ? ?16
> +
> +static void pca953x_irq_work(struct work_struct *work)
> +{
> + ? ? ? DECLARE_BITMAP(rising, PCA953X_NUM_IRQ);
> + ? ? ? DECLARE_BITMAP(falling, PCA953X_NUM_IRQ);
> + ? ? ? struct pca953x_chip *chip;
> + ? ? ? unsigned short input, mask;
> + ? ? ? int ret, irq;
> +
> + ? ? ? chip = container_of(work, struct pca953x_chip, irq_work);
> + ? ? ? ret = pca953x_read_reg(chip, PCA953X_INPUT, &input);
> + ? ? ? if (ret < 0)
> + ? ? ? ? ? ? ? return;
> +
> + ? ? ? mutex_lock(&chip->irq_lock);
> + ? ? ? mask = (input ^ chip->last_input) & chip->irq_mask;
> + ? ? ? rising[0] = (input & mask) & chip->irq_rising_edge;
> + ? ? ? falling[0] = (~input & mask) & chip->irq_falling_edge;
> +
> + ? ? ? while (!bitmap_empty(rising, PCA953X_NUM_IRQ)) {
> + ? ? ? ? ? ? ? irq = find_first_bit(rising, PCA953X_NUM_IRQ);
> + ? ? ? ? ? ? ? clear_bit(irq, rising);
> + ? ? ? ? ? ? ? generic_handle_irq(chip->irq_start + irq);
> + ? ? ? }
> + ? ? ? while (!bitmap_empty(falling, PCA953X_NUM_IRQ)) {
> + ? ? ? ? ? ? ? irq = find_first_bit(falling, PCA953X_NUM_IRQ);
> + ? ? ? ? ? ? ? clear_bit(irq, falling);
> + ? ? ? ? ? ? ? generic_handle_irq(chip->irq_start + irq);
> + ? ? ? }
> + ? ? ? chip->last_input = input;
> + ? ? ? mutex_unlock(&chip->irq_lock);
> +}
> +
> +static void pca953x_irq_handler(unsigned int irq, struct irq_desc *desc)
> +{
> + ? ? ? struct pca953x_chip *chip = desc->handler_data;
> +
> + ? ? ? desc->chip->ack(irq);
> + ? ? ? schedule_work(&chip->irq_work);
> +}
> +
> +static void pca953x_irq_enable(unsigned int irq)
> +{
> + ? ? ? struct pca953x_chip *chip = get_irq_chip_data(irq);
> +
> + ? ? ? chip->irq_mask |= 1u << (irq - chip->irq_start);
> +}
> +
> +static void pca953x_irq_disable(unsigned int irq)
> +{
> + ? ? ? struct pca953x_chip *chip = get_irq_chip_data(irq);
> +
> + ? ? ? chip->irq_mask &= ~(1u << (irq - chip->irq_start));
> +}
> +
> +static int pca953x_irq_type(unsigned int irq, unsigned int trigger)
> +{
> + ? ? ? struct pca953x_chip *chip = get_irq_chip_data(irq);
> + ? ? ? unsigned short mask = 1u << (irq - chip->irq_start);
> +
> + ? ? ? if (trigger & IRQ_TYPE_EDGE_RISING)
> + ? ? ? ? ? ? ? chip->irq_rising_edge |= mask;
> + ? ? ? else
> + ? ? ? ? ? ? ? chip->irq_rising_edge &= ~mask;
> + ? ? ? if (trigger & IRQ_TYPE_EDGE_FALLING)
> + ? ? ? ? ? ? ? chip->irq_falling_edge |= mask;
> + ? ? ? else
> + ? ? ? ? ? ? ? chip->irq_falling_edge &= ~mask;
> + ? ? ? return 0;
> +}
> +
> +static struct irq_chip pca953x_irqchip = {
> + ? ? ? .name ? ? ? ? ? = "GPIO",
> + ? ? ? .enable ? ? ? ? = pca953x_irq_enable,
> + ? ? ? .disable ? ? ? ?= pca953x_irq_disable,
> + ? ? ? .set_type ? ? ? = pca953x_irq_type,
> +};
> +
> +static void pca953x_setup_irq(struct i2c_client *client)
> +{
> + ? ? ? struct pca953x_chip *chip = i2c_get_clientdata(client);
> + ? ? ? int i;
> +
> + ? ? ? if (!client->irq)
> + ? ? ? ? ? ? ? return;
> +
> + ? ? ? mutex_init(&chip->irq_lock);
> + ? ? ? chip->irq_start = gpio_to_irq(chip->gpio_start);
> + ? ? ? for (i = 0; i < chip->gpio_chip.ngpio; i++) {
> + ? ? ? ? ? ? ? set_irq_chip(chip->irq_start + i, &pca953x_irqchip);
> + ? ? ? ? ? ? ? set_irq_chip_data(chip->irq_start + i, chip);
> + ? ? ? ? ? ? ? set_irq_handler(chip->irq_start + i, handle_edge_irq);
> + ? ? ? ? ? ? ? set_irq_flags(chip->irq_start + i, IRQF_VALID);
> + ? ? ? }
> + ? ? ? set_irq_type(client->irq, IRQ_TYPE_EDGE_FALLING);
> + ? ? ? set_irq_data(client->irq, chip);
> + ? ? ? set_irq_chained_handler(client->irq, pca953x_irq_handler);
> + ? ? ? INIT_WORK(&chip->irq_work, pca953x_irq_work);
> +}
> +
> ?static int __devinit pca953x_probe(struct i2c_client *client,
> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? const struct i2c_device_id *id)
> ?{
> ? ? ? ?struct pca953x_platform_data *pdata;
> ? ? ? ?struct pca953x_chip *chip;
> + ? ? ? unsigned short input;
> ? ? ? ?int ret;
>
> ? ? ? ?chip = kzalloc(sizeof(struct pca953x_chip), GFP_KERNEL);
> @@ -282,12 +392,18 @@ static int __devinit pca953x_probe(struct
> i2c_client *client,
> ? ? ? ?chip->gpio_start = pdata->gpio_base;
>
> ? ? ? ?chip->names = pdata->names;
> + ? ? ? chip->irq_mask = -1UL;
>
> ? ? ? ?/* initialize cached registers from their original values.
> ? ? ? ? * we can't share this chip with another i2c master.
> ? ? ? ? */
> ? ? ? ?pca953x_setup_gpio(chip, id->driver_data);
>
> + ? ? ? /* clear interrupt status */
> + ? ? ? ret = pca953x_read_reg(chip, PCA953X_INPUT, &input);
> + ? ? ? if (ret)
> + ? ? ? ? ? ? ? goto out_failed;
> +
> ? ? ? ?ret = pca953x_read_reg(chip, PCA953X_OUTPUT, &chip->reg_output);
> ? ? ? ?if (ret)
> ? ? ? ? ? ? ? ?goto out_failed;
> @@ -314,6 +430,7 @@ static int __devinit pca953x_probe(struct
> i2c_client *client,
> ? ? ? ?}
>
> ? ? ? ?i2c_set_clientdata(client, chip);
> + ? ? ? pca953x_setup_irq(client);
> ? ? ? ?return 0;
>
> ?out_failed:
> --
> 1.5.6.5
>
