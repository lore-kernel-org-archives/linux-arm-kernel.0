From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 30 Sep 2014 12:36:28 +0200
Subject: [PATCH V3] bcma: use device from DT (brcm,
 bus-chipcommon) for SoC GPIO chip
In-Reply-To: <1412072546-3529-1-git-send-email-zajec5@gmail.com>
References: <1411892641-5662-1-git-send-email-zajec5@gmail.com>
 <1412072546-3529-1-git-send-email-zajec5@gmail.com>
Message-ID: <3484902.1UVy7lmJAD@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 30 September 2014 12:22:26 Rafa? Mi?ecki wrote:
> 
> +The top-level axi bus may contain children representing attached cores
> +(devices). This is needed since some hardware details can't be auto
> +detected (e.g. IRQ numbers). Also some of the cores may be responsible
> +for extra things, e.g. ChipCommon providing access to the GPIO chip.
> +
>  Example:
>  
>         axi at 18000000 {
> @@ -17,4 +22,12 @@ Example:
>                 ranges = <0x00000000 0x18000000 0x00100000>;
>                 #address-cells = <1>;
>                 #size-cells = <1>;
> +
> +               chipcommon {
> +                       compatible = "brcm,bus-chipcommon";
> +                       reg = <0x00000000 0x1000>;
> +
> +                       gpio-controller;
> +                       #gpio-cells = <2>;
> +               };
>         };

Looks good.


> diff --git a/drivers/bcma/driver_gpio.c b/drivers/bcma/driver_gpio.c
> index 8ea497c..28bdbe5 100644
> --- a/drivers/bcma/driver_gpio.c
> +++ b/drivers/bcma/driver_gpio.c
> @@ -218,6 +218,12 @@ int bcma_gpio_init(struct bcma_drv_cc *cc)
>  #if IS_BUILTIN(CONFIG_BCM47XX)
>         chip->to_irq            = bcma_gpio_to_irq;
>  #endif
> +#if IS_BUILTIN(CONFIG_OF)
> +       if (cc->core->bus->hosttype == BCMA_HOSTTYPE_SOC)
> +               chip->of_node   = of_find_compatible_node(
> +                                       bus->host_pdev->dev.of_node, NULL,
> +                                       "brcm,bus-chipcommon");
> +#endif
>         switch (cc->core->bus->chipinfo.id) {

This doesn't: you are now searching through all nodes starting at the
axi node rather than searching just through the children.

I think it would be better with the first change in place to set
chip->of_node to cc->core->dev.of_node, and set that pointer in
bcma_bus_scan by matching the 'reg' number. I think that is what
an earlier version of the bcma DT support did in order to find the
IRQs. We no longer need it for that purpose, but it seems like a
good idea anyway, as I expect other bcma_devices to have similar
requirements to add additional properties.

	Arnd
