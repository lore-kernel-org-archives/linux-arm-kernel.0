From: f.fainelli@gmail.com (Florian Fainelli)
Date: Thu, 24 May 2018 16:30:40 -0700
Subject: [PATCH 03/14] ARM: bugs: hook processor bug checking into SMP and
 suspend paths
In-Reply-To: <E1fKjEx-00063Y-N5@rmk-PC.armlinux.org.uk>
References: <20180521114238.GN17671@n2100.armlinux.org.uk>
 <E1fKjEx-00063Y-N5@rmk-PC.armlinux.org.uk>
Message-ID: <b454e37c-52a8-387f-3649-8ce72c9a5b18@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/21/2018 04:44 AM, Russell King wrote:
> Check for CPU bugs when secondary processors are being brought online,
> and also when CPUs are resuming from a low power mode.  This gives an
> opportunity to check that processor specific bug workarounds are
> correctly enabled for all paths that a CPU re-enters the kernel.
> 
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>

Something I missed, is that this correctly warns about e.g: missing the
IBE bit for secondary cores, but it seems to be missing it for the boot CPU:

[    0.001053] CPU: Testing write buffer coherency: ok
[    0.001086] CPU: Spectre v2: using ICIALLU workaround
[    0.001304] CPU0: update cpu_capacity 1024
[    0.001316] CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
[    0.001693] Setting up static identity map for 0x200000 - 0x200060
[    0.001769] Hierarchical SRCU implementation.
[    0.003951] brcmstb: biuctrl: MCP: Write pairing already disabled
[    0.004224] smp: Bringing up secondary CPUs ...
[    0.004874] CPU1: update cpu_capacity 1024
[    0.004877] CPU1: thread -1, cpu 1, socket 0, mpidr 80000001
[    0.004881] CPU1: Spectre v2: firmware did not set auxiliary control
register IBE bit, system vulnerable
[    0.005604] CPU2: update cpu_capacity 1024
[    0.005607] CPU2: thread -1, cpu 2, socket 0, mpidr 80000002
[    0.005610] CPU2: Spectre v2: firmware did not set auxiliary control
register IBE bit, system vulnerable
[    0.006295] CPU3: update cpu_capacity 1024
[    0.006299] CPU3: thread -1, cpu 3, socket 0, mpidr 80000003
[    0.006302] CPU3: Spectre v2: firmware did not set auxiliary control
register IBE bit, system vulnerable
[    0.006377] smp: Brought up 1 node, 4 CPUs
[    0.006389] SMP: Total of 4 processors activated (216.00 BogoMIPS).
[    0.006398] CPU: All CPU(s) started in SVC mode.

Which could be confusing if you intentionally restricted a SMP system to
UP with maxcpus=1 or smp=off:

[    0.001043] CPU: Testing write buffer coherency: ok
[    0.001077] CPU: Spectre v2: using ICIALLU workaround
[    0.001291] CPU0: update cpu_capacity 1024
[    0.001302] CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
[    0.001516] Setting up static identity map for 0x200000 - 0x200060
[    0.001593] Hierarchical SRCU implementation.
[    0.003829] brcmstb: biuctrl: MCP: Write pairing already disabled
[    0.004097] smp: Bringing up secondary CPUs ...
[    0.004108] smp: Brought up 1 node, 1 CPU
[    0.004117] SMP: Total of 1 processors activated (54.00 BogoMIPS).
[    0.004126] CPU: All CPU(s) started in SVC mode.



> ---
>  arch/arm/include/asm/bugs.h | 2 ++
>  arch/arm/kernel/bugs.c      | 5 +++++
>  arch/arm/kernel/smp.c       | 4 ++++
>  arch/arm/kernel/suspend.c   | 2 ++
>  4 files changed, 13 insertions(+)
> 
> diff --git a/arch/arm/include/asm/bugs.h b/arch/arm/include/asm/bugs.h
> index ed122d294f3f..73a99c72a930 100644
> --- a/arch/arm/include/asm/bugs.h
> +++ b/arch/arm/include/asm/bugs.h
> @@ -14,8 +14,10 @@ extern void check_writebuffer_bugs(void);
>  
>  #ifdef CONFIG_MMU
>  extern void check_bugs(void);
> +extern void check_other_bugs(void);
>  #else
>  #define check_bugs() do { } while (0)
> +#define check_other_bugs() do { } while (0)
>  #endif
>  
>  #endif
> diff --git a/arch/arm/kernel/bugs.c b/arch/arm/kernel/bugs.c
> index 88024028bb70..16e7ba2a9cc4 100644
> --- a/arch/arm/kernel/bugs.c
> +++ b/arch/arm/kernel/bugs.c
> @@ -3,7 +3,12 @@
>  #include <asm/bugs.h>
>  #include <asm/proc-fns.h>
>  
> +void check_other_bugs(void)
> +{
> +}
> +
>  void __init check_bugs(void)
>  {
>  	check_writebuffer_bugs();
> +	check_other_bugs();
>  }
> diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
> index 2da087926ebe..5ad0b67b9e33 100644
> --- a/arch/arm/kernel/smp.c
> +++ b/arch/arm/kernel/smp.c
> @@ -31,6 +31,7 @@
>  #include <linux/irq_work.h>
>  
>  #include <linux/atomic.h>
> +#include <asm/bugs.h>
>  #include <asm/smp.h>
>  #include <asm/cacheflush.h>
>  #include <asm/cpu.h>
> @@ -405,6 +406,9 @@ asmlinkage void secondary_start_kernel(void)
>  	 * before we continue - which happens after __cpu_up returns.
>  	 */
>  	set_cpu_online(cpu, true);
> +
> +	check_other_bugs();
> +
>  	complete(&cpu_running);
>  
>  	local_irq_enable();
> diff --git a/arch/arm/kernel/suspend.c b/arch/arm/kernel/suspend.c
> index a40ebb7c0896..d08099269e35 100644
> --- a/arch/arm/kernel/suspend.c
> +++ b/arch/arm/kernel/suspend.c
> @@ -3,6 +3,7 @@
>  #include <linux/slab.h>
>  #include <linux/mm_types.h>
>  
> +#include <asm/bugs.h>
>  #include <asm/cacheflush.h>
>  #include <asm/idmap.h>
>  #include <asm/pgalloc.h>
> @@ -36,6 +37,7 @@ int cpu_suspend(unsigned long arg, int (*fn)(unsigned long))
>  		cpu_switch_mm(mm->pgd, mm);
>  		local_flush_bp_all();
>  		local_flush_tlb_all();
> +		check_other_bugs();
>  	}
>  
>  	return ret;
> 


-- 
Florian
