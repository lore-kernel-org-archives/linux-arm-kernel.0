From: tharvey@gateworks.com (Tim Harvey)
Date: Tue,  4 Mar 2014 06:54:24 -0800
Subject: [PATCH 1/2] of/irq: Fix irq-mapping in of_irq_parse_raw()
Message-ID: <1393944864-28113-1-git-send-email-tharvey@gateworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When an interrupt-map contains multiple entries an imap pointer arithmetic
bug can cause only the first entry to be properly evaluated and causes
the out_irq parameters to be incorrect depending on the #interrupt-cells
and #address-cells of the parent interrupt controller.

Specifically, the imap pointer into the interrupt-map table should be
adjusted by the parent interrupt controller #interrupt-cells size only
as at this point the only the parent unit interrupt specifier needs to be
stepped over.

This resolves an issue encountered when using the of_irq_parse_and_map_pci()
for the imx6 pcie host controller driver map_irq function where a P2P bridge
is on the bus and legacy PCI interrupts are to be used.

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
Cc: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Cc: Jingoo Han <jg1.han@samsung.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-samsung-soc <linux-samsung-soc@vger.kernel.org>
Cc: Richard Zhu <r65037@freescale.com>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Simon Horman <horms@verge.net.au>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Ben Dooks <ben-linux@fluff.org>
Cc: linux-tegra <linux-tegra@vger.kernel.org>
Cc: Kukjin Kim <kgene.kim@samsung.com>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Grant Likely <grant.likely@linaro.org>
---
 drivers/of/irq.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/of/irq.c b/drivers/of/irq.c
index 9bcf2cf..8829197 100644
--- a/drivers/of/irq.c
+++ b/drivers/of/irq.c
@@ -237,11 +237,11 @@ int of_irq_parse_raw(const __be32 *addr, struct of_phandle_args *out_irq)
 			/* Check for malformed properties */
 			if (WARN_ON(newaddrsize + newintsize > MAX_PHANDLE_ARGS))
 				goto fail;
-			if (imaplen < (newaddrsize + newintsize))
+			if (imaplen < newintsize)
 				goto fail;
 
-			imap += newaddrsize + newintsize;
-			imaplen -= newaddrsize + newintsize;
+			imap += newintsize;
+			imaplen -= newintsize;
 
 			pr_debug(" -> imaplen=%d\n", imaplen);
 		}
-- 
1.8.3.2
