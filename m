From: kgene@kernel.org (kgene at kernel.org)
Date: Tue, 09 Sep 2014 12:39:36 +0900
Subject: [PATCH v5 RESEND 1/3] ARM: EXYNOS: Move code from hotplug.c to
 platsmp.c
In-Reply-To: <1409920495-16533-1-git-send-email-k.kozlowski@samsung.com>
References: <1409920495-16533-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <03a501cfcbdf$ad9f5680$08de0380$@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Krzysztof Kozlowski wrote:
> 
> Cleanup a little the SMP/hotplug code for Exynos by:
> 1. Moving completely all functions from hotplug.c into the platsmp.c;
> 2. Deleting the hotplug.c file.
> 
> After recent cleanups (e.g. 75ad2ab28f0f "ARM: EXYNOS: use
> v7_exit_coherency_flush macro for cache disabling") there was only CPU
> power down related code in hotplug.c file.
> 
> Rationale behind the code movement and benefits:
> 1. The file platsmp.c is the only user of code located in hotplug.c.
>    Keeping code in hotplug.c required declaring exynos_cpu_die() in common.h.
>    Such dependencies and mentioned exynos_cpu_die() declaration can be
>    removed.
> 2. In next patches exynos_set_delayed_reset_assertion() will be
>    introduced. This function will be called by:
>     - cpu_leave_power (hotplug.c),
>     - platform_do_lowpower (hotplug.c),
>     - exynos_boot_secondary (platsmp.c).
> 
> Merging hotplug.c into platsmp.c leads to simpler and cleaner code with
> less dependencies between files.
> 
> The commit only moves code around with one additional observable change:
> the hotplug.c was compiled with custom CFLAGS (-march=armv7-a). These
> CFLAGS are not necessary any more.
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Reviewed-by: Tomasz Figa <t.figa@samsung.com>
> 
> ---
> Changes since v4:
> 1. Rebase on linux-next-20140804.
> 2. Add Reviewed-by Tomasz Figa.
> ---
>  arch/arm/mach-exynos/Makefile  |  3 --
>  arch/arm/mach-exynos/common.h  |  2 -
>  arch/arm/mach-exynos/hotplug.c | 91 ------------------------------------------
>  arch/arm/mach-exynos/platsmp.c | 74 ++++++++++++++++++++++++++++++++++
>  4 files changed, 74 insertions(+), 96 deletions(-)
>  delete mode 100644 arch/arm/mach-exynos/hotplug.c

[...]

OK, I will take this series but I'm not sure what conflicts will be happened
with other pm related patches. If anything, I'll let you know ;)

Thanks,
Kukjin
