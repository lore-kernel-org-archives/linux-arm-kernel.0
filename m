From: lkp@intel.com (kbuild test robot)
Date: Thu, 24 Aug 2017 03:14:03 +0800
Subject: [PATCH v1 1/3] arm: npcm: add basic support for Nuvoton BMCs
In-Reply-To: <20170822033502.4100-2-brendanhiggins@google.com>
Message-ID: <201708240359.VARhpnvP%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Brendan,

[auto build test ERROR on linus/master]
[also build test ERROR on v4.13-rc6 next-20170823]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Brendan-Higgins/arm-npcm-add-basic-support-for-Nuvoton-BMCs/20170824-031106
config: arm-allmodconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

   arch/arm/mach-npcm/headsmp.S: Assembler messages:
>> arch/arm/mach-npcm/headsmp.S:73: Error: selected processor does not support `dsb' in ARM mode
>> arch/arm/mach-npcm/headsmp.S:74: Error: selected processor does not support `isb' in ARM mode

vim +73 arch/arm/mach-npcm/headsmp.S

    42	
    43	ENTRY(v7_invalidate_l1_npcmX50)
    44		mov	r0, #0
    45		mcr	p15, 0, r0, c7, c5, 0 /* invalidate I cache */
    46		mcr	p15, 2, r0, c0, c0, 0
    47		mrc	p15, 1, r0, c0, c0, 0
    48	
    49		ldr	r1, =0x7fff
    50		and	r2, r1, r0, lsr #13
    51	
    52		ldr	r1, =0x3ff
    53	
    54		and	r3, r1, r0, lsr #3 /* NumWays - 1 */
    55		add	r2, r2, #1         /* NumSets */
    56	
    57		and	r0, r0, #0x7
    58		add	r0, r0, #4 /* SetShift */
    59	
    60		clz	r1, r3     /* WayShift */
    61		add	r4, r3, #1 /* NumWays */
    62	1:	sub	r2, r2, #1 /* NumSets-- */
    63		mov	r3, r4     /* Temp = NumWays */
    64	2:	subs	r3, r3, #1 /* Temp-- */
    65		mov	r5, r3, lsl r1
    66		mov	r6, r2, lsl r0
    67		/* Reg = (Temp << WayShift) | (NumSets << SetShift) */
    68		orr	r5, r5, r6
    69		mcr	p15, 0, r5, c7, c6, 2
    70		bgt	2b
    71		cmp	r2, #0
    72		bgt	1b
  > 73		dsb
  > 74		isb
    75		mov	pc, lr
    76	ENDPROC(v7_invalidate_l1_npcmX50)
    77	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 62836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170824/c5e6fba4/attachment-0001.gz>
