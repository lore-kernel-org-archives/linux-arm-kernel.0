From: pawel.moll@arm.com (Pawel Moll)
Date: Fri, 11 Mar 2011 17:18:07 +0000
Subject: [PATCH] arm: mmci: Add ARM variant with extended FIFO
Message-ID: <1299863887-15490-1-git-send-email-pawel.moll@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

New IO FPGA implementation for Versatile Express boards contain
MMCI (PL180) cell with FIFO extended to 128 words (512 bytes).

Signed-off-by: Pawel Moll <pawel.moll@arm.com>
---
 drivers/mmc/host/mmci.c |   13 ++++++++++++-
 1 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 2d6de3e..e7197b0 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -66,6 +66,12 @@ static struct variant_data variant_arm = {
 	.datalength_bits	= 16,
 };
 
+static struct variant_data variant_arm_extended_fifo = {
+	.fifosize		= 128 * 4,
+	.fifohalfsize		= 64 * 4,
+	.datalength_bits	= 16,
+};
+
 static struct variant_data variant_u300 = {
 	.fifosize		= 16 * 4,
 	.fifohalfsize		= 8 * 4,
@@ -1019,10 +1025,15 @@ static int mmci_resume(struct amba_device *dev)
 static struct amba_id mmci_ids[] = {
 	{
 		.id	= 0x00041180,
-		.mask	= 0x000fffff,
+		.mask	= 0xff0fffff,
 		.data	= &variant_arm,
 	},
 	{
+		.id	= 0x01041180,
+		.mask	= 0xff0fffff,
+		.data	= &variant_arm_extended_fifo,
+	},
+	{
 		.id	= 0x00041181,
 		.mask	= 0x000fffff,
 		.data	= &variant_arm,
-- 
1.6.3.3
