From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Tue, 06 Jan 2015 16:14:09 +0200
Subject: [PATCH] ARM: shmobile: sh73a0 legacy: Set .control_parent for all
 irqpin instances
In-Reply-To: <1420551550-27512-1-git-send-email-geert+renesas@glider.be>
References: <1420551550-27512-1-git-send-email-geert+renesas@glider.be>
Message-ID: <4452252.suqURC1IYD@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Geert,

Thank you for the patch.

On Tuesday 06 January 2015 14:39:10 Geert Uytterhoeven wrote:
> The sh73a0 INTC can't mask interrupts properly most likely due to a
> hardware bug. Set the .control_parent flag to delegate masking to the
> parent interrupt controller, like was already done for irqpin1.
> 
> Without this, accessing the three-axis digital accelerometer ADXL345
> on kzm9g through /dev/input/event1 causes an interrupt storm, which
> requires a power-cycle to recover from.
> 
> This was inspired by a patch for arch/arm/boot/dts/sh73a0.dtsi from
> Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>.

This looks correct to me, but shouldn't we concentrate on getting rid of 
legacy code instead ?

> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Fixes: 341eb5465f67437a ("ARM: shmobile: INTC External IRQ pin driver on
> sh73a0") ---
>  arch/arm/mach-shmobile/setup-sh73a0.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm/mach-shmobile/setup-sh73a0.c
> b/arch/arm/mach-shmobile/setup-sh73a0.c index
> 354cab111bf17ea6..613ce65184a6648c 100644
> --- a/arch/arm/mach-shmobile/setup-sh73a0.c
> +++ b/arch/arm/mach-shmobile/setup-sh73a0.c
> @@ -595,6 +595,7 @@ static struct platform_device ipmmu_device = {
> 
>  static struct renesas_intc_irqpin_config irqpin0_platform_data = {
>  	.irq_base = irq_pin(0), /* IRQ0 -> IRQ7 */
> +	.control_parent = true,
>  };
> 
>  static struct resource irqpin0_resources[] = {
> @@ -656,6 +657,7 @@ static struct platform_device irqpin1_device = {
> 
>  static struct renesas_intc_irqpin_config irqpin2_platform_data = {
>  	.irq_base = irq_pin(16), /* IRQ16 -> IRQ23 */
> +	.control_parent = true,
>  };
> 
>  static struct resource irqpin2_resources[] = {
> @@ -686,6 +688,7 @@ static struct platform_device irqpin2_device = {
> 
>  static struct renesas_intc_irqpin_config irqpin3_platform_data = {
>  	.irq_base = irq_pin(24), /* IRQ24 -> IRQ31 */
> +	.control_parent = true,
>  };
> 
>  static struct resource irqpin3_resources[] = {

-- 
Regards,

Laurent Pinchart
