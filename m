From: jic23@cam.ac.uk (Jonathan Cameron)
Date: Mon, 08 Mar 2010 17:57:23 +0000
Subject: pxa: Couple of build issues (missing dependencies)
Message-ID: <4B953A83.7020705@cam.ac.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Whilst testing the uncompress patch just sent, I tried a full build
of pxa platforms by just enabling them along side my normal couple.
This is more or less a vanilla tree as of earlier today (+ a couple
of uncompress related patches from Eric's tree).  I haven't chased
these down terribly carefully  but thought I might as well bring them
to the lists attention.

Sharpsl_pm calls max1111_read_channel if CONFIG_CORGI_SSP_DEPRECATED
is not set.  There is no dependancy to enforce this being available.
(none obvious in the pxa devel tree either).


FB_W100 is selected by MACH_E740 leading to the following which
I would guess indicate some missing dependencies as well.
Looks like it doesn't actually drag in frame buffer support as I'd
imagine was intended:

drivers/built-in.o: In function `w100fb_remove':
/home/jic23/src/kernel/fix.git/drivers/video/w100fb.c:794: undefined reference to `unregister_framebuffer'
/home/jic23/src/kernel/fix.git/drivers/video/w100fb.c:799: undefined reference to `fb_dealloc_cmap'
/home/jic23/src/kernel/fix.git/drivers/video/w100fb.c:805: undefined reference to `framebuffer_release'
drivers/built-in.o: In function `w100fb_copyarea':
/home/jic23/src/kernel/fix.git/drivers/video/w100fb.c:385: undefined reference to `cfb_copyarea'
drivers/built-in.o: In function `w100fb_fillrect':
/home/jic23/src/kernel/fix.git/drivers/video/w100fb.c:357: undefined reference to `cfb_fillrect'
drivers/built-in.o: In function `w100fb_probe':
/home/jic23/src/kernel/fix.git/drivers/video/w100fb.c:672: undefined reference to `framebuffer_alloc'
/home/jic23/src/kernel/fix.git/drivers/video/w100fb.c:715: undefined reference to `fb_alloc_cmap'
/home/jic23/src/kernel/fix.git/drivers/video/w100fb.c:751: undefined reference to `register_framebuffer'
/home/jic23/src/kernel/fix.git/drivers/video/w100fb.c:779: undefined reference to `framebuffer_release'
/home/jic23/src/kernel/fix.git/drivers/video/w100fb.c:769: undefined reference to `fb_dealloc_cmap'
drivers/built-in.o:(.data+0x208): undefined reference to `cfb_imageblit'

Thanks,

Jonathan
