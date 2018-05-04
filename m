From: shawnguo@kernel.org (Shawn Guo)
Date: Fri, 4 May 2018 15:19:27 +0800
Subject: [PATCH] ARM: dts: imx7s: Pass the 'fsl,sec-era' property
In-Reply-To: <1524601519-23502-1-git-send-email-festevam@gmail.com>
References: <1524601519-23502-1-git-send-email-festevam@gmail.com>
Message-ID: <20180504071926.GT3443@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 24, 2018 at 05:25:19PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@nxp.com>
> 
> Currently the following error is seen from the CAAM driver:
> 
> caam 30900000.caam: device ID = 0x0a16030000000000 (Era -524)
> 
> Pass the 'fsl,sec-era' property to properly describe the
> era information.
> 
> This error happens because the 'fsl,sec-era' is not passed via
> device tree.
> 
> The era information is used in various places inside drivers/crypto/caam,
> so pass the correct version via device tree.

The property is documented as optional in the bindings.  Missing the
property shouldn't cause any fatal error, I guess.

Shawn

> 
> Fixes: 0eeabcad7da5 ("ARM: dts: imx7s: add CAAM device node")
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
> ---
> I have sent a patch for 4.18 that allows retrieving the era information
> from the CAAM registers in run-time:
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/drivers/crypto/caam/ctrl.c?h=next-20180424&id=654f2b937b389295581bcb4aa26011a63db7bc8f
> 
> This will only be applied in 4.18 though.
> 
> In order to avoid i.MX7 report the incorrect era version in 4.17,
> let's pass this property.
> 
>  arch/arm/boot/dts/imx7s.dtsi | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/boot/dts/imx7s.dtsi b/arch/arm/boot/dts/imx7s.dtsi
> index a6fe324..b416d2b 100644
> --- a/arch/arm/boot/dts/imx7s.dtsi
> +++ b/arch/arm/boot/dts/imx7s.dtsi
> @@ -884,6 +884,7 @@
>  
>  			crypto: caam at 30900000 {
>  				compatible = "fsl,sec-v4.0";
> +				fsl,sec-era = <8>;
>  				#address-cells = <1>;
>  				#size-cells = <1>;
>  				reg = <0x30900000 0x40000>;
> -- 
> 2.7.4
> 
