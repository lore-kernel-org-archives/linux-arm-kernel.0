From: eric.y.miao@gmail.com (Eric Miao)
Date: Fri, 30 Oct 2009 11:19:42 +0800
Subject: [PATCH] ARM: pxafb: Use the passed fb_var_screeninfo struct in
	pxafb_pan_display()
In-Reply-To: <20091029195156.GI22046@sci.fi>
References: <20091022063434.GQ14091@buzzloop.caiaq.de>
	<20091028001805.GC14091@buzzloop.caiaq.de>
	<f17812d70910271913l15950170we45290bb1892761a@mail.gmail.com>
	<20091029195156.GI22046@sci.fi>
Message-ID: <f17812d70910292019j658059b4v1bd5b085c91226c6@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 30, 2009 at 3:51 AM, Ville Syrj?l? <syrjala@sci.fi> wrote:
> On Wed, Oct 28, 2009 at 10:13:17AM +0800, Eric Miao wrote:
>> I see no problem with this patch, applied to 'devel'.
>
> This patch looks broken to me. The only fields of of the fb_var_screeninfo
> passed to pan_display that should be used are xoffset, yoffset and
> vmode & FB_VMODE_YWRAP. The rest are not checked by the common code at
> all and depending on the hardware the pan operation may involve looking
> at any number of fields from fb_var_screeninfo so if other fields are
> taken from the passed fb_var_screeninfo the pan operation may end up doing
> a lot more than panning (eg. it could change the video mode). Even worse
> things could happen since the values are not checked at all.
>
> To prevent driver authors' from shooting themselves in the foot it might
> make sense to change the common code to make a copy of info->var and
> merge those three fields from the passed fb_var_screeninfo into the copy,
> which would then be passed to the driver.
>

Daniel,

Could you please help look into this?

>>
>> On Wed, Oct 28, 2009 at 8:18 AM, Daniel Mack <daniel@caiaq.de> wrote:
>> > Any idea what to do with this one?
>> >
>> > Daniel
>> >
>> >
>> > On Thu, Oct 22, 2009 at 08:34:34AM +0200, Daniel Mack wrote:
>> >> Hi Eric,
>> >>
>> >> this one has been living in our kernel tree for quite some time now but
>> >> it seems it hasn't been merged yet. It's needed to make the pxafb driver
>> >> work with DirectFB applications properly.
>> >>
>> >> Thanks,
>> >> Daniel
>> >>
>> >>
>> >> From 42e8a4226777b6cc82988061c80167813f403ec8 Mon Sep 17 00:00:00 2001
>> >> From: Sven Neumann <s.neumann@raumfeld.com>
>> >> Date: Wed, 6 May 2009 16:22:50 +0200
>> >> Subject: [PATCH] ARM: pxafb: Use the passed fb_var_screeninfo struct in pxafb_pan_display()
>> >>
>> >> pxafb_pan_display() used to ignore the fb_var_screeninfo parameter. Now
>> >> pass it to setup_base_frame() instead of pulling default values out of
>> >> fb_info.
>> >>
>> >> Signed-off-by: Sven Neumann <s.neumann@raumfeld.com>
>> >> Signed-off-by: Daniel Mack <daniel@caiaq.de>
>> >> Cc: Eric Miao <eric.y.miao@gmail.com>
>> >> ---
>> >> ?drivers/video/pxafb.c | ? 12 +++++++-----
>> >> ?1 files changed, 7 insertions(+), 5 deletions(-)
>> >>
>> >> diff --git a/drivers/video/pxafb.c b/drivers/video/pxafb.c
>> >> index 1820c4a..a20a7d4 100644
>> >> --- a/drivers/video/pxafb.c
>> >> +++ b/drivers/video/pxafb.c
>> >> @@ -80,7 +80,8 @@
>> >> ?static int pxafb_activate_var(struct fb_var_screeninfo *var,
>> >> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? struct pxafb_info *);
>> >> ?static void set_ctrlr_state(struct pxafb_info *fbi, u_int state);
>> >> -static void setup_base_frame(struct pxafb_info *fbi, int branch);
>> >> +static void setup_base_frame(struct pxafb_info *fbi,
>> >> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? struct fb_var_screeninfo *var, int branch);
>> >> ?static int setup_frame_dma(struct pxafb_info *fbi, int dma, int pal,
>> >> ? ? ? ? ? ? ? ? ? ? ? ? ?unsigned long offset, size_t size);
>> >>
>> >> @@ -536,7 +537,7 @@ static int pxafb_pan_display(struct fb_var_screeninfo *var,
>> >> ? ? ? if (fbi->state != C_ENABLE)
>> >> ? ? ? ? ? ? ? return 0;
>> >>
>> >> - ? ? setup_base_frame(fbi, 1);
>> >> + ? ? setup_base_frame(fbi, var, 1);
>> >>
>> >> ? ? ? if (fbi->lccr0 & LCCR0_SDS)
>> >> ? ? ? ? ? ? ? lcd_writel(fbi, FBR1, fbi->fdadr[dma + 1] | 0x1);
>> >> @@ -1052,9 +1053,10 @@ static int setup_frame_dma(struct pxafb_info *fbi, int dma, int pal,
>> >> ? ? ? return 0;
>> >> ?}
>> >>
>> >> -static void setup_base_frame(struct pxafb_info *fbi, int branch)
>> >> +static void setup_base_frame(struct pxafb_info *fbi,
>> >> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? struct fb_var_screeninfo *var,
>> >> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? int branch)
>> >> ?{
>> >> - ? ? struct fb_var_screeninfo *var = &fbi->fb.var;
>> >> ? ? ? struct fb_fix_screeninfo *fix = &fbi->fb.fix;
>> >> ? ? ? int nbytes, dma, pal, bpp = var->bits_per_pixel;
>> >> ? ? ? unsigned long offset;
>> >> @@ -1332,7 +1334,7 @@ static int pxafb_activate_var(struct fb_var_screeninfo *var,
>> >> ?#endif
>> >> ? ? ? ? ? ? ? setup_parallel_timing(fbi, var);
>> >>
>> >> - ? ? setup_base_frame(fbi, 0);
>> >> + ? ? setup_base_frame(fbi, var, 0);
>> >>
>> >> ? ? ? fbi->reg_lccr0 = fbi->lccr0 |
>> >> ? ? ? ? ? ? ? (LCCR0_LDM | LCCR0_SFM | LCCR0_IUM | LCCR0_EFM |
>> >> --
>> >> 1.6.5
>> >>
>> >>
>> >> _______________________________________________
>> >> linux-arm-kernel mailing list
>> >> linux-arm-kernel at lists.infradead.org
>> >> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>> >
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
> --
> Ville Syrj?l?
> syrjala at sci.fi
> http://www.sci.fi/~syrjala/
>
