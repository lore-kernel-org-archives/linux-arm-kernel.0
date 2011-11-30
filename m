From: robherring2@gmail.com (Rob Herring)
Date: Tue, 29 Nov 2011 21:28:11 -0600
Subject: [PATCH 2/2] gpio/tegra: Make it a DT interrupt controller
In-Reply-To: <1322616743-31985-2-git-send-email-swarren@nvidia.com>
References: <1322616743-31985-1-git-send-email-swarren@nvidia.com>
 <1322616743-31985-2-git-send-email-swarren@nvidia.com>
Message-ID: <4ED5A2CB.8020905@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 11/29/2011 07:32 PM, Stephen Warren wrote:
> Fix the DT binding documentation to describe interrupt-related properties,
> and the contents of "child" node interrupts property.
> 
> Update tegra20.dtsi to specify the required interrupt-related properties.
> 
> Fix the driver to creating an IRQ domain for itself, so that child node
> interrupts properties are correctly parsed.
> 
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> ---
> This patch depends on "arm/tegra: convert tegra20 to GIC devicetree binding",
> at least for context, and probably functionally (and of course patch 1 in
> this series).
> 
> I've tested that this patch causes the WM8903 to receive a valid IRQ when
> instantiated from device-tree (although the patches to instantiate the
> WM8903 from DT are local to me for now).
> 
>  .../devicetree/bindings/gpio/gpio_nvidia.txt       |   10 ++++++++++
>  arch/arm/boot/dts/tegra20.dtsi                     |    2 ++
>  drivers/gpio/gpio-tegra.c                          |    4 ++++
>  3 files changed, 16 insertions(+), 0 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/gpio/gpio_nvidia.txt b/Documentation/devicetree/bindings/gpio/gpio_nvidia.txt
> index eb4b530..ecdf19c 100644
> --- a/Documentation/devicetree/bindings/gpio/gpio_nvidia.txt
> +++ b/Documentation/devicetree/bindings/gpio/gpio_nvidia.txt
> @@ -6,3 +6,13 @@ Required properties:
>    second cell is used to specify optional parameters:
>    - bit 0 specifies polarity (0 for normal, 1 for inverted)
>  - gpio-controller : Marks the device node as a GPIO controller.
> +- #interrupt-cells : Should be 3.

Should be 2??

> +  The first cell is the GPIO number.
> +  The second cell is used to specify flags:
> +    bits[3:0] trigger type and level flags:
> +      1 = low-to-high edge triggered.
> +      2 = high-to-low edge triggered.
> +      4 = active high level-sensitive.
> +      8 = active low level-sensitive.
> +      Valid combinations are 1, 2, 3, 4, 8.
> +- interrupt-controller : Marks the device node as an interrupt controller.
> diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi
> index db6f562..e25f4a6 100644
> --- a/arch/arm/boot/dts/tegra20.dtsi
> +++ b/arch/arm/boot/dts/tegra20.dtsi
> @@ -79,6 +79,8 @@
>  			       0 55 0x04
>  			       0 87 0x04
>  			       0 89 0x04 >;
> +		interrupt-controller;
> +		#interrupt-cells = <2>;
>  		#gpio-cells = <2>;
>  		gpio-controller;
>  	};
> diff --git a/drivers/gpio/gpio-tegra.c b/drivers/gpio/gpio-tegra.c
> index 61044c8..26b0c85 100644
> --- a/drivers/gpio/gpio-tegra.c
> +++ b/drivers/gpio/gpio-tegra.c
> @@ -25,6 +25,7 @@
>  #include <linux/of.h>
>  #include <linux/platform_device.h>
>  #include <linux/module.h>
> +#include <linux/irqdomain.h>
>  
>  #include <asm/mach/irq.h>
>  
> @@ -410,6 +411,9 @@ static int __devinit tegra_gpio_probe(struct platform_device *pdev)
>  			spin_lock_init(&bank->lvl_lock[j]);
>  	}
>  
> +	if (pdev->dev.of_node)
> +		irq_domain_add_simple(pdev->dev.of_node, TEGRA_GPIO_TO_IRQ(0));
> +

This is a bit of a temporary solution. Really, you want to end up with
something like this to eliminate INT_GPIO_BASE and dynamically assign
the irqbase:

diff --git a/drivers/gpio/gpio-tegra.c b/drivers/gpio/gpio-tegra.c
index 61044c8..a146a20 100644
--- a/drivers/gpio/gpio-tegra.c
+++ b/drivers/gpio/gpio-tegra.c
@@ -139,7 +139,7 @@ static int tegra_gpio_direction_output(struct
gpio_chip *chip, unsigned offset,

 static int tegra_gpio_to_irq(struct gpio_chip *chip, unsigned offset)
 {
-       return TEGRA_GPIO_TO_IRQ(offset);
+       return irq_domain_to_irq(chip->domain, offset);

>>> This is a bit wrong. You need a tegra_gpio_chip containing a domain
and gpio_chip.

 }

 static struct gpio_chip tegra_gpio_chip = {
@@ -155,28 +155,28 @@ static struct gpio_chip tegra_gpio_chip = {

 static void tegra_gpio_irq_ack(struct irq_data *d)
 {
-       int gpio = d->irq - INT_GPIO_BASE;
+       int gpio = d->hwirq;

        tegra_gpio_writel(1 << GPIO_BIT(gpio), GPIO_INT_CLR(gpio));
 }

 static void tegra_gpio_irq_mask(struct irq_data *d)
 {
-       int gpio = d->irq - INT_GPIO_BASE;
+       int gpio = d->hwirq;

        tegra_gpio_mask_write(GPIO_MSK_INT_ENB(gpio), gpio, 0);
 }

 static void tegra_gpio_irq_unmask(struct irq_data *d)
 {
-       int gpio = d->irq - INT_GPIO_BASE;
+       int gpio = d->hwirq;

        tegra_gpio_mask_write(GPIO_MSK_INT_ENB(gpio), gpio, 1);
 }

 static int tegra_gpio_irq_set_type(struct irq_data *d, unsigned int type)
 {
-       int gpio = d->irq - INT_GPIO_BASE;
+       int gpio = d->hwirq;
        struct tegra_gpio_bank *bank = irq_data_get_irq_chip_data(d);
        int port = GPIO_PORT(gpio);
        int lvl_type;
@@ -385,6 +385,7 @@ static int __devinit tegra_gpio_probe(struct
platform_device *pdev)
        tegra_gpio_chip.of_node = pdev->dev.of_node;
 #endif

+       domain.irq_base = irq_alloc_descs(...)

        gpiochip_add(&tegra_gpio_chip);

        for (gpio = 0; gpio < TEGRA_NR_GPIOS; gpio++) {


Rob
