From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 16 Jan 2015 08:27:16 +0100
Subject: [PATCH] i.MX6-SabreAuto: WEIM: add steering-gpios to set WEIM
 for NOR
In-Reply-To: <1421347571-9239-2-git-send-email-alison_chaiken@mentor.com>
References: <20150115075646.GM23940@pengutronix.de>
 <1421347571-9239-1-git-send-email-alison_chaiken@mentor.com>
 <1421347571-9239-2-git-send-email-alison_chaiken@mentor.com>
Message-ID: <20150116072716.GD18220@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 15, 2015 at 10:46:11AM -0800, alison at she-devel.com wrote:
> From: Alison Chaiken <alison_chaiken@mentor.com>
> 
> EIM_D18 pin of i.MX6 CPU is connected to the WEIM switch, to which pin
> DQ2 of the parallel NOR is also attached.  Use GPIO5, pin 4 to steer
> the switch to connect the pin to the parallel NOR at boot.  If the
> GPIO is not set LOW, the probe of the NOR fails when cfi_qry_present()
> returns "U-V-]" rather than "Q-R-Y" because bit 2 is erroneously high.
> Implement control of the GPIO by adding a steering-gpios property to
> the nor child node of the WEIM in the SabreAuto device-tree. Also add
> a function to the imx-weim probe to set GPIO5 to drive the pad.
> 
> Signed-off-by: Alison Chaiken <alison_chaiken@mentor.com>
> ---
>  Documentation/devicetree/bindings/bus/imx-weim.txt | 10 +++++
>  arch/arm/boot/dts/imx6qdl-sabreauto.dtsi           |  1 +
>  drivers/bus/imx-weim.c                             | 46 ++++++++++++++++++++++
>  3 files changed, 57 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/bus/imx-weim.txt b/Documentation/devicetree/bindings/bus/imx-weim.txt
> index 6630d84..359fb26 100644
> --- a/Documentation/devicetree/bindings/bus/imx-weim.txt
> +++ b/Documentation/devicetree/bindings/bus/imx-weim.txt
> @@ -59,6 +59,15 @@ Timing property for child nodes. It is mandatory, not optional.
>  			there are six registers: CSxGCR1, CSxGCR2, CSxRCR1,
>  			CSxRCR2, CSxWCR1, CSxWCR2.
>  
> +Steering property for child nodes is optional.  Steering is needed if
> +the bootloader doesn't set the GPIOs driving the EIM switch to connect
> +the WEIM to the CPU rather than to the peripherals with which the WEIM
> +has a pin conflict.
> +
> + - fsl,steering-gpios:  For i.mx6q-sabreauto, the connectivity of CPU
> +			pins EIM_D18 and EIM_D30 can be controlled via
> +			GPIOs.

It seems to be common that some GPIOs which are not regulators or reset
pins must be switched into the right direction for stuff to work. Adding
board specific properties to the device tree to solve this common
problem for a single usecase doesn't sound like a good solution. I
suggest that you take a look at the GPIO hogging mechanism patches from
Benoit Parrot instead: https://lkml.org/lkml/2014/12/19/342

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
