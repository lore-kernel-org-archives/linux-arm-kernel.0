From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Wed, 6 Apr 2016 10:31:40 -0700
Subject: [PATCH v4 3/3] ARM: dts: use syscon in cygnus touchscreen dt node
In-Reply-To: <1456556396-4759-4-git-send-email-raveendra.padasalagi@broadcom.com>
References: <1456556396-4759-1-git-send-email-raveendra.padasalagi@broadcom.com>
 <1456556396-4759-4-git-send-email-raveendra.padasalagi@broadcom.com>
Message-ID: <20160406173140.GB38452@dtor-ws>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 27, 2016 at 12:29:56PM +0530, Raveendra Padasalagi wrote:
> In Cygnus SOC touch screen controller registers are shared
> with ADC and flex timer. Using readl/writel could lead to
> race condition. So touchscreen driver is enhanced to support
> syscon based register access to take care of mutually exclusive
> access.
> 
> This patch enables syscon support in touchscreen driver
> by adding necessary properties in touchscreen dt node and
> in addition to this renamed existing "tsc" touchscreen node
> name to "touchscreen".
> 
> Signed-off-by: Raveendra Padasalagi <raveendra.padasalagi@broadcom.com>
> Reviewed-by: Ray Jui <ray.jui@broadcom.com>
> Reviewed-by: Scott Branden <scott.branden@broadcom.com>

OK, since the new dts is really needed for the driver I'll be folding
this into the touchscreen driver patch unless I hear someone yelling at
me.

Thanks!

> ---
>  arch/arm/boot/dts/bcm-cygnus.dtsi | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/bcm-cygnus.dtsi b/arch/arm/boot/dts/bcm-cygnus.dtsi
> index 3878793..b42fe55 100644
> --- a/arch/arm/boot/dts/bcm-cygnus.dtsi
> +++ b/arch/arm/boot/dts/bcm-cygnus.dtsi
> @@ -351,9 +351,16 @@
>  					<&pinctrl 142 10 1>;
>  		};
>  
> -		touchscreen: tsc at 180a6000 {
> +		ts_adc_syscon: ts_adc_syscon at 180a6000 {
> +			compatible = "brcm,iproc-ts-adc-syscon", "syscon";
> +			reg = <0x180a6000 0xc30>;
> +		};
> +
> +		touchscreen: touchscreen at 180a6000 {
>  			compatible = "brcm,iproc-touchscreen";
> -			reg = <0x180a6000 0x40>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ts_syscon = <&ts_adc_syscon>;
>  			clocks = <&asiu_clks BCM_CYGNUS_ASIU_ADC_CLK>;
>  			clock-names = "tsc_clk";
>  			interrupts = <GIC_SPI 164 IRQ_TYPE_LEVEL_HIGH>;
> -- 
> 1.9.1
> 

-- 
Dmitry
