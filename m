From: grant.likely@secretlab.ca (Grant Likely)
Date: Wed, 3 Aug 2011 23:22:54 +0100
Subject: [PATCH] gpio: pl061: add DT binding support
In-Reply-To: <1312397661-3328-1-git-send-email-robherring2@gmail.com>
References: <1312397661-3328-1-git-send-email-robherring2@gmail.com>
Message-ID: <CACxGe6u1g_XZCvWB=7Z=0hGhZKfcQaiRm1WaQfJMrkkHTTqn8Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 3, 2011 at 7:54 PM, Rob Herring <robherring2@gmail.com> wrote:
> From: Rob Herring <rob.herring@calxeda.com>
>
> This adds devicetree binding support to the ARM pl061 driver removing the
> platform_data dependency. When DT binding is used, the gpio numbering is
> assigned dynamically. The interrupt assignment is converted to use the
> irq_domain infrastructure.
>
> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> ---
> ?drivers/gpio/gpio-pl061.c | ? 32 +++++++++++++++++++++++---------
> ?1 files changed, 23 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpio/gpio-pl061.c b/drivers/gpio/gpio-pl061.c
> index 2c5a18f..7ea74ff 100644
> --- a/drivers/gpio/gpio-pl061.c
> +++ b/drivers/gpio/gpio-pl061.c
> @@ -23,6 +23,7 @@
> ?#include <linux/amba/bus.h>
> ?#include <linux/amba/pl061.h>
> ?#include <linux/slab.h>
> +#include <linux/of_irq.h>
>
> ?#define GPIODIR 0x400
> ?#define GPIOIS ?0x404
> @@ -246,6 +247,20 @@ static int pl061_probe(struct amba_device *dev, const struct amba_id *id)
> ? ? ? ?if (chip == NULL)
> ? ? ? ? ? ? ? ?return -ENOMEM;
>
> + ? ? ? pdata = dev->dev.platform_data;
> + ? ? ? if (pdata) {
> + ? ? ? ? ? ? ? chip->gc.base = pdata->gpio_base;
> + ? ? ? ? ? ? ? chip->irq_base = pdata->irq_base;
> + ? ? ? } else if (dev->dev.of_node) {
> + ? ? ? ? ? ? ? u32 intspec = 0;
> + ? ? ? ? ? ? ? chip->gc.base = -1;
> + ? ? ? ? ? ? ? chip->irq_base = irq_create_of_mapping(dev->dev.of_node,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?&intspec, 1);

This looks wrong.  intspec is always 0 here, when I would assume you
would want the value of the interrupts property from this device's
node.  Is this the cascade irq number?  Or is it supposed to be the
starting interrupt number for the gpios?  If it is starting interrupt
number, then it should actually be dynamically assigned.  If it is the
cascade, then platform_get_irq() should work.

g.
