From: zajec5@gmail.com (=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=)
Date: Thu, 2 Mar 2017 19:54:22 +0100
Subject: [PATCH 1/2] ARM: dts: bcm5301x: Add TWD WD Support to DT
In-Reply-To: <1488313886-17155-2-git-send-email-jon.mason@broadcom.com>
References: <1488313886-17155-1-git-send-email-jon.mason@broadcom.com>
 <1488313886-17155-2-git-send-email-jon.mason@broadcom.com>
Message-ID: <de705b40-1a8a-faef-846e-3635682671f6@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/28/2017 09:31 PM, Jon Mason wrote:
> From: Jon Mason <jonmason@broadcom.com>
>
> Add support for the ARM TWD Watchdog to the bcm5301x device tree.  The
> ARM TWD timer allocated the register space for the WDT, so this patch
> necessitated shrinking that.  Also, the GIC masks were added for these.
>
> Signed-off-by: Jon Mason <jonmason@broadcom.com>
> ---
>  arch/arm/boot/dts/bcm5301x.dtsi | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/boot/dts/bcm5301x.dtsi b/arch/arm/boot/dts/bcm5301x.dtsi
> index 4fbb089..3fbc450 100644
> --- a/arch/arm/boot/dts/bcm5301x.dtsi
> +++ b/arch/arm/boot/dts/bcm5301x.dtsi
> @@ -70,10 +70,19 @@
>  			clocks = <&periph_clk>;
>  		};
>
> -		local-timer at 20600 {
> +		timer at 20600 {
>  			compatible = "arm,cortex-a9-twd-timer";
> -			reg = <0x20600 0x100>;
> -			interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_HIGH>;
> +			reg = <0x20600 0x20>;
> +			interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(2) |
> +						  IRQ_TYPE_LEVEL_HIGH)>;
> +			clocks = <&periph_clk>;
> +		};

If you follow my recent e-mail thread:
BCM5301X: GIC: PPI11 is secure or misconfigured (same for PPI13)
you'll see IRQ_TYPE_LEVEL_HIGH type isn't correct. It should be
IRQ_TYPE_EDGE_RISING.

I believe patch switching to IRQ_TYPE_EDGE_RISING should be sent with Cc stable
for kernels 4.8+.

The same change is needed for "arm,cortex-a9-global-timer".

Would you find time to revise this patch?
