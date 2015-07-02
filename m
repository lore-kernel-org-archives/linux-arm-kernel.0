From: michael@smart-africa.com (Michael van der Westhuizen)
Date: Thu, 2 Jul 2015 08:05:26 +0100
Subject: [PATCH 1/2] gpio: dwapb: Use human understandable gpio numbering.
In-Reply-To: <d6b5ce85a17164970d454583560e07f7aed7b8ca.1435777856.git.rcochran@linutronix.de>
References: <cover.1435777856.git.rcochran@linutronix.de>
 <d6b5ce85a17164970d454583560e07f7aed7b8ca.1435777856.git.rcochran@linutronix.de>
Message-ID: <267A46E7-C5C5-4696-90CC-D44F4130B3EF@smart-africa.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I have a very similar patch in my tree, and I?ve substituted this patch for mine,
tested it and it works correctly.  However, there are administrative issues with
this change.

> On 01 Jul 2015, at 8:34 PM, Richard Cochran <richardcochran@gmail.com> wrote:
> 
> The system-on-chips using this IP core have well defined gpio numbers.
> Instead of using random numbers, this patch lets the device tree specify
> the correct gpio numbering.

The subject should not end with a full-stop.

Also, the commit message should explain why the change is needed, not what
it does.  While the message is accurate, the problem is not that humans can?t
really make sense of the GPIO numbering, its that the GPIO numbering exposed
to userland is often important for backward compatibility with a vendor BSP and
it can be important (conceptually) to tie this numbering to the vendor documentation.

Ultimately, the numbering is inconsequential to users in kernel-space when DT is
in use.  It?s the userland users we?re trying to help.

In my case, I have quite a lot of vendor-supplied code that needs the numbers to
be stable and backward compatible.  This quickly devolves into a discussion of
GPIOs in sysfs as an ABI, which is not a discussion I want to have :)

> 
> Signed-off-by: Richard Cochran <rcochran@linutronix.de>
> ---
> Documentation/devicetree/bindings/gpio/snps-dwapb-gpio.txt | 2 ++
> drivers/gpio/gpio-dwapb.c                                  | 8 +++++++-
> 2 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/gpio/snps-dwapb-gpio.txt b/Documentation/devicetree/bindings/gpio/snps-dwapb-gpio.txt
> index dd5d2c0..5c9effd 100644
> --- a/Documentation/devicetree/bindings/gpio/snps-dwapb-gpio.txt
> +++ b/Documentation/devicetree/bindings/gpio/snps-dwapb-gpio.txt
> @@ -28,6 +28,7 @@ controller.
> - interrupt-parent : The parent interrupt controller.
> - interrupts : The interrupt to the parent controller raised when GPIOs
>   generate the interrupts.
> +- snps,base : The base gpio number.
> - snps,nr-gpios : The number of pins in the port, a single cell.
> 
> Example:
> @@ -42,6 +43,7 @@ gpio: gpio at 20000 {
> 		compatible = "snps,dw-apb-gpio-port";
> 		gpio-controller;
> 		#gpio-cells = <2>;
> +		snps,base = <8>;
> 		snps,nr-gpios = <8>;
> 		reg = <0>;
> 		interrupt-controller;

This bindings change need to be in a separate patch for review by the devicetree maintainers.

> diff --git a/drivers/gpio/gpio-dwapb.c b/drivers/gpio/gpio-dwapb.c
> index 58faf04..b7e7977 100644
> --- a/drivers/gpio/gpio-dwapb.c
> +++ b/drivers/gpio/gpio-dwapb.c
> @@ -491,6 +491,13 @@ dwapb_gpio_get_pdata_of(struct device *dev)
> 			return ERR_PTR(-EINVAL);
> 		}
> 
> +		if (of_property_read_u32(port_np, "snps,base",
> +					 &pp->gpio_base)) {
> +			dev_info(dev, "no base gpio specified for %s\n",
> +				 port_np->full_name);

This should be dev_dbg, or should just be removed.  This is not a problem, as it is simply
maintaining existing behaviour.

Michael
