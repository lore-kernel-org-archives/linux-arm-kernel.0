From: benjamin.zores@alcatel-lucent.com (Benjamin Zores)
Date: Fri, 04 Jun 2010 09:09:27 +0200
Subject: [PATCH 4/4 v2] [ARM] Kirkwood: add support for PCIe1
Message-ID: <4C08A6A7.8010904@alcatel-lucent.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Sorry not to be able to reply/quote, wasn't subscribed before.
Anyhow, this is a patch review/comment from 
http://lists.infradead.org/pipermail/linux-arm-kernel/2010-June/017106.html

There are a few things missing for proper PCIe #1 support imho:

diff --git a/arch/arm/mach-kirkwood/db88f6281-bp-setup.c b/arch/arm/mach-kirkwood/db88f6281-bp-setup.c
index 39bdf4b..b11b5fe 100644
--- a/arch/arm/mach-kirkwood/db88f6281-bp-setup.c
+++ b/arch/arm/mach-kirkwood/db88f6281-bp-setup.c
@@ -74,9 +74,15 @@ static void __init db88f6281_init(void)

  static int __init db88f6281_pci_init(void)
  {
-	if (machine_is_db88f6281_bp())
-		kirkwood_pcie_init();
+	if (machine_is_db88f6281_bp()) {
+		u32 dev, rev;
+		int init_port1 = 0;

+		kirkwood_pcie_id(&dev,&rev);
+		if (dev == MV88F6282_DEV_ID)
+			init_port1 = 1;
+		kirkwood_pcie_init(1, init_port1);
+	}
  	return 0;
  }
  subsys_initcall(db88f6281_pci_init);


This is really likely not to be possible, unless the 2 boards 
(db-88f6281-bp and db-88f6282-bp have the same ID given by uboot, which 
I guess is not the case).
Better would be to define a new board.

diff --git a/arch/arm/mach-kirkwood/include/mach/bridge-regs.h b/arch/arm/mach-kirkwood/include/mach/bridge-regs.h
index 418f501..2026b30 100644
--- a/arch/arm/mach-kirkwood/include/mach/bridge-regs.h
+++ b/arch/arm/mach-kirkwood/include/mach/bridge-regs.h
@@ -59,6 +59,7 @@
  #define CGC_SATA1		(1<<  15)
  #define CGC_XOR1		(1<<  16)
  #define CGC_CRYPTO		(1<<  17)
+#define CGC_PEX1		(1<<  18)
  #define CGC_GE1			(1<<  19)
  #define CGC_TDM			(1<<  20)
  #define CGC_RESERVED		((1<<  18) | (0x6<<  21))


 From datasheet, that's correct but then you need to update the 
CGC_RESERVED define to remove the (1 << 18) now that is being used.

@@ -72,6 +81,7 @@
  #define PCIE_VIRT_BASE		(KIRKWOOD_REGS_VIRT_BASE | 0x40000)
  #define PCIE_LINK_CTRL		(PCIE_VIRT_BASE | 0x70)
  #define PCIE_STATUS		(PCIE_VIRT_BASE | 0x1a04)
+#define PCIE1_VIRT_BASE		(KIRKWOOD_REGS_VIRT_BASE | 0x44000)


Also correct, but then you also need to define the following ones:

+ #define PCIE1_LINK_CTRL        (PCIE1_VIRT_BASE | 0x70)
+ #define PCIE1_STATUS        (PCIE1_VIRT_BASE | 0x1a04)

A few other things also need to be done in 
arch/arm/mach-kirkwood/common.c for 2nd PCIe to be properly initialized.
Sorry for this not to be in patch format but you'll probably get my 
point anyhow.

The I/O Mapping has to be set conditionally. I'd propose the following 
approach:

/* I/O Mapping with 1 PEX controller */
static struct map_desc kirkwood_io_desc_1[] __initdata = {
     {
         .virtual    = KIRKWOOD_PCIE_IO_VIRT_BASE,
         .pfn        = __phys_to_pfn(KIRKWOOD_PCIE_IO_PHYS_BASE),
         .length        = KIRKWOOD_PCIE_IO_SIZE,
         .type        = MT_DEVICE,
     }, {
         .virtual    = KIRKWOOD_REGS_VIRT_BASE,
         .pfn        = __phys_to_pfn(KIRKWOOD_REGS_PHYS_BASE),
         .length        = KIRKWOOD_REGS_SIZE,
         .type        = MT_DEVICE,
     },
};

/* I/O Mapping with 2 PEX controllers */
static struct map_desc kirkwood_io_desc_2[] __initdata = {
     {
         .virtual    = KIRKWOOD_PCIE_IO_VIRT_BASE,
         .pfn        = __phys_to_pfn(KIRKWOOD_PCIE_IO_PHYS_BASE),
         .length        = KIRKWOOD_PCIE_IO_SIZE,
         .type        = MT_DEVICE,
     }, {
     {
         .virtual    = KIRKWOOD_PCIE1_IO_VIRT_BASE,
         .pfn        = __phys_to_pfn(KIRKWOOD_PCIE1_IO_PHYS_BASE),
         .length        = KIRKWOOD_PCIE1_IO_SIZE,
         .type        = MT_DEVICE,
     }, {
         .virtual    = KIRKWOOD_REGS_VIRT_BASE,
         .pfn        = __phys_to_pfn(KIRKWOOD_REGS_PHYS_BASE),
         .length        = KIRKWOOD_REGS_SIZE,
         .type        = MT_DEVICE,
     },
};

void __init kirkwood_map_io(void)
{
     u32 dev, rev;

     kirkwood_pcie_id(&dev, &rev);

     if (dev == MV88F6282_DEV_ID && (rev == MV88F6282_REV_A0))
         iotable_init(kirkwood_io_desc_2,
                  ARRAY_SIZE(kirkwood_io_desc_2));
     else
         iotable_init(kirkwood_io_desc_1,
                  ARRAY_SIZE(kirkwood_io_desc_1));
}


And also in kirkwood_clock_gate():

/* Make sure those units are accessible */
- writel(curr | CGC_SATA0 | CGC_SATA1 | CGC_PEX0 | CGC_PEX1, 
CLOCK_GATING_CTRL);
+ writel(curr | CGC_SATA0 | CGC_SATA1 | CGC_PEX0, CLOCK_GATING_CTRL);

And 2nd PCIe PHY shutdown at init:

+    /* For PCIe #1: first shutdown the phy */
+   if (!(kirkwood_clk_ctrl & CGC_PEX1)) {
+        writel(readl(PCIE1_LINK_CTRL) | 0x10, PCIE1_LINK_CTRL);
+       while (1)
+          if (readl(PCIE1_STATUS) & 0x1)
+             break;
+    writel(readl(PCIE1_LINK_CTRL) & ~0x10, PCIE1_LINK_CTRL);
+  }

Additionally, not sure it is needed for PCIe support but@least for F6282,
you need to refine the MPP matrix in mpp.h. The 6282 MPP _really_ is 
different from 6281 one.
I can send a patch for this if needed, I already have done the necessary 
changes in my tree.

Ben
