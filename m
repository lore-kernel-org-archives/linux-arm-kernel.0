From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 21 Jun 2016 22:11:19 +0200
Subject: [RFC][PATCH] arm: ubsan: select ARCH_HAS_UBSAN_SANITIZE_ALL
In-Reply-To: <57696C7B.8050109@virtuozzo.com>
References: <1466487545-22819-1-git-send-email-sw0312.kim@samsung.com>
 <3804659.HRLf903cuS@wuerfel> <57696C7B.8050109@virtuozzo.com>
Message-ID: <5946354.UH0QiYmsAx@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, June 21, 2016 7:34:03 PM CEST Andrey Ryabinin wrote:
> 
> On 06/21/2016 02:44 PM, Arnd Bergmann wrote:
> > On Tuesday, June 21, 2016 10:43:19 AM CEST Arnd Bergmann wrote:
> >> On Tuesday, June 21, 2016 2:39:05 PM CEST Seung-Woo Kim wrote:
> >>> To enable UBSAN on arm, this patch enables ARCH_HAS_UBSAN_SANITIZE_ALL
> >>> from arm confiuration. Basic kernel booting is tested on arm kernel
> >>> enabled CONFIG_UBSAN_SANITIZE_ALL from Exynos5422 based Odroid-XU3
> >>> board.
> >>>
> >>> Signed-off-by: Seung-Woo Kim <sw0312.kim@samsung.com>
> >>> ---
> >>> Because I tested only with specific soc board, so I am not sure the ubsan is
> >>> fine for all other cases. So, I send this patch as a RFC.
> >>>
> >>
> >> I've tried this out on my build test box in the past, but ran into
> >> some problems. In particular I ended up disabling 
> >> -fsanitize=signed-integer-overflow and -fsanitize=object-size
> >> and later reverting the whole thing, but don't remember exactly
> >> why (possibly I was hitting internal compiler errors?).'
> >>
> >> Let me re-enable it with your patch locally and report back
> >> with whatever build problems I run into.
> > 
> > This is what I have run into so far, during  a few dozen randconfig builds,
> > this is with "arm-linux-gnueabi-gcc (GCC) 6.0.0 20160323 (experimental)"
> > and I can try building a newer version if you think that helps.
> > 
> 
> Unlikely newer compiler will change anything. Ubsan causes register pressure and bloats code and stack.
> We could workaround most of the build errors bellow by bumping CONFIG_FRAME_WARN limit.

For the crypto/serpent_generic.c case, I see that on ARM the stack grows
from 560 bytes to 1080 bytes, so almost twice the original size and on x86
it even grows to 1600 bytes, three times what it was before.

I have opened bug reports for the compiler to our Linaro toolchain team
so they can look into the behavior on ARM:

https://bugs.linaro.org/show_bug.cgi?id=2349
https://bugs.linaro.org/show_bug.cgi?id=2350
https://bugs.linaro.org/show_bug.cgi?id=2354

If you are right that the compiler cannot do better than it does now
because of the register pressure, we should probably not just change
the warning limit but also double the kernel stack size for builds with
UBSAN_SANITIZE_ALL enabled, since a large increase in stack frame size
all over the kernel would risk overflowing the kernel stack and
introduce new security risks.

> > ../drivers/video/fbdev/aty/atyfb_base.c: In function 'aty_bl_update_status':
> > ../drivers/video/fbdev/aty/atyfb_base.c:167:33: error: array subscript is above array bounds [-Werror=array-bounds]
> >    return aty_ld_le32(lt_lcd_regs[index], par);
> >                       ~~~~~~~~~~~^~~~~~~
> 
> This is just a bug in code. lt_lcd_regs[] has only 9 elements, while:
> 
> #define LCD_MISC_CNTL		0x14
> ....
> 
> aty_bl_update_status():
> 	unsigned int reg = aty_ld_lcd(LCD_MISC_CNTL, par);

Yes, I already came to the same conclusion and prepared a patch for it, but
have not sent it out yet. The first gcc bug is about the lack of warning
for that one. Again, it's possible that this is a WONTFIX bug because it's
too expensive for gcc to figure out the overflow unless it already does the
-fsanitize=object-size step, but it's also possible that this is something
that gcc should have caught.

> > 
> > Some warnings go away after I turn off -fsanitize=signed-integer-overflow and
> > -fsanitize=object-size, but the one in crypto/serpent_generic.c remains
> > unchanged.
> 
> __serpent_setkey() bloat caused by alignment checks, i.e. -fsanitize=alignment
> 
Right, actually a combination of multiple sanitizers. I also looked into
drivers/media/dvb-frontends/mb86a16.c some more, in that case it was only
-fsanitize=signed-integer-overflow that caused a massive stack growth.

The last one is 

drivers/media/built-in.o: In function `zl10353_calc_nominal_rate':
radio-wl1273.c:(.text+0x207d40): undefined reference to `____ilog2_NaN'
radio-wl1273.c:(.text+0x207df4): undefined reference to `__aeabi_uldivmod'
radio-wl1273.c:(.text+0x207ecc): undefined reference to `__aeabi_uldivmod'
radio-wl1273.c:(.text+0x207f38): undefined reference to `__aeabi_uldivmod'
radio-wl1273.c:(.text+0x207fac): undefined reference to `__aeabi_uldivmod'
radio-wl1273.c:(.text+0x208050): undefined reference to `__aeabi_uldivmod'
drivers/media/built-in.o:radio-wl1273.c:(.text+0x2081e8): more undefined references to `__aeabi_uldivmod' follow

and this is a bug I've run into before, without UBSAN, but it has become
much more frequent now, so I've opened a new gcc bug report for that.

We can work around it by replacing do_div() with something else, but this
looks like gcc is really doing something wrong.

	Arnd
