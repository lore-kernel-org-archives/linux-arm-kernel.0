From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Thu, 10 Jan 2013 00:41:44 +0100
Subject: [RFC PATCH 2/7] ARM: common: vic: Fix invalid first IRQ number in
 OF-based registration
In-Reply-To: <1357774909-29938-1-git-send-email-tomasz.figa@gmail.com>
References: <1357774909-29938-1-git-send-email-tomasz.figa@gmail.com>
Message-ID: <1357774909-29938-3-git-send-email-tomasz.figa@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Without this patch, vic_of_init passed -1 as first IRQ number to
__vic_init (as signed int), then to vic_register (now as unsigned int
equals to 0xffffffff) and finally to irq_domain_add_simple (again as
unsigned 0xffffffff), which tries to allocate irq descriptors starting
from IRQ 0xffffffff, which obviously is bound to fail.

This patch corrects OF-based VIC registration by locating VICs in IRQ
address space starting from IRQ 32 and then placing one VIC after
another. This is similar to the solution used with GIC and allows to
maintain compatibility with legacy code using static IRQ numbers.

Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
---
 arch/arm/common/vic.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/common/vic.c b/arch/arm/common/vic.c
index c2889da..8001994 100644
--- a/arch/arm/common/vic.c
+++ b/arch/arm/common/vic.c
@@ -421,9 +421,9 @@ int __init vic_of_init(struct device_node *node, struct device_node *parent)
 	of_property_read_u32(node, "wakeup-mask", &wakeup_mask);
 
 	/*
-	 * Passing -1 as first IRQ makes the simple domain allocate descriptors
+	 * Use IRQ numbers starting from 32 and placing each VIC after another
 	 */
-	__vic_init(regs, -1, interrupt_mask, wakeup_mask, node);
+	__vic_init(regs, 32 + (32 * vic_id), interrupt_mask, wakeup_mask, node);
 
 	return 0;
 }
-- 
1.8.1
