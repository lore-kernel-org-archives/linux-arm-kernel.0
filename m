From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 01 Sep 2011 13:49:59 +0100
Subject: [PATCH 05/11] ARM: pm: force non-zero return value from
	__cpu_suspend when aborting
In-Reply-To: <20110901124752.GE29729@n2100.arm.linux.org.uk>
References: <20110901124752.GE29729@n2100.arm.linux.org.uk>
Message-ID: <E1Qz6iV-00078R-9z@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ensure that the return value from __cpu_suspend is non-zero when
aborting.  Zero indicates a successful suspend occurred.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/kernel/sleep.S |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/kernel/sleep.S b/arch/arm/kernel/sleep.S
index dc902f2..46a9f46 100644
--- a/arch/arm/kernel/sleep.S
+++ b/arch/arm/kernel/sleep.S
@@ -61,6 +61,8 @@ ENDPROC(__cpu_suspend)
 
 cpu_suspend_abort:
 	ldmia	sp!, {r1 - r3}		@ pop v:p, virt SP, phys resume fn
+	teq	r0, #0
+	moveq	r0, #1			@ force non-zero value
 	mov	sp, r2
 	ldmfd	sp!, {r4 - r11, pc}
 ENDPROC(cpu_suspend_abort)
-- 
1.7.4.4
