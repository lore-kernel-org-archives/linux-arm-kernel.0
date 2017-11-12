From: marc.zyngier@arm.com (Marc Zyngier)
Date: Sun, 12 Nov 2017 15:41:01 +0000
Subject: spi->irq == 0 on module reload of driver using IRQF_TRIGGER_LOW
In-Reply-To: <CD4EBEF8-DDFD-40C3-A03E-7EC964B32357@martin.sperl.org>
References: <21FDD1B8-E8F6-4DCE-9D30-D82B713B0008@martin.sperl.org>
 <20171112141349.6b4b3852@why.wild-wind.fr.eu.org>
 <CD4EBEF8-DDFD-40C3-A03E-7EC964B32357@martin.sperl.org>
Message-ID: <20171112154101.483d21d2@why.wild-wind.fr.eu.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 12 Nov 2017 16:13:44 +0100
<kernel@martin.sperl.org> wrote:

> Hi Marc!
> 
> > On 12.11.2017, at 15:13, Marc Zyngier <marc.zyngier@arm.com> wrote:
> > 
> > On Sun, 12 Nov 2017 13:32:44 +0100
> > <kernel@martin.sperl.org> wrote:
> > 
> > Martin,
> >   
> >> Hi!
> >> 
> >> During the development of a new spi driver on a raspberry pi CM1
> >> I have seen an issue with the following code triggering strange behavior:
> >> 
> >> 	ret = request_threaded_irq(spi->irq, NULL,
> >> 				   mcp2517fd_can_ist,
> >> 				   IRQF_ONESHOT | IRQF_TRIGGER_LOW,
> >> 				   DEVICE_NAME, priv);
> >> 
> >> This works fine the first time the module is loaded (spi->irq is not 0),
> >> but as soon as the module gets removed and reinstalled spi->irq is 0 
> >> and I get the message in dmesg:
> >> [ 1282.311991] irq: type mismatch, failed to map hwirq-16 for /soc/gpio at 7e200000!
> >> 
> >> This does not happen when using the IRQF_TRIGGER_FALLING flag.
> >> 
> >> in spi_drv_probe spi core does sets spi->dev to 0 in case 
> >> of_irq_get returns < 0;
> >> 
> >> The specific code that triggers this message and return 0 is 
> >> irq_create_fwspec_mapping.
> >> 
> >> After implementing: https://www.spinics.net/lists/arm-kernel/msg528469.html
> >> and also checking for spi->irq == 0, I get:
> >> 
> >> [   87.867456] irq: type mismatch (2/8), failed to map hwirq-16 for /soc/gpio at 7e200000!  
> > 
> > Well, you have the answer here: The interrupt has been configured with
> > a falling edge trigger, while you're requesting a level low. Obviously,
> > something is changing it.  
> 
> It was configured as level on the first install/request and the driver is
> not changed between rmmod and insmod, so it again requests level on the
> second request.
> 
> > 
> > It would be interesting to see both the driver code and the DT file
> > where the interrupt is described?  
> 
> The relevant patch to the device tree I am using:
> --- a/arch/arm/boot/dts/bcm2835-rpi-b-plus.dts
> +++ b/arch/arm/boot/dts/bcm2835-rpi-b-plus.dts
> @@ -107,3 +107,38 @@
>         pinctrl-0 = <&uart0_gpio14>;
>         status = "okay";
>  };
> +
> +&gpio {
> +      can0_pins: can0_pins {
> +                brcm,pins = <16>;
> +                brcm,function = <0>; /* input */
> +      };
> +};
> +
> +/ {
> +            can0_osc: can0_osc {
> +                compatible = "fixed-clock";
> +                #clock-cells = <0>;
> +                clock-frequency  = <4000000>;
> +            };
> +};
> +
> +&spi {
> +            status = "okay";
> +
> +            can0: mcp2517fd at 0 {
> +                reg = <0>;
> +                compatible = "microchip,mcp2517fd";
> +                pinctrl-names = "default";
> +                pinctrl-0 = <&can0_pins>;
> +                spi-max-frequency = <12500000>;
> +                interrupt-parent = <&gpio>;
> +                interrupts = <16 0x2>;

This indicates a falling edge. No wonder the kernel is confused (I
don't know why this isn't enforced the first time though, probably an
issue in the GPIO irqchip driver...). Replacing this 2 with a 8 should
allow you to make some progress.

Thanks,

	M.
-- 
Without deviation from the norm, progress is not possible.
