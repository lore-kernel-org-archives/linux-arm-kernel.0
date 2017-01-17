From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 17 Jan 2017 10:20:26 +0000
Subject: [RFC PATCH 05/33] irqchip/gic-v3-its: Zero command on allocation
In-Reply-To: <1484648454-21216-1-git-send-email-marc.zyngier@arm.com>
References: <1484648454-21216-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1484648454-21216-6-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When reusing commands from the ring buffer, it would be better
to zero them out, even if the ITS should ignore the unused
fields.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/irq-gic-v3-its.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 2ca27f6..9304dd2 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -426,6 +426,12 @@ static struct its_cmd_block *its_allocate_entry(struct its_node *its)
 	if (its->cmd_write == (its->cmd_base + ITS_CMD_QUEUE_NR_ENTRIES))
 		its->cmd_write = its->cmd_base;
 
+	/* Clear command  */
+	cmd->raw_cmd[0] = 0;
+	cmd->raw_cmd[1] = 0;
+	cmd->raw_cmd[2] = 0;
+	cmd->raw_cmd[3] = 0;
+
 	return cmd;
 }
 
-- 
2.1.4
