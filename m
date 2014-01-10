From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Fri, 10 Jan 2014 14:37:40 +0200
Subject: [PATCHv5][ 1/5] fbdev: Add the lacking FB_SYNC_* for matching
 the DISPLAY_FLAGS_*
In-Reply-To: <1383915693-9422-1-git-send-email-denis@eukrea.com>
References: <1383915693-9422-1-git-send-email-denis@eukrea.com>
Message-ID: <52CFE994.8070701@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2013-11-08 15:01, Denis Carikli wrote:
> Without that fix, drivers using the fb_videomode_from_videomode
>   function will not be able to get certain information because
>   some DISPLAY_FLAGS_* have no corresponding FB_SYNC_*.

> diff --git a/include/linux/fb.h b/include/linux/fb.h
> index ffac70a..cf2ad5d 100644
> --- a/include/linux/fb.h
> +++ b/include/linux/fb.h
> @@ -45,6 +45,9 @@ struct device_node;
>  #define FB_SIGNAL_SYNC_ON_GREEN	8
>  #define FB_SIGNAL_SERRATION_ON	16
>  
> +#define FB_SYNC_DE_HIGH_ACT     64      /* data enable active high flag */
> +#define FB_SYNC_PIXDAT_HIGH_ACT 128     /* drive data on positive edge */
> +
>  #define FB_MISC_PRIM_COLOR	1
>  #define FB_MISC_1ST_DETAIL	2	/* First Detailed Timing is preferred */
>  struct fb_chroma {

I don't think this is better than the previous version where
FB_SYNC_DE_HIGH_ACT and FB_SYNC_PIXDAT_HIGH_ACT were in
include/uapi/linux/fb.h. Now those flag defines are not visible to the
userspace, but the actual flags are still visible from the var->sync field.

It's true what Russell replied to the previous version, that the
userspace has no idea how to handle those new flags. But then again, for
LCDs, the userspace has no idea how to handle, say, hsync polarity either.

In any case, splitting the FB_SYNC_ defines into uapi and
kernel-internal header files, but still giving the kernel-internal
values to userspace is surely wrong.

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 901 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140110/f2ef0407/attachment.sig>
