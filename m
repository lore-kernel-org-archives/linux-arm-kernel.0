From: Jean-Philippe.Brucker@arm.com (Jean-Philippe Brucker)
Date: Wed, 17 Feb 2016 19:51:28 +0000
Subject: [arm:for-next 24/31] arch/arm/kernel/hyp-stub.S:168: Error:
 selected processor does not support ARM mode `ubfx r7,r7,#28,#4'
In-Reply-To: <201602180044.PcvJbrb9%fengguang.wu@intel.com>
References: <201602180044.PcvJbrb9%fengguang.wu@intel.com>
Message-ID: <20160217195127.GA4566@e106794-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 18, 2016 at 12:26:46AM +0800, kbuild test robot wrote:
> tree:   http://repo.or.cz/linux-2.6/linux-2.6-arm.git for-next
> head:   5aeac3b523644cbc300f17d67c8fce73df9060c0
> commit: e59941b9b3817c9b1dd6662d903150fe3f3c3b0b [24/31] ARM: 8527/1: virt: enable GICv3 system registers
> config: arm-allmodconfig (attached as .config)
> reproduce:
>         wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout e59941b9b3817c9b1dd6662d903150fe3f3c3b0b
>         # save the attached .config to linux build tree
>         make.cross ARCH=arm 
> 
> All errors (new ones prefixed by >>):
> 
>    arch/arm/kernel/hyp-stub.S: Assembler messages:
> >> arch/arm/kernel/hyp-stub.S:168: Error: selected processor does not support ARM mode `ubfx r7,r7,#28,#4'
> >> arch/arm/kernel/hyp-stub.S:176: Error: selected processor does not support ARM mode `isb'

Selected processor being arm1136j-s, it doesn't make sense to build
hyp-stub.S at all, in my opinion. We should select ARM_VIRT_EXT only
when CPU_32v6 and lower are deselected (as with LPAE). I realize such a
change might be too invasive for a fix, so I attached a version of my
patch that builds for older architectures. If there is no objection, it
will supersede the previous one.

Thanks,
Jean-Philippe

---
>From 2e188d870dcfeff0db5098d9c6ad3eaa139a7ddd Mon Sep 17 00:00:00 2001
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Date: Tue, 22 Sep 2015 09:27:17 +0100
Subject: [PATCH v2] ARM: virt: enable GICv3 system registers

ARMv8 introduces system registers for the Generic Interrupt Controller's
CPU and virtual interfaces.
When GICv3 is implemented, EL2 needs to allow the kernel to use those
registers, by changing the value of ICC_HSRE.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
---
 arch/arm/kernel/hyp-stub.S |   24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/kernel/hyp-stub.S b/arch/arm/kernel/hyp-stub.S
index 2a55373..6c98210 100644
--- a/arch/arm/kernel/hyp-stub.S
+++ b/arch/arm/kernel/hyp-stub.S
@@ -17,6 +17,7 @@
  */
 
 #include <linux/init.h>
+#include <linux/irqchip/arm-gic-v3.h>
 #include <linux/linkage.h>
 #include <asm/assembler.h>
 #include <asm/virt.h>
@@ -161,6 +162,29 @@ ARM_BE8(orr	r7, r7, #(1 << 25))     @ HSCTLR.EE
 1:
 #endif
 
+#ifdef CONFIG_ARM_GIC_V3
+	@ Check whether GICv3 system registers are available
+	mrc	p15, 0, r7, c0, c1, 1	@ ID_PFR1
+	lsr	r7, r7, #28
+	cmp	r7, #1
+	bne	2f
+
+	@ Enable system register accesses
+	mrc	p15, 4, r7, c12, c9, 5	@ ICC_HSRE
+	orr	r7, r7, #(ICC_SRE_EL2_ENABLE | ICC_SRE_EL2_SRE)
+	mcr	p15, 4, r7, c12, c9, 5	@ ICC_HSRE
+	instr_sync
+
+	@ SRE bit could be forced to 0 by firmware.
+	@ Check whether it sticks before accessing any other sysreg
+	mrc	p15, 4, r7, c12, c9, 5	@ ICC_HSRE
+	tst	r7, #ICC_SRE_EL2_SRE
+	beq	2f
+	mov	r7, #0
+	mcr	p15, 4, r7, c12, c11, 0	@ ICH_HCR
+2:
+#endif
+
 	bx	lr			@ The boot CPU mode is left in r4.
 ENDPROC(__hyp_stub_install_secondary)
 
-- 
1.7.9.5
