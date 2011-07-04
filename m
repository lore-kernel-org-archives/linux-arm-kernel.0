From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 04 Jul 2011 09:47:56 +0100
Subject: [PATCH 01/10] ARM: dmabounce: fix map_single() error return value
In-Reply-To: <20110704084711.GN21898@n2100.arm.linux.org.uk>
References: <20110704084711.GN21898@n2100.arm.linux.org.uk>
Message-ID: <E1Qdeou-0000Z4-3p@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When map_single() is unable to obtain a safe buffer, we must return
the dma_addr_t error value, which is ~0 rather than 0.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/common/dmabounce.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/common/dmabounce.c b/arch/arm/common/dmabounce.c
index e568163..841df7d 100644
--- a/arch/arm/common/dmabounce.c
+++ b/arch/arm/common/dmabounce.c
@@ -255,7 +255,7 @@ static inline dma_addr_t map_single(struct device *dev, void *ptr, size_t size,
 		if (buf == 0) {
 			dev_err(dev, "%s: unable to map unsafe buffer %p!\n",
 			       __func__, ptr);
-			return 0;
+			return ~0;
 		}
 
 		dev_dbg(dev,
-- 
1.7.4.4
