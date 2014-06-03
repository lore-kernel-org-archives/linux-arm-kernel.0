From: chirantan@chromium.org (Chirantan Ekbote)
Date: Tue, 3 Jun 2014 11:41:26 -0700
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
Message-ID: <CAJFHJrq79aH1QaDZqT74edwhcmYhriqG9FR4dfO1d24VfH1_uw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kukjin,

On Wed, May 21, 2014 at 5:47 AM, Kukjin Kim <kgene.kim@samsung.com> wrote:
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
>

As Doug mentioned, this seems more complicated than necessary since
the kernel doesn't care about the initial value of the mct counter at
all.  Is there some reason from a hardware standpoint that the counter
needs to be cleared?  If not, I would rather just delete the two
offending lines.  I am sending a patch that does this instead.

Cheers,
Chirantan
