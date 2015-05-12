From: kgene@kernel.org (Kukjin Kim)
Date: Wed, 13 May 2015 02:18:51 +0900
Subject: [PATCH] arm/mach-exynos: suspend: Don't try to initialize
 suspend/suspend on old DT
In-Reply-To: <1431438307-25410-1-git-send-email-julien.grall@citrix.com>
References: <1431438307-25410-1-git-send-email-julien.grall@citrix.com>
Message-ID: <555235FB.3040804@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/12/15 22:45, Julien Grall wrote:
> Since commit 8b283c0 "ARM: exynos4/5: convert pmu wakeup to stacked domains",
> a suspend/resume is not supported on old DT.
> 
> Although, rather than printing a warning and continue to boot, the
> kernel will segfault just after:
> 
> ------------[ cut here ]------------
> 
> WARNING: CPU: 1 PID: 1 at arch/arm/mach-exynos/suspend.c:726 exynos_pm_init+0x4c/0xc8()
> Modules linked in:
> CPU: 1 PID: 1 Comm: swapper/0 Not tainted 4.1.0-rc3 #1
> Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
> [<c02181c4>] (unwind_backtrace) from [<c0213b2c>] (show_stack+0x10/0x14)
> [<c0213b2c>] (show_stack) from [<c0949890>] (dump_stack+0x70/0x8c)
> [<c0949890>] (dump_stack) from [<c024f0b0>] (warn_slowpath_common+0x74/0xac)
> [<c024f0b0>] (warn_slowpath_common) from [<c024f104>] (warn_slowpath_null+0x1c/0x24)
> [<c024f104>] (warn_slowpath_null) from [<c0cf1d28>] (exynos_pm_init+0x4c/0xc8)
> [<c0cf1d28>] (exynos_pm_init) from [<c0ceaae8>] (init_machine_late+0x1c/0x28)
> [<c0ceaae8>] (init_machine_late) from [<c020aa64>] (do_one_initcall+0x80/0x1d0)
> [<c020aa64>] (do_one_initcall) from [<c0ce8d4c>] (kernel_init_freeable+0x10c/0x1d8)
> [<c0ce8d4c>] (kernel_init_freeable) from [<c0944a2c>] (kernel_init+0x8/0xe4)
> [<c0944a2c>] (kernel_init) from [<c0210e60>] (ret_from_fork+0x14/0x34)
> ---[ end trace 335bd937d409f3c7 ]---
> Outdated DT detected, suspend/resume will NOT work
> Unable to handle kernel NULL pointer dereference at virtual address 00000608
> pgd = c0204000
> [00000608] *pgd=00000000
> Internal error: Oops: 5 [#1] SMP ARM
> Modules linked in:
> CPU: 1 PID: 1 Comm: swapper/0 Tainted: G        W       4.1.0-rc3 #1
> Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
> task: db06c000 ti: db05a000 task.ti: db05a000
> PC is at exynos_pm_init+0x6c/0xc8
> LR is at exynos_pm_init+0x54/0xc8
> pc : [<c0cf1d48>]    lr : [<c0cf1d30>]    psr: 60000113
> sp : db05bee8  ip : 00000000  fp : 00000000
> r10: 00000116  r9 : c0dab2d4  r8 : d8d5f440
> r7 : c0db7ad8  r6 : c0db7ad8  r5 : 00000000  r4 : c0ceaacc
> r3 : c0eb2aec  r2 : c0951e40  r1 : 00000000  r0 : c0eb2acc
> Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
> Control: 10c5387d  Table: 6020406a  DAC: 00000015
> Process swapper/0 (pid: 1, stack limit = 0xdb05a220)
> Stack: (0xdb05bee8 to 0xdb05c000)
> bee0:                   c0db7ad8 c0d8fe34 c0cf17c8 c0ceaae8 00000000 c020aa64
> bf00: 00000033 c09580b8 db04fd00 c0ed79a4 c0eb1000 c0ce8588 c0ca2bc4 c0353fcc
> bf20: 00000000 c0df358c 60000113 00000000 dbfffba4 00000000 c0ca2bc4 c026654c
> bf40: c0b80134 c0ca1a64 00000007 00000007 c0df3554 c0d6c2f4 00000007 c0d6c2d4
> bf60: c0eb1000 c0ce8588 c0dab2d4 00000116 00000000 c0ce8d4c 00000007 00000007
> bf80: c0ce8588 c0944a24 00000000 c0944a24 00000000 00000000 00000000 00000000
> bfa0: 00000000 c0944a2c 00000000 c0210e60 00000000 00000000 00000000 00000000
> bfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> bfe0: 00000000 00000000 00000000 00000000 00000013 00000000 00000000 00000000
> [<c0cf1d48>] (exynos_pm_init) from [<c0ceaae8>] (init_machine_late+0x1c/0x28)
> [<c0ceaae8>] (init_machine_late) from [<c020aa64>] (do_one_initcall+0x80/0x1d0)
> [<c020aa64>] (do_one_initcall) from [<c0ce8d4c>] (kernel_init_freeable+0x10c/0x1d8)
> [<c0ce8d4c>] (kernel_init_freeable) from [<c0944a2c>] (kernel_init+0x8/0xe4)
> [<c0944a2c>] (kernel_init) from [<c0210e60>] (ret_from_fork+0x14/0x34)
> Code: e59f005c e59220c0 e5901000 e5832000 (e591e608)
> ---[ end trace 335bd937d409f3c8 ]---
> 
> This is happening because pmu_base_addr is only initialized when the
> PMU is an interrupt controller. It's not the case on old DT.
> 
> Signed-off-by: Julien Grall <julien.grall@citrix.com>
> ---
>  arch/arm/mach-exynos/suspend.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-exynos/suspend.c b/arch/arm/mach-exynos/suspend.c
> index 3e6aea7..b6f3ddc 100644
> --- a/arch/arm/mach-exynos/suspend.c
> +++ b/arch/arm/mach-exynos/suspend.c
> @@ -723,8 +723,10 @@ void __init exynos_pm_init(void)
>  		return;
>  	}
>  
> -	if (WARN_ON(!of_find_property(np, "interrupt-controller", NULL)))
> +	if (WARN_ON(!of_find_property(np, "interrupt-controller", NULL))) {
>  		pr_warn("Outdated DT detected, suspend/resume will NOT work\n");
> +		return;
> +	}
>  
>  	pm_data = (const struct exynos_pm_data *) match->data;
>  
I'm fine on this, applied.

Thanks,
Kukjin
