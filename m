From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 10 Apr 2013 13:02:16 -0400
Subject: [PATCH] arm: mvebu: Fix the irq map function in SMP mode
In-Reply-To: <1365165172-11447-2-git-send-email-gregory.clement@free-electrons.com>
References: <1365165172-11447-1-git-send-email-gregory.clement@free-electrons.com>
 <1365165172-11447-2-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20130410170216.GC28693@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 05, 2013 at 02:32:52PM +0200, Gregory CLEMENT wrote:
> This patch fix the regression introduced by the commit 3202bf0157ccb
> "arm: mvebu: Improve the SMP support of the interrupt controller":
> GPIO IRQ were no longer delivered to the CPUs.
> 
> To be delivered to a CPU an interrupt must be enabled at CPU level and
> at interrupt source level. Before the offending patch, all the
> interrupts were enabled at source level during map() function. Mask()
> and unmask() was done by handling the per-CPU part. It was fine when
> running in UP with only one CPU.
> 
> The offending patch added support for SMP, in this case mask() and
> unmask() was done by handling the interrupt source level part. The
> per-CPU level part was handled by the affinity API to select the CPU
> which will receive the interrupt. (Due to some hardware limitation
> only one CPU at a time can received a given interrupt).
> 
> For "normal" interrupt __setup_irq() was called when an irq was
> registered. irq_set_affinity() is called from this function, which
> enabled the interrupt on one of the CPUs. Whereas for GPIO IRQ which
> were chained interrupts, the irq_set_affinity() was never called and
> none of the CPUs was selected to receive the interrupt.
> 
> With this patch all the interrupt are enable on the current CPU during
> map() function. Enabling the interrupts on a CPU doesn't depend
> anymore on irq_set_affinity() and then the chained irq are not anymore
> a special case. However the CPU which will receive the irq can still
> be modify later using irq_set_affinity().
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> Reported-by: Ryan Press <ryan@presslab.us>
> Investigated-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> Tested-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> 
> Tested with Mirabox (A370) and Openblocks AX3 (AXP), rootfs mounted
> over NFS, compiled with CONFIG_SMP=y/N.
> ---
>  arch/arm/mach-mvebu/irq-armada-370-xp.c |   16 +++++-----------
>  1 file changed, 5 insertions(+), 11 deletions(-)

Applied to mvebu/fixes with one small change, I moved the "*-by: ..."
block to the end of the commit message and added Ryan's Tested-by:

thx,

Jason.
