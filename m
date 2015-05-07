From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Thu,  7 May 2015 11:27:11 +0200
Subject: [PATCH v2] ARM: l2c: Add support for the "arm,
 shared-override" property
Message-ID: <1430990831-23825-1-git-send-email-geert+renesas@glider.be>
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
Then, it's up to the OS to decide. The current behavior is to set the
"shared attribute override enable" bit, as there may exist kernel linear
mappings and cacheable aliases for the DMA buffers, even if CMA is
enabled.

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
v2:
  - Set the "shared attribute override enable" bit, irrespective of CMA
    being used or not,
  - Drop reference to "r2p0" from the binding doc, as it was not
    correct,
  - Extract from series "[PATCH v3 0/6] ARM: l2c / shmobile: r8a7740 :
    Shared Override".
---
 Documentation/devicetree/bindings/arm/l2cc.txt | 6 ++++++
 arch/arm/mm/cache-l2x0.c                       | 5 +++++
 2 files changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/l2cc.txt b/Documentation/devicetree/bindings/arm/l2cc.txt
index 0dbabe9a6b0abb91..2484aed78c86546d 100644
--- a/Documentation/devicetree/bindings/arm/l2cc.txt
+++ b/Documentation/devicetree/bindings/arm/l2cc.txt
@@ -67,6 +67,12 @@ Optional properties:
   disable if zero.
 - arm,prefetch-offset : Override prefetch offset value. Valid values are
   0-7, 15, 23, and 31.
+- arm,shared-override : The default behavior of the pl310 cache controller with
+  respect to the shareable attribute is to transform "normal memory
+  non-cacheable transactions" into "cacheable no allocate" (for reads) or
+  "write through no write allocate" (for writes).
+  On systems where this may cause DMA buffer corruption, this property must be
+  specified to indicate that such transforms are precluded.
 
 Example:
 
diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index e309c8f35af5af61..86d0e7461e5b0b18 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -1149,6 +1149,11 @@ static void __init l2c310_of_parse(const struct device_node *np,
 		}
 	}
 
+	if (of_property_read_bool(np, "arm,shared-override")) {
+		*aux_val |= L2C_AUX_CTRL_SHARED_OVERRIDE;
+		*aux_mask &= ~L2C_AUX_CTRL_SHARED_OVERRIDE;
+	}
+
 	prefetch = l2x0_saved_regs.prefetch_ctrl;
 
 	ret = of_property_read_u32(np, "arm,double-linefill", &val);
-- 
1.9.1
