From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 04 Jul 2011 09:50:57 +0100
Subject: [PATCH 10/10] ARM: dmabounce: no need to check dev->bus type in
	needs_bounce function
In-Reply-To: <20110704084711.GN21898@n2100.arm.linux.org.uk>
References: <20110704084711.GN21898@n2100.arm.linux.org.uk>
Message-ID: <E1Qderp-0000Zi-7l@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As the needs_bounce function is passed at DMA bounce register time,
we already know what the device bus type is, so we don't need to check
it each time the needs_bounce function is called.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/common/it8152.c          |    3 +--
 arch/arm/mach-ixp4xx/common-pci.c |    2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm/common/it8152.c b/arch/arm/common/it8152.c
index 80b49e1..14ad62e 100644
--- a/arch/arm/common/it8152.c
+++ b/arch/arm/common/it8152.c
@@ -247,8 +247,7 @@ static int it8152_needs_bounce(struct device *dev, dma_addr_t dma_addr, size_t s
 {
 	dev_dbg(dev, "%s: dma_addr %08x, size %08x\n",
 		__func__, dma_addr, size);
-	return dev->bus == &pci_bus_type &&
-		(dma_addr + size - PHYS_OFFSET) >= SZ_64M;
+	return (dma_addr + size - PHYS_OFFSET) >= SZ_64M;
 }
 
 /*
diff --git a/arch/arm/mach-ixp4xx/common-pci.c b/arch/arm/mach-ixp4xx/common-pci.c
index d7db10c..e2e98bb 100644
--- a/arch/arm/mach-ixp4xx/common-pci.c
+++ b/arch/arm/mach-ixp4xx/common-pci.c
@@ -318,7 +318,7 @@ static int abort_handler(unsigned long addr, unsigned int fsr, struct pt_regs *r
 
 static int ixp4xx_needs_bounce(struct device *dev, dma_addr_t dma_addr, size_t size)
 {
-	return dev->bus == &pci_bus_type && (dma_addr + size) >= SZ_64M;
+	return (dma_addr + size) >= SZ_64M;
 }
 
 /*
-- 
1.7.4.4
