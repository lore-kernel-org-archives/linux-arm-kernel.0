From: shawn.guo@linaro.org (Shawn Guo)
Date: Sat, 11 Feb 2012 09:14:25 -0800
Subject: [PATCH 1/8] irq: choose irq_domain type for generic-chip based on
 irq_base
In-Reply-To: <1328980472-11923-1-git-send-email-shawn.guo@linaro.org>
References: <1328980472-11923-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1328980472-11923-2-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Choosing irq_domain type for generic-chip based on device_node forces
non-DT users to use legacy irq_domain, which makes no sense, because
linear irq_domain is actually encouraged to be used by both DT and
non-DT users.

The patch changes it to make the decision based on irq_base.  If users
pass in a negative irq_base value, a linear irq_domain will be created,
otherwise a legacy irq_domain will be created.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/irq/generic-chip.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/kernel/irq/generic-chip.c b/kernel/irq/generic-chip.c
index 3ac7fa1..839f882 100644
--- a/kernel/irq/generic-chip.c
+++ b/kernel/irq/generic-chip.c
@@ -346,7 +346,7 @@ int irq_setup_generic_chip_domain(const char *name, struct device_node *node,
 		irq_setup_generic_chip(gc[i], 0, flags, clr, set);
 	}
 
-	if (node)
+	if ((int) irq_base < 0)
 		d = irq_domain_add_linear(node, hwirq_cnt,
 					  &irq_gc_irq_domain_ops, gc);
 	else
-- 
1.7.5.4
