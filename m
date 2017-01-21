From: bharat.kumar.gogada@xilinx.com (Bharat Kumar Gogada)
Date: Sat, 21 Jan 2017 16:41:11 +0530
Subject: [PATCH 3/4] PCI: Xilinx NWL: Modifying flow handler for legacy
 interrupts
In-Reply-To: <1484997072-19276-1-git-send-email-bharatku@xilinx.com>
References: <1484997072-19276-1-git-send-email-bharatku@xilinx.com>
Message-ID: <1484997072-19276-3-git-send-email-bharatku@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Legacy interrupts are level sensitive, so using handle_level_irq
is more approprate as it is masks interrupts until End point handles
interrupts and unmasks interrutps after End point handler is executed.

Signed-off-by: Bharat Kumar Gogada <bharatku@xilinx.com>
---
 drivers/pci/host/pcie-xilinx-nwl.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/pci/host/pcie-xilinx-nwl.c b/drivers/pci/host/pcie-xilinx-nwl.c
index e1809f9..50f9c0d 100644
--- a/drivers/pci/host/pcie-xilinx-nwl.c
+++ b/drivers/pci/host/pcie-xilinx-nwl.c
@@ -433,7 +433,7 @@ static void nwl_unmask_leg_irq(struct irq_data *data)
 static int nwl_legacy_map(struct irq_domain *domain, unsigned int irq,
 			  irq_hw_number_t hwirq)
 {
-	irq_set_chip_and_handler(irq, &nwl_leg_irq_chip, handle_simple_irq);
+	irq_set_chip_and_handler(irq, &nwl_leg_irq_chip, handle_level_irq);
 	irq_set_chip_data(irq, domain->host_data);
 
 	return 0;
-- 
1.7.1
