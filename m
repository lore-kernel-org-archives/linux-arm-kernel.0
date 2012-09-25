From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Tue, 25 Sep 2012 02:02:13 +0200
Subject: [PATCH 1/6] ARM: dove: Add pcie clock support
In-Reply-To: <1348531338-16624-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1348531338-16624-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1348531338-16624-2-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As dove now has clock gating control ensure pcie ports grab their
clocks.

Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Olof Johansson <olof@lixom.net>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
---
 arch/arm/mach-dove/pcie.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/mach-dove/pcie.c b/arch/arm/mach-dove/pcie.c
index bb15b26..0ef4435 100644
--- a/arch/arm/mach-dove/pcie.c
+++ b/arch/arm/mach-dove/pcie.c
@@ -10,6 +10,7 @@
 
 #include <linux/kernel.h>
 #include <linux/pci.h>
+#include <linux/clk.h>
 #include <video/vga.h>
 #include <asm/mach/pci.h>
 #include <asm/mach/arch.h>
@@ -188,6 +189,10 @@ static void __init add_pcie_port(int index, void __iomem *base)
 
 	if (orion_pcie_link_up(base)) {
 		struct pcie_port *pp = &pcie_port[num_pcie_ports++];
+		struct clk *clk = clk_get_sys("pcie", (index ? "1" : "0"));
+
+		if (!IS_ERR(clk))
+			clk_prepare_enable(clk);
 
 		printk(KERN_INFO "link up\n");
 
-- 
1.7.10.4
