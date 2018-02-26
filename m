From: lkp@intel.com (kbuild test robot)
Date: Mon, 26 Feb 2018 14:22:44 +0800
Subject: [PATCH v4 08/10] ARM: sunxi: smp: Move assembly code into a file
In-Reply-To: <20180223133742.26044-9-mylene.josserand@bootlin.com>
References: <20180223133742.26044-9-mylene.josserand@bootlin.com>
Message-ID: <201802261422.ZCMWtsTA%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Myl?ne,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on next-20180223]
[cannot apply to arm-soc/for-next robh/for-next linux-rpi/for-rpi-next v4.16-rc2 v4.16-rc1 v4.15 v4.16-rc3]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Myl-ne-Josserand/Sunxi-Add-SMP-support-on-A83T/20180226-035312
config: arm-allmodconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

   arch/arm/mach-sunxi/headsmp.S: Assembler messages:
>> arch/arm/mach-sunxi/headsmp.S:22: Error: selected processor does not support `movw r2,#(0xff00fff0&0xffff)' in ARM mode
>> arch/arm/mach-sunxi/headsmp.S:23: Error: selected processor does not support `movt r2,#(0xff00fff0>>16)' in ARM mode
   arch/arm/mach-sunxi/headsmp.S:25: Error: selected processor does not support `movw r2,#(0x4100c0f0&0xffff)' in ARM mode
   arch/arm/mach-sunxi/headsmp.S:26: Error: selected processor does not support `movt r2,#(0x4100c0f0>>16)' in ARM mode

vim +22 arch/arm/mach-sunxi/headsmp.S

    13	
    14	ENTRY(sunxi_mc_smp_cluster_cache_enable)
    15		/*
    16		* Enable cluster-level coherency, in preparation for turning on the MMU.
    17		*
    18		* Also enable regional clock gating and L2 data latency settings for
    19		* Cortex-A15. These settings are from the vendor kernel.
    20		*/
    21		mrc	p15, 0, r1, c0, c0, 0
  > 22		movw	r2, #(0xff00fff0&0xffff)
  > 23		movt	r2, #(0xff00fff0>>16)
    24		and	r1, r1, r2
    25		movw	r2, #(0x4100c0f0&0xffff)
    26		movt	r2, #(0x4100c0f0>>16)
    27		cmp	r1, r2
    28		bne	not_a15
    29	
    30		/* The following is Cortex-A15 specific */
    31	
    32		/* ACTLR2: Enable CPU regional clock gates */
    33		mrc p15, 1, r1, c15, c0, 4
    34		orr r1, r1, #(0x1<<31)
    35		mcr p15, 1, r1, c15, c0, 4
    36	
    37		/* L2ACTLR */
    38		mrc p15, 1, r1, c15, c0, 0
    39		/* Enable L2, GIC, and Timer regional clock gates */
    40		orr r1, r1, #(0x1<<26)
    41		/* Disable clean/evict from being pushed to external */
    42		orr r1, r1, #(0x1<<3)
    43		mcr p15, 1, r1, c15, c0, 0
    44	
    45		/* L2CTRL: L2 data RAM latency */
    46		mrc p15, 1, r1, c9, c0, 2
    47		bic r1, r1, #(0x7<<0)
    48		orr r1, r1, #(0x3<<0)
    49		mcr p15, 1, r1, c9, c0, 2
    50	
    51		/* End of Cortex-A15 specific setup */
    52		not_a15:
    53	
    54		/* Get value of sunxi_mc_smp_first_comer */
    55		adr	r1, first
    56		ldr	r0, [r1]
    57		ldr	r0, [r1, r0]
    58	
    59		/* Skip cci_enable_port_for_self if not first comer */
    60		cmp	r0, #0
    61		bxeq	lr
    62		b	cci_enable_port_for_self
    63	
    64		.align 2
    65		first: .word sunxi_mc_smp_first_comer - .
    66	ENDPROC(sunxi_mc_smp_cluster_cache_enable)
    67	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 65297 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180226/a2b7d9ec/attachment-0001.gz>
