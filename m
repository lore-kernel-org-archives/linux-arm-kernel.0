From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 30 Sep 2014 11:37:24 +0200
Subject: [PATCH V2] bcma: use device from DT (brcm,
 bus-gpio) for SoC GPIO chip
In-Reply-To: <1411892641-5662-1-git-send-email-zajec5@gmail.com>
References: <1411741733-13888-1-git-send-email-zajec5@gmail.com>
 <1411892641-5662-1-git-send-email-zajec5@gmail.com>
Message-ID: <7035315.8m6ICWZ25d@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 28 September 2014 10:24:01 Rafa? Mi?ecki wrote:
> This will allow us to define GPIO-attached devices (LEDs, buttons) in
> the the device tree.
> 
> Signed-off-by: Rafa? Mi?ecki <zajec5@gmail.com>
> ---
> This is based on top of
> [PATCH v6] bcma: register bcma as device tree driver
> that I hope will reach wireless-next git tree.
> 
> V2: Describe axi chilren and make gpio a child of chipcommon core.
> ---
>  Documentation/devicetree/bindings/bus/bcma.txt | 24 ++++++++++++++++++++++++
>  drivers/bcma/driver_gpio.c                     |  5 +++++
>  2 files changed, 29 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/bus/bcma.txt b/Documentation/devicetree/bindings/bus/bcma.txt
> index e9070c1..26ef4b7 100644
> --- a/Documentation/devicetree/bindings/bus/bcma.txt
> +++ b/Documentation/devicetree/bindings/bus/bcma.txt
> @@ -9,6 +9,22 @@ Required properties:
>  The cores on the AXI bus are automatically detected by bcma with the
>  memory ranges they are using and they get registered afterwards.
>  
> +The top-level axi bus may contain children representing attached cores
> +(devices). This is needed since some hardware details can't be auto
> +detected (e.g. IRQ numbers).
> +
> +There is also one special core called ChipCommon that may contain some
> +extra sub-devices. This is because some devices (e.g. GPIO chip) are
> +not standalone cores and can be access using ChipCommon regs only.
> +Possible ChipCommon children:
> +
> +- gpio: GPIO chip on the SoC
> +
> +  Required properties:
> +  - compatible: "brcm,bus-gpio"
> +  - gpio-controller : makes the node a GPIO controller
> +  - #gpio-cells : size of the GPIO specifier, must be 2
> +
>  Example:
>  
>  	axi at 18000000 {
> @@ -17,4 +33,12 @@ Example:
>  		ranges = <0x00000000 0x18000000 0x00100000>;
>  		#address-cells = <1>;
>  		#size-cells = <1>;
> +
> +		chipcommon at 0 {
> +			gpio at 0 {
> +				compatible = "brcm,bus-gpio";
> +				gpio-controller;
> +				#gpio-cells = <2>;
> +			};
> +		};

I think you should list the 'reg' property of the chipcommon area
and make that match the unit address, rather than using '0', mostly
for consistency.

Can you have multiple gpio areas in chipcommon? If not, I'd probably
leave out the extra node and mark the chipcommon device itself as
a 'gpio-controller'. It can also be other things at the same time,
e.g. 'interrupt-controller' or provide things like pwms or pinctrl
if that's what the hardware does. No need to have separate nodes
for those if it's all the same register set.


>  	};
> diff --git a/drivers/bcma/driver_gpio.c b/drivers/bcma/driver_gpio.c
> index 8ea497c..7ae39a8 100644
> --- a/drivers/bcma/driver_gpio.c
> +++ b/drivers/bcma/driver_gpio.c
> @@ -218,6 +218,11 @@ int bcma_gpio_init(struct bcma_drv_cc *cc)
>  #if IS_BUILTIN(CONFIG_BCM47XX)
>  	chip->to_irq		= bcma_gpio_to_irq;
>  #endif
> +#if IS_BUILTIN(CONFIG_OF)
> +	if (cc->core->bus->hosttype == BCMA_HOSTTYPE_SOC)
> +		chip->of_node	= of_find_compatible_node(NULL, NULL,
> +							  "brcm,bus-gpio");
> +#endif

Just commenting on the general style here, I think you can skip this
step entirely, as mentioned above.

You should use C syntax here:

	if (IS_BUILTIN(CONFIG_OF) && cc->core->bus->hosttype == BCMA_HOSTTYPE_SOC))
		chip->of_node = of_find_compatible_node(NULL, NULL, "brcm,bus-gpio");

If CONFIG_OF is not set, of_find_compatible_node() is turned into an inline
function that returns NULL, so you probably don't even need that.

Finally, of_find_compatible_node() is a really slow operation, and "brcm,bus-gpio"
is a much too generic name. If you need to look for something that is a child
node, use something based on for_each_available_child_of_node().


	Arnd
