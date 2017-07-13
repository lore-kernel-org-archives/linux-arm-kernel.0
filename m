From: gabriele.paoloni@huawei.com (Gabriele Paoloni)
Date: Thu, 13 Jul 2017 10:29:25 +0000
Subject: [PATCH v4] PCI: Support hibmc VGA cards behind a misbehaving
 HiSilicon bridge
In-Reply-To: <20170712200430.GI14614@bhelgaas-glaptop.roam.corp.google.com>
References: <20170712050811.3620-1-dja@axtens.net>
 <20170712200430.GI14614@bhelgaas-glaptop.roam.corp.google.com>
Message-ID: <EE11001F9E5DDD47B7634E2F8A612F2E40B35F02@FRAEML521-MBX.china.huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bjorn, Daniel

[...]

> 
> Is this quirk useful on any arch other than arm64?  Per
> drivers/pci/dwc/Kconfig, CONFIG_PCI_HISI depends on CONFIG_ARM64.
> 
> Would it make sense to put this quirk in arch/arm64/kernel/pci.c?

Indeed our host controller depends on ARM64 so maybe it would make
sense to move the quirk arch/arm64/kernel/pci.c; however regardless
why is it strictly required for a VGA device to be legacy one in order
to make it the default boot device?
i.e. couldn't we have:

diff --git a/drivers/gpu/vga/vgaarb.c b/drivers/gpu/vga/vgaarb.c
index 0f5b2dd..a6b606c 100644
--- a/drivers/gpu/vga/vgaarb.c
+++ b/drivers/gpu/vga/vgaarb.c
@@ -667,8 +667,7 @@ static bool vga_arbiter_add_pci_device(struct pci_dev *pdev)
 	/* Deal with VGA default device. Use first enabled one
 	 * by default if arch doesn't have it's own hook
 	 */
-	if (vga_default == NULL &&
-	    ((vgadev->owns & VGA_RSRC_LEGACY_MASK) == VGA_RSRC_LEGACY_MASK)) {
+	if (vga_default == NULL) {
 		vgaarb_info(&pdev->dev, "setting as boot VGA device\n");
 		vga_set_default_device(pdev);
 	}

?
Thanks
Gab
