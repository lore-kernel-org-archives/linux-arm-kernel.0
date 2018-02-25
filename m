From: lkp@intel.com (kbuild test robot)
Date: Sun, 25 Feb 2018 18:09:44 +0800
Subject: [PATCH 2/2] arm: kprobes: Prohibit kprobes on get_user functions
In-Reply-To: <151945939903.11045.1486072728379559979.stgit@devbox>
References: <151945939903.11045.1486072728379559979.stgit@devbox>
Message-ID: <201802251710.fJ5muILY%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Masami,

I love your patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v4.16-rc2 next-20180223]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Masami-Hiramatsu/arm-kprobes-Prohibit-kprobes-on-do_undefinstr/20180225-151050
config: arm-ixp4xx_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

   arch/arm/lib/getuser.S: Assembler messages:
   arch/arm/lib/getuser.S:41: Error: bad instruction `_asm_nokprobe(__get_user_1)'
   arch/arm/lib/getuser.S:62: Error: bad instruction `_asm_nokprobe(__get_user_2)'
   arch/arm/lib/getuser.S:70: Error: bad instruction `_asm_nokprobe(__get_user_4)'
   arch/arm/lib/getuser.S:84: Error: bad instruction `_asm_nokprobe(__get_user_8)'
>> arch/arm/lib/getuser.S:98: Error: bad instruction `_asm_nokprobe(__get_user_32t_8)'
>> arch/arm/lib/getuser.S:106: Error: bad instruction `_asm_nokprobe(__get_user_64t_1)'
>> arch/arm/lib/getuser.S:123: Error: bad instruction `_asm_nokprobe(__get_user_64t_2)'
>> arch/arm/lib/getuser.S:131: Error: bad instruction `_asm_nokprobe(__get_user_64t_4)'
   arch/arm/lib/getuser.S:142: Error: bad instruction `_asm_nokprobe(__get_user_bad)'
   arch/arm/lib/getuser.S:143: Error: bad instruction `_asm_nokprobe(__get_user_bad8)'

vim +98 arch/arm/lib/getuser.S

    34	
    35	ENTRY(__get_user_1)
    36		check_uaccess r0, 1, r1, r2, __get_user_bad
    37	1: TUSER(ldrb)	r2, [r0]
    38		mov	r0, #0
    39		ret	lr
    40	ENDPROC(__get_user_1)
  > 41	_ASM_NOKPROBE(__get_user_1)
    42	
    43	ENTRY(__get_user_2)
    44		check_uaccess r0, 2, r1, r2, __get_user_bad
    45	#ifdef CONFIG_CPU_USE_DOMAINS
    46	rb	.req	ip
    47	2:	ldrbt	r2, [r0], #1
    48	3:	ldrbt	rb, [r0], #0
    49	#else
    50	rb	.req	r0
    51	2:	ldrb	r2, [r0]
    52	3:	ldrb	rb, [r0, #1]
    53	#endif
    54	#ifndef __ARMEB__
    55		orr	r2, r2, rb, lsl #8
    56	#else
    57		orr	r2, rb, r2, lsl #8
    58	#endif
    59		mov	r0, #0
    60		ret	lr
    61	ENDPROC(__get_user_2)
    62	_ASM_NOKPROBE(__get_user_2)
    63	
    64	ENTRY(__get_user_4)
    65		check_uaccess r0, 4, r1, r2, __get_user_bad
    66	4: TUSER(ldr)	r2, [r0]
    67		mov	r0, #0
    68		ret	lr
    69	ENDPROC(__get_user_4)
    70	_ASM_NOKPROBE(__get_user_4)
    71	
    72	ENTRY(__get_user_8)
    73		check_uaccess r0, 8, r1, r2, __get_user_bad8
    74	#ifdef CONFIG_THUMB2_KERNEL
    75	5: TUSER(ldr)	r2, [r0]
    76	6: TUSER(ldr)	r3, [r0, #4]
    77	#else
    78	5: TUSER(ldr)	r2, [r0], #4
    79	6: TUSER(ldr)	r3, [r0]
    80	#endif
    81		mov	r0, #0
    82		ret	lr
    83	ENDPROC(__get_user_8)
    84	_ASM_NOKPROBE(__get_user_8)
    85	
    86	#ifdef __ARMEB__
    87	ENTRY(__get_user_32t_8)
    88		check_uaccess r0, 8, r1, r2, __get_user_bad
    89	#ifdef CONFIG_CPU_USE_DOMAINS
    90		add	r0, r0, #4
    91	7:	ldrt	r2, [r0]
    92	#else
    93	7:	ldr	r2, [r0, #4]
    94	#endif
    95		mov	r0, #0
    96		ret	lr
    97	ENDPROC(__get_user_32t_8)
  > 98	_ASM_NOKPROBE(__get_user_32t_8)
    99	
   100	ENTRY(__get_user_64t_1)
   101		check_uaccess r0, 1, r1, r2, __get_user_bad8
   102	8: TUSER(ldrb)	r3, [r0]
   103		mov	r0, #0
   104		ret	lr
   105	ENDPROC(__get_user_64t_1)
 > 106	_ASM_NOKPROBE(__get_user_64t_1)
   107	
   108	ENTRY(__get_user_64t_2)
   109		check_uaccess r0, 2, r1, r2, __get_user_bad8
   110	#ifdef CONFIG_CPU_USE_DOMAINS
   111	rb	.req	ip
   112	9:	ldrbt	r3, [r0], #1
   113	10:	ldrbt	rb, [r0], #0
   114	#else
   115	rb	.req	r0
   116	9:	ldrb	r3, [r0]
   117	10:	ldrb	rb, [r0, #1]
   118	#endif
   119		orr	r3, rb, r3, lsl #8
   120		mov	r0, #0
   121		ret	lr
   122	ENDPROC(__get_user_64t_2)
 > 123	_ASM_NOKPROBE(__get_user_64t_2)
   124	
   125	ENTRY(__get_user_64t_4)
   126		check_uaccess r0, 4, r1, r2, __get_user_bad8
   127	11: TUSER(ldr)	r3, [r0]
   128		mov	r0, #0
   129		ret	lr
   130	ENDPROC(__get_user_64t_4)
 > 131	_ASM_NOKPROBE(__get_user_64t_4)
   132	#endif
   133	
   134	__get_user_bad8:
   135		mov	r3, #0
   136	__get_user_bad:
   137		mov	r2, #0
   138		mov	r0, #-EFAULT
   139		ret	lr
   140	ENDPROC(__get_user_bad)
   141	ENDPROC(__get_user_bad8)
   142	_ASM_NOKPROBE(__get_user_bad)
   143	_ASM_NOKPROBE(__get_user_bad8)
   144	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 19581 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180225/a7467c82/attachment-0001.gz>
