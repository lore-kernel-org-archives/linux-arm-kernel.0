From: dianders@chromium.org (Doug Anderson)
Date: Wed, 15 Nov 2017 10:45:34 -0800
Subject: [RFC] Improving udelay/ndelay on platforms where that is possible
In-Reply-To: <11393e07-b042-180c-3bcd-484bf51eada6@sigmadesigns.com>
References: <d3f42f35-8175-58f6-78b7-3331efe64da2@sigmadesigns.com>
 <20171101175325.2557ce85@alans-desktop>
 <4b707ce0-6067-ab36-e167-1acf348d26bf@free.fr>
 <CA+55aFxxH0HE9SfUoLVqsvDKO0PfeM+vSoDmbXQv85yJcPZoPQ@mail.gmail.com>
 <e03436d1-b140-3f29-59a6-3b1eb6bf9da4@free.fr>
 <11393e07-b042-180c-3bcd-484bf51eada6@sigmadesigns.com>
Message-ID: <CAD=FV=UxTwZdPa0QpcH810pRwua9i2+2uKWQwQTuVAihtCTGGg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Nov 15, 2017 at 4:51 AM, Marc Gonzalez
<marc_gonzalez@sigmadesigns.com> wrote:
> On 01/11/2017 20:38, Marc Gonzalez wrote:
>
>> OK, I'll just send my patch, and then crawl back under my rock.
>
> Linus,
>
> As promised, the patch is provided below. And as promised, I will
> no longer bring this up on LKML.
>
> FWIW, I have checked that the computed value matches the expected
> value for all HZ and delay_us, and for a few clock frequencies,
> using the following program:
>
> $ cat delays.c
> #include <stdio.h>
> #define MEGA 1000000u
> typedef unsigned int uint;
> typedef unsigned long long u64;
> #define DIV_ROUND_UP(n,d) (((n) + (d) - 1) / (d))
>
> static const uint HZ_tab[] = { 100, 250, 300, 1000 };
>
> static void check_cycle_count(uint freq, uint HZ, uint delay_us)
> {
>         uint UDELAY_MULT = (2147 * HZ) + (483648 * HZ / MEGA);
>         uint lpj = DIV_ROUND_UP(freq, HZ);
>         uint computed = ((u64)lpj * delay_us * UDELAY_MULT >> 31) + 1;
>         uint expected = DIV_ROUND_UP((u64)delay_us * freq, MEGA);
>
>         if (computed != expected)
>                 printf("freq=%u HZ=%u delay_us=%u comp=%u exp=%u\n", freq, HZ, delay_us, computed, expected);
> }
>
> int main(void)
> {
>         uint idx, delay_us, freq;
>
>         for (freq = 3*MEGA; freq <= 100*MEGA; freq += 3*MEGA)
>                 for (idx = 0; idx < sizeof HZ_tab / sizeof *HZ_tab; ++idx)
>                         for (delay_us = 1; delay_us <= 2000; ++delay_us)
>                                 check_cycle_count(freq, HZ_tab[idx], delay_us);
>
>         return 0;
> }
>
>
>
> -- >8 --
> Subject: [PATCH] ARM: Tweak clock-based udelay implementation
>
> In 9f8197980d87a ("delay: Add explanation of udelay() inaccuracy")
> Russell pointed out that loop-based delays may return early.
>
> On the arm platform, delays may be either loop-based or clock-based.
>
> This patch tweaks the clock-based implementation so that udelay(N)
> is guaranteed to spin at least N microseconds.
>
> Signed-off-by: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
> ---
>  arch/arm/lib/delay.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

As I have indicated in the past, I'm not a believer in the "don't fix
bug A because bug B is still there" argument.  From the statements
"platform code could try to make their udelay/ndelay() be as good as
it can be on a particular platform" and "I'm very much open to udelay
improvements, and if somebody sends patches for particular platforms
to do particularly well on that platform" it's my understanding that
this is consistent with Linus's opinion.  Since Marc's bugfix seems
good and valid:

Reviewed-by: Douglas Anderson <dianders@chromium.org>

Marc's bugfix would immediately be useful if you happened to know your
driver was only running on a system that was using a timer-based
udelay on ARM.

Marc's bugfix could also form the basis of future patches that
extended the udelay() API to somehow express the error, as Linus
suggested by saying "we could maybe export some interface to give
estimated errors so that drivers could then try to correct for them
depending on just how much they care".


-Doug
