From: chris.packham@alliedtelesis.co.nz (Chris Packham)
Date: Mon, 30 Jan 2017 12:20:30 +1300
Subject: [PATCHv5 0/5] Support for Marvell switches with integrated CPUs
Message-ID: <20170129232035.25189-1-chris.packham@alliedtelesis.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The 98DX3236, 98DX3336 and 98DX4251 are a set of switch ASICs with
integrated CPUs. They CPU block is common within these product lines and
(as far as I can tell/have been told) is based on the Armada XP. There
are a few differences due to the fact they have to squeeze the CPU into
the same package as the switch.

I've rebased this series against linux-pinctrl/devel to get access to
mvebu_mmio_mpp_ctrl. Everything else still applies cleanly to v4.10.0-rc5.

Chris Packham (4):
  clk: mvebu: support for 98DX3236 SoC
    Changes in v2:
    - Update devicetree binding documentation for new compatible string
    Changes in v3:
    - Add 98dx3236 support to mvebu/clk-corediv.c rather than creating a new
      driver.
    - Document mv98dx3236-corediv-clock binding
    Changes in v4:
    - None
    Changes in v5:
    - Collect ack from Rob
    - Remove explicit initialisation of fields to 0 in mv98dx3236_coreclks
    - Register dummy clock provider for marvell,mv98dx3236-cpu-clock
    Changes in v6:
   - None. Note this has already been applied to clk-net, I've just
     included it for completeness.
  arm: mvebu: support for SMP on 98DX3336 SoC
    Changes in v2:
    - Document new enable-method value
    - Correct some references from 98DX4521 to 98DX3236
    Changes in v3:
    - Simplify mv98dx3236_resume_init by using of_io_request_and_map()
    Changes in v4:
    - integrate changes into platsmp.c instead of new init call
    - avoid duplicated code.
    - fix error return
    - Collect ack from Rob
    Changes in v5:
    - Remove useless casts (thanks to Stephen Boyd)
    Changes in v6:
    - use a #define instead of a new structure for resume control registers.
  arm: mvebu: Add device tree for 98DX3236 SoCs
    Changes in v2:
    - Update devicetree binding documentation to reflect that 98DX3336 and
      984251 are supersets of 98DX3236.
    - disable crypto block
    - disable sdio for 98DX3236, enable for 98DX4251
    Changes in v3:
    - fix typo 4521 -> 4251
    - document prestera bindings
    - rework corediv-clock binding
    - add label to packet processor node
    - add new compatible string for DFX server
    Changes in v4:
    - Collect ack from Rob
    Changes in v5:
    - Fixup license text. Add labels to nodes.
    Changes in v6:
    - None
  arm: mvebu: Add device tree for db-dxbc2 and db-xc3-24g4xg boards
    Changes in v5:
    - update license text
    - use node labels
    Changes in v6:
    - Rename dts files to include 'armada-xp-' prefix

Kalyan Kinthada (1):
  pinctrl: mvebu: pinctrl driver for 98DX3236 SoC
    Changes in v2:
    - include sdio support for the 98DX4251
    Changes in v3:
    - None
    Changes in v4:
    - Correct some discrepencies between binding and driver.
    - Collect acks from Rob and Sebastian
    Changes in v5:
    - Update bindings to reflect "gpo" pins
    - Use mvebu_mmio_mpp_ctrl instead of armada_xp_mpp_ctrl (note this is reliant
      on changes queued in linux-pinctrl)
    Changes in v6:
    - None

 Documentation/devicetree/bindings/arm/cpus.txt     |   1 +
 .../bindings/arm/marvell/98dx3236-resume-ctrl.txt  |  16 ++
 .../devicetree/bindings/arm/marvell/98dx3236.txt   |  23 ++
 .../bindings/clock/mvebu-corediv-clock.txt         |   1 +
 .../devicetree/bindings/clock/mvebu-cpu-clock.txt  |   1 +
 .../devicetree/bindings/net/marvell,prestera.txt   |  50 ++++
 .../pinctrl/marvell,armada-98dx3236-pinctrl.txt    |  46 ++++
 arch/arm/boot/dts/armada-xp-98dx3236.dtsi          | 254 +++++++++++++++++++++
 arch/arm/boot/dts/armada-xp-98dx3336.dtsi          |  76 ++++++
 arch/arm/boot/dts/armada-xp-98dx4251.dtsi          |  90 ++++++++
 arch/arm/boot/dts/armada-xp-db-dxbc2.dts           | 151 ++++++++++++
 arch/arm/boot/dts/armada-xp-db-xc3-24g4xg.dts      | 142 ++++++++++++
 arch/arm/mach-mvebu/platsmp.c                      |  75 ++++++
 drivers/clk/mvebu/armada-xp.c                      |  39 ++++
 drivers/clk/mvebu/clk-corediv.c                    |  23 ++
 drivers/clk/mvebu/clk-cpu.c                        |   8 +
 drivers/pinctrl/mvebu/pinctrl-armada-xp.c          | 156 +++++++++++++
 17 files changed, 1152 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/marvell/98dx3236-resume-ctrl.txt
 create mode 100644 Documentation/devicetree/bindings/arm/marvell/98dx3236.txt
 create mode 100644 Documentation/devicetree/bindings/net/marvell,prestera.txt
 create mode 100644 Documentation/devicetree/bindings/pinctrl/marvell,armada-98dx3236-pinctrl.txt
 create mode 100644 arch/arm/boot/dts/armada-xp-98dx3236.dtsi
 create mode 100644 arch/arm/boot/dts/armada-xp-98dx3336.dtsi
 create mode 100644 arch/arm/boot/dts/armada-xp-98dx4251.dtsi
 create mode 100644 arch/arm/boot/dts/armada-xp-db-dxbc2.dts
 create mode 100644 arch/arm/boot/dts/armada-xp-db-xc3-24g4xg.dts

inter-diff to v5:
diff --git a/arch/arm/boot/dts/db-dxbc2.dts
b/arch/arm/boot/dts/armada-xp-db-dxbc2.dts
similarity index 100%
rename from arch/arm/boot/dts/db-dxbc2.dts
rename to arch/arm/boot/dts/armada-xp-db-dxbc2.dts
diff --git a/arch/arm/boot/dts/db-xc3-24g4xg.dts
b/arch/arm/boot/dts/armada-xp-db-xc3-24g4xg.dts
similarity index 100%
rename from arch/arm/boot/dts/db-xc3-24g4xg.dts
rename to arch/arm/boot/dts/armada-xp-db-xc3-24g4xg.dts
diff --git a/arch/arm/mach-mvebu/platsmp.c
b/arch/arm/mach-mvebu/platsmp.c
index a5b464497e1a..e62273aacb43 100644
--- a/arch/arm/mach-mvebu/platsmp.c
+++ b/arch/arm/mach-mvebu/platsmp.c
@@ -185,46 +185,35 @@ const struct smp_operations armada_xp_smp_ops
__initconst = {
 CPU_METHOD_OF_DECLARE(armada_xp_smp, "marvell,armada-xp-smp",
                      &armada_xp_smp_ops);
 
-struct resume_controller {
-       u32 resume_control;
-       u32 resume_boot_addr;
-};
-
-static const struct resume_controller mv98dx3336_resume_controller = {
-       .resume_control = 0x08,
-       .resume_boot_addr = 0x04,
-};
+#define MV98DX3236_CPU_RESUME_CTRL_REG 0x08
+#define MV98DX3236_CPU_RESUME_ADDR_REG 0x04
 
 static const struct of_device_id of_mv98dx3236_resume_table[] = {
        {
                .compatible = "marvell,98dx3336-resume-ctrl",
-               .data = &mv98dx3336_resume_controller,
        },
        { /* end of list */ },
 };
 
 static int mv98dx3236_resume_set_cpu_boot_addr(int hw_cpu, void
*boot_addr)
 {
-       const struct of_device_id *match;
        struct device_node *np;
        void __iomem *base;
-       const struct resume_controller *rc;
-
        WARN_ON(hw_cpu != 1);
 
-       np = of_find_matching_node_and_match(NULL,
        of_mv98dx3236_resume_table,
-                                            &match);
+       np = of_find_matching_node(NULL, of_mv98dx3236_resume_table);
        if (!np)
                return -ENODEV;
 
        base = of_io_request_and_map(np, 0, of_node_full_name(np));
-       rc = match->data;
        of_node_put(np);
        if (IS_ERR(base))
                return PTR_ERR(base);
 
-       writel(0, base + rc->resume_control);
-       writel(virt_to_phys(boot_addr), base + rc->resume_boot_addr);
+       writel(0, base + MV98DX3236_CPU_RESUME_CTRL_REG);
+       writel(virt_to_phys(boot_addr), base +
MV98DX3236_CPU_RESUME_ADDR_REG);
+
+       iounmap(base);
 
        return 0;
 }

-- 
2.11.0.24.ge6920cf
