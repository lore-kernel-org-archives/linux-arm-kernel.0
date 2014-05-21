From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 21 May 2014 21:47:20 +0900
Subject: [PATCH] arm: dts: exynos5: Remove multi core timer
In-Reply-To: <CAJFHJrrb2XFDZqJh4OuLdFP=J0aR4pGe-WLWKZ7ZpMfUSPGd4Q@mail.gmail.com>
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
Message-ID: <033a01cf74f2$d025ce80$70716b80$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Chirantan Ekbote wrote:
> 
> >>> Anyway, I'm by no means opposed to switching to arch timers. They
> >>> provide a well designed, generic interface and drivers shared by
> >>> multiple platforms, which means more code sharing and possibly more eyes
> >>> looking at the code, which is always good. However if they don't support
> >>> low power states correctly, we can't just remove MCT.
> >>
> >> I think low power states aren't in mainline (right?).
> >>
> >> One solution that might work could be to leave the device tree entry
> >> alone but change the MCT init code to simply act as a no-op if it sees
> >> an arch timer is in the device tree and enabled.  Then when/if someone
> >> got the low power states enabled we could just change source code
> >> rather than dts files.
> >>
> Doug and I were talking about this and we think we may have a way to
> have the mct and arch timers co-exist.  The main issue is that the mct
> (and therefore arch timer) gets cleared once during boot and every
> time we do a suspend / resume.  This happens in
> exynos4_mct_frc_start() but it's not immediately clear to us why the
> counter needs to be reset at all.  If we remove the lines that clear
> the counter then there is no longer an issue with having both the mct
> and the arch timers on at the same time.
> 
Yeah, actually we don't need to reset the count value after suspend/resume.
So, how about following? I think, it should be fine to you.

diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mct.c
index 8d64200..d24db6f 100644
--- a/drivers/clocksource/exynos_mct.c
+++ b/drivers/clocksource/exynos_mct.c
@@ -157,12 +157,15 @@ static void exynos4_mct_frc_start(u32 hi, u32 lo)
 {
 	u32 reg;
 
-	exynos4_mct_write(lo, EXYNOS4_MCT_G_CNT_L);
-	exynos4_mct_write(hi, EXYNOS4_MCT_G_CNT_U);
-
 	reg = __raw_readl(reg_base + EXYNOS4_MCT_G_TCON);
-	reg |= MCT_G_TCON_START;
-	exynos4_mct_write(reg, EXYNOS4_MCT_G_TCON);
+
+	if (!(reg & MCT_G_TCON_START)) {
+		exynos4_mct_write(lo, EXYNOS4_MCT_G_CNT_L);
+		exynos4_mct_write(hi, EXYNOS4_MCT_G_CNT_U);
+
+		reg |= MCT_G_TCON_START;
+		exynos4_mct_write(reg, EXYNOS4_MCT_G_TCON);
+	}
 }


> Alternately, if there is some code that depends on the mct being reset
> we could store an offset instead of clearing the counter and then
> subtract that offset every time something reads it.  Doug has a patch
> that does this at
> https://chromium-review.googlesource.com/#/c/200298/.  Effectively the
> visible behavior will not change.  Would either of these options work?
> 
Hmm...I cannot open the webpage :(

- Kukjin
