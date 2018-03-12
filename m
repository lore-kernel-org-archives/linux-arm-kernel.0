From: lkp@intel.com (kbuild test robot)
Date: Mon, 12 Mar 2018 13:56:30 +0800
Subject: [PATCH V2] ZBOOT: fix stack protector in compressed boot phase
In-Reply-To: <1520820258-19225-1-git-send-email-chenhc@lemote.com>
References: <1520820258-19225-1-git-send-email-chenhc@lemote.com>
Message-ID: <201803121309.rL1h1C83%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Huacai,

I love your patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v4.16-rc5 next-20180309]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Huacai-Chen/ZBOOT-fix-stack-protector-in-compressed-boot-phase/20180312-114651
config: sh-allnoconfig (attached as .config)
compiler: sh4-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=sh 

All errors (new ones prefixed by >>):

   arch/sh/boot/compressed/head_32.S: Assembler messages:
>> arch/sh/boot/compressed/head_32.S:79: Error: pcrel too far
>> arch/sh/boot/compressed/head_32.S:80: Error: offset out of range
>> arch/sh/boot/compressed/head_32.S:80: Error: value of 658943 too large for field of 2 bytes at 102

vim +79 arch/sh/boot/compressed/head_32.S

    12	
    13		.global	startup
    14	startup:
    15		/* Load initial status register */
    16		mov.l   init_sr, r1
    17		ldc     r1, sr
    18	
    19		/* Move myself to proper location if necessary */
    20		mova	1f, r0
    21		mov.l	1f, r2
    22		cmp/eq	r2, r0
    23		bt	clear_bss
    24		sub	r0, r2
    25		mov.l	bss_start_addr, r0
    26		mov	#0xffffffe0, r1
    27		and	r1, r0			! align cache line
    28		mov.l	text_start_addr, r3
    29		mov	r0, r1
    30		sub	r2, r1
    31	3:
    32		mov.l	@r1, r4
    33		mov.l	@(4,r1), r5
    34		mov.l	@(8,r1), r6
    35		mov.l	@(12,r1), r7
    36		mov.l	@(16,r1), r8
    37		mov.l	@(20,r1), r9
    38		mov.l	@(24,r1), r10
    39		mov.l	@(28,r1), r11
    40		mov.l	r4, @r0
    41		mov.l	r5, @(4,r0)
    42		mov.l	r6, @(8,r0)
    43		mov.l	r7, @(12,r0)
    44		mov.l	r8, @(16,r0)
    45		mov.l	r9, @(20,r0)
    46		mov.l	r10, @(24,r0)
    47		mov.l	r11, @(28,r0)
    48	#ifdef CONFIG_CPU_SH4
    49		ocbwb	@r0
    50	#endif
    51		cmp/hi	r3, r0
    52		add	#-32, r0
    53		bt/s	3b
    54		 add	#-32, r1
    55		mov.l	2f, r0
    56		jmp	@r0
    57		 nop
    58	
    59		.align 2
    60	1:	.long	1b
    61	2:	.long	clear_bss
    62	text_start_addr:
    63		.long	startup
    64	
    65		/* Clear BSS */
    66	clear_bss:
    67		mov.l	end_addr, r1
    68		mov.l	bss_start_addr, r2
    69		mov	#0, r0
    70	l1:
    71		mov.l	r0, @-r1
    72		cmp/eq	r1,r2
    73		bf	l1
    74	
    75		/* Set the initial pointer. */
    76		mov.l	init_stack_addr, r0
    77		mov.l	@r0, r15
    78	
  > 79		mov.l	__stack_chk_guard, r0
  > 80		mov	#0x000a0dff, r1

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 5471 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180312/3f67aa8b/attachment.gz>
