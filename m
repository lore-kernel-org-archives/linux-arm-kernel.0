From: troy.kisky@boundarydevices.com (Troy Kisky)
Date: Thu, 21 May 2015 11:35:45 -0700
Subject: [RFC PATCH 1/1] pci-imx6: add speed change timeout message
Message-ID: <1432233345-10160-1-git-send-email-troy.kisky@boundarydevices.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, the timeout is never detected as count
has a value of -1 if a timeout happens, but the code is checking
for 0.

Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>

---

This patch breaks pcie for imx6sx as my board always times out.
So, if someone could check this on an imx6sx I'd appreciate it.

Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>
---
 drivers/pci/host/pci-imx6.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
index fdb9536..51be92c 100644
--- a/drivers/pci/host/pci-imx6.c
+++ b/drivers/pci/host/pci-imx6.c
@@ -398,20 +398,22 @@ static int imx6_pcie_start_link(struct pcie_port *pp)
 	writel(tmp, pp->dbi_base + PCIE_LINK_WIDTH_SPEED_CONTROL);
 
 	count = 200;
-	while (count--) {
+	while (1) {
 		tmp = readl(pp->dbi_base + PCIE_LINK_WIDTH_SPEED_CONTROL);
 		/* Test if the speed change finished. */
-		if (!(tmp & PORT_LOGIC_SPEED_CHANGE))
+		if (!(tmp & PORT_LOGIC_SPEED_CHANGE)) {
+			/* Make sure link training is finished as well! */
+			ret = imx6_pcie_wait_for_link(pp);
+			break;
+		}
+		if (count-- == 0) {
+			dev_err(pp->dev, "Speed change timeout\n");
+			ret = -EINVAL;
 			break;
+		}
 		usleep_range(100, 1000);
 	}
 
-	/* Make sure link training is finished as well! */
-	if (count)
-		ret = imx6_pcie_wait_for_link(pp);
-	else
-		ret = -EINVAL;
-
 	if (ret) {
 		dev_err(pp->dev, "Failed to bring link up!\n");
 	} else {
-- 
1.9.1
