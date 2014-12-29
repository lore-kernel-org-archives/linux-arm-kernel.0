From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 29 Dec 2014 17:49:00 +0100
Subject: [GIT PULL] Renesas ARM Based SoC DT PM Updates for v3.20
In-Reply-To: <cover.1419809198.git.horms+renesas@verge.net.au>
References: <cover.1419809198.git.horms+renesas@verge.net.au>
Message-ID: <CAMuHMdXA+NaxCaBmH743Q-EotQa1en9tpRQPOhRvDi1POnUxdg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

On Mon, Dec 29, 2014 at 2:43 AM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> Please consider these Renesas ARM based SoC DT PM updates for v3.20.
>
>
> The following changes since commit 97bf6af1f928216fd6c5a66e8a57bfa95a659672:
>
>   Linux 3.19-rc1 (2014-12-20 17:08:50 -0800)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-dt-pm-for-v3.20
>
> for you to fetch changes up to 73e844408c4e344aaece455a4bfa9d845e4d8425:
>
>   ARM: shmobile: r8a7740 dtsi: Add PM domain support (2014-12-21 16:59:10 +0900)
>
> ----------------------------------------------------------------
> Renesas ARM Based SoC DT PM Updates for v3.20
>
> * DT support from PM domains
> * Enable DT support for PM domains on r8a7740
>
> ----------------------------------------------------------------
> Geert Uytterhoeven (6):
>       PM / Domains: Add DT bindings for the R-Mobile System Controller
>       ARM: shmobile: R-Mobile: Use generic_pm_domain.attach_dev() for pm_clk setup
>       ARM: shmobile: R-Mobile: Enable module clocks if !CONFIG_PM_RUNTIME

Is it still possible to drop the above commit?
This branch was rebased on v3.19-rc1[*], where this is no longer needed, and
even has bad (as in suboptimal; fortunately it does not crash) side effects:

    As of commit b2b49ccbdd547135 ("PM: Kconfig: Set PM_RUNTIME if PM_SLEEP
    is selected"), CONFIG_PM_RUNTIME is always enabled if CONFIG_PM is
    enabled, so this section is no longer needed.

    As of commit 464ed18ebdb6236f ("PM: Eliminate CONFIG_PM_RUNTIME"),
    CONFIG_PM_RUNTIME no longer exists, and this section will always be
    executed, which may enable clocks that are not needed.

Anyway, I've sent a revert, too
(http://marc.info/?l=linux-sh&m=141987158302176&w=2).

Thanks!

BTW, this happened because this series was originally intended for 3.19, but
postponed to 3.20 because a dependency entered mainline only in a late
3.18-rc*, when arm-soc for 3.19 was about to close.

[*] If it wouldn't have been rebased, the issue would have shown up after the
    merge into post-v3.19-rc1 anyway, and would have needed a revert.

>       ARM: shmobile: R-Mobile: Store SYSC base address in rmobile_pm_domain
>       ARM: shmobile: R-Mobile: Add DT support for PM domains
>       ARM: shmobile: r8a7740 dtsi: Add PM domain support

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
