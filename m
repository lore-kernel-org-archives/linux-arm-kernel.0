From: dirk.behme@gmail.com (Dirk Behme)
Date: Sun, 13 Dec 2015 10:15:16 +0100
Subject: [PATCH 1/2 v2] ARM: Documentation: l2c: Rename l2cc to l2c2x0
Message-ID: <1449998117-5998-1-git-send-email-dirk.behme@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The documentation in the l2cc.txt is specific to the L2 cache
controllers L2C210/L2C220/L2C310 (also known as PL210/PL220/PL310
and variants) and not generic as the file name implies. It's not
valid for integrated L2 controllers as found in e.g.
Cortex-A15/A7/A57/A53.

Reflect this by adapting the file name accordingly.

Signed-off-by: Dirk Behme <dirk.behme@gmail.com>
---
Changes in v2:
Use the file name l2c2x0.txt and replace the PL prefix with L2C

 Documentation/devicetree/bindings/arm/l2c2x0.txt | 93 ++++++++++++++++++++++++
 Documentation/devicetree/bindings/arm/l2cc.txt   | 93 ------------------------
 2 files changed, 93 insertions(+), 93 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/l2c2x0.txt
 delete mode 100644 Documentation/devicetree/bindings/arm/l2cc.txt

diff --git a/Documentation/devicetree/bindings/arm/l2c2x0.txt b/Documentation/devicetree/bindings/arm/l2c2x0.txt
new file mode 100644
index 0000000..06c88a4
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/l2c2x0.txt
@@ -0,0 +1,93 @@
+* ARM L2 Cache Controller
+
+ARM cores often have a separate level 2 cache controller. There are various
+implementations of the L2 cache controller with compatible programming models.
+Some of the properties that are just prefixed "cache-*" are taken from section
+3.7.3 of the ePAPR v1.1 specification which can be found at:
+https://www.power.org/wp-content/uploads/2012/06/Power_ePAPR_APPROVED_v1.1.pdf
+
+The ARM L2 cache representation in the device tree should be done as follows:
+
+Required properties:
+
+- compatible : should be one of:
+  "arm,pl310-cache"
+  "arm,l220-cache"
+  "arm,l210-cache"
+  "bcm,bcm11351-a2-pl310-cache": DEPRECATED by "brcm,bcm11351-a2-pl310-cache"
+  "brcm,bcm11351-a2-pl310-cache": For Broadcom bcm11351 chipset where an
+     offset needs to be added to the address before passing down to the L2
+     cache controller
+  "marvell,aurora-system-cache": Marvell Controller designed to be
+     compatible with the ARM one, with system cache mode (meaning
+     maintenance operations on L1 are broadcasted to the L2 and L2
+     performs the same operation).
+  "marvell,aurora-outer-cache": Marvell Controller designed to be
+     compatible with the ARM one with outer cache mode.
+  "marvell,tauros3-cache": Marvell Tauros3 cache controller, compatible
+     with arm,pl310-cache controller.
+- cache-unified : Specifies the cache is a unified cache.
+- cache-level : Should be set to 2 for a level 2 cache.
+- reg : Physical base address and size of cache controller's memory mapped
+  registers.
+
+Optional properties:
+
+- arm,data-latency : Cycles of latency for Data RAM accesses. Specifies 3 cells of
+  read, write and setup latencies. Minimum valid values are 1. Controllers
+  without setup latency control should use a value of 0.
+- arm,tag-latency : Cycles of latency for Tag RAM accesses. Specifies 3 cells of
+  read, write and setup latencies. Controllers without setup latency control
+  should use 0. Controllers without separate read and write Tag RAM latency
+  values should only use the first cell.
+- arm,dirty-latency : Cycles of latency for Dirty RAMs. This is a single cell.
+- arm,filter-ranges : <start length> Starting address and length of window to
+  filter. Addresses in the filter window are directed to the M1 port. Other
+  addresses will go to the M0 port.
+- arm,io-coherent : indicates that the system is operating in an hardware
+  I/O coherent mode. Valid only when the arm,pl310-cache compatible
+  string is used.
+- interrupts : 1 combined interrupt.
+- cache-size : specifies the size in bytes of the cache
+- cache-sets : specifies the number of associativity sets of the cache
+- cache-block-size : specifies the size in bytes of a cache block
+- cache-line-size : specifies the size in bytes of a line in the cache,
+  if this is not specified, the line size is assumed to be equal to the
+  cache block size
+- cache-id-part: cache id part number to be used if it is not present
+  on hardware
+- wt-override: If present then L2 is forced to Write through mode
+- arm,double-linefill : Override double linefill enable setting. Enable if
+  non-zero, disable if zero.
+- arm,double-linefill-incr : Override double linefill on INCR read. Enable
+  if non-zero, disable if zero.
+- arm,double-linefill-wrap : Override double linefill on WRAP read. Enable
+  if non-zero, disable if zero.
+- arm,prefetch-drop : Override prefetch drop enable setting. Enable if non-zero,
+  disable if zero.
+- arm,prefetch-offset : Override prefetch offset value. Valid values are
+  0-7, 15, 23, and 31.
+- arm,shared-override : The default behavior of the pl310 cache controller with
+  respect to the shareable attribute is to transform "normal memory
+  non-cacheable transactions" into "cacheable no allocate" (for reads) or
+  "write through no write allocate" (for writes).
+  On systems where this may cause DMA buffer corruption, this property must be
+  specified to indicate that such transforms are precluded.
+- prefetch-data : Data prefetch. Value: <0> (forcibly disable), <1>
+  (forcibly enable), property absent (retain settings set by firmware)
+- prefetch-instr : Instruction prefetch. Value: <0> (forcibly disable),
+  <1> (forcibly enable), property absent (retain settings set by
+  firmware)
+
+Example:
+
+L2: cache-controller {
+        compatible = "arm,pl310-cache";
+        reg = <0xfff12000 0x1000>;
+        arm,data-latency = <1 1 1>;
+        arm,tag-latency = <2 2 2>;
+        arm,filter-ranges = <0x80000000 0x8000000>;
+        cache-unified;
+        cache-level = <2>;
+	interrupts = <45>;
+};
diff --git a/Documentation/devicetree/bindings/arm/l2cc.txt b/Documentation/devicetree/bindings/arm/l2cc.txt
deleted file mode 100644
index 06c88a4..0000000
--- a/Documentation/devicetree/bindings/arm/l2cc.txt
+++ /dev/null
@@ -1,93 +0,0 @@
-* ARM L2 Cache Controller
-
-ARM cores often have a separate level 2 cache controller. There are various
-implementations of the L2 cache controller with compatible programming models.
-Some of the properties that are just prefixed "cache-*" are taken from section
-3.7.3 of the ePAPR v1.1 specification which can be found at:
-https://www.power.org/wp-content/uploads/2012/06/Power_ePAPR_APPROVED_v1.1.pdf
-
-The ARM L2 cache representation in the device tree should be done as follows:
-
-Required properties:
-
-- compatible : should be one of:
-  "arm,pl310-cache"
-  "arm,l220-cache"
-  "arm,l210-cache"
-  "bcm,bcm11351-a2-pl310-cache": DEPRECATED by "brcm,bcm11351-a2-pl310-cache"
-  "brcm,bcm11351-a2-pl310-cache": For Broadcom bcm11351 chipset where an
-     offset needs to be added to the address before passing down to the L2
-     cache controller
-  "marvell,aurora-system-cache": Marvell Controller designed to be
-     compatible with the ARM one, with system cache mode (meaning
-     maintenance operations on L1 are broadcasted to the L2 and L2
-     performs the same operation).
-  "marvell,aurora-outer-cache": Marvell Controller designed to be
-     compatible with the ARM one with outer cache mode.
-  "marvell,tauros3-cache": Marvell Tauros3 cache controller, compatible
-     with arm,pl310-cache controller.
-- cache-unified : Specifies the cache is a unified cache.
-- cache-level : Should be set to 2 for a level 2 cache.
-- reg : Physical base address and size of cache controller's memory mapped
-  registers.
-
-Optional properties:
-
-- arm,data-latency : Cycles of latency for Data RAM accesses. Specifies 3 cells of
-  read, write and setup latencies. Minimum valid values are 1. Controllers
-  without setup latency control should use a value of 0.
-- arm,tag-latency : Cycles of latency for Tag RAM accesses. Specifies 3 cells of
-  read, write and setup latencies. Controllers without setup latency control
-  should use 0. Controllers without separate read and write Tag RAM latency
-  values should only use the first cell.
-- arm,dirty-latency : Cycles of latency for Dirty RAMs. This is a single cell.
-- arm,filter-ranges : <start length> Starting address and length of window to
-  filter. Addresses in the filter window are directed to the M1 port. Other
-  addresses will go to the M0 port.
-- arm,io-coherent : indicates that the system is operating in an hardware
-  I/O coherent mode. Valid only when the arm,pl310-cache compatible
-  string is used.
-- interrupts : 1 combined interrupt.
-- cache-size : specifies the size in bytes of the cache
-- cache-sets : specifies the number of associativity sets of the cache
-- cache-block-size : specifies the size in bytes of a cache block
-- cache-line-size : specifies the size in bytes of a line in the cache,
-  if this is not specified, the line size is assumed to be equal to the
-  cache block size
-- cache-id-part: cache id part number to be used if it is not present
-  on hardware
-- wt-override: If present then L2 is forced to Write through mode
-- arm,double-linefill : Override double linefill enable setting. Enable if
-  non-zero, disable if zero.
-- arm,double-linefill-incr : Override double linefill on INCR read. Enable
-  if non-zero, disable if zero.
-- arm,double-linefill-wrap : Override double linefill on WRAP read. Enable
-  if non-zero, disable if zero.
-- arm,prefetch-drop : Override prefetch drop enable setting. Enable if non-zero,
-  disable if zero.
-- arm,prefetch-offset : Override prefetch offset value. Valid values are
-  0-7, 15, 23, and 31.
-- arm,shared-override : The default behavior of the pl310 cache controller with
-  respect to the shareable attribute is to transform "normal memory
-  non-cacheable transactions" into "cacheable no allocate" (for reads) or
-  "write through no write allocate" (for writes).
-  On systems where this may cause DMA buffer corruption, this property must be
-  specified to indicate that such transforms are precluded.
-- prefetch-data : Data prefetch. Value: <0> (forcibly disable), <1>
-  (forcibly enable), property absent (retain settings set by firmware)
-- prefetch-instr : Instruction prefetch. Value: <0> (forcibly disable),
-  <1> (forcibly enable), property absent (retain settings set by
-  firmware)
-
-Example:
-
-L2: cache-controller {
-        compatible = "arm,pl310-cache";
-        reg = <0xfff12000 0x1000>;
-        arm,data-latency = <1 1 1>;
-        arm,tag-latency = <2 2 2>;
-        arm,filter-ranges = <0x80000000 0x8000000>;
-        cache-unified;
-        cache-level = <2>;
-	interrupts = <45>;
-};
-- 
2.6.4
