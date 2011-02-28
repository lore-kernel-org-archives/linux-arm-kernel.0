From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Mon, 28 Feb 2011 17:09:17 +0200
Subject: [PATCH resend] omap: Fix linker error in
	drivers/video/omap/lcd_2430sdp.c
In-Reply-To: <20110228164715.e34a965e.jhnikula@gmail.com>
References: <1298193466-29534-1-git-send-email-jhnikula@gmail.com>
	<1298232248-347-1-git-send-email-jhnikula@gmail.com>
	<20110224212644.GN20560@atomide.com>
	<20110228164715.e34a965e.jhnikula@gmail.com>
Message-ID: <1298905757.9809.135.camel@deskari>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2011-02-28 at 08:47 -0600, Jarkko Nikula wrote:
> On Thu, 24 Feb 2011 13:26:44 -0800
> Tony Lindgren <tony@atomide.com> wrote:
> 
> > We should avoid selecting driver related things, otherwise we can never
> > build a tiny kernel with initramfs with everything as modules.
> > 
> > Can you see if adding depends to the LCD panel option does the trick
> > instead?
> > 
> True and as lcd_2430sdp.c is not compiled without CONFIG_FB_OMAP a hack
> below should work a bit better.
> 
> What would you think Tomi?
> 
> diff --git a/drivers/video/omap/Kconfig b/drivers/video/omap/Kconfig
> index 083c8fe..c981249 100644
> --- a/drivers/video/omap/Kconfig
> +++ b/drivers/video/omap/Kconfig
> @@ -5,6 +5,7 @@ config FB_OMAP
>  	select FB_CFB_FILLRECT
>  	select FB_CFB_COPYAREA
>  	select FB_CFB_IMAGEBLIT
> +	select TWL4030_CORE if MACH_OMAP_2430SDP
>  	help
>            Frame buffer driver for OMAP based boards.
> 

Well, it's a bit ugly, but I'm fine with it. It's for the old omapfb,
which hopefully nobody uses anymore (right =), and there's no simple way
to make it modular and neat.

The old omapfb compiles lcd_2430sdp always into the kernel if
MACH_OMAP_2430SDP is defined, so this looks like a correct fix to me.

Heh, interestingly, the old omapfb Makefile says: "Makefile for the new
OMAP framebuffer device driver". Things are relative =).

 Tomi
