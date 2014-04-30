From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Wed, 30 Apr 2014 02:45:55 +0200
Subject: [PATCH 3/4] ARM: shmobile: marzen: Initialise SCIF devices using
 DT
In-Reply-To: <1398757406-30920-4-git-send-email-horms+renesas@verge.net.au>
References: <1398757406-30920-1-git-send-email-horms+renesas@verge.net.au>
 <1398757406-30920-4-git-send-email-horms+renesas@verge.net.au>
Message-ID: <22937305.8Aq8zO6ih4@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

Thank you for the patch.

On Tuesday 29 April 2014 16:43:25 Simon Horman wrote:
> Initialise SCIF devices using DT when booting marzen
> using multiplatform.
> 
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  arch/arm/boot/dts/r8a7779-marzen.dts   | 22 +++++++++++++++++++---
>  arch/arm/mach-shmobile/setup-r8a7779.c | 10 +++++-----
>  2 files changed, 24 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/r8a7779-marzen.dts
> b/arch/arm/boot/dts/r8a7779-marzen.dts index 769ae84..6e603db 100644
> --- a/arch/arm/boot/dts/r8a7779-marzen.dts
> +++ b/arch/arm/boot/dts/r8a7779-marzen.dts
> @@ -18,6 +18,11 @@
>  	model = "marzen";
>  	compatible = "renesas,marzen", "renesas,r8a7779";
> 
> +	aliases {
> +		serial2 = &scif2;
> +		serial4 = &scif4;
> +	};
> +
>  	chosen {
>  		bootargs = "console=ttySC2,115200 ignore_loglevel root=/dev/nfs 
ip=on";
>  	};
> @@ -73,9 +78,6 @@
>  };
> 
>  &pfc {
> -	pinctrl-0 = <&scif2_pins &scif4_pins>;
> -	pinctrl-names = "default";
> -
>  	lan0_pins: lan0 {
>  		intc {
>  			renesas,groups = "intc_irq1_b";
> @@ -108,6 +110,20 @@
>  	};
>  };
> 
> +&scif2 {
> +       pinctrl-0 = <&scif2_pins>;
> +       pinctrl-names = "default";
> +
> +       status = "okay";
> +};
> +
> +&scif4 {
> +       pinctrl-0 = <&scif4_pins>;
> +       pinctrl-names = "default";
> +
> +       status = "okay";
> +};
> +
>  &sdhi0 {
>  	pinctrl-0 = <&sdhi0_pins>;
>  	pinctrl-names = "default";
> diff --git a/arch/arm/mach-shmobile/setup-r8a7779.c
> b/arch/arm/mach-shmobile/setup-r8a7779.c index 3471a9b..0d2910c 100644
> --- a/arch/arm/mach-shmobile/setup-r8a7779.c
> +++ b/arch/arm/mach-shmobile/setup-r8a7779.c
> @@ -679,17 +679,17 @@ static void __init r8a7779_register_hpb_dmae(void)
>  }
> 
>  static struct platform_device *r8a7779_devices_dt[] __initdata = {
> +	&tmu00_device,
> +	&tmu01_device,
> +};
> +
> +static struct platform_device *r8a7779_standard_devices[] __initdata = {
>  	&scif0_device,
>  	&scif1_device,
>  	&scif2_device,
>  	&scif3_device,
>  	&scif4_device,
>  	&scif5_device,
> -	&tmu00_device,
> -	&tmu01_device,
> -};
> -
> -static struct platform_device *r8a7779_standard_devices[] __initdata = {
>  	&i2c0_device,
>  	&i2c1_device,
>  	&i2c2_device,

-- 
Regards,

Laurent Pinchart
