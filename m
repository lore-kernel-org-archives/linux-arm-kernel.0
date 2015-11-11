From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 11 Nov 2015 12:18:16 +0000
Subject: PSCI: NULL pointer dereference
In-Reply-To: <56432D5F.1090101@samsung.com>
References: <5642F64B.3030801@samsung.com> <20151111103724.GA21276@red-moon>
 <56432D5F.1090101@samsung.com>
Message-ID: <20151111121816.GD31900@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 11, 2015 at 05:28:23PM +0530, Alim Akhtar wrote:
> Hi Lorenzo,
> Thanks for reply.
> 
> On 11/11/2015 04:07 PM, Lorenzo Pieralisi wrote:
> >On Wed, Nov 11, 2015 at 01:33:23PM +0530, Alim Akhtar wrote:
> >>Hi Mark/Lorenzo,
> >>
> >>Getting a NULL pointer dereference from psci_0_2_set_functions() like [1].
> >>But this goes away with a addition of a printk (see blow diff) or a
> >>udelay(10) with the same firmware on the board.
> >>
> >>diff --git a/drivers/firmware/psci.c b/drivers/firmware/psci.c
> >>index d24f35d74b27..92a0798e4138 100644
> >>--- a/drivers/firmware/psci.c
> >>+++ b/drivers/firmware/psci.c
> >>@@ -312,6 +312,7 @@ static void __init psci_0_2_set_functions(void)
> >>         psci_function_id[PSCI_FN_CPU_OFF] = PSCI_0_2_FN_CPU_OFF;
> >>         psci_ops.cpu_off = psci_cpu_off;
> >>
> >>+       pr_info("Using standard PSCI v0.2 function IDs CPU_OFF\n");
> >>         psci_function_id[PSCI_FN_CPU_ON] = PSCI_FN_NATIVE(0_2, CPU_ON);
> >>         psci_ops.cpu_on = psci_cpu_on;

[...]

> In disassembly PC points to  "str     x1, [x20,#48]"
> see [2] below
> My thinking is kernel should not have crashed this way even if
> firmware does something wrong. No?? should have exit with a warning
> may be?

We could see issues like this if your firmware modifies registers other
than x0-x18. Per the SMC calling conventions, other registers should
have their originial values preserved.

> >>psci: probing for conduit method from DT.
> >>psci: PSCIv0.2 detected in firmware.
> >>psci: Using standard PSCI v0.2 function ID.s
> >>Unable to handle kernel NULL pointer dereference at virtual address 00000be8
> >>pgd = ffffffc00097f000
> >>[00000be8] *pgd=0000000000000000, *pud=0000000000000000
> >>Internal error: Oops: 96000045 [#1] PREEMPT SMP
> >>Modules linked in:
> >>CPU: 0 PID: 0 Comm: swapper Not tainted 4.3.0-next-20151109+ #13
> >>
> >>task: ffffffc0008d1100 ti: ffffffc0008c4000 task.ti: ffffffc0008c4000
> >>PC is at psci_0_2_init+0x90/0x290
> >>LR is at psci_0_2_init+0x84/0x290
> >>pc : [<ffffffc00084e4a0>] lr : [<ffffffc00084e494>] pstate: 600002c5
> >>sp : ffffffc0008c7eb0
> >>x29: ffffffc0008c7eb0 x28: 0000000000000000
> >>x27: ffffffc002000000 x26: ffffffc0008d28b0
> >>x25: ffffffc0007680b8 x24: ffffffc0008d2000
> >>x23: ffffffc0008d75b0 x22: 0000000000000000
> >>x21: 0000000000000000 x20: 0000000000000bb8
> >>x19: 0000000000000000 x18: 0000000000000000
> >>x17: 0000000000000000 x16: 0000000000000000
> >>x15: 0000000000000000 x14: 0000000000000000
> >>x13: 0000000000000000 x12: 0000000000000006
> >>x11: 0000000000000000 x10: 000000000000000f
> >>x9 : 0000000000000010 x8 : 6620322e30762049
> >>x7 : ffffffc0008caa58 x6 : 0000000000000001
> >>x5 : ffffffc0003bfda4 x4 : 0000000000000000
> >>x3 : 0000000000000000 x2 : 0000000000000001
> >>x1 : ffffffc0004c77bc x0 : 000000000000002b

It is somewhat suspicious that x19-x22 are all zero (from the asm below
[2] I see x20 was zero, but had 0xbb8 added to it before the store).

I suspect that your firmware is corrupting more registers than it is
permitted to, and the delay or printk call changes the register
allocation in the function so we don't notice.

Thanks,
Mark.

> >>
> >>Process swapper (pid: 0, stack limit = 0xffffffc0008c4020)
> >>Stack: (0xffffffc0008c7eb0 to 0xffffffc0008c8000)
> >>7ea0:                                   ffffffc0008c7ee0 ffffffc00084e6cc
> >>7ec0: ffffffc0befe5f80 ffffffc0009524a8 ffffffc0008d2ab0 ffffffc0008e0000
> >>7ee0: ffffffc0008c7f00 ffffffc00082b618 ffffffc0befe5f80 ffffffc00089c708
> >>7f00: ffffffc0008c7fa0 ffffffc000828668 0000000000000001 ffffffc000861d80
> >>7f20: 0000000048000000 0000000000000000 ffffffc0008ca000 0000000040000000
> >>7f40: 000000004097c000 000000004097f000 ffffffc000081198 00000000ffffffc8
> >>7f60: 000000008f065000 ffffffc0005d80a0 0000000000000001 0000000048000000
> >>7f80: ffffffffffffffff 0000000000000000 0000000000000080 fefefefefefefefe
> >>7fa0: 0000000000000000 00000000405d4000 000000008f065000 0000000000000e11
> >>7fc0: 0000000048000000 0000000000000000 0000000000000000 0000000040000000
> >>7fe0: 0000000000000000 ffffffc0008625a8 0000000000000000 0000000000000000
> >>Call trace:
> >>[<ffffffc00084e4a0>] psci_0_2_init+0x90/0x290
> >>[<ffffffc00084e6cc>] psci_dt_init+0x2c/0x3c
> >>[<ffffffc00082b618>] setup_arch+0x384/0x550
> >>[<ffffffc000828668>] start_kernel+0x98/0x3b8
> >>[<00000000405d4000>] 0x405d4000
> >>Code: 97e3c1ec b0ffe3c1 912ee2b4 911ef021 (f9001a81)
> >>---[ end trace cb88537fdc8fa200 ]---
> >>Kernel panic - not syncing: Attempted to kill the idle task!
> >>---[ end Kernel panic - not syncing: Attempted to kill the idle task!
> >>
> [2]:
> ffffffc00084e410 <psci_0_2_init>:
> ffffffc00084e410:       a9bd7bfd        stp     x29, x30, [sp,#-48]!
> ffffffc00084e414:       910003fd        mov     x29, sp
> ffffffc00084e418:       a90153f3        stp     x19, x20, [sp,#16]
> ffffffc00084e41c:       a9025bf5        stp     x21, x22, [sp,#32]
> ffffffc00084e420:       97f2a447        bl      ffffffc0004f753c
> <get_set_conduit_method>
> ffffffc00084e424:       2a0003f3        mov     w19, w0
> ffffffc00084e428:       35001320        cbnz    w0, ffffffc00084e68c
> <psci_0_2_init+0x27c>
> ffffffc00084e42c:       90000915        adrp    x21,
> ffffffc00096e000 <usb_minors+0x3b8>
> ffffffc00084e430:       912ee2a0        add     x0, x21, #0xbb8
> ffffffc00084e434:       d2800001        mov     x1, #0x0         //
> #0
> ffffffc00084e438:       f9400004        ldr     x4, [x0]
> ffffffc00084e43c:       aa0103e2        mov     x2, x1
> ffffffc00084e440:       aa0103e3        mov     x3, x1
> ffffffc00084e444:       d2b08000        mov     x0, #0x84000000
> // #2214592512
> ffffffc00084e448:       d63f0080        blr     x4
> ffffffc00084e44c:       53107c16        lsr     w22, w0, #16
> ffffffc00084e450:       12003c14        and     w20, w0, #0xffff
> ffffffc00084e454:       b0fffb40        adrp    x0, ffffffc0007b7000
> <kallsyms_token_index+0x50600>
> ffffffc00084e458:       913d2000        add     x0, x0, #0xf48
> ffffffc00084e45c:       2a1603e1        mov     w1, w22
> ffffffc00084e460:       2a1403e2        mov     w2, w20
> ffffffc00084e464:       97e3c1f7        bl      ffffffc00013ec40 <printk>
> ffffffc00084e468:       35000116        cbnz    w22,
> ffffffc00084e488 <psci_0_2_init+0x78>
> ffffffc00084e46c:       7100069f        cmp     w20, #0x1
> ffffffc00084e470:       540000c8        b.hi    ffffffc00084e488
> <psci_0_2_init+0x78>
> ffffffc00084e474:       b0fffb40        adrp    x0, ffffffc0007b7000
> <kallsyms_token_index+0x50600>
> ffffffc00084e478:       913de000        add     x0, x0, #0xf78
> ffffffc00084e47c:       97e3c1f1        bl      ffffffc00013ec40 <printk>
> ffffffc00084e480:       128002b3        mov     w19, #0xffffffea
> // #-22
> ffffffc00084e484:       14000082        b       ffffffc00084e68c
> <psci_0_2_init+0x27c>
> ffffffc00084e488:       b0fffb40        adrp    x0, ffffffc0007b7000
> <kallsyms_token_index+0x50600>
> ffffffc00084e48c:       913ea000        add     x0, x0, #0xfa8
> ffffffc00084e490:       97e3c1ec        bl      ffffffc00013ec40 <printk>
> ffffffc00084e494:       b0ffe3c1        adrp    x1, ffffffc0004c7000
> <syscon_led_probe+0xc>
> ffffffc00084e498:       912ee2b4        add     x20, x21, #0xbb8
> ffffffc00084e49c:       911ef021        add     x1, x1, #0x7bc
> ffffffc00084e4a0:       f9001a81        str     x1, [x20,#48]
> ffffffc00084e4a4:       b0ffe3c1        adrp    x1, ffffffc0004c7000
> <syscon_led_probe+0xc>
> ffffffc00084e4a8:       91203021        add     x1, x1, #0x80c
> ffffffc00084e4ac:       f9001e81        str     x1, [x20,#56]
> 
> >>
> >>_______________________________________________
> >>linux-arm-kernel mailing list
> >>linux-arm-kernel at lists.infradead.org
> >>http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> >>
> >
> >
> 
