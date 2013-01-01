From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Tue,  1 Jan 2013 21:16:07 +0800
Subject: [PATCH] ARM: mm: fix wrong branch from a9 to pj4b
Message-ID: <1357046167-32495-1-git-send-email-haojian.zhuang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If CONFIG_ARCH_MULTIPLATFORM & CONFIG_ARCH_MVEBU are both enabled,
__v7_pj4b_setup is added between __v7_ca9mp_setup and __v7_setup.

But there's no jump instruction added. If the chip is Cortex A5/A9,
it goes through __v7_pj4b_setup also. It results in system hang.

Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
---
 arch/arm/mm/proc-v7.S |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
index 350f6a7..863de63 100644
--- a/arch/arm/mm/proc-v7.S
+++ b/arch/arm/mm/proc-v7.S
@@ -169,6 +169,7 @@ __v7_ca15mp_setup:
 	orreq	r0, r0, r10			@ Enable CPU-specific SMP bits
 	mcreq	p15, 0, r0, c1, c0, 1
 #endif
+	b	__v7_setup
 
 __v7_pj4b_setup:
 #ifdef CONFIG_CPU_PJ4B
-- 
1.7.10.4
