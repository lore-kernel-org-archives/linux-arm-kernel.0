From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 5 Oct 2017 14:25:23 +0200
Subject: [PATCH] ARM: shmobile: rcar-gen2: fix non-SMP build
In-Reply-To: <20171005120914.465582-1-arnd@arndb.de>
References: <20171005120914.465582-1-arnd@arndb.de>
Message-ID: <CAMuHMdXjD-MpW9sqKtdUasizN8YkWuzChNyduyHz7p-cz38VBg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Thu, Oct 5, 2017 at 2:09 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> A bugfix for the SMP case broke the build for the UP case:
>
> arch/arm/mach-shmobile/headsmp-apmu.o: In function `shmobile_boot_apmu':
> (.text+0x34): undefined reference to `secondary_startup'
>
> The assembler file mixes code that is used for SMP with code
> that we also need on a single-CPU build, so I'm leaving it
> always enabled in the Makefile, but enclose the SMP code
> in an #ifdef.

Oops, sorry for that. Looks like 0-day doesn't do UP builds?

> 3fd45a136ff6 ("ARM: shmobile: rcar-gen2: Make sure CNTVOFF is initialized on CA7/15")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be> ;-)

> ---
>  arch/arm/mach-shmobile/headsmp-apmu.S | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/arm/mach-shmobile/headsmp-apmu.S b/arch/arm/mach-shmobile/headsmp-apmu.S
> index db4743d2bf91..5672b5849401 100644
> --- a/arch/arm/mach-shmobile/headsmp-apmu.S
> +++ b/arch/arm/mach-shmobile/headsmp-apmu.S

As this hasn't been pulled into arm-soc yet (pull request sent though),
perhaps Simon should squash this fix into the original commit?
Should we rename headsmp-apmu.S to head-apmu.S?

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
