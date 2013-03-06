From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed,  6 Mar 2013 17:59:58 +0100
Subject: [PATCH 03/10] arm: mach-orion5x: use mv_mbus_dram_info() in PCI code
In-Reply-To: <1362589205-4726-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1362589205-4726-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1362589205-4726-4-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The PCI code was directly accessing the orion_mbus_dram_info structure
to get access to a description of the SDRAM chip selects in order to
configure the PCIe -> SDRAM address decoding windows.

However, with the introduction of the mvebu-mbus driver, we are going
to remove this global structure and instead leave only the exported
mv_mbus_dram_info() function to access this description of the SDRAM
chip selects. Therefore, we simply switch to using this API.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/mach-orion5x/pci.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-orion5x/pci.c b/arch/arm/mach-orion5x/pci.c
index d9c7c3b..973db98 100644
--- a/arch/arm/mach-orion5x/pci.c
+++ b/arch/arm/mach-orion5x/pci.c
@@ -402,8 +402,9 @@ static void __init orion5x_pci_master_slave_enable(void)
 	orion5x_pci_hw_wr_conf(bus_nr, 0, func, reg, 4, val | 0x7);
 }
 
-static void __init orion5x_setup_pci_wins(struct mbus_dram_target_info *dram)
+static void __init orion5x_setup_pci_wins(void)
 {
+	const struct mbus_dram_target_info *dram = mv_mbus_dram_info();
 	u32 win_enable;
 	int bus;
 	int i;
@@ -420,7 +421,7 @@ static void __init orion5x_setup_pci_wins(struct mbus_dram_target_info *dram)
 	bus = orion5x_pci_local_bus_nr();
 
 	for (i = 0; i < dram->num_cs; i++) {
-		struct mbus_dram_window *cs = dram->cs + i;
+		const struct mbus_dram_window *cs = dram->cs + i;
 		u32 func = PCI_CONF_FUNC_BAR_CS(cs->cs_index);
 		u32 reg;
 		u32 val;
@@ -467,7 +468,7 @@ static int __init pci_setup(struct pci_sys_data *sys)
 	/*
 	 * Point PCI unit MBUS decode windows to DRAM space.
 	 */
-	orion5x_setup_pci_wins(&orion_mbus_dram_info);
+	orion5x_setup_pci_wins();
 
 	/*
 	 * Master + Slave enable
-- 
1.7.9.5
