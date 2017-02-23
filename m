From: shankerd@codeaurora.org (Shanker Donthineni)
Date: Thu, 23 Feb 2017 14:02:05 -0600
Subject: [PATCH v2] arm64: Fix the kernel panic() on QDF2400 platform
Message-ID: <1487880125-1371-1-git-send-email-shankerd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The commit 38fd94b0275c 'arm64: Work around Falkor erratum 1003' has
been added to fix the hardware bug but causing a system crash. The
value of the register x1 which contains 'struct mm_struct *' should
be preserved inside macro pre_ttbr0_update_workaround.

Macro pre_ttbr0_update_workaround expects 2nd and 3rd arguments are
temporary registers. Don't clobber register x1, Otherwise the next
load operation 'mmid x1 x1' access the invalid address.

[<ffff0000080989a0>] cpu_do_switch_mm+0x20/0x40
[<ffff000008b18614>] efi_virtmap_load+0x34/0x40
[<ffff000008b1812c>] virt_efi_get_next_variable+0x64/0xc8
[<ffff000008b16204>] efivar_init+0x8c/0x348
[<ffff0000092b777c>] efisubsys_init+0xd4/0x270
[<ffff000009270c74>] do_one_initcall+0x80/0x110
[<ffff000009270ea0>] kernel_init_freeable+0x19c/0x240
[<ffff000008d8cef0>] kernel_init+0x10/0x100
[<ffff000008082ec0>] ret_from_fork+0x10/0x50
 Code: d5033fdf b340bc01 d5182001 d5033fdf (f9416821)
 ---[ end trace 15247ca922eb6bb7 ]---
 note: swapper/0[1] exited with preempt_count 2
 Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b

 SMP: stopping secondary CPUs
 ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b

Signed-off-by: Shanker Donthineni <shankerd@codeaurora.org>
Tested-by: Manoj Iyer <manoj.iyer@canonical.com>
---
v2: include 12 digit commit-id in commit description.

 arch/arm64/mm/proc.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index cd4d53d..877d42f 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -138,7 +138,7 @@ ENDPROC(cpu_do_resume)
  *	- pgd_phys - physical address of new TTB
  */
 ENTRY(cpu_do_switch_mm)
-	pre_ttbr0_update_workaround x0, x1, x2
+	pre_ttbr0_update_workaround x0, x2, x3
 	mmid	x1, x1				// get mm->context.id
 	bfi	x0, x1, #48, #16		// set the ASID
 	msr	ttbr0_el1, x0			// set TTBR0
-- 
Qualcomm Datacenter Technologies, Inc. on behalf of the Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
