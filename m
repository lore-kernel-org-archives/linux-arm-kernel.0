From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 2 Jun 2017 21:31:06 +0200
Subject: [PATCH 12/19] drm/sun4i: hdmi: Support the DDC clock in the
 A31's HDMI controller
In-Reply-To: <20170602101024.18940-13-wens@csie.org>
References: <20170602101024.18940-1-wens@csie.org>
 <20170602101024.18940-13-wens@csie.org>
Message-ID: <20170602193106.c3yagwkglhg45h6y@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 02, 2017 at 06:10:17PM +0800, Chen-Yu Tsai wrote:
> On the A31, the HDMI DDC block is different from the one in the
> other SoCs. As far as the DDC clock goes, it has no pre-divider,
> as it is clocked from a slower parent clock, not the TMDS clock.
> The divider offset from the register value is different. And the
> clock control register is at a different offset.
> 
> This patch adds support for this variant.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  drivers/gpu/drm/sun4i/sun4i_hdmi.h         |  1 +
>  drivers/gpu/drm/sun4i/sun4i_hdmi_ddc_clk.c | 11 +++++++++++
>  2 files changed, 12 insertions(+)
> 
> diff --git a/drivers/gpu/drm/sun4i/sun4i_hdmi.h b/drivers/gpu/drm/sun4i/sun4i_hdmi.h
> index 08c514672fd3..c39c2a245339 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_hdmi.h
> +++ b/drivers/gpu/drm/sun4i/sun4i_hdmi.h
> @@ -178,6 +178,7 @@ struct sun4i_hdmi {
>  };
>  
>  int sun4i_ddc_create(struct sun4i_hdmi *hdmi, struct clk *clk);
> +int sun6i_ddc_create(struct sun4i_hdmi *hdmi, struct clk *clk);
>  int sun4i_tmds_create(struct sun4i_hdmi *hdmi);
>  int sun6i_tmds_create(struct sun4i_hdmi *hdmi);
>  
> diff --git a/drivers/gpu/drm/sun4i/sun4i_hdmi_ddc_clk.c b/drivers/gpu/drm/sun4i/sun4i_hdmi_ddc_clk.c
> index 9a6b6243e977..b1395e7b242c 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_hdmi_ddc_clk.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_hdmi_ddc_clk.c
> @@ -151,3 +151,14 @@ int sun4i_ddc_create(struct sun4i_hdmi *hdmi, struct clk *parent)
>  {
>  	return _sun4i_ddc_create(hdmi, parent, &sun4i_variant);
>  }
> +
> +static const struct sun4i_ddc_variant sun6i_variant = {
> +	.reg_offset	= SUN6I_HDMI_DDC_CLK_REG,

This one should be handled through a regmap_field.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170602/224c43cb/attachment.sig>
