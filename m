From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Thu, 25 Feb 2016 18:45:37 +0200
Subject: [PATCH 11/11] ARM: versatile: move CLCD configuration to device
 tree
In-Reply-To: <CACRpkdZd8TLdsi7_cOrqzcqWKJrfdp4Vz2sx5ozpwJXOj0fa+Q@mail.gmail.com>
References: <1454594660-7532-1-git-send-email-linus.walleij@linaro.org>
 <3695074.sKSIyOjpjD@wuerfel>
 <CACRpkdZjfjOCFUucF1U5yVZBxSwa41GKEMv-HHQE=ymF2NZ21g@mail.gmail.com>
 <6859810.tb1t0IEONi@wuerfel> <56CC57FC.20707@ti.com>
 <CACRpkdYNaNtQQJ-tsBe5ksa4-z380ZQj-zN8ZnK0ED2kNPUwvg@mail.gmail.com>
 <56CC60C4.6040908@ti.com>
 <CACRpkdZd8TLdsi7_cOrqzcqWKJrfdp4Vz2sx5ozpwJXOj0fa+Q@mail.gmail.com>
Message-ID: <56CF2FB1.106@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 25/02/16 16:04, Linus Walleij wrote:
> On Tue, Feb 23, 2016 at 2:38 PM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> 
>> Maybe Versatile is different. If CLCD is only used on that board, or a
>> small family of boards, from one vendor, I guess it is maintainable to
>> have board specific driver parts for CLCD. But if CLCD can be used by
>> many vendors in many different boards, I'd steer clear of board specific
>> driver code.
> 
> OK I think at this point we would say that CLCD is a legacy driver.

Ok.

My biggest fear with this is the maintenance nightmare that comes if an
IP or panel is used in multiple SoCs and future designs. We have the
same display subsystem and panel drivers used from OMAP2 forward, and
it's been a constant struggle, so I've come to appreciate the effort to
split things up as much as possible, so that when the time comes when
the HW guys have decided to change a piece here or there, it's easier to
cope with.

Anyway, if it's likely that we're not seeing new CLCD boards, I think
it's fine if we don't go to any great lengths to clean things up there.
Let's just get it working.

> HOWEVER: the ARM Versatile is the *only* platform I have
> seen of these that have plug'n'play for the display.

Ok. And presumably no new boards will use that plug'n'play display, so
we can just consider it specific to versatile.

> *All* the others
> will be very happy with *ONE* display defined as panel in the
> device tree, and off they go. Usually VGA. And that will look

You keep mentioning VGA. So is there are VGA output? Or do you just mean
MIPI DPI panels, which happen to take the same video timings as VGA?

> I add support for doing this for the Integrator and RealView in
> the patch set, by grabbing a handle to the system controller
> where they have a few "misc registers". However if you look at
> it:
> 
> static void integrator_clcd_enable(struct clcd_fb *fb)
> {
>         struct fb_var_screeninfo *var = &fb->fb.var;
>         u32 val;
> 
>         dev_info(&fb->dev->dev, "enable Integrator CLCD connectors\n");
> 
>         val = INTEGRATOR_CLCD_LCD_STATIC1 | INTEGRATOR_CLCD_LCD_STATIC2 |
>                 INTEGRATOR_CLCD_LCD0_EN | INTEGRATOR_CLCD_LCD1_EN;
>         if (var->bits_per_pixel <= 8 ||
>             (var->bits_per_pixel == 16 && var->green.length == 5))
>                 /* Pseudocolor, RGB555, BGR555 */
>                 val |= INTEGRATOR_CLCD_LCDMUX_VGA555;
>         else if (fb->fb.var.bits_per_pixel <= 16)
>                 /* truecolor RGB565 */
>                 val |= INTEGRATOR_CLCD_LCDMUX_VGA565;
>         else
>                 val = 0; /* no idea for this, don't trust the docs */
> 
>         regmap_update_bits(versatile_syscon_map,
>                            INTEGRATOR_HDR_CTRL_OFFSET,
>                            0,
>                            INTEGRATOR_CLCD_MASK);
> }
> 
> This is stuff that is so closely tied in to the fbdev driver that even
> if it is SoC-specific (and reside in arch/arm/mach-integrator etc
> today) it would be hard to argument that it should not be part
> of the fbdev driver: what it does is connect the lines out of the
> CLCD block to the physical VGA encode chip in different ways
> depending on how the pixels were set up.

Hmm so is there an external VGA encoder on the board?

 Tomi

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160225/bd6de85d/attachment-0001.sig>
