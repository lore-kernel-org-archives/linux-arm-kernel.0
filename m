From: will.deacon@arm.com (Will Deacon)
Date: Fri, 23 Sep 2016 11:02:48 +0100
Subject: [PATCH v2 2/3] arm64: kgdb: prevent kgdb from being invoked
 recursively
In-Reply-To: <20160923073327.9657-3-takahiro.akashi@linaro.org>
References: <20160923073327.9657-1-takahiro.akashi@linaro.org>
 <20160923073327.9657-3-takahiro.akashi@linaro.org>
Message-ID: <20160923100247.GB6397@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 23, 2016 at 04:33:26PM +0900, AKASHI Takahiro wrote:
> If a breakpoint is set in an interrupt-sensitive place,
> like gic_handle_irq(), a debug exception can be triggerred recursively.
> We will see the following message:
> 
>     KGDB: re-enter error: breakpoint removed ffffffc000081258
>     ------------[ cut here ]------------
>     WARNING: CPU: 0 PID: 650 at kernel/debug/debug_core.c:435
>                                         kgdb_handle_exception+0x1dc/0x1f4()
>     Modules linked in:
>     CPU: 0 PID: 650 Comm: sh Not tainted 3.17.0-rc2+ #177
>     Call trace:
>     [<ffffffc000087fac>] dump_backtrace+0x0/0x130
>     [<ffffffc0000880ec>] show_stack+0x10/0x1c
>     [<ffffffc0004d683c>] dump_stack+0x74/0xb8
>     [<ffffffc0000ab824>] warn_slowpath_common+0x8c/0xb4
>     [<ffffffc0000ab90c>] warn_slowpath_null+0x14/0x20
>     [<ffffffc000121bfc>] kgdb_handle_exception+0x1d8/0x1f4
>     [<ffffffc000092ffc>] kgdb_brk_fn+0x18/0x28
>     [<ffffffc0000821c8>] brk_handler+0x9c/0xe8
>     [<ffffffc0000811e8>] do_debug_exception+0x3c/0xac
>     Exception stack(0xffffffc07e027650 to 0xffffffc07e027770)
>     ...
>     [<ffffffc000083cac>] el1_dbg+0x14/0x68
>     [<ffffffc00012178c>] kgdb_cpu_enter+0x464/0x5c0
>     [<ffffffc000121bb4>] kgdb_handle_exception+0x190/0x1f4
>     [<ffffffc000092ffc>] kgdb_brk_fn+0x18/0x28
>     [<ffffffc0000821c8>] brk_handler+0x9c/0xe8
>     [<ffffffc0000811e8>] do_debug_exception+0x3c/0xac
>     Exception stack(0xffffffc07e027ac0 to 0xffffffc07e027be0)
>     ...
>     [<ffffffc000083cac>] el1_dbg+0x14/0x68
>     [<ffffffc00032e4b4>] __handle_sysrq+0x11c/0x190
>     [<ffffffc00032e93c>] write_sysrq_trigger+0x4c/0x60
>     [<ffffffc0001e7d58>] proc_reg_write+0x54/0x84
>     [<ffffffc000192fa4>] vfs_write+0x98/0x1c8
>     [<ffffffc0001939b0>] SyS_write+0x40/0xa0
> 
> When some interrupt occurs, a breakpoint at gic_handle_irq() invokes kgdb.
> Kgdb then calls kgdb_roundup_cpus() to sync with other cpus. Current
> kgdb_roundup_cpus() unmasks interrupts temporarily to use
> smp_call_function(). This eventually allows another interrupt to occur and
> likely results in hitting a breakpoint at gic_handle_irq() again since
> a debug exception is always enabled in el1_irq.
> 
> We can avoid this issue by specifying "nokgdbroundup" in a kernel command
> line, but this will also leave other cpus be in unknown state in terms of
> kgdb, and may result in interfering with kgdb.
> 
> This patch re-implements kgdb_roundup_cpus() so that we won't have to
> enable interrupts there by using irq_work.
> 
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Jason Wessel <jason.wessel@windriver.com>
> Cc: <stable@vger.kernel.org> # 3.15-
> ---
>  arch/arm64/kernel/kgdb.c | 32 ++++++++++++++++++++++++++++----
>  1 file changed, 28 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/kernel/kgdb.c b/arch/arm64/kernel/kgdb.c
> index afe5f90..59c4aec 100644
> --- a/arch/arm64/kernel/kgdb.c
> +++ b/arch/arm64/kernel/kgdb.c
> @@ -19,10 +19,13 @@
>   * along with this program.  If not, see <http://www.gnu.org/licenses/>.
>   */
>  
> +#include <linux/cpumask.h>
>  #include <linux/irq.h>
> +#include <linux/irq_work.h>
>  #include <linux/kdebug.h>
>  #include <linux/kgdb.h>
>  #include <linux/kprobes.h>
> +#include <linux/percpu.h>
>  #include <asm/traps.h>
>  
>  struct dbg_reg_def_t dbg_reg_def[DBG_MAX_REG_NUM] = {
> @@ -106,6 +109,8 @@ struct dbg_reg_def_t dbg_reg_def[DBG_MAX_REG_NUM] = {
>  	{ "fpcr", 4, -1 },
>  };
>  
> +static DEFINE_PER_CPU(struct irq_work, kgdb_irq_work);
> +
>  char *dbg_get_reg(int regno, void *mem, struct pt_regs *regs)
>  {
>  	if (regno >= DBG_MAX_REG_NUM || regno < 0)
> @@ -258,16 +263,27 @@ static struct step_hook kgdb_step_hook = {
>  	.fn		= kgdb_step_brk_fn
>  };
>  
> -static void kgdb_call_nmi_hook(void *ignored)
> +static void kgdb_roundup_hook(struct irq_work *work)
>  {
>  	kgdb_nmicallback(raw_smp_processor_id(), get_irq_regs());
>  }
>  
>  void kgdb_roundup_cpus(unsigned long flags)
>  {
> -	local_irq_enable();
> -	smp_call_function(kgdb_call_nmi_hook, NULL, 0);
> -	local_irq_disable();
> +	int cpu;
> +	struct cpumask mask;
> +	struct irq_work *work;
> +
> +	mask = *cpu_online_mask;

Are you sure you want to do this on the stack? Assuming it's safe to
allocate here, why not use cpumask_var_t?

Will
