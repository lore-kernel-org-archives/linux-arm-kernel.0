From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Tue, 29 Oct 2013 12:35:11 +0200
Subject: [PATCHv3][ 1/5] fbdev: Add the lacking FB_SYNC_* for matching
 the DISPLAY_FLAGS_*
In-Reply-To: <1382532229-32755-1-git-send-email-denis@eukrea.com>
References: <1382532229-32755-1-git-send-email-denis@eukrea.com>
Message-ID: <526F8F5F.6050905@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23/10/13 15:43, Denis Carikli wrote:
> Without that fix, drivers using the fb_videomode_from_videomode
>   function will not be able to get certain information because
>   some DISPLAY_FLAGS_* have no corresponding FB_SYNC_*.
> 
> Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Cc: linux-fbdev at vger.kernel.org
> Cc: Rob Herring <rob.herring@calxeda.com>
> Cc: Pawel Moll <pawel.moll@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Stephen Warren <swarren@wwwdotorg.org>
> Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
> Cc: devicetree at vger.kernel.org
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: Eric B?nard <eric@eukrea.com>
> Signed-off-by: Denis Carikli <denis@eukrea.com>
> Acked-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> ---
> ChangeLog v2->v3:
> - Added Jean-Christophe PLAGNIOL-VILLARD's ACK.
> ---
>  drivers/video/fbmon.c   |    4 ++++
>  include/uapi/linux/fb.h |    2 ++
>  2 files changed, 6 insertions(+)
> 
> diff --git a/drivers/video/fbmon.c b/drivers/video/fbmon.c
> index 6103fa6..29a9ed0 100644
> --- a/drivers/video/fbmon.c
> +++ b/drivers/video/fbmon.c
> @@ -1402,6 +1402,10 @@ int fb_videomode_from_videomode(const struct videomode *vm,
>  		fbmode->sync |= FB_SYNC_HOR_HIGH_ACT;
>  	if (vm->flags & DISPLAY_FLAGS_VSYNC_HIGH)
>  		fbmode->sync |= FB_SYNC_VERT_HIGH_ACT;
> +	if (vm->flags & DISPLAY_FLAGS_DE_HIGH)
> +		fbmode->sync |= FB_SYNC_DE_HIGH_ACT;
> +	if (vm->flags & DISPLAY_FLAGS_PIXDATA_POSEDGE)
> +		fbmode->sync |= FB_SYNC_PIXDAT_HIGH_ACT;
>  	if (vm->flags & DISPLAY_FLAGS_INTERLACED)
>  		fbmode->vmode |= FB_VMODE_INTERLACED;
>  	if (vm->flags & DISPLAY_FLAGS_DOUBLESCAN)
> diff --git a/include/uapi/linux/fb.h b/include/uapi/linux/fb.h
> index fb795c3..30487df 100644
> --- a/include/uapi/linux/fb.h
> +++ b/include/uapi/linux/fb.h
> @@ -215,6 +215,8 @@ struct fb_bitfield {
>  					/* vtotal = 144d/288n/576i => PAL  */
>  					/* vtotal = 121d/242n/484i => NTSC */
>  #define FB_SYNC_ON_GREEN	32	/* sync on green */
> +#define FB_SYNC_DE_HIGH_ACT	64	/* data enable high active */
> +#define FB_SYNC_PIXDAT_HIGH_ACT	64	/* data enable high active */

This can't be right. You map both flags to value 64. And the comment is
the same for both.

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 901 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131029/6985d4b0/attachment.sig>
