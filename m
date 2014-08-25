From: horms@verge.net.au (Simon Horman)
Date: Mon, 25 Aug 2014 09:41:30 +0900
Subject: [GIT PULL] Renesas ARM Based SoC Updates for v3.18
In-Reply-To: <cover.1408671240.git.horms+renesas@verge.net.au>
References: <cover.1408671240.git.horms+renesas@verge.net.au>
Message-ID: <20140825004130.GA17055@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 23, 2014 at 10:44:20AM +0900, Simon Horman wrote:
> Hi Olof, Hi Kevin, Hi Arnd,
> 
> Please consider these Renesas ARM based SoC updates for v3.18.
> 
> 
> The following changes since commit 7d1311b93e58ed55f3a31cc8f94c4b8fe988a2b9:
> 
>   Linux 3.17-rc1 (2014-08-16 10:40:26 -0600)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-soc-for-v3.18
> 
> for you to fetch changes up to 5ac9e7f35db00e630c9f95a1f73ac329371cdbbf:
> 
>   ARM: shmobile: sh73a0: Remove unneeded nr_irqs initialization (2014-08-20 09:09:24 +0900)

This pull request has a minor conflict in
arch/arm/mach-shmobile/setup-r8a7779.c with
"ARM: shmobile: marzen-reference: Enable TMU0 in device tree" which
is included in the pull request "Renesas ARM Based SoC DT Timers Updates
for v3.18" which is tagged as renesas-dt-timers-for-v3.18.

The resolution is to take the changes from both branches.
The DT_MACHINE_START stanza should end up as follows:

DT_MACHINE_START(R8A7779_DT, "Generic R8A7779 (Flattened Device Tree)")
        .map_io         = r8a7779_map_io,
        .init_early     = shmobile_init_delay,
        .init_irq       = r8a7779_init_irq_dt,
        .init_late      = shmobile_init_late,
        .dt_compat      = r8a7779_compat_dt,
MACHINE_END

This resolution is available in renesas-next-20140820-v3.17-rc1
tag of the next branch of the renesas tree.

> ----------------------------------------------------------------
> Renesas ARM Based SoC Updates for v3.18
> 
> * Remove unnecessary nr_irqs initialisation on sh73a0, sh7372,
>   and r8a7779 SoCs
> * Use defines hardcoded numbers for DMA
> * Rework multiplatform include workaround
> * Correctly use shmobile_init_late on a wider range of SoCs
> 
> ----------------------------------------------------------------
> Geert Uytterhoeven (4):
>       ARM: shmobile: r8a7778: Add missing call to shmobile_init_late()
>       ARM: shmobile: dma: Use defines instead of hardcoded numbers
>       ARM: shmobile: sh7372: Remove unneeded nr_irqs initialization
>       ARM: shmobile: sh73a0: Remove unneeded nr_irqs initialization
> 
> Magnus Damm (7):
>       ARM: shmobile: sh73a0: Add shmobile_init_late()
>       ARM: shmobile: r8a7779: Fix shmobile_init_late()
>       ARM: shmobile: r8a7778: Fix shmobile_init_late()
>       ARM: shmobile: r8a73a4: Add shmobile_init_late()
>       ARM: shmobile: r7s72100: Add shmobile_init_late()
>       ARM: shmobile: Rework multiplatform include workaround
>       ARM: shmobile: r8a7779: Remove NR_IRQS_LEGACY
> 
>  arch/arm/mach-shmobile/Makefile         | 2 --
>  arch/arm/mach-shmobile/dma-register.h   | 4 ++--
>  arch/arm/mach-shmobile/irqs.h           | 2 +-
>  arch/arm/mach-shmobile/setup-r7s72100.c | 1 +
>  arch/arm/mach-shmobile/setup-r8a73a4.c  | 1 +
>  arch/arm/mach-shmobile/setup-r8a7778.c  | 3 ++-
>  arch/arm/mach-shmobile/setup-r8a7779.c  | 3 +--
>  arch/arm/mach-shmobile/setup-sh7372.c   | 1 -
>  arch/arm/mach-shmobile/setup-sh73a0.c   | 2 +-
>  9 files changed, 9 insertions(+), 10 deletions(-)
> 
