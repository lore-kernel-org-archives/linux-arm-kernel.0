From: alim.akhtar@samsung.com (Alim Akhtar)
Date: Wed, 11 Nov 2015 13:33:23 +0530
Subject: PSCI: NULL pointer dereference
Message-ID: <5642F64B.3030801@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark/Lorenzo,

Getting a NULL pointer dereference from psci_0_2_set_functions() like [1].
But this goes away with a addition of a printk (see blow diff) or a 
udelay(10) with the same firmware on the board.

diff --git a/drivers/firmware/psci.c b/drivers/firmware/psci.c
index d24f35d74b27..92a0798e4138 100644
--- a/drivers/firmware/psci.c
+++ b/drivers/firmware/psci.c
@@ -312,6 +312,7 @@ static void __init psci_0_2_set_functions(void)
         psci_function_id[PSCI_FN_CPU_OFF] = PSCI_0_2_FN_CPU_OFF;
         psci_ops.cpu_off = psci_cpu_off;

+       pr_info("Using standard PSCI v0.2 function IDs CPU_OFF\n");
         psci_function_id[PSCI_FN_CPU_ON] = PSCI_FN_NATIVE(0_2, CPU_ON);
         psci_ops.cpu_on = psci_cpu_on;


My firmware returns PSCI_E_NOT_SUPPORTED for psci_migrate() and 
PSCI_TOS_NOT_PRESENT_MP for psci_migrate_info_type().

Any idea, what going wrong?
Why adding a print or delay always works?

[1]:
==============

psci: probing for conduit method from DT.
psci: PSCIv0.2 detected in firmware.
psci: Using standard PSCI v0.2 function IDs
Unable to handle kernel NULL pointer dereference at virtual address 00000be8
pgd = ffffffc00097f000
[00000be8] *pgd=0000000000000000, *pud=0000000000000000
Internal error: Oops: 96000045 [#1] PREEMPT SMP
Modules linked in:
CPU: 0 PID: 0 Comm: swapper Not tainted 4.3.0-next-20151109+ #13

task: ffffffc0008d1100 ti: ffffffc0008c4000 task.ti: ffffffc0008c4000
PC is at psci_0_2_init+0x90/0x290
LR is at psci_0_2_init+0x84/0x290
pc : [<ffffffc00084e4a0>] lr : [<ffffffc00084e494>] pstate: 600002c5
sp : ffffffc0008c7eb0
x29: ffffffc0008c7eb0 x28: 0000000000000000
x27: ffffffc002000000 x26: ffffffc0008d28b0
x25: ffffffc0007680b8 x24: ffffffc0008d2000
x23: ffffffc0008d75b0 x22: 0000000000000000
x21: 0000000000000000 x20: 0000000000000bb8
x19: 0000000000000000 x18: 0000000000000000
x17: 0000000000000000 x16: 0000000000000000
x15: 0000000000000000 x14: 0000000000000000
x13: 0000000000000000 x12: 0000000000000006
x11: 0000000000000000 x10: 000000000000000f
x9 : 0000000000000010 x8 : 6620322e30762049
x7 : ffffffc0008caa58 x6 : 0000000000000001
x5 : ffffffc0003bfda4 x4 : 0000000000000000
x3 : 0000000000000000 x2 : 0000000000000001
x1 : ffffffc0004c77bc x0 : 000000000000002b

Process swapper (pid: 0, stack limit = 0xffffffc0008c4020)
Stack: (0xffffffc0008c7eb0 to 0xffffffc0008c8000)
7ea0:                                   ffffffc0008c7ee0 ffffffc00084e6cc
7ec0: ffffffc0befe5f80 ffffffc0009524a8 ffffffc0008d2ab0 ffffffc0008e0000
7ee0: ffffffc0008c7f00 ffffffc00082b618 ffffffc0befe5f80 ffffffc00089c708
7f00: ffffffc0008c7fa0 ffffffc000828668 0000000000000001 ffffffc000861d80
7f20: 0000000048000000 0000000000000000 ffffffc0008ca000 0000000040000000
7f40: 000000004097c000 000000004097f000 ffffffc000081198 00000000ffffffc8
7f60: 000000008f065000 ffffffc0005d80a0 0000000000000001 0000000048000000
7f80: ffffffffffffffff 0000000000000000 0000000000000080 fefefefefefefefe
7fa0: 0000000000000000 00000000405d4000 000000008f065000 0000000000000e11
7fc0: 0000000048000000 0000000000000000 0000000000000000 0000000040000000
7fe0: 0000000000000000 ffffffc0008625a8 0000000000000000 0000000000000000
Call trace:
[<ffffffc00084e4a0>] psci_0_2_init+0x90/0x290
[<ffffffc00084e6cc>] psci_dt_init+0x2c/0x3c
[<ffffffc00082b618>] setup_arch+0x384/0x550
[<ffffffc000828668>] start_kernel+0x98/0x3b8
[<00000000405d4000>] 0x405d4000
Code: 97e3c1ec b0ffe3c1 912ee2b4 911ef021 (f9001a81)
---[ end trace cb88537fdc8fa200 ]---
Kernel panic - not syncing: Attempted to kill the idle task!
---[ end Kernel panic - not syncing: Attempted to kill the idle task!
