From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Thu, 09 Nov 2017 05:45:36 +0200
Subject: [PATCH 4/4] omapdss: fix problem enabling VDDS_DSI on OMAP3530
 (OpenPandora)
In-Reply-To: <b94c5e773994ee55df9225fc84825bacb3fcb256.1510175371.git.hns@goldelico.com>
References: <cover.1510175371.git.hns@goldelico.com>
 <b94c5e773994ee55df9225fc84825bacb3fcb256.1510175371.git.hns@goldelico.com>
Message-ID: <3397395.9drm9Essi0@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nikolaus,

Thank you for the patch.

On Wednesday, 8 November 2017 23:09:32 EET H. Nikolaus Schaller wrote:
> commit d178e034d565 ("drm: omapdrm: Move FEAT_DPI_USES_VDDS_DSI feature to
> dpi code")
> 
> introduced a new match table which turned out to be wrong, at least
> for the 600 MHz OpenPandora using the OMAP3530.
> 
> The effect was strange: only the Blue channel of the RGB panel was
> driven while Red and Green stayed black. So a coloured picture turned
> into blue/black.
> 
> The GTA04 with DM3730 didn't show the effect.
> 
> It turned out that VDDS_DSI was not properly initialized on OMAP3530,
> because the .family string is just "OMAP3" for these processors and
> not "OMAP3xxx".
> 
> Therefore we match the .machine attribute.
> 
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>

I've already submitted a similar patch (but without the problem pointed out 
below) in the mail thread where we discussed the issue. It is customary to use 
the first patch posted (unless it is utterly broken of course). Could you thus 
please include it in this series in replacement of this patch ?

> ---
>  drivers/gpu/drm/omapdrm/dss/dpi.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/omapdrm/dss/dpi.c
> b/drivers/gpu/drm/omapdrm/dss/dpi.c index 4ed5fde11313..aae3626910bb 100644
> --- a/drivers/gpu/drm/omapdrm/dss/dpi.c
> +++ b/drivers/gpu/drm/omapdrm/dss/dpi.c
> @@ -566,8 +566,7 @@ static int dpi_verify_pll(struct dss_pll *pll)
>  }
> 
>  static const struct soc_device_attribute dpi_soc_devices[] = {
> -	{ .family = "OMAP3[456]*" },
> -	{ .family = "[AD]M37*" },
> +	{ .machine = "OMAP3[456]*" },

You also need 

	{ .machine = "[AD]M37*" },

otherwise there will be no match for the OMAP3-like AM37xx and DM37xx SoCs.

Another option would be to match on { .family = "OMAP3*" } but there could be 
spurious matches, even though I haven't identified any.

>  	{ /* sentinel */ }
>  };

-- 
Regards,

Laurent Pinchart
