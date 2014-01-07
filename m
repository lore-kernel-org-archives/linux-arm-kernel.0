From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 7 Jan 2014 22:17:25 +0800
Subject: [PATCH 1/3] ARM: imx: add suspend in ocram support on i.mx6q
In-Reply-To: <1389041739-18389-1-git-send-email-b20788@freescale.com>
References: <1389041739-18389-1-git-send-email-b20788@freescale.com>
Message-ID: <20140107141723.GM12346@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 06, 2014 at 03:55:37PM -0500, Anson Huang wrote:
> @@ -215,10 +235,68 @@ void __init imx6q_pm_set_ccm_base(void __iomem *base)
>  	ccm_base = base;
>  }
>  
> +static struct map_desc imx6_pm_io_desc[] __initdata = {
> +	imx_map_entry(MX6Q, MMDC_P0, MT_DEVICE),
> +	imx_map_entry(MX6Q, SRC, MT_DEVICE),
> +	imx_map_entry(MX6Q, IOMUXC, MT_DEVICE),
> +	imx_map_entry(MX6Q, CCM, MT_DEVICE),
> +	imx_map_entry(MX6Q, GPC, MT_DEVICE),
> +	imx_map_entry(MX6Q, L2, MT_DEVICE),
> +};
> +
> +void __init imx6_pm_map_io(void)
> +{
> +	iotable_init(imx6_pm_io_desc, ARRAY_SIZE(imx6_pm_io_desc));
> +}
> +

I know this is what we do in FSL kernel - create static mapping to save
the address passing between C and assembly function.  However this is
not acceptable for upstream kernel, because we're trying to limit the
static mapping use to the cases where there is no other way around, and
move everything else to dynamic mapping.

Also, having those MX6Q_XXX_BASE_ADDR and MX6Q_XXX_SIZE definitions is
not nice either, because device tree should be the only source for these
data.

Shawn
