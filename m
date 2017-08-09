From: icenowy@aosc.io (Icenowy Zheng)
Date: Wed,  9 Aug 2017 16:56:25 +0800
Subject: [PATCH 2/4] drivers: soc: sunxi: fix error processing on base address
 when claiming
In-Reply-To: <20170809085627.32687-1-icenowy@aosc.io>
References: <20170809085627.32687-1-icenowy@aosc.io>
Message-ID: <20170809085627.32687-3-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When claiming SRAM, if the base is set to an error, it means that the
SRAM controller has been probed, but failed to remap the controller
memory zone. If the base is zero, thus the SRAM controller should be not
probed at all, and it should return -EPROBE_DEFER. However, currently we
returned -EPROBE_DEFER in the former situation, and ignored the latter
situation (which will lead to the kernel to panic).

Fix the behavior on abnormal base address processing when claiming.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 drivers/soc/sunxi/sunxi_sram.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/soc/sunxi/sunxi_sram.c b/drivers/soc/sunxi/sunxi_sram.c
index 99e354c8f53f..c1ff7fa62cb4 100644
--- a/drivers/soc/sunxi/sunxi_sram.c
+++ b/drivers/soc/sunxi/sunxi_sram.c
@@ -190,6 +190,9 @@ int sunxi_sram_claim(struct device *dev)
 	u32 val, mask;
 
 	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	if (!base)
 		return -EPROBE_DEFER;
 
 	if (!dev || !dev->of_node)
-- 
2.13.0
