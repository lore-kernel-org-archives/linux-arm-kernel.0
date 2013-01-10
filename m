From: gang.chen@asianux.com (Chen Gang)
Date: Thu, 10 Jan 2013 18:29:41 +0800
Subject: [PATCH] arch/arm/plat-omap: initializing dma_lch_count, before judging
 omap_dma_reserve_channels
Message-ID: <50EE9815.2080402@asianux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


  dma_lch_count is zero before 1st call of omap_system_dma_probe.
  omap_dma_reserve_channels has value before 1st call of omap_system_dma_probe

  when 1st call of omap_system_dma_probe
    we need set dma_lch_count before use it for judging
    or which will be failed for omap_dma_reserve_channels

  additional info:
    this patch is only for fixing bug, not touch the features.
    so, not use d->lch_count instead of dma_lch_count for the statement:

                        && (omap_dma_reserve_channels <= dma_lch_count))

    at least, now, current fixing is equal to above.
    in the future
      maybe omap_dma_reserve_channels can be set by outside (such as from /proc)
      dma_lch_count is a static global variable which has effect to all devices.
      maybe the original author do not hope the newer is larger than the older

Signed-off-by: Chen Gang <gang.chen@asianux.com>
---
 arch/arm/plat-omap/dma.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
index 4136b20..b382eef 100644
--- a/arch/arm/plat-omap/dma.c
+++ b/arch/arm/plat-omap/dma.c
@@ -2018,6 +2018,9 @@ static int omap_system_dma_probe(struct platform_device *pdev)
 	d			= p->dma_attr;
 	errata			= p->errata;
 
+	if (!dma_lch_count)
+		dma_lch_count	= d->lch_count;
+
 	if ((d->dev_caps & RESERVE_CHANNEL) && omap_dma_reserve_channels
 			&& (omap_dma_reserve_channels <= dma_lch_count))
 		d->lch_count	= omap_dma_reserve_channels;
-- 
1.7.10.4
