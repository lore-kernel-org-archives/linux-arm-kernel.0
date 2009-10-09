From: simon.kagstrom@netinsight.net (Simon Kagstrom)
Date: Fri, 9 Oct 2009 08:26:45 +0200
Subject: [PATCH v2] OpenRD base: Initialize PCI express and i2c
In-Reply-To: <alpine.LFD.2.00.0910081337260.18779@xanadu.home>
References: <200910081333.43065.dk-arm-linux@gmx.de>
	<20091008133329.675796da@marrow.netinsight.se>
	<alpine.LFD.2.00.0910081337260.18779@xanadu.home>
Message-ID: <20091009082645.7e37573d@marrow.netinsight.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Simon Kagstrom <simon.kagstrom@netinsight.net>
---
Right now I don't have a PCI card to test with, so Dieter: could you
test the patch and ack it?

ChangeLog:

v2:
  * Rebase against 2.6.32
  * Remove UART1 initialization (UART1 is not always present - either
    the SD card or UART1 is selected)

 arch/arm/mach-kirkwood/openrd_base-setup.c |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-kirkwood/openrd_base-setup.c b/arch/arm/mach-kirkwood/openrd_base-setup.c
index 947dfb8..77617c7 100644
--- a/arch/arm/mach-kirkwood/openrd_base-setup.c
+++ b/arch/arm/mach-kirkwood/openrd_base-setup.c
@@ -70,8 +70,20 @@ static void __init openrd_base_init(void)
 	kirkwood_ge00_init(&openrd_base_ge00_data);
 	kirkwood_sata_init(&openrd_base_sata_data);
 	kirkwood_sdio_init(&openrd_base_mvsdio_data);
+
+	kirkwood_i2c_init();
 }
 
+static int __init openrd_base_pci_init(void)
+{
+	if (machine_is_openrd_base())
+		kirkwood_pcie_init();
+
+	return 0;
+ }
+subsys_initcall(openrd_base_pci_init);
+
+
 MACHINE_START(OPENRD_BASE, "Marvell OpenRD Base Board")
 	/* Maintainer: Dhaval Vasa <dhaval.vasa@einfochips.com> */
 	.phys_io	= KIRKWOOD_REGS_PHYS_BASE,
-- 
1.6.0.4
