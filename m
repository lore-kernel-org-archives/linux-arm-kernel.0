From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Mon, 13 Dec 2010 10:47:05 -0200
Subject: [PATCH] ARM: mx5: check for error in ioremap
Message-ID: <1292244425-19155-1-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mach-mx5/board-cpuimx51.c     |    4 ++++
 arch/arm/mach-mx5/board-cpuimx51sd.c   |    4 ++++
 arch/arm/mach-mx5/board-mx51_babbage.c |    4 ++++
 arch/arm/mach-mx5/board-mx51_efikamx.c |    2 ++
 arch/arm/plat-mxc/ehci.c               |    4 ++++
 5 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx5/board-cpuimx51.c b/arch/arm/mach-mx5/board-cpuimx51.c
index 6ab002d..125a196 100644
--- a/arch/arm/mach-mx5/board-cpuimx51.c
+++ b/arch/arm/mach-mx5/board-cpuimx51.c
@@ -178,6 +178,8 @@ static int initialize_otg_port(struct platform_device *pdev)
 	void __iomem *usbother_base;
 
 	usb_base = ioremap(MX51_OTG_BASE_ADDR, SZ_4K);
+	if (!usb_base)
+		return -ENOMEM;
 	usbother_base = usb_base + MX5_USBOTHER_REGS_OFFSET;
 
 	/* Set the PHY clock to 19.2MHz */
@@ -196,6 +198,8 @@ static int initialize_usbh1_port(struct platform_device *pdev)
 	void __iomem *usbother_base;
 
 	usb_base = ioremap(MX51_OTG_BASE_ADDR, SZ_4K);
+	if (!usb_base)
+		return -ENOMEM;
 	usbother_base = usb_base + MX5_USBOTHER_REGS_OFFSET;
 
 	/* The clock for the USBH1 ULPI port will come externally from the PHY. */
diff --git a/arch/arm/mach-mx5/board-cpuimx51sd.c b/arch/arm/mach-mx5/board-cpuimx51sd.c
index 8e71c19..7e8fb82 100644
--- a/arch/arm/mach-mx5/board-cpuimx51sd.c
+++ b/arch/arm/mach-mx5/board-cpuimx51sd.c
@@ -157,6 +157,8 @@ static int initialize_otg_port(struct platform_device *pdev)
 	void __iomem *usbother_base;
 
 	usb_base = ioremap(MX51_OTG_BASE_ADDR, SZ_4K);
+	if (!usb_base)
+		return -ENOMEM;
 	usbother_base = usb_base + MX5_USBOTHER_REGS_OFFSET;
 
 	/* Set the PHY clock to 19.2MHz */
@@ -175,6 +177,8 @@ static int initialize_usbh1_port(struct platform_device *pdev)
 	void __iomem *usbother_base;
 
 	usb_base = ioremap(MX51_OTG_BASE_ADDR, SZ_4K);
+	if (!usb_base)
+		return -ENOMEM;
 	usbother_base = usb_base + MX5_USBOTHER_REGS_OFFSET;
 
 	/* The clock for the USBH1 ULPI port will come from the PHY. */
diff --git a/arch/arm/mach-mx5/board-mx51_babbage.c b/arch/arm/mach-mx5/board-mx51_babbage.c
index a896f84..faab7fb 100644
--- a/arch/arm/mach-mx5/board-mx51_babbage.c
+++ b/arch/arm/mach-mx5/board-mx51_babbage.c
@@ -262,6 +262,8 @@ static int initialize_otg_port(struct platform_device *pdev)
 	void __iomem *usbother_base;
 
 	usb_base = ioremap(MX51_OTG_BASE_ADDR, SZ_4K);
+	if (!usb_base)
+		return -ENOMEM;
 	usbother_base = usb_base + MX5_USBOTHER_REGS_OFFSET;
 
 	/* Set the PHY clock to 19.2MHz */
@@ -280,6 +282,8 @@ static int initialize_usbh1_port(struct platform_device *pdev)
 	void __iomem *usbother_base;
 
 	usb_base = ioremap(MX51_OTG_BASE_ADDR, SZ_4K);
+	if (!usb_base)
+		return -ENOMEM;
 	usbother_base = usb_base + MX5_USBOTHER_REGS_OFFSET;
 
 	/* The clock for the USBH1 ULPI port will come externally from the PHY. */
diff --git a/arch/arm/mach-mx5/board-mx51_efikamx.c b/arch/arm/mach-mx5/board-mx51_efikamx.c
index 5ab21a0..94e7818 100644
--- a/arch/arm/mach-mx5/board-mx51_efikamx.c
+++ b/arch/arm/mach-mx5/board-mx51_efikamx.c
@@ -148,6 +148,8 @@ static int initialize_otg_port(struct platform_device *pdev)
 	void __iomem *usb_base;
 	void __iomem *usbother_base;
 	usb_base = ioremap(MX51_OTG_BASE_ADDR, SZ_4K);
+	if (!usb_base)
+		return -ENOMEM;
 	usbother_base = (void __iomem *)(usb_base + MX5_USBOTHER_REGS_OFFSET);
 
 	/* Set the PHY clock to 19.2MHz */
diff --git a/arch/arm/plat-mxc/ehci.c b/arch/arm/plat-mxc/ehci.c
index c1a7146..d9982bc 100644
--- a/arch/arm/plat-mxc/ehci.c
+++ b/arch/arm/plat-mxc/ehci.c
@@ -254,6 +254,10 @@ int mxc_initialize_usb_hw(int port, unsigned int flags)
 		int ret = 0;
 
 		usb_base = ioremap(MX51_OTG_BASE_ADDR, SZ_4K);
+		if (!usb_base) {
+			printk(KERN_ERR "%s(): ioremap failed\n", __func__);
+			return -ENOMEM;
+		}
 
 		switch (port) {
 		case 0:	/* OTG port */
-- 
1.6.0.4
