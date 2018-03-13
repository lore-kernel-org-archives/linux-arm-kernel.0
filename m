From: phil.edworthy@renesas.com (Phil Edworthy)
Date: Tue, 13 Mar 2018 14:26:40 +0000
Subject: [PATCH v2] mmc: sdhci-of-arasan: Add quirk to avoid unexpected
 interrupt msgs
Message-ID: <1520951200-24703-1-git-send-email-phil.edworthy@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On SD 2.00 cards we get lots of these messages:
"mmc0: Got data interrupt 0x00000002 even though no data operation was in progress"
By applying the SDHCI_QUIRK2_STOP_WITH_TC quirk, the messages no longer happen.

A single card claiming to be SD 3.00 compliant also generates the interrupts,
but since the card's manfacturing date is 2002 mar, it's unlikely to really be
SD 3.00. This card is a 8GB SanDisk 'SU08G' 8.0 (SDHC class 4).

This has been reported on Xilinx devices that also use the Arasan IP.
See https://patchwork.kernel.org/patch/8062871/

This has been tested on the Renesas RZ/ND-DB board with the RZ/N1 SoC. The
Arasan IP in this device is version 1.39a and uses a max SD clock of 50MHz and
does not support DDR modes.

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
---
v2:
 - Changed commit msg to detail the cards that fail.
 - Provided the IP version and further background info.
---
 drivers/mmc/host/sdhci-of-arasan.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
index c33a5f7..ab66e32 100644
--- a/drivers/mmc/host/sdhci-of-arasan.c
+++ b/drivers/mmc/host/sdhci-of-arasan.c
@@ -290,7 +290,8 @@ static const struct sdhci_pltfm_data sdhci_arasan_pdata = {
 	.ops = &sdhci_arasan_ops,
 	.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
 	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
-			SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN,
+			SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN |
+			SDHCI_QUIRK2_STOP_WITH_TC,
 };
 
 static u32 sdhci_arasan_cqhci_irq(struct sdhci_host *host, u32 intmask)
-- 
2.7.4
