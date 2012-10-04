From: linux@prisktech.co.nz (Tony Prisk)
Date: Thu, 04 Oct 2012 19:38:11 +1300
Subject: usb: uhci-platform driver fails after patch changes during merge
Message-ID: <1349332691.7583.3.camel@gitbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mike,

I see someone made changes to the uhci-platform.c driver I submitted
during v3.7 which results in it not working on mach-vt8500.

Could you clarify why the changes were made, and what the suggested
resolution would be to solve the problem that it introduced?

Lines indicated by ---> below were removed from the patch, which means
that on arch-vt8500 there is no dma_mask set, and its fails to
communicate with attached devices.

Regards

Tony P


static int __devinit uhci_hcd_platform_probe(struct platform_device
*pdev)
...
	if (usb_disabled())
		return -ENODEV;
--->
	/* Right now device-tree probed devices don't get dma_mask set.
	 * Since shared usb code relies on it, set it here for now.
	 * Once we have dma capability bindings this can go away.
	 */
	if (!pdev->dev.dma_mask)
		pdev->dev.dma_mask = &platform_uhci_dma_mask;
--->
	hcd = usb_create_hcd(&uhci_platform_hc_driver, &pdev->dev,
				pdev->name);
...
