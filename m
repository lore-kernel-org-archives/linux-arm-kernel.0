From: tony@atomide.com (Tony Lindgren)
Date: Thu, 5 Mar 2015 07:40:39 -0800
Subject: [PATCH v2 2/2] ARM: dts: am33xx: Move wkup_m3 node to soc node
 and add ranges
In-Reply-To: <1425528742-3087-3-git-send-email-d-gerlach@ti.com>
References: <1425528742-3087-1-git-send-email-d-gerlach@ti.com>
 <1425528742-3087-3-git-send-email-d-gerlach@ti.com>
Message-ID: <20150305154039.GD13520@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Dave Gerlach <d-gerlach@ti.com> [150304 20:14]:
> Signed-off-by: Suman Anna <s-anna@ti.com>
> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
> ---
>  arch/arm/boot/dts/am33xx.dtsi | 21 +++++++++++++--------
>  1 file changed, 13 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
> index acd3705..086415c 100644
> --- a/arch/arm/boot/dts/am33xx.dtsi
> +++ b/arch/arm/boot/dts/am33xx.dtsi
> @@ -77,10 +77,23 @@
>  	 */
>  	soc {
>  		compatible = "ti,omap-infra";
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges = <0x0     0x44d00000 0x4000>,
> +			 <0x80000 0x44d80000 0x2000>;
> +

I think putting the ranges here will cause issues for adding
ranges for anything else.

How about do something like this instead (untested):

ocp {
	l4_wkup: l4_wkup at 44c00000 {
		compatible = "am335-l4-wkup", "simple-bus";
		ranges = <0 0x44c00000 0x3fffff>;

		wkup_m3: wkup_m3 at 44d00000 {
			compatible = "ti,am3353-wkup-m3";
			reg = <0x1000000     0x4000>,	/* M3 UMEM */
			      <0x180000	     0x2000>;	/* M3 DMEM */
			ti,hwmods = "wkup_m3";
			ti,pm-firmware = "am335x-pm-firmware.elf";
		};

		...
	};
};

That way we can start moving also the other l4_wkup components there
eventuallly without having to redo the ranges again for wkup_m3.

You can also look at how the scm_conf was done for dm816x.dtsi for an
example, and the recent large set of patches posted by Tero.

Regards,

Tony
