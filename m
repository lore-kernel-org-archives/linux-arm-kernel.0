From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Fri, 9 May 2014 10:38:54 +0300
Subject: [PATCH 1/4] OMAPDSS: Fix DSS clock multiplier issue on 3703 and
 probably 3630
In-Reply-To: <1398815562-24113-2-git-send-email-tony@atomide.com>
References: <1398815562-24113-1-git-send-email-tony@atomide.com>
 <1398815562-24113-2-git-send-email-tony@atomide.com>
Message-ID: <536C860E.1000501@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30/04/14 02:52, Tony Lindgren wrote:
> Otherwise we can get often errors like the following and the
> display won't come on:
> 
> omapdss APPLY error: FIFO UNDERFLOW on gfx, disabling the overlay
> omapdss APPLY error: SYNC_LOST on channel lcd, restarting
> the output with video overlays disabled
> 
> There are some earlier references to this issue:
> 
> http://www.spinics.net/lists/linux-omap/msg59511.html
> http://www.spinics.net/lists/linux-omap/msg59724.html

Those don't sound like the same issue, but it's hard to say. What kind
of clock rates do you get? Cat you paste debugfs/omapdss/clk, with and
without this patch?

What resolution do you have? If it's a very high resolution (say, DVI
output to a monitor), it could just be an issue of
not-enough-memory-bandwidth.

> It seems that it's safe to set the lower values even for 3630.
> If we can confirm that 3630 works with the higher values
> reliably we can add further detection.
> 
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  drivers/video/fbdev/omap2/dss/dss.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/video/fbdev/omap2/dss/dss.c b/drivers/video/fbdev/omap2/dss/dss.c
> index d55266c..ad6561f 100644
> --- a/drivers/video/fbdev/omap2/dss/dss.c
> +++ b/drivers/video/fbdev/omap2/dss/dss.c
> @@ -707,9 +707,10 @@ static const struct dss_features omap34xx_dss_feats __initconst = {
>  	.dpi_select_source	=	&dss_dpi_select_source_omap2_omap3,
>  };
>  
> +/* Supposedly 3630 can use div 32 mult 2, but that needs to be rechecked */
>  static const struct dss_features omap3630_dss_feats __initconst = {
> -	.fck_div_max		=	32,
> -	.dss_fck_multiplier	=	1,
> +	.fck_div_max		=	16,
> +	.dss_fck_multiplier	=	2,

These values tell about the clock hardware, they are not settings that
can be changed to change the clock. OMAP3630 has a fixed x2 multiplier
and a divider with maximum value of 16.

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140509/9322631b/attachment.sig>
