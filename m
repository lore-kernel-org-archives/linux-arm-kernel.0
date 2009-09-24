From: mike.rapoport@gmail.com (Mike Rapoport)
Date: Thu, 24 Sep 2009 19:46:18 +0300
Subject: patches for pxafb
In-Reply-To: <3ea34a000909240715i2742faa8r83f574e7d652d3b9@mail.gmail.com>
References: <3ea34a000909240715i2742faa8r83f574e7d652d3b9@mail.gmail.com>
Message-ID: <f870da180909240946u60ab9439p8e2b1d70073d870b@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Christopher,

On Thu, Sep 24, 2009 at 5:15 PM, Christopher Friedt
<chrisfriedt@gmail.com> wrote:
> Hi folks,
>
> I have a couple of patches for the pxa framebuffer that I would like
> to submit upstream,
> but I'm fairly new to it and thought that this would be a good place to start.
>
> [1] add width / height members to struct pxafb_mach_info, and related
> code in pxafb.c

This might be usefull indeed.

> [2] add code to handle double-buffer allocation in pxafb_set_par()

If I'm not much mistaken, pxafb can utilize panning to support double
buffering. You just need to set video_mem_size to be 2*xres*yres*bpp,
and then y-pan will emulate double buffering

> Also, I wrote a multi-function driver for the STMPE2401 gpio expander
> / keypad controller / rotator input / pwm output ?chip, and would
> really appreciate it if someone could review it. I already informed
> another project (PeekLinux) via IRC, because their device uses the
> same chip, but had no replies. The code currently only impliments
> keypad functionality, but I've made lots of room / structure for the
> rest of the multi-function devices. I'd like to submit that upstream
> at some point after a couple of reviews. Any volounteers? :-)

Send your patch MFD maintainer and LKML. You may CC me as well, I'll
try to find time to review your pacth.

> Cheers,
>
> Chris
>

>
> [1]
>
> diff --git a/arch/arm/mach-pxa/include/mach/pxafb.h
> b/arch/arm/mach-pxa/include/mach/pxafb.h
> index 6932720..44e1c93 100644
> --- a/arch/arm/mach-pxa/include/mach/pxafb.h
> +++ b/arch/arm/mach-pxa/include/mach/pxafb.h
> @@ -115,6 +115,10 @@ struct pxafb_mach_info {
> ? ? ? ?unsigned int ? ?lcd_conn;
> ? ? ? ?unsigned long ? video_mem_size;
>
> + ? ? ? // physical dimensions of the display (mm)

C++ style comments are not allowed in the kernel.

> + ? ? ? unsigned int ? ?width;
> + ? ? ? unsigned int ? ?height;
> +
> ? ? ? ?u_int ? ? ? ? ? fixed_modes:1,
> ? ? ? ? ? ? ? ? ? ? ? ?cmap_inverse:1,
> ? ? ? ? ? ? ? ? ? ? ? ?cmap_static:1,
>
> [2]
>
> diff --git a/drivers/video/pxafb.c b/drivers/video/pxafb.c
> index 6506117..14921a8 100644
> --- a/drivers/video/pxafb.c
> +++ b/drivers/video/pxafb.c
> @@ -493,6 +493,32 @@ static int pxafb_set_par(struct fb_info *info)
> ?{
> ? ? ? ?struct pxafb_info *fbi = (struct pxafb_info *)info;
> ? ? ? ?struct fb_var_screeninfo *var = &info->var;
> + ? ? ? void *newmem = NULL, *oldmem;
> + ? ? ? int size;
> +
> + ? ? ? // increase yres_virtual for double buffering
> + ? ? ? if ( var->yres_virtual ? != ? ? fbi->fb.var.yres_virtual ? &&
> + ? ? ? ? ? ? ? ?var->yres_virtual ? == 2 * fbi->fb.var.yres ? ? ? ? ? &&
> + ? ? ? ? ? ? ? ?var->xres ? ? ? ? ? == ? ? fbi->fb.var.xres ? ? ? ? ? &&
> + ? ? ? ? ? ? ? ?var->bits_per_pixel == ? ? fbi->fb.var.bits_per_pixel ){
> +
> + ? ? ? ? ? ? ? oldmem = fbi->video_mem;
> + ? ? ? ? ? ? ? size = PAGE_ALIGN( 2 * fbi->video_mem_size );
> +
> + ? ? ? ? ? ? ? newmem = alloc_pages_exact(size, GFP_KERNEL | __GFP_ZERO);
> + ? ? ? ? ? ? ? if ( newmem == NULL ) return -ENOMEM;
> +
> + ? ? ? ? ? ? ? fbi->video_mem_phys ? ? = virt_to_phys(fbi->video_mem);
> + ? ? ? ? ? ? ? fbi->video_mem_size ? ? = size;
> + ? ? ? ? ? ? ? fbi->fb.fix.smem_start ?= fbi->video_mem_phys;
> + ? ? ? ? ? ? ? fbi->fb.fix.smem_len ? ?= fbi->video_mem_size;
> + ? ? ? ? ? ? ? fbi->fb.screen_base ? ? ? ? ? ? = fbi->video_mem;
> +
> + ? ? ? ? ? ? ? fbi->fb.var.yres_virtual = var->yres_virtual;
> + ? ? ? ? ? ? ? fbi->fb.flags |= FBINFO_HWACCEL_YPAN | FBINFO_PARTIAL_PAN_OK;
> +
> + ? ? ? ? ? ? ? kfree( oldmem );
> + ? ? ? }

As I said, it seems to me that it's enough to set video_mem_size in
pxa_mach_info and the panning will be used to emulate double
buffering.

> ? ? ? ?if (var->bits_per_pixel >= 16)
> ? ? ? ? ? ? ? ?fbi->fb.fix.visual = FB_VISUAL_TRUECOLOR;
> ?#ifdef CONFIG_FB_PXA_OVERLAY
> @@ -1685,7 +1713,13 @@ static void pxafb_decode_mach_info(struct
> pxafb_info *fbi,
>
> ? ? ? ?fbi->cmap_inverse ? ? ? = inf->cmap_inverse;
> ? ? ? ?fbi->cmap_static ? ? ? ?= inf->cmap_static;
> ? ? ? ?fbi->lccr4 ? ? ? ? ? ? ?= inf->lccr4;
> +
> + ? ? ? // set physical display dimensions from mach info

No C++ comments

> + ? ? ? if ( inf->width && inf->height ) {
> + ? ? ? ? ? ? ? fbi->fb.var.width = inf->width;
> + ? ? ? ? ? ? ? fbi->fb.var.height = inf->height;
> + ? ? ? }
>
> ? ? ? ?switch (lcd_conn & LCD_TYPE_MASK) {
> ? ? ? ?case LCD_TYPE_MONO_STN:
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>



-- 
	Sincerely Yours,
		Mike.
