From: shankerd@codeaurora.org (Shanker Donthineni)
Date: Sun,  3 Dec 2017 17:21:09 -0600
Subject: [PATCH] irqchip/gic-v3: Fix the driver probe() fail due to disabled
 GICC entry
Message-ID: <1512343269-19327-1-git-send-email-shankerd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As per MADT specification, it's perfectly valid firmware can pass
MADT table to OS with disabled GICC entries. ARM64-SMP code skips
those cpu cores to bring online. However the current GICv3 driver
probe bails out in this case on systems where redistributor regions
are not in the always-on power domain.

This patch does the two things to fix the panic.
  - Don't return an error in gic_acpi_match_gicc() for disabled GICC.
  - No need to keep GICR region information for disabled GICC.

Kernel crash traces:
  Kernel panic - not syncing: No interrupt controller found.
  CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.13.5 #26
  [<ffff000008087770>] dump_backtrace+0x0/0x218
  [<ffff0000080879dc>] show_stack+0x14/0x20
  [<ffff00000883b078>] dump_stack+0x98/0xb8
  [<ffff0000080c5c14>] panic+0x118/0x26c
  [<ffff000008b62348>] init_IRQ+0x24/0x2c
  [<ffff000008b609fc>] start_kernel+0x230/0x394
  [<ffff000008b601e4>] __primary_switched+0x64/0x6c
  ---[ end Kernel panic - not syncing: No interrupt controller found.

Disabled GICC subtable example:
                   Subtable Type : 0B [Generic Interrupt Controller]
                          Length : 50
                        Reserved : 0000
            CPU Interface Number : 0000003D
                   Processor UID : 0000003D
           Flags (decoded below) : 00000000
               Processor Enabled : 0
 Performance Interrupt Trig Mode : 0
 Virtual GIC Interrupt Trig Mode : 0
        Parking Protocol Version : 00000000
           Performance Interrupt : 00000017
                  Parked Address : 0000000000000000
                    Base Address : 0000000000000000
        Virtual GIC Base Address : 0000000000000000
     Hypervisor GIC Base Address : 0000000000000000
           Virtual GIC Interrupt : 00000019
      Redistributor Base Address : 0000FFFF88F40000
                       ARM MPIDR : 000000000000000D
                Efficiency Class : 00
                        Reserved : 000000

Signed-off-by: Shanker Donthineni <shankerd@codeaurora.org>
---
 drivers/irqchip/irq-gic-v3.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index b56c3e2..a30fbac 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -1331,6 +1331,10 @@ static int __init gic_of_init(struct device_node *node, struct device_node *pare
 	u32 size = reg == GIC_PIDR2_ARCH_GICv4 ? SZ_64K * 4 : SZ_64K * 2;
 	void __iomem *redist_base;
 
+	/* GICC entry which has !ACPI_MADT_ENABLED is not unusable so skip */
+	if (!(gicc->flags & ACPI_MADT_ENABLED))
+		return 0;
+
 	redist_base = ioremap(gicc->gicr_base_address, size);
 	if (!redist_base)
 		return -ENOMEM;
@@ -1374,13 +1378,13 @@ static int __init gic_acpi_match_gicc(struct acpi_subtable_header *header,
 				(struct acpi_madt_generic_interrupt *)header;
 
 	/*
-	 * If GICC is enabled and has valid gicr base address, then it means
-	 * GICR base is presented via GICC
+	 * If GICC is enabled and has not valid gicr base address, then it means
+	 * GICR base is not presented via GICC
 	 */
-	if ((gicc->flags & ACPI_MADT_ENABLED) && gicc->gicr_base_address)
-		return 0;
+	if ((gicc->flags & ACPI_MADT_ENABLED) && (!gicc->gicr_base_address))
+		return -ENODEV;
 
-	return -ENODEV;
+	return 0;
 }
 
 static int __init gic_acpi_count_gicr_regions(void)
-- 
Qualcomm Datacenter Technologies, Inc. on behalf of the Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
