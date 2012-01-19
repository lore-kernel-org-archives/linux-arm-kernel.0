From: will.deacon@arm.com (Will Deacon)
Date: Thu, 19 Jan 2012 16:07:27 +0000
Subject: [PATCH] ARM: irq: avoid NULL check in for_each_irq_desc loop
Message-ID: <1326989247-8599-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM unconditionally selects CONFIG_GENERIC_HARDIRQS, so the definition
of for_each_irq_desc will check that the desc is non-NULL anyway.

This patch removes a redundant check from the IRQ migration code.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/kernel/irq.c |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/arch/arm/kernel/irq.c b/arch/arm/kernel/irq.c
index 831435d..95ea88f 100644
--- a/arch/arm/kernel/irq.c
+++ b/arch/arm/kernel/irq.c
@@ -181,10 +181,7 @@ void migrate_irqs(void)
 	local_irq_save(flags);
 
 	for_each_irq_desc(i, desc) {
-		bool affinity_broken = false;
-
-		if (!desc)
-			continue;
+		bool affinity_broken;
 
 		raw_spin_lock(&desc->lock);
 		affinity_broken = migrate_one_irq(desc);
-- 
1.7.4.1
