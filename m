From: will.deacon@arm.com (Will Deacon)
Date: Wed, 30 Nov 2016 10:50:52 +0000
Subject: [PATCH 1/2] arm64: Correcting format specifier for printin 64
 bit addresses
In-Reply-To: <1480493036-47334-1-git-send-email-maninder1.s@samsung.com>
References: <1480493036-47334-1-git-send-email-maninder1.s@samsung.com>
Message-ID: <20161130105052.GC2724@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 30, 2016 at 01:33:56PM +0530, Maninder Singh wrote:
> This patch corrects format specifier for printing 64 bit addresses.
> 
> Before Patch
> ============
> [   68.251603] Unable to handle kernel NULL pointer dereference at virtual address 00000000
> [   68.251673] pgd = ffffffc013950000
> [   68.251782] [00000000] *pgd=0000000093e19003, *pud=0000000093e19003, *pmd=0000000000000000
> 
> After patch
> ===========
> [    8.565030] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
> [    8.565389] pgd = ffffffc013872000
> [    8.565553] [0000000000000000] *pgd=0000000093874003, *pud=0000000093874003, *pmd=0000000000000000
> 
> and same for user space fault.
> 
> Signed-off-by: Vaneet Narang <v.narang@samsung.com>
> Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
> ---
>  arch/arm64/mm/fault.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)

There are a bunch of these you haven't caught:

arch/arm64/kernel/signal.c:             pr_info_ratelimited("%s[%d]: bad frame in %s: pc=%08llx sp=%08llx\n",
arch/arm64/kernel/signal32.c:           pr_info_ratelimited("%s[%d]: bad frame in %s: pc=%08llx sp=%08llx\n",
arch/arm64/kernel/signal32.c:           pr_info_ratelimited("%s[%d]: bad frame in %s: pc=%08llx sp=%08llx\n",
arch/arm64/kvm/sys_regs.c:      kvm_err("Unsupported guest CP%d access at: %08lx\n",
arch/arm64/kvm/trace.h: TP_printk("guest executed wf%c at: 0x%08lx",
arch/arm64/kvm/trace.h: TP_printk("HVC at 0x%08lx (r0: 0x%08lx, imm: 0x%lx)",
arch/arm64/kvm/trace.h: TP_printk("%s %s reg %d (0x%08llx)", __entry->fn,  __entry->is_write?"write to":"read from", __entry->reg, __entry->write_value)
arch/arm64/mm/fault.c:  pr_alert("[%08lx] *pgd=%016llx", addr, pgd_val(*pgd));
arch/arm64/mm/fault.c:  pr_alert("Unable to handle kernel %s at virtual address %08lx\n",
arch/arm64/mm/fault.c:          pr_info("%s[%d]: unhandled %s (%d) at 0x%08lx, esr 0x%03x\n",
arch/arm64/mm/mmu.c:            pr_warn("fix_to_virt(FIX_BTMAP_BEGIN): %08lx\n",
arch/arm64/mm/mmu.c:            pr_warn("fix_to_virt(FIX_BTMAP_END):   %08lx\n",

so it would probably make sense to fix these to be consistent.

Will
