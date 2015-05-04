From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Mon,  4 May 2015 17:24:27 +0200
Subject: [PATCH v3 1/6] ARM: l2c: Add DT support for Shared Override
In-Reply-To: <1430753072-17145-1-git-send-email-geert+renesas@glider.be>
References: <1430753072-17145-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1430753072-17145-2-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

"CoreLink Level 2 Cache Controller L2C-310", p. 2-15, section 2.3.2
Shareable attribute" states:

    "The default behavior of the cache controller with respect to the
     shareable attribute is to transform Normal Memory Non-cacheable
     transactions into:
        - cacheable no allocate for reads
        - write through no write allocate for writes."

Depending on the system architecture, this may cause memory corruption
in the presence of bus mastering devices (e.g. OHCI). To avoid such
corruption, the default behavior can be disabled by setting the Shared
Override bit in the Auxiliary Control register.

Currently the Shared Override bit can be set only using C code:
  - by calling l2x0_init() directly, which is deprecated,
  - by setting/clearing the bit in the machine_desc.l2c_aux_val/mask
    fields, but using values differing from 0/~0 is also deprecated.

Hence add support for an "arm,shared-override" device tree property for
the l2c device node. By specifying this property, affected systems can
indicate that non-cacheable transactions must not be transformed.

If specified, the actual behavior of the kernel depends on whether CMA
is available or not:
  - If CMA is available, nothing needs to be done, as there won't be a
    kernel linear mappings and cacheable aliases for the DMA buffers,
  - If CMA is not available, the "shared attribute override enable" bit
    will be set.

See also commit 1a8e41cd672f894b ("ARM: 6395/1: VExpress: Set bit 22 in
the PL310 (cache controller) AuxCtlr register"):

    "Clearing bit 22 in the PL310 Auxiliary Control register (shared
     attribute override enable) has the side effect of transforming
     Normal Shared Non-cacheable reads into Cacheable no-allocate reads.

     Coherent DMA buffers in Linux always have a Cacheable alias via the
     kernel linear mapping and the processor can speculatively load
     cache lines into the PL310 controller. With bit 22 cleared,
     Non-cacheable reads would unexpectedly hit such cache lines leading
     to buffer corruption."

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v3:
  - New.
---
 Documentation/devicetree/bindings/arm/l2cc.txt |  6 ++++++
 arch/arm/mm/cache-l2x0.c                       | 10 ++++++++++
 2 files changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/l2cc.txt b/Documentation/devicetree/bindings/arm/l2cc.txt
index 0dbabe9a6b0abb91..f6f81b263a9cf56d 100644
--- a/Documentation/devicetree/bindings/arm/l2cc.txt
+++ b/Documentation/devicetree/bindings/arm/l2cc.txt
@@ -67,6 +67,12 @@ Optional properties:
   disable if zero.
 - arm,prefetch-offset : Override prefetch offset value. Valid values are
   0-7, 15, 23, and 31.
+- arm,shared-override : As of r2p0, the default behavior of the pl310 cache
+  controller with respect to the shareable attribute is to transform "normal
+  memory non-cacheable transactions" into "cacheable no allocate" (for reads)
+  or "write through no write allocate" (for writes).
+  On systems where this may cause DMA buffer corruption, this property must be
+  specified to indicate that such transforms are precluded.
 
 Example:
 
diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index e309c8f35af5af61..535b575ac3d7a52f 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -17,6 +17,7 @@
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
  */
 #include <linux/cpu.h>
+#include <linux/dma-contiguous.h>
 #include <linux/err.h>
 #include <linux/init.h>
 #include <linux/smp.h>
@@ -1149,6 +1150,15 @@ static void __init l2c310_of_parse(const struct device_node *np,
 		}
 	}
 
+	if (of_property_read_bool(np, "arm,shared-override")) {
+		if (dev_get_cma_area(NULL)) {
+			pr_info("L2C-310 ignoring arm,shared-override when CMA is enabled\n");
+		} else {
+			*aux_val |= L2C_AUX_CTRL_SHARED_OVERRIDE;
+			*aux_mask &= ~L2C_AUX_CTRL_SHARED_OVERRIDE;
+		}
+	}
+
 	prefetch = l2x0_saved_regs.prefetch_ctrl;
 
 	ret = of_property_read_u32(np, "arm,double-linefill", &val);
-- 
1.9.1
