From: chrisfriedt@gmail.com (Christopher Friedt)
Date: Thu, 24 Sep 2009 16:15:54 +0200
Subject: patches for pxafb
Message-ID: <3ea34a000909240715i2742faa8r83f574e7d652d3b9@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi folks,

I have a couple of patches for the pxa framebuffer that I would like
to submit upstream,
but I'm fairly new to it and thought that this would be a good place to start.

[1] add width / height members to struct pxafb_mach_info, and related
code in pxafb.c

* useful for providing physical display dimensions to the struct
fb_var_screeninfo
* some applications (namely Android) will look for these metrics to
get an idea of
  what the pixels-per-inch ratio is
* this is something that can vary on a per-machine basis, which is why
I put it in
  pxafb_mach_info

[2] add code to handle double-buffer allocation in pxafb_set_par()

* normally, only a single image-buffer (xres*yres*bpp/8) is allocated
when the device
  is probed
* some applications (namely Android) rely on having a back-buffer in
the kernel for
  page-flipping and they will try to request that with the FBIOPUT_VSCREENINFO
  ioctl. This would normally fail on the pxafb (mine at least).
* this code checks specifically that xres,yres, and bpp don't change, and that
  yres_virtual == 2 * yres, when userspace passes the fb_var_screeninfo back.
  Kernelspace will then try to allocate a second image buffer and
replace / free the
  first one if successful

Also, I wrote a multi-function driver for the STMPE2401 gpio expander
/ keypad controller / rotator input / pwm output  chip, and would
really appreciate it if someone could review it. I already informed
another project (PeekLinux) via IRC, because their device uses the
same chip, but had no replies. The code currently only impliments
keypad functionality, but I've made lots of room / structure for the
rest of the multi-function devices. I'd like to submit that upstream
at some point after a couple of reviews. Any volounteers? :-)

Cheers,

Chris


[1]

diff --git a/arch/arm/mach-pxa/include/mach/pxafb.h
b/arch/arm/mach-pxa/include/mach/pxafb.h
index 6932720..44e1c93 100644
--- a/arch/arm/mach-pxa/include/mach/pxafb.h
+++ b/arch/arm/mach-pxa/include/mach/pxafb.h
@@ -115,6 +115,10 @@ struct pxafb_mach_info {
 	unsigned int	lcd_conn;
 	unsigned long	video_mem_size;

+	// physical dimensions of the display (mm)
+	unsigned int	width;
+	unsigned int	height;
+
 	u_int		fixed_modes:1,
 			cmap_inverse:1,
 			cmap_static:1,

[2]

diff --git a/drivers/video/pxafb.c b/drivers/video/pxafb.c
index 6506117..14921a8 100644
--- a/drivers/video/pxafb.c
+++ b/drivers/video/pxafb.c
@@ -493,6 +493,32 @@ static int pxafb_set_par(struct fb_info *info)
 {
 	struct pxafb_info *fbi = (struct pxafb_info *)info;
 	struct fb_var_screeninfo *var = &info->var;
+	void *newmem = NULL, *oldmem;
+	int size;
+
+	// increase yres_virtual for double buffering
+	if ( var->yres_virtual   !=     fbi->fb.var.yres_virtual   &&
+		 var->yres_virtual   == 2 * fbi->fb.var.yres           &&
+		 var->xres           ==     fbi->fb.var.xres           &&
+		 var->bits_per_pixel ==     fbi->fb.var.bits_per_pixel ){
+
+		oldmem = fbi->video_mem;
+		size = PAGE_ALIGN( 2 * fbi->video_mem_size );
+
+		newmem = alloc_pages_exact(size, GFP_KERNEL | __GFP_ZERO);
+		if ( newmem == NULL ) return -ENOMEM;
+
+		fbi->video_mem_phys 	= virt_to_phys(fbi->video_mem);
+		fbi->video_mem_size 	= size;
+		fbi->fb.fix.smem_start	= fbi->video_mem_phys;
+		fbi->fb.fix.smem_len	= fbi->video_mem_size;
+		fbi->fb.screen_base		= fbi->video_mem;
+
+		fbi->fb.var.yres_virtual = var->yres_virtual;
+		fbi->fb.flags |= FBINFO_HWACCEL_YPAN | FBINFO_PARTIAL_PAN_OK;
+
+		kfree( oldmem );
+	}

 	if (var->bits_per_pixel >= 16)
 		fbi->fb.fix.visual = FB_VISUAL_TRUECOLOR;
 #ifdef CONFIG_FB_PXA_OVERLAY
@@ -1685,7 +1713,13 @@ static void pxafb_decode_mach_info(struct
pxafb_info *fbi,

 	fbi->cmap_inverse	= inf->cmap_inverse;
 	fbi->cmap_static	= inf->cmap_static;
	fbi->lccr4 		= inf->lccr4;
+
+	// set physical display dimensions from mach info
+	if ( inf->width && inf->height ) {
+		fbi->fb.var.width = inf->width;
+		fbi->fb.var.height = inf->height;
+	}

 	switch (lcd_conn & LCD_TYPE_MASK) {
 	case LCD_TYPE_MONO_STN:
