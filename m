From: gautam.vivek@samsung.com (Vivek Gautam)
Date: Wed, 26 Dec 2012 17:58:31 +0530
Subject: [PATCH v4] usb: phy: samsung: Add support to set pmu isolation
Message-ID: <1356524912-4736-1-git-send-email-gautam.vivek@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes form v3:
 - Removing the hostphy_en_mas since this gets used in forthcoming patches
   only when host phy support is added.
 - Resolving few nits:
	- using 'const' specifier for driver data structures.
	- using ARRAY_SIZE() instead of giving magic number
	  for of_property_read_u32_array()

Changes from v2:
 - Removed the phandle type of device node properties, instead using
   sub-nodes now.
 - Removed the property 'samsung,enable-mask' since it is SoC dependent
   (SoCs like S5PV210 and S3C64XX have different bits to enable/disable
   phy controller in comparison to exysno4210 onwards).
 - Maintaining the phy enable mask (which is SoC dependent) for device type phy
   and host type phy in the driver data.
 - Re-structuring to get device properties using sub-nodes for 'usbphy-pmu'

Changes from v1:
 - Changed the name of property for phy handler from'samsung,usb-phyctrl'
   to 'samsung,usb-phyhandle' to make it look more generic.
 - Similarly 'samsung,phyctrl-reg' is changed to 'samsung,phyhandle-reg'
 - Added a check for 'samsung,usb-phyhandle' before getting node from
   phandle.
 - Putting the node using 'of_node_put()' which had been missed.
 - Adding necessary check for the pointer in 'samsung_usbphy_set_isolation()'
   to avoid any NULL pointer dereferencing.
 - Unmapping the register ioremapped in 'samsung_usbphy_parse_dt_param()'.

Based on usb-next branch with Praveen Paneri's patches on top of it.
- http://lists.infradead.org/pipermail/linux-arm-kernel/2012-November/134476.html
- http://lists.infradead.org/pipermail/linux-arm-kernel/2012-November/131763.html

Vivek Gautam (1):
  usb: phy: samsung: Add support to set pmu isolation

 .../devicetree/bindings/usb/samsung-usbphy.txt     |   31 ++++
 drivers/usb/phy/samsung-usbphy.c                   |  145 +++++++++++++++++---
 2 files changed, 155 insertions(+), 21 deletions(-)

-- 
1.7.6.5
