From: anson.huang@nxp.com (Anson Huang)
Date: Fri, 26 Jan 2018 06:32:23 +0000
Subject: [PATCH] ARM: dts: imx6sx: add pu power domain support
In-Reply-To: <20180125153025.GC24622@b29396-OptiPlex-7040>
References: <1516720343-21933-1-git-send-email-Anson.Huang@nxp.com>
 <20180125153025.GC24622@b29396-OptiPlex-7040>
Message-ID: <AM3PR04MB1315462173409260DDEB4C3DF5E00@AM3PR04MB1315.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



-----Original Message-----
From: Dong Aisheng [mailto:dongas86 at gmail.com] 
Sent: 2018?1?25? 23:30
To: Anson Huang <anson.huang@nxp.com>
Cc: shawnguo at kernel.org; kernel at pengutronix.de; Fabio Estevam <fabio.estevam@nxp.com>; robh+dt at kernel.org; A.s. Dong <aisheng.dong@nxp.com>; mark.rutland at arm.com; linux at armlinux.org.uk; dl-linux-imx <linux-imx@nxp.com>; linux-arm-kernel at lists.infradead.org; devicetree at vger.kernel.org; linux-kernel at vger.kernel.org
Subject: Re: [PATCH] ARM: dts: imx6sx: add pu power domain support

On Tue, Jan 23, 2018 at 11:12:23PM +0800, Anson Huang wrote:
> Add PU power domain support, GPU is the only module inside PU power 
> domain, and PU power is supplied by LDO_SOC.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  arch/arm/boot/dts/imx6sx.dtsi | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx6sx.dtsi 
> b/arch/arm/boot/dts/imx6sx.dtsi index fd78793..42ef4c6 100644
> --- a/arch/arm/boot/dts/imx6sx.dtsi
> +++ b/arch/arm/boot/dts/imx6sx.dtsi
> @@ -188,6 +188,7 @@
>  				 <&clks IMX6SX_CLK_GPU>,
>  				 <&clks IMX6SX_CLK_GPU>;
>  			clock-names = "bus", "core", "shader";
> +			power-domains = <&pd_pu>;
>  		};
>  
>  		dma_apbh: dma-apbh at 1804000 {
> @@ -767,6 +768,13 @@
>  					#address-cells = <1>;
>  					#size-cells = <0>;
>  
> +					pd_pu: power-domain at 1 {
> +						reg = <1>;
> +						#power-domain-cells = <0>;
> +						power-supply = <&reg_soc>;

I wonder we may not need this as it's a non-stop domain just like we did for arm domain, right?

Otherwise, the patch looks fine to me.

Acked-by: Dong Aisheng <aisheng.dong@nxp.com>

No, this domain can be power gated, there is an internal power gate in GPC, just the input
power can NOT be disabled. So there might be some leakage in this domain, but power still
can be saved a lot if internal power gate is off.

Anson.

Regards
Dong Aisheng

> +						clocks = <&clks IMX6SX_CLK_GPU>;
> +					};
> +
>  					pd_pci: power-domain at 3 {
>  						reg = <3>;
>  						#power-domain-cells = <0>;
> --
> 2.7.4
> 
