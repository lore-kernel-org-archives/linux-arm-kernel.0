From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 18 Dec 2015 09:16:13 +0000
Subject: [PATCH 2/2] ARM: Make IPI_CPU_BACKTRACE a "non-secure" SGI
In-Reply-To: <1450430173-26992-1-git-send-email-marc.zyngier@arm.com>
References: <1450430173-26992-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1450430173-26992-3-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Having IPI_CPU_BACKTRACE as SGI15 may not work if the kernel is
running in non-secure mode and that the secure firmware has
decided to follow ARM's recommendations that SGI8-15 should
be reserved for secure purpose.

Now that we are "only" using SGI0-6, change IPI_CPU_BACKTRACE
to use SGI7, which makes it more likely to work.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/kernel/smp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index d50a77d..fe517f1 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -72,7 +72,7 @@ enum ipi_msg_type {
 	IPI_CPU_STOP,
 	IPI_IRQ_WORK,
 	IPI_COMPLETION,
-	IPI_CPU_BACKTRACE = 15,
+	IPI_CPU_BACKTRACE,
 };
 
 static DECLARE_COMPLETION(cpu_running);
-- 
2.1.4
