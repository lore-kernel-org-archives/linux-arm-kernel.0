From: appana.durga.rao@xilinx.com (Appana Durga Kedareswara Rao)
Date: Tue, 26 Jul 2016 15:09:19 +0000
Subject: [RFC PATCH v2 1/4] Documentation: DT: net: Add Xilinx
 gmiitorgmii converter device tree binding documentation
In-Reply-To: <03CA77BA8AF6F1469AEDFBDA1322A7B74A19393B@XAP-PVEXMBX02.xlnx.xilinx.com>
References: <1467623084-15471-1-git-send-email-appanad@xilinx.com>
 <1467623084-15471-2-git-send-email-appanad@xilinx.com>
 <20160704140458.GC3282@lunn.ch>
 <03CA77BA8AF6F1469AEDFBDA1322A7B74A193913@XAP-PVEXMBX02.xlnx.xilinx.com>
 <20160706142121.GI19800@lunn.ch>
 <03CA77BA8AF6F1469AEDFBDA1322A7B74A19393B@XAP-PVEXMBX02.xlnx.xilinx.com>
Message-ID: <C246CAC1457055469EF09E3A7AC4E11A4A5C2387@XAP-PVEXMBX01.xlnx.xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,

	Thanks for the inputs...

> >
> > > > Hi Kedareswara
> > > >
> > > > So looking at the device tree, you have the gmiitorgmii as an mdio
> > > > device. It will get probed as an mdio device, and from that you
> > > > know the address on the bus. However, your driver does not
> > > > actually do this. xilinx_gmii2rgmii.c is just a library of two
> > > > functions, and does not use any of this device tree information.
> > > > You device tree binding is completely bogus.
> > > >
> > > > What i think is a much more logical structure, and fits the
> > > > hardware, which is what DT is all about, is to make your driver an mdio
> driver.
> > > > Also, have a phy-handle pointing to the PHY in the gmii_to_rgmii node.
> > > > You then no longer need the exported gmii2rgmii_phyprobe() function.
> > > >
> > > > Next, you want gmiitorgmii driver to register a phy. The MAC
> > > > driver can then look this up using phy-handle:
> > > >
> > > >        mdio {
> > > >                 #address-cells = <1>;
> > > >                 #size-cells = <0>;
> > > >
> > > >                 phy: ethernet-phy at 0 {
> > > >                         reg = <0>;
> > > >                 };
> > > >
> > > >                 gmii_to_rgmii: gmii-to-rgmii at 8 {
> > > >                         compatible = "xlnx,gmiitorgmii";
> > > >                         reg = <8>;
> > > > 			phy-handle = <&phy>;
> > > >                 };
> > > >        };
> > >
> > >
> > > Thanks for your inputs initially we too thought the similar
> > > implementation But the GMII2RGMII converter contains only one
> > > register and it is  not compatible to the standard ethernet MII
> > > interface. Also it doesn't have a standard VID and PID registers So,
> > > during the mdio bus scan, this device
> > will
> > > not appear.

I tried to implement the driver as you suggested but there are few limitations in this
Implementation please correct me if my understanding is wrong...

The device-tree will look like below...
        mdio {
                #address-cells = <1>;
                 #size-cells = <0>;
                 phy: ethernet-phy at 0 {
                         reg = <0>;
                 };
                 gmii_to_rgmii: gmii-to-rgmii at 8 {
                         compatible = "xlnx,gmiitorgmii";
                         reg = <8>;
		phy-handle = <&phy>;
                 };
      };

The MAC driver does the below.
	---> It creates a MDIO device for the gmii_to_rgmii node.
	---> It creates a PHY device for the External PHY node.

The GMII2RGMII driver does the below.
	1) It registers the gmii_to_rgmii node as a MDIO driver.
	It contains the external phy as a phy-handle
	2) Register a PHY Driver.
	---> Register it as a phy driver (phy_register_driver): 
	        For this implementation the converter won't have any VID or DID(PHY register 2 and 3)  
	---> Register phy using of_phy_connect call: 
	       For this implementation needed a netdev pointer to pass it to the of_phy_connect call.
	      (Need to allocate a network device during probe and need to register it as netdev) 
		
	For the 2nd one implement I am facing above limitations...
	Please correct me if my understanding is wrong...

Regards,
Kedar.
