From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 21 Mar 2017 19:20:44 +0000
Subject: [PATCH v4 14/28] ARM: hyp-stub: Use r1 for the soft-restart address
In-Reply-To: <20170321192058.9300-1-marc.zyngier@arm.com>
References: <20170321192058.9300-1-marc.zyngier@arm.com>
Message-ID: <20170321192058.9300-15-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It is not really obvious why the restart address should be in r3
when communicated to the hyp-stub. r1 should be perfectly adequate,
and consistent with the rest of the code.

Tested-by: Keerthy <j-keerthy@ti.com>
Acked-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/kernel/hyp-stub.S | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm/kernel/hyp-stub.S b/arch/arm/kernel/hyp-stub.S
index 8301db963d83..15eaa14322a7 100644
--- a/arch/arm/kernel/hyp-stub.S
+++ b/arch/arm/kernel/hyp-stub.S
@@ -214,7 +214,7 @@ __hyp_stub_do_trap:
 
 1:	teq	r0, #HVC_SOFT_RESTART
 	bne	1f
-	bx	r3
+	bx	r1
 
 1:	mov	r0, #-1
 
@@ -258,10 +258,9 @@ ENTRY(__hyp_set_vectors)
 ENDPROC(__hyp_set_vectors)
 
 ENTRY(__hyp_soft_restart)
-	mov	r3, r0
+	mov	r1, r0
 	mov	r0, #HVC_SOFT_RESTART
 	__HVC(0)
-	mov	r0, r3
 	ret	lr
 ENDPROC(__hyp_soft_restart)
 
-- 
2.11.0
