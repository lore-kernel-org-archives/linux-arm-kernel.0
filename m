From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 06 Jul 2011 12:02:26 +0100
Subject: [PATCH v8 00/14] Consolidating GIC per-cpu interrupts
In-Reply-To: <1309855755-6261-1-git-send-email-marc.zyngier@arm.com>
References: <1309855755-6261-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <4E1440C2.2000203@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/07/11 09:49, Marc Zyngier wrote:
> The current GIC per-cpu interrupts (aka PPIs) suffer from a number of
> problems:
> 
> - They use a completely separate scheme to handle the interrupts,
>   mostly because the PPI concept doesn't really match the kernel view
>   of an interrupt.
> - PPIs can only be used by the timer code, unless we add more low-level
>   assembly code.
> - The local timer code can only be used by devices generating PPIs,
>   and not SPIs.
> - At least one platform (msm) has started implementing its own
>   alternative scheme.
> - Some low-level code gets duplicated, as usual...
> 
> The proposed solution is to let the GIC code expose the PPIs as
> something that the kernel can manage. Instead of having a single
> interrupt number shared on all cores, make the interrupt number be
> different on each CPU.
> 
> This enables the use of the normal kernel API (request_irq() and
> friends) and the elimination of some low level code. It also serves as
> the basis of the GIC device tree support code. On the other side, it
> causes quite a bit of churn in the timer code.
> 
> Previous versions of this series have received ACKs from some platform
> maintainers, but so far there has been very little comment on the core
> code. As I now have quite a large number of patches relying on this
> series (local timers as devices, device tree support for GIC and TWD),
> I'd be grateful for at least a hint indicating that this is going in
> the right direction. Or not.
> 
> This patch set is based on 3.0-rc5. Tested on PB-11MP, Tegra2
> (Harmony) and SMDK-V310. Also available in the "gic_ppi_map" branch of
> git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git
> 
> From v7:
> - Rebased on v3.0-rc5
> - Rename gic_ppi_to_vppi() to gic_ppi_map()
> - Rename CONFIG_ARM_GIC_VPPI to CONFIG_ARM_GIC_PPI_MAP
> - Add gic_ppi_map_on_cpu()
> 
> From v6:
> - Fix compilation when !CONFIG_PM.
> 
> From v5:
> - Update Exynos4 MCT to use the local timer infrastructure, now that
>   it doesn't depend on PPIs anymore. Untested, as the board I have
>   doesn't implement MCT (EVT0 syndrome).
> 
> From v4:
> - Fix arch/arm/common/Kconfig indentation
> - Fix MSM warning when building UP.
> 
> From v3:
> - Fix yet another CPU_HOTPLUG problem: instead of calling free_irq()
>   on timer halt, just disable the interrupt. On timer restart, detect
>   that the interrupt has been requested already and just enable the
>   interrupt back. This avoid doing a request_irq() with preemption
>   disabled, which triggers an ugly warning. Reported by Stephen Boyd.
> 
> From v2:
> - More MSM fixes
> - Dropped MSM interrupt handler removal, as this requires more discussion,
>   and will be addressed in a separate series.
> - Moved introduction of percpu_timer_handler to a separate patch
> 
> From v1:
> - Fix crash while hotpluging a CPU
> - Use handle_percpu_irq() instead of handle_fasteoi_irq()
> - MSM fixes courtesy of Stephen Boyd
> - MSM switched to percpu_timer_handler()
> - Remove local timer interrupt accounting
> - Restructure patches #1 and #2
> 
> Marc Zyngier (14):
>   ARM: gic: add per-cpu interrupt mapping
>   ARM: smp: add interrupt handler for local timers
>   ARM: smp_twd: add support for remapped PPI interrupts
>   ARM: omap4: use remapped PPI interrupts for local timer
>   ARM: versatile: use remapped PPI interrupts for local timer
>   ARM: shmobile: use remapped PPI interrupts for local timer
>   ARM: ux500: use remapped PPI interrupts for local timer
>   ARM: tegra: use remapped PPI interrupts for local timer
>   ARM: msm: use remapped PPI interrupts for local timer
>   ARM: exynos4: use remapped PPI interrupts for local timer
>   ARM: gic: remove previous local timer interrupt handling
>   ARM: gic: add compute_irqnr macro for exynos4
>   ARM: SMP: automatically select ARM_GIC_PPI_MAP
>   ARM: gic: add gic_ppi_map_on_cpu()
> 
>  arch/arm/Kconfig                                  |    1 +
>  arch/arm/common/Kconfig                           |    5 +
>  arch/arm/common/gic.c                             |  152 +++++++++++++++++++--
>  arch/arm/include/asm/entry-macro-multi.S          |    7 -
>  arch/arm/include/asm/hardirq.h                    |    3 -
>  arch/arm/include/asm/hardware/entry-macro-gic.S   |   31 ++---
>  arch/arm/include/asm/hardware/gic.h               |   11 ++-
>  arch/arm/include/asm/localtimer.h                 |    7 +-
>  arch/arm/include/asm/smp.h                        |    5 -
>  arch/arm/kernel/irq.c                             |   11 +-
>  arch/arm/kernel/smp.c                             |   27 +---
>  arch/arm/kernel/smp_twd.c                         |   25 +++-
>  arch/arm/mach-exynos4/include/mach/entry-macro.S  |   70 +---------
>  arch/arm/mach-exynos4/localtimer.c                |    3 +-
>  arch/arm/mach-msm/board-msm8x60.c                 |   11 --
>  arch/arm/mach-msm/include/mach/entry-macro-qgic.S |   73 +----------
>  arch/arm/mach-msm/timer.c                         |   58 ++++----
>  arch/arm/mach-omap2/include/mach/entry-macro.S    |   14 +--
>  arch/arm/mach-omap2/timer-mpu.c                   |    3 +-
>  arch/arm/mach-shmobile/entry-intc.S               |    3 -
>  arch/arm/mach-shmobile/include/mach/entry-macro.S |    3 -
>  arch/arm/mach-shmobile/localtimer.c               |    3 +-
>  arch/arm/mach-tegra/localtimer.c                  |    3 +-
>  arch/arm/mach-ux500/localtimer.c                  |    3 +-
>  arch/arm/plat-versatile/localtimer.c              |    3 +-
>  25 files changed, 253 insertions(+), 282 deletions(-)

Russell,

Unless you have any objection, I'd like to push this to Arnd's arm-soc
tree. Would that be OK with you?

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
