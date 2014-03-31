From: tthayer@altera.com (tthayer at altera.com)
Date: Mon, 31 Mar 2014 17:07:07 -0500
Subject: [PATCH 2/2] arm: socfpga: Add support for Altera SoC SDRAM controller
In-Reply-To: <1396303627-29198-1-git-send-email-tthayer@altera.com>
References: <1396303627-29198-1-git-send-email-tthayer@altera.com>
Message-ID: <1396303627-29198-3-git-send-email-tthayer@altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thor Thayer <tthayer@altera.com>

Addition of the Altera SDRAM controller registers to the
Altera SoC project. These registers are shared by future
drivers such as ECC and the FPGA bridge.

Signed-off-by: Thor Thayer <tthayer@altera.com>
To: Rob Herring <rob.herring@calxeda.com>
To: Pawel Moll <pawel.moll@arm.com>
To: Mark Rutland <mark.rutland@arm.com>
To: Ian Campbell <ijc+devicetree@hellion.org.uk>
To: Kumar Gala <galak@codeaurora.org>
To: Rob Landley <rob@landley.net>
To: Russell King <linux@arm.linux.org.uk>
To: Dinh Nguyen <dinguyen@altera.com>
Cc: devicetree at vger.kernel.org
Cc: linux-doc at vger.kernel.org
Cc: linux-kernel at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
---
 arch/arm/mach-socfpga/socfpga.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/mach-socfpga/socfpga.c b/arch/arm/mach-socfpga/socfpga.c
index 21d6026..d514e8a 100644
--- a/arch/arm/mach-socfpga/socfpga.c
+++ b/arch/arm/mach-socfpga/socfpga.c
@@ -32,6 +32,7 @@
 void __iomem *socfpga_scu_base_addr = ((void __iomem *)(SOCFPGA_SCU_VIRT_BASE));
 void __iomem *sys_manager_base_addr;
 void __iomem *rst_manager_base_addr;
+void __iomem *sdr_ctl_base_addr;
 void __iomem *clk_mgr_base_addr;
 unsigned long cpu1start_addr;
 
@@ -150,6 +151,15 @@ void __init socfpga_sysmgr_init(void)
 
 	np = of_find_compatible_node(NULL, NULL, "altr,clk-mgr");
 	clk_mgr_base_addr = of_iomap(np, 0);
+
+	np = of_find_compatible_node(NULL, NULL, "altr,sdr-ctl");
+	if (!np) {
+		pr_err("SOCFPGA: Unable to find sdr-ctl\n");
+		return;
+	}
+
+	sdr_ctl_base_addr = of_iomap(np, 0);
+	WARN_ON(!sdr_ctl_base_addr);
 }
 
 static void __init socfpga_init_irq(void)
-- 
1.7.9.5
