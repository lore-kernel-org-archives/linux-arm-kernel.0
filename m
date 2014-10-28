From: jiang.liu@linux.intel.com (Jiang Liu)
Date: Tue, 28 Oct 2014 16:26:34 +0800
Subject: [Patch Part2 v3 16/24] x86,
 irq: Directly call native_compose_msi_msg() for DMAR IRQ
In-Reply-To: <1414484803-10311-1-git-send-email-jiang.liu@linux.intel.com>
References: <1414484803-10311-1-git-send-email-jiang.liu@linux.intel.com>
Message-ID: <1414484803-10311-17-git-send-email-jiang.liu@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

DMAR interrupt won't be remapped by interrupt remapping hardware,
so directly call native_compose_msi_msg() for DMAR IRQ to compose MSI
message data. This will help to simplify MSI code later.

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
---
 arch/x86/kernel/apic/msi.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/apic/msi.c b/arch/x86/kernel/apic/msi.c
index 354abd7ef2ad..6aac2ec1b3ef 100644
--- a/arch/x86/kernel/apic/msi.c
+++ b/arch/x86/kernel/apic/msi.c
@@ -396,12 +396,10 @@ static struct irq_chip dmar_msi_type = {
 
 int arch_setup_dmar_msi(unsigned int irq)
 {
-	int ret;
 	struct msi_msg msg;
+	struct irq_cfg *cfg = irq_cfg(irq);
 
-	ret = msi_compose_msg(NULL, irq, &msg, -1);
-	if (ret < 0)
-		return ret;
+	native_compose_msi_msg(NULL, irq, cfg->dest_apicid, &msg, -1);
 	dmar_msi_write(irq, &msg);
 	irq_set_chip_and_handler_name(irq, &dmar_msi_type, handle_edge_irq,
 				      "edge");
-- 
1.7.10.4
