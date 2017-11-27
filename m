From: joel@jms.id.au (Joel Stanley)
Date: Mon, 27 Nov 2017 12:05:19 +1030
Subject: [PATCH 1/2] ARM: BUG if jumping to usermode address in kernel mode
In-Reply-To: <E1eIYiX-0007t0-AH@rmk-PC.armlinux.org.uk>
References: <20171125113302.GY31757@n2100.armlinux.org.uk>
 <E1eIYiX-0007t0-AH@rmk-PC.armlinux.org.uk>
Message-ID: <CACPK8XdvUtvKiX_uqTnnb8U-jKuhy4Kw+cda=OKvzabfaffjgQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Russell,

On Sat, Nov 25, 2017 at 10:03 PM, Russell King
<rmk+kernel@armlinux.org.uk> wrote:
> Detect if we are returning to usermode via the normal kernel exit paths
> but the saved PSR value indicates that we are in kernel mode.  This
> could occur due to corrupted stack state, which has been observed with
> "ftracetest".
>
> This ensures that we catch the problem case before we get to user code.
>
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> ---

This patch breaks my 32 bit ARM system when running under Qemu. I get
this continually:

[    2.130043] ------------[ cut here ]------------
[    2.130132] kernel BUG at Returning to usermode but unexpected PSR
bits set?:9!
[    2.130233] Internal error: Oops - BUG: 0 [#1] ARM
[    2.130375] Modules linked in:
[    2.130805] CPU: 0 PID: 154 Comm: modprobe Not tainted 4.15.0-rc1 #3
[    2.130874] Hardware name: Generic DT based system
[    2.131023] task: 87a02800 task.stack: 87970000
[    2.131158] PC is at no_work_pending+0x2c/0x30
[    2.131402] LR is at 0x76f18ae8
[    2.131462] pc : [<8000a600>]    lr : [<76f18ae8>]    psr: 200001d3
[    2.131516] sp : 87971fb0  ip : 80014484  fp : 00000000
[    2.131567] r10: 00000000  r9 : 87970000  r8 : 00000000
[    2.131627] r7 : 00c5387d  r6 : ffffffff  r5 : 00000150  r4 : 76f18ae8
[    2.131686] r3 : 00000000  r2 : 87971fec  r1 : 00000150  r0 : 00000000
[    2.131818] Flags: nzCv  IRQs off  FIQs off  Mode SVC_32  ISA ARM
Segment user
[    2.131894] Control: 00c5387d  Table: 8794c008  DAC: 00000055
[    2.131971] Process modprobe (pid: 154, stack limit = 0x87970188)
[    2.132075] Stack: (0x87971fb0 to 0x87972000)
[    2.132273] 1fa0:                                     00000000
00000000 00000000 00000000
[    2.132344] 1fc0: 00000000 00000000 00000000 00000000 00000000
00000000 00000000 00000000
[    2.132395] 1fe0: 00000000 7ec5fec0 00000000 76f18ae8 00000150
ffffffff e3a00001 e58d300c
[    2.133146] Code: e9527fff e1a00000 e28dd048 e1b0f00e (e7f001f2)
[    2.133593] ---[ end trace 46087be8f22855bc ]---

This is 4.15-rc1, booting aspeed_g5_defconfig on Qemu master
(v2.11.0-rc2-14-ge7b47c2).

qemu-system-arm -nographic -nodefaults -serial stdio -M romulus-bmc \
 -kernel arch/arm/boot/zImage -dtb
arch/arm/boot/dts/aspeed-bmc-opp-romulus.dtb \
 -initrd arm.cpio.xz

If I revert the patch userspace runs as expected.

Cheers,

Joel

>  arch/arm/include/asm/assembler.h | 18 ++++++++++++++++++
>  arch/arm/kernel/entry-header.S   |  6 ++++++
>  2 files changed, 24 insertions(+)
>
> diff --git a/arch/arm/include/asm/assembler.h b/arch/arm/include/asm/assembler.h
> index ad301f107dd2..bc8d4bbd82e2 100644
> --- a/arch/arm/include/asm/assembler.h
> +++ b/arch/arm/include/asm/assembler.h
> @@ -518,4 +518,22 @@ THUMB(     orr     \reg , \reg , #PSR_T_BIT        )
>  #endif
>         .endm
>
> +       .macro  bug, msg, line
> +#ifdef CONFIG_THUMB2_KERNEL
> +1:     .inst   0xde02
> +#else
> +1:     .inst   0xe7f001f2
> +#endif
> +#ifdef CONFIG_DEBUG_BUGVERBOSE
> +       .pushsection .rodata.str, "aMS", %progbits, 1
> +2:     .asciz  "\msg"
> +       .popsection
> +       .pushsection __bug_table, "aw"
> +       .align  2
> +       .word   1b, 2b
> +       .hword  \line
> +       .popsection
> +#endif
> +       .endm
> +
>  #endif /* __ASM_ASSEMBLER_H__ */
> diff --git a/arch/arm/kernel/entry-header.S b/arch/arm/kernel/entry-header.S
> index d523cd8439a3..7f4d80c2db6b 100644
> --- a/arch/arm/kernel/entry-header.S
> +++ b/arch/arm/kernel/entry-header.S
> @@ -300,6 +300,8 @@
>         mov     r2, sp
>         ldr     r1, [r2, #\offset + S_PSR]      @ get calling cpsr
>         ldr     lr, [r2, #\offset + S_PC]!      @ get pc
> +       tst     r1, #0xcf
> +       bne     1f
>         msr     spsr_cxsf, r1                   @ save in spsr_svc
>  #if defined(CONFIG_CPU_V6) || defined(CONFIG_CPU_32v6K)
>         @ We must avoid clrex due to Cortex-A15 erratum #830321
> @@ -314,6 +316,7 @@
>                                                 @ after ldm {}^
>         add     sp, sp, #\offset + PT_REGS_SIZE
>         movs    pc, lr                          @ return & move spsr_svc into cpsr
> +1:     bug     "Returning to usermode but unexpected PSR bits set?", \@
>  #elif defined(CONFIG_CPU_V7M)
>         @ V7M restore.
>         @ Note that we don't need to do clrex here as clearing the local
> @@ -329,6 +332,8 @@
>         ldr     r1, [sp, #\offset + S_PSR]      @ get calling cpsr
>         ldr     lr, [sp, #\offset + S_PC]       @ get pc
>         add     sp, sp, #\offset + S_SP
> +       tst     r1, #0xcf
> +       bne     1f
>         msr     spsr_cxsf, r1                   @ save in spsr_svc
>
>         @ We must avoid clrex due to Cortex-A15 erratum #830321
> @@ -341,6 +346,7 @@
>         .endif
>         add     sp, sp, #PT_REGS_SIZE - S_SP
>         movs    pc, lr                          @ return & move spsr_svc into cpsr
> +1:     bug     "Returning to usermode but unexpected PSR bits set?", \@
>  #endif /* !CONFIG_THUMB2_KERNEL */
>         .endm
>
> --
> 2.7.4
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
-------------- next part --------------
A non-text attachment was scrubbed...
Name: linux-4.15-rc1-dmesg
Type: application/octet-stream
Size: 11762 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171127/44b0b540/attachment-0001.obj>
