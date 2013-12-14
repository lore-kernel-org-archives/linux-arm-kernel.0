From: olof@lixom.net (Olof Johansson)
Date: Fri, 13 Dec 2013 21:52:11 -0800
Subject: [PATCH CRITICAL] ARM: s3c64xx: dt: Fix boot failure due to double
 clock initialization
In-Reply-To: <1386964779-29457-1-git-send-email-tomasz.figa@gmail.com>
References: <1386964779-29457-1-git-send-email-tomasz.figa@gmail.com>
Message-ID: <CAOesGMifjnTDUcsweOwsw9fFgsE7b4q3wsASfP8YL-uMH5KiPA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 13, 2013 at 11:59 AM, Tomasz Figa <tomasz.figa@gmail.com> wrote:
> Commit
>
> 4178bac ARM: call of_clk_init from default time_init handler
>
> added implicit call to of_clk_init() from default time_init callback,
> but it did not change platforms calling it from other callbacks, despite
> of not having custom time_init callbacks. This caused double clock
> initialization on such platforms, leading to boot failures. An example
> of such platform is mach-s3c64xx.
>
> This patch fixes boot failure on s3c64xx by dropping custom init_irq
> callback, which had a call to of_clk_init() and moving system reset
> initialization to init_machine callback. This allows us to have
> clocks initialized properly without a need to have custom init_time or
> init_irq callbacks.
>
> Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
> ---
>  arch/arm/mach-s3c64xx/mach-s3c64xx-dt.c | 11 +----------
>  1 file changed, 1 insertion(+), 10 deletions(-)
>
> NOTE: This is a critical boot regression fix for mach-s3c64xx that
> should be merged for next 3.13-rc release.

Applied to fixes. We sent a batch of fixes just the other day so this
will likely go in sometime next week, but it'll be in linux-next as of
the next release.

Hm, it'd be nice to get better coverage of 64xx as well as exynos 4.
Are there any cheap 64xx development boards out there?


-Olof
