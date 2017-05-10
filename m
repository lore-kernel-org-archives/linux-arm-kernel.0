From: shawnguo@kernel.org (Shawn Guo)
Date: Wed, 10 May 2017 22:49:04 +0800
Subject: [PATCH v2] ARM: dts: imx6sx-sdb: Remove OPP override
In-Reply-To: <7b929a65b4893e081c2c04bb0588801f37ac2cca.1493981825.git.leonard.crestez@nxp.com>
References: <7b929a65b4893e081c2c04bb0588801f37ac2cca.1493981825.git.leonard.crestez@nxp.com>
Message-ID: <20170510144903.GC5833@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 05, 2017 at 02:00:17PM +0300, Leonard Crestez wrote:
> The board file for imx6sx-sdb overrides cpufreq operating points to use
> higher voltages. This is done because the board has a shared rail for
> VDD_ARM_IN and VDD_SOC_IN and when using LDO bypass the shared voltage
> needs to be a value suitable for both ARM and SOC.
> 
> This only applies to LDO bypass mode, a feature not present in upstream.
> When LDOs are enabled the effect is to use higher voltages than necessary
> for no good reason.
> 
> Setting these higher voltages can make some boards fail to boot with ugly
> semi-random crashes reminiscent of memory corruption. These failures only
> happen on board rev. C, rev. B is reported to still work.
> 
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> CC: stable at vger.kernel.org

It should have the Fixes tag below.  I can add it when applying.

Fixes: 54183bd7f766 ("ARM: imx6sx-sdb: add revb board and make it default")

> 
> ---
> 
> It is not known exactly why setting these higher voltages causes crashes.
> Maybe this means that it's not appropriate to CC stable?

It should depend on whether we care about the crashes on stable kernel
running on Rev C board.  Do we?

Shawn

> 
> Removing this override is a correct change anyway because these OPP
> overrides do not serve a purpose without ldo bypass.
> 
> Changes since v1:
> - Adjusted commit message
> - Link: https://lkml.org/lkml/2017/4/25/636
> 
>  arch/arm/boot/dts/imx6sx-sdb.dts | 17 -----------------
>  1 file changed, 17 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx6sx-sdb.dts b/arch/arm/boot/dts/imx6sx-sdb.dts
> index 5bb8fd5..d71da30 100644
> --- a/arch/arm/boot/dts/imx6sx-sdb.dts
> +++ b/arch/arm/boot/dts/imx6sx-sdb.dts
> @@ -12,23 +12,6 @@
>  	model = "Freescale i.MX6 SoloX SDB RevB Board";
>  };
>  
> -&cpu0 {
> -	operating-points = <
> -		/* kHz    uV */
> -		996000  1250000
> -		792000  1175000
> -		396000  1175000
> -		198000  1175000
> -		>;
> -	fsl,soc-operating-points = <
> -		/* ARM kHz      SOC uV */
> -		996000	1250000
> -		792000	1175000
> -		396000	1175000
> -		198000  1175000
> -	>;
> -};
> -
>  &i2c1 {
>  	clock-frequency = <100000>;
>  	pinctrl-names = "default";
> -- 
> 2.7.4
> 
