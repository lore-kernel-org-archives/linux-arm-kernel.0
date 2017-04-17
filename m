From: nrg02771@nifty.com (nrg02771 at nifty.com)
Date: Tue, 18 Apr 2017 07:39:16 +0900 (JST)
Subject: Increase stack size to 16KB
Message-ID: <828135836.20701492468756240.nrg02771@nifty.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, all,

I want to increase stack size to 16KB on freescale 32bit arm system.

I'm using the following environment.
CPU: freescale imx6dl 32bit
Kernel:3.14.28-1.0.0

I modified the following kernel source code to increase stack size.
I confirmed kernel work fine, but after mounted rootfs, init process
dose not work with the following error message.
 I confirmed init process created without error, but it seems when
executing init process the error occurs.
Is it possible to increase stack size to 16KB with 32bit arm freescale
environment?

I confirmed OMAP arm 32bit environment work fine with the same modification.

Can I have any advice?

Best Regards,
Akira Matsui

--------- Error Message --------------------
...
EXT3-fs (mmcblk3p2): using internal journal
EXT3-fs (mmcblk3p2): recovery complete
EXT3-fs (mmcblk3p2): mounted filesystem with ordered data mode
VFS: Mounted root (ext3 filesystem) on device 179:2.
devtmpfs: mounted
Freeing unused kernel memory: 324K (80c68000 - 80cb9000)
Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b


----------- kernel modification ------------------
I defined original macro CONFIG_DEBUG_STACK_16K.

?arch/arm/include/asm/thread_info.h

#ifdef CONFIG_DEBUG_STACK_16K
#define THREAD_SIZE_ORDER      2
#define THREAD_SIZE            16384
#define THREAD_START_SP                (THREAD_SIZE - 16)
#else
#define THREAD_SIZE_ORDER 1
#define THREAD_SIZE 8192
#define THREAD_START_SP (THREAD_SIZE - 8)
#endif

?arch/arm/kernel/entry-header.S
...
#ifdef CONFIG_DEBUG_STACK_16K
mov     ?rd, sp, lsr #14
        mov     ?rd, ?rd, lsl #14
#else
mov ?rd, sp, lsr #13
mov ?rd, ?rd, lsl #13
#endif

...
#ifdef CONFIG_DEBUG_STACK_16K
lsr     ?rd, ?rd, #14
        mov     ?rd, ?rd, lsl #14
#else
lsr ?rd, ?rd, #13
mov ?rd, ?rd, lsl #13
#endif

?arch/arm/mm/proc-macros.S
/*
 * act_mm - get current->active_mm
 */
.macro act_mm, rd
#ifdef CONFIG_DEBUG_STACK_16K
mov ?rd, sp, lsr #12 + THREAD_SIZE_ORDER
    mov ?rd, ?rd, lsl #12 + THREAD_SIZE_ORDER
#else
bic ?rd, sp, #8128
bic ?rd, ?rd, #63
#endif
ldr ?rd, [?rd, #TI_TASK]
ldr ?rd, [?rd, #TSK_ACTIVE_MM]
.endm
