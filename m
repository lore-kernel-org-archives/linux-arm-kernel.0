From: joelf@ti.com (Joel Fernandes)
Date: Fri, 13 Sep 2013 19:57:21 -0500
Subject: [PATCH v3] ARM: EDMA: Fix clearing of unused list for DT DMA
 resources
In-Reply-To: <5231903F.7080301@ti.com>
References: <1378839171-14455-1-git-send-email-joelf@ti.com>
 <5231903F.7080301@ti.com>
Message-ID: <5233B471.40603@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/12/2013 04:58 AM, Sekhar Nori wrote:
> On Wednesday 11 September 2013 12:22 AM, Joel Fernandes wrote:
>> HWMOD removal for MMC is breaking edma_start as the events are being manually
>> triggered due to unused channel list not being clear.
[..]
> It is better to send one version with all comments fixed. Helps avoid
> confusion.

Ok, here is the final version with all comments fixed, please apply this one:

--->8---
From: Joel Fernandes <joelf@ti.com>
Subject: [PATCH v4] ARM: EDMA: Fix clearing of unused list for DT DMA resources

HWMOD removal for MMC is breaking edma_start as the events are being manually
triggered due to unused channel list not being clear.

This patch fixes the issue, by reading the "dmas" property from the DT node if
it exists and clearing the bits in the unused channel list. For this purpose
we use the of_* helpers to parse the arguments in the dmas phandle list.

Reviewed-by: Sekhar Nori <nsekhar@ti.com>
Reported-by: Balaji T K <balajitk@ti.com>
Cc: Pantel Antoniou <panto@antoniou-consulting.com>
Signed-off-by: Joel Fernandes <joelf@ti.com>
---
Changes since v1, in v2 and v3:
- Reduced indentation of non-of case by returning from of-case
- Using of_* helpers for parsing

Note:
This patch should go into the merge window as it is a critical bug fix.

 arch/arm/common/edma.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/arch/arm/common/edma.c b/arch/arm/common/edma.c
index 39ad030..43c7b22 100644
--- a/arch/arm/common/edma.c
+++ b/arch/arm/common/edma.c
@@ -560,14 +560,33 @@ static int reserve_contiguous_slots(int ctlr, unsigned int
id,
 static int prepare_unused_channel_list(struct device *dev, void *data)
 {
 	struct platform_device *pdev = to_platform_device(dev);
-	int i, ctlr;
+	int i, count, ctlr;
+	struct of_phandle_args  dma_spec;

+	if (dev->of_node) {
+		count = of_property_count_strings(dev->of_node, "dma-names");
+		if (count < 0)
+			return 0;
+		for (i = 0; i < count; i++) {
+			if (of_parse_phandle_with_args(dev->of_node, "dmas",
+						       "#dma-cells", i,
+						       &dma_spec))
+				continue;
+
+			ctlr = EDMA_CTLR(dma_spec.args[0]);
+			clear_bit(EDMA_CHAN_SLOT(dma_spec.args[0]),
+				  edma_cc[ctlr]->edma_unused);
+		}
+		return 0;
+	}
+
+	/* For non-OF case */
 	for (i = 0; i < pdev->num_resources; i++) {
 		if ((pdev->resource[i].flags & IORESOURCE_DMA) &&
 				(int)pdev->resource[i].start >= 0) {
 			ctlr = EDMA_CTLR(pdev->resource[i].start);
 			clear_bit(EDMA_CHAN_SLOT(pdev->resource[i].start),
-					edma_cc[ctlr]->edma_unused);
+				  edma_cc[ctlr]->edma_unused);
 		}
 	}

-- 
1.8.1.2
