From: aleksey.makarov@cavium.com (Aleksey Makarov)
Date: Fri, 24 Nov 2017 15:04:03 +0300
Subject: [PATCH net-next] net: thunderx: Set max queue count taking XDP_TX
 into account
Message-ID: <20171124120411.7660-1-aleksey.makarov@cavium.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sunil Goutham <sgoutham@cavium.com>

on T81 there are only 4 cores, hence setting max queue count to 4
would leave nothing for XDP_TX. This patch fixes this by doubling
max queue count in above scenarios.

Signed-off-by: Sunil Goutham <sgoutham@cavium.com>
Signed-off-by: cjacob <cjacob@caviumnetworks.com>
Signed-off-by: Aleksey Makarov <aleksey.makarov@cavium.com>
---
 drivers/net/ethernet/cavium/thunder/nicvf_main.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/cavium/thunder/nicvf_main.c b/drivers/net/ethernet/cavium/thunder/nicvf_main.c
index b82e28262c57..52b3a6044f85 100644
--- a/drivers/net/ethernet/cavium/thunder/nicvf_main.c
+++ b/drivers/net/ethernet/cavium/thunder/nicvf_main.c
@@ -1891,6 +1891,11 @@ static int nicvf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	nic->pdev = pdev;
 	nic->pnicvf = nic;
 	nic->max_queues = qcount;
+	/* If no of CPUs are too low, there won't be any queues left
+	 * for XDP_TX, hence double it.
+	 */
+	if (!nic->t88)
+		nic->max_queues *= 2;
 
 	/* MAP VF's configuration registers */
 	nic->reg_base = pcim_iomap(pdev, PCI_CFG_REG_BAR_NUM, 0);
-- 
2.15.0
