From: b29396@freescale.com (Aisheng.Dong)
Date: Thu, 24 Mar 2011 19:16:40 +0800
Subject: [PATCH 1/1] ARM: dmabounce: fix dmabounce may cause crash issue
Message-ID: <1300965400-28304-1-git-send-email-b29396@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The map_single does not check if dev is NULL which may cause kernel panic
like follows:
Unable to handle kernel NULL pointer dereference at virtual address 000000bc
pgd = 80004000
[000000bc] *pgd=00000000
Internal error: Oops: 5 [#1] PREEMPT
last sysfs file:
Modules linked in:
CPU: 0    Not tainted  (2.6.35.3-00845-g204c152-dirty #112)
PC is at dma_map_single+0x2c/0x2a0
LR is at fec_enet_interrupt+0x1d4/0x450
pc : [<8003cf04>]    lr : [<802936b8>]    psr: 60000193
sp : 80809ec8  ip : 00000080  fp : 99308040
r10: 99308040  r9 : 00000002  r8 : 99074f00
r7 : fa0a5000  r6 : 00000000  r5 : 00000060  r4 : 992e4000
r3 : 00000002  r2 : 8080cac0  r1 : 99308040  r0 : 00000000

The patch checks the dev to avoid this issue and align with the
original dma_map_single to allow dev is NULL.

Signed-off-by: Aisheng.Dong <b29396@freescale.com>
Signed-off-by: Jason.Liu <r64343@freescale.com>
---
 arch/arm/common/dmabounce.c |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/arm/common/dmabounce.c b/arch/arm/common/dmabounce.c
index e568163..8b575ef 100644
--- a/arch/arm/common/dmabounce.c
+++ b/arch/arm/common/dmabounce.c
@@ -222,16 +222,19 @@ static struct safe_buffer *find_safe_buffer_dev(struct device *dev,
 static inline dma_addr_t map_single(struct device *dev, void *ptr, size_t size,
 		enum dma_data_direction dir)
 {
-	struct dmabounce_device_info *device_info = dev->archdata.dmabounce;
+	struct dmabounce_device_info *device_info;
 	dma_addr_t dma_addr;
 	int needs_bounce = 0;
 
+	if (dev)
+		device_info = dev->archdata.dmabounce;
+
 	if (device_info)
 		DO_STATS ( device_info->map_op_count++ );
 
 	dma_addr = virt_to_dma(dev, ptr);
 
-	if (dev->dma_mask) {
+	if (dev && dev->dma_mask) {
 		unsigned long mask = *dev->dma_mask;
 		unsigned long limit;
 
@@ -248,7 +251,7 @@ static inline dma_addr_t map_single(struct device *dev, void *ptr, size_t size,
 		needs_bounce = (dma_addr | (dma_addr + size - 1)) & ~mask;
 	}
 
-	if (device_info && (needs_bounce || dma_needs_bounce(dev, dma_addr, size))) {
+	if (dev && device_info && (needs_bounce || dma_needs_bounce(dev, dma_addr, size))) {
 		struct safe_buffer *buf;
 
 		buf = alloc_safe_buffer(device_info, ptr, size, dir);
-- 
1.7.0.4
