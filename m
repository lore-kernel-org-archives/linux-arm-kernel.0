From: fengguang.wu@intel.com (kbuild test robot)
Date: Thu, 18 Feb 2016 00:26:46 +0800
Subject: [arm:for-next 24/31] arch/arm/kernel/hyp-stub.S:168: Error: selected
 processor does not support ARM mode `ubfx r7,r7,#28,#4'
Message-ID: <201602180044.PcvJbrb9%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   http://repo.or.cz/linux-2.6/linux-2.6-arm.git for-next
head:   5aeac3b523644cbc300f17d67c8fce73df9060c0
commit: e59941b9b3817c9b1dd6662d903150fe3f3c3b0b [24/31] ARM: 8527/1: virt: enable GICv3 system registers
config: arm-allmodconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout e59941b9b3817c9b1dd6662d903150fe3f3c3b0b
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

   arch/arm/kernel/hyp-stub.S: Assembler messages:
>> arch/arm/kernel/hyp-stub.S:168: Error: selected processor does not support ARM mode `ubfx r7,r7,#28,#4'
>> arch/arm/kernel/hyp-stub.S:176: Error: selected processor does not support ARM mode `isb'

vim +168 arch/arm/kernel/hyp-stub.S

   162	1:
   163	#endif
   164	
   165	#ifdef CONFIG_ARM_GIC_V3
   166		@ Check whether GICv3 system registers are available
   167		mrc	p15, 0, r7, c0, c1, 1	@ ID_PFR1
 > 168		ubfx	r7, r7, #28, #4
   169		cmp	r7, #1
   170		bne	2f
   171	
   172		@ Enable system register accesses
   173		mrc	p15, 4, r7, c12, c9, 5	@ ICC_HSRE
   174		orr	r7, r7, #(ICC_SRE_EL2_ENABLE | ICC_SRE_EL2_SRE)
   175		mcr	p15, 4, r7, c12, c9, 5	@ ICC_HSRE
 > 176		isb
   177	
   178		@ SRE bit could be forced to 0 by firmware.
   179		@ Check whether it sticks before accessing any other sysreg

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 56246 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160218/1033e90f/attachment-0001.obj>
