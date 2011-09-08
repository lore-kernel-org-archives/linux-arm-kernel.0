From: grant.likely@secretlab.ca (Grant Likely)
Date: Thu, 8 Sep 2011 11:03:00 -0700
Subject: [RFC PATCH 02/10] arm/dts: OMAP4: Add a main ocp entry bound to
	l3-noc driver
In-Reply-To: <1314191356-10963-3-git-send-email-b-cousson@ti.com>
References: <1314191356-10963-1-git-send-email-b-cousson@ti.com>
	<1314191356-10963-3-git-send-email-b-cousson@ti.com>
Message-ID: <20110908180300.GB2967@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 24, 2011 at 03:09:08PM +0200, Benoit Cousson wrote:
> Used the main OCP node to add bindings with the l3_noc driver.
> Remove l3_noc static device creation if CONFIG_OF is defined.
> 
> Signed-off-by: Benoit Cousson <b-cousson@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> ---
>  arch/arm/boot/dts/omap4.dtsi  |    3 ++-
>  arch/arm/mach-omap2/devices.c |    2 ++
>  2 files changed, 4 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
> index 97a3ea7..928a74c 100644
> --- a/arch/arm/boot/dts/omap4.dtsi
> +++ b/arch/arm/boot/dts/omap4.dtsi
> @@ -64,10 +64,11 @@
>  	 * hierarchy.
>  	 */
>  	ocp {
> -		compatible = "simple-bus";
> +		compatible = "ti,l3-noc", "arteris,noc", "simple-bus";
>  		#address-cells = <1>;
>  		#size-cells = <1>;
>  		ranges;
> +		hwmods = "l3_main_1", "l3_main_2", "l3_main_3";
>  
>  		gic: interrupt-controller at 48241000 {
>  			compatible = "ti,omap4-gic", "arm,gic";
> diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
> index 2d4a199..5964650 100644
> --- a/arch/arm/mach-omap2/devices.c
> +++ b/arch/arm/mach-omap2/devices.c
> @@ -70,6 +70,7 @@ static int __init omap3_l3_init(void)
>  }
>  postcore_initcall(omap3_l3_init);
>  
> +#ifndef CONFIG_OF
>  static int __init omap4_l3_init(void)
>  {
>  	int l, i;
> @@ -100,6 +101,7 @@ static int __init omap4_l3_init(void)
>  	return IS_ERR(pdev) ? PTR_ERR(pdev) : 0;
>  }
>  postcore_initcall(omap4_l3_init);
> +#endif

Don't do this.  Turning on CONFIG_OF must not break non-DT booting.
Instead, check at runtime if a DT is available, and if it does then
don't run the hook.

g.
