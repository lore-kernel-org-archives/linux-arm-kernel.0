From: chirantan@chromium.org (Chirantan Ekbote)
Date: Wed, 21 May 2014 11:34:12 -0700
Subject: [PATCH] arm: dts: exynos5: Remove multi core timer
In-Reply-To: <033a01cf74f2$d025ce80$70716b80$@samsung.com>
References: <1400188079-21832-1-git-send-email-chirantan@chromium.org>
 <53752E25.9060604@gmail.com>
 <CAD=FV=WKOtZaUyzTWNqR=vi_L=U-Q1dct2U_oCYi3ZJv6401Hg@mail.gmail.com>
 <53753443.8010303@gmail.com>
 <CAD=FV=V8UZoeOqEwfx_E015pLM+amTt51LrUa+dk7mTdn=vKgA@mail.gmail.com>
 <53753C17.1090002@gmail.com>
 <CAD=FV=WGa7j_As_NpySxU7OEd_SzuGWK6oxU6UeiJ-4HsoWvvg@mail.gmail.com>
 <CAJFHJrrgWGc4XGQB0ysLufAg3Wouz-aYXu97Sy2Kp=HzK+akVQ@mail.gmail.com>
 <CAASgrz2Nr69tpfC8ka9gbs2OvjLEGsvgAj4vBCFxhsamuFum7w@mail.gmail.com>
 <53754CE2.3000905@gmail.com>
 <CAD=FV=UMoL7i9rg_QtBAqPwisSQyRqRmk8wQhneMXAiLBjTT1A@mail.gmail.com>
 <CAPz6YkU8GDrLj8UkqEQXxxqxWF5_p427wKSDgAp+QPR7WE7Ujg@mail.gmail.com>
 <CAJFHJrrb2XFDZqJh4OuLdFP=J0aR4pGe-WLWKZ7ZpMfUSPGd4Q@mail.gmail.com>
 <033a01cf74f2$d025ce80$70716b80$@samsung.com>
Message-ID: <CAJFHJroU1RO8YXN4eSEsPz=QNf0i8OXhXy0i9Em1Zkm9rDSJdA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 21, 2014 at 5:47 AM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> Chirantan Ekbote wrote:
>>
>> >>> Anyway, I'm by no means opposed to switching to arch timers. They
>> >>> provide a well designed, generic interface and drivers shared by
>> >>> multiple platforms, which means more code sharing and possibly more eyes
>> >>> looking at the code, which is always good. However if they don't support
>> >>> low power states correctly, we can't just remove MCT.
>> >>
>> >> I think low power states aren't in mainline (right?).
>> >>
>> >> One solution that might work could be to leave the device tree entry
>> >> alone but change the MCT init code to simply act as a no-op if it sees
>> >> an arch timer is in the device tree and enabled.  Then when/if someone
>> >> got the low power states enabled we could just change source code
>> >> rather than dts files.
>> >>
>> Doug and I were talking about this and we think we may have a way to
>> have the mct and arch timers co-exist.  The main issue is that the mct
>> (and therefore arch timer) gets cleared once during boot and every
>> time we do a suspend / resume.  This happens in
>> exynos4_mct_frc_start() but it's not immediately clear to us why the
>> counter needs to be reset at all.  If we remove the lines that clear
>> the counter then there is no longer an issue with having both the mct
>> and the arch timers on at the same time.
>>
> Yeah, actually we don't need to reset the count value after suspend/resume.
> So, how about following? I think, it should be fine to you.
>
> diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mct.c
> index 8d64200..d24db6f 100644
> --- a/drivers/clocksource/exynos_mct.c
> +++ b/drivers/clocksource/exynos_mct.c
> @@ -157,12 +157,15 @@ static void exynos4_mct_frc_start(u32 hi, u32 lo)
>  {
>         u32 reg;
>
> -       exynos4_mct_write(lo, EXYNOS4_MCT_G_CNT_L);
> -       exynos4_mct_write(hi, EXYNOS4_MCT_G_CNT_U);
> -
>         reg = __raw_readl(reg_base + EXYNOS4_MCT_G_TCON);
> -       reg |= MCT_G_TCON_START;
> -       exynos4_mct_write(reg, EXYNOS4_MCT_G_TCON);
> +
> +       if (!(reg & MCT_G_TCON_START)) {
> +               exynos4_mct_write(lo, EXYNOS4_MCT_G_CNT_L);
> +               exynos4_mct_write(hi, EXYNOS4_MCT_G_CNT_U);
> +
> +               reg |= MCT_G_TCON_START;
> +               exynos4_mct_write(reg, EXYNOS4_MCT_G_TCON);
> +       }
>  }
>

So if I understand correctly, we still need to reset the counter
during boot?  This is still a problem because there would be a big
jump in time since the sched_clock code would think that the timer had
wrapped around.  Additionally, any clock events that were scheduled
before the reset would be delayed until the cycle counter caught back
up to the value it had previously.  This manifests itself in our tree
as an extra long jiffy when the xor code is measuring the software
checksum speed and it delays the entire boot process.

There is a hacky solution to this, which is to ensure that the mct is
always initialized before the arch timer.  This should be possible by
reordering the entries in the device tree.  We would also need to
change the clocksource rating for one of the two (either increase the
arch timer rating or decrease the mct rating) to ensure that the
kernel still picked the arch timer as its clocksource.

>
>> Alternately, if there is some code that depends on the mct being reset
>> we could store an offset instead of clearing the counter and then
>> subtract that offset every time something reads it.  Doug has a patch
>> that does this at
>> https://chromium-review.googlesource.com/#/c/200298/.  Effectively the
>> visible behavior will not change.  Would either of these options work?
>>
> Hmm...I cannot open the webpage :(
>

I've attached the patch to this email.

Chirantan
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-clocksource-mct-Don-t-clear-the-mct.patch
Type: text/x-patch
Size: 3636 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140521/5f5ddfae/attachment-0001.bin>
