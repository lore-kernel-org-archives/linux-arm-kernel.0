From: dan.carpenter@oracle.com (Dan Carpenter)
Date: Wed, 12 Oct 2016 13:54:34 +0300
Subject: [bug report] PCI: rockchip: Add Rockchip PCIe controller support
Message-ID: <20161012105434.GA21452@mwanda>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Shawn Lin,

The patch e77f847df54c: "PCI: rockchip: Add Rockchip PCIe controller
support" from Sep 3, 2016, leads to the following static checker
warning:

	drivers/pci/host/pcie-rockchip.c:552 rockchip_pcie_init_port()
	warn: mask and shift to zero

drivers/pci/host/pcie-rockchip.c
   549  
   550          /* Check the final link width from negotiated lane counter from MGMT */
   551          status = rockchip_pcie_read(rockchip, PCIE_CORE_CTRL);
   552          status =  0x1 << ((status & PCIE_CORE_PL_CONF_LANE_MASK) >>
   553                            PCIE_CORE_PL_CONF_LANE_MASK);

Presumably we should be shifting by PCIE_CORE_PL_CONF_LANE_SHIFT but
this still looks all kind of jumbled up.

   554          dev_dbg(dev, "current link width is x%d\n", status);
   555  

regards,
dan carpenter
