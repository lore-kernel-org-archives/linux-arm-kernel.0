From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 31 Jan 2013 12:15:24 +0000
Subject: [PATCHv5 01/16] arm: arch_timer: balance device_node refcounting
In-Reply-To: <1359634539-9580-1-git-send-email-mark.rutland@arm.com>
References: <1359634539-9580-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1359634539-9580-2-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When we get the device_node for the arch timer, it's refcount is
automatically incremented in of_find_matching_node, but it is
never decremented.

This patch decrements the refcount on the node after we're finished
using it.

Reported-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/kernel/arch_timer.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/kernel/arch_timer.c b/arch/arm/kernel/arch_timer.c
index c8ef207..6dd73c6 100644
--- a/arch/arm/kernel/arch_timer.c
+++ b/arch/arm/kernel/arch_timer.c
@@ -488,6 +488,8 @@ int __init arch_timer_of_register(void)
 	for (i = PHYS_SECURE_PPI; i < MAX_TIMER_PPI; i++)
 		arch_timer_ppi[i] = irq_of_parse_and_map(np, i);
 
+	of_node_put(np);
+
 	/*
 	 * If no interrupt provided for virtual timer, we'll have to
 	 * stick to the physical timer. It'd better be accessible...
-- 
1.8.1.1
