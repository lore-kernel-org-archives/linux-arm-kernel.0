From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Mon,  4 Aug 2014 10:46:44 +0200
Subject: [GIT PULL 27/51] ARM: virt: fix wrong HSCTLR.EE bit setting
In-Reply-To: <1407142028-31105-1-git-send-email-christoffer.dall@linaro.org>
References: <1407142028-31105-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <1407142028-31105-28-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Li Liu <john.liuli@huawei.com>

HSCTLR.EE is defined as bit[25] referring to arm manual
DDI0606C.b(p1590).

Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Li Liu <john.liuli@huawei.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/kernel/hyp-stub.S | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm/kernel/hyp-stub.S b/arch/arm/kernel/hyp-stub.S
index 797b1a6..7e666cf 100644
--- a/arch/arm/kernel/hyp-stub.S
+++ b/arch/arm/kernel/hyp-stub.S
@@ -134,9 +134,7 @@ ENTRY(__hyp_stub_install_secondary)
 	mcr	p15, 4, r7, c1, c1, 3	@ HSTR
 
 THUMB(	orr	r7, #(1 << 30)	)	@ HSCTLR.TE
-#ifdef CONFIG_CPU_BIG_ENDIAN
-	orr	r7, #(1 << 9)		@ HSCTLR.EE
-#endif
+ARM_BE8(orr	r7, r7, #(1 << 25))     @ HSCTLR.EE
 	mcr	p15, 4, r7, c1, c0, 0	@ HSCTLR
 
 	mrc	p15, 4, r7, c1, c1, 1	@ HDCR
-- 
2.0.0
