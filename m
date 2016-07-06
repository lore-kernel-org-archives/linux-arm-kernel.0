From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 6 Jul 2016 16:21:21 +0200
Subject: [RFC PATCH v2 1/4] Documentation: DT: net: Add Xilinx
 gmiitorgmii converter device tree binding documentation
In-Reply-To: <03CA77BA8AF6F1469AEDFBDA1322A7B74A193913@XAP-PVEXMBX02.xlnx.xilinx.com>
References: <1467623084-15471-1-git-send-email-appanad@xilinx.com>
 <1467623084-15471-2-git-send-email-appanad@xilinx.com>
 <20160704140458.GC3282@lunn.ch>
 <03CA77BA8AF6F1469AEDFBDA1322A7B74A193913@XAP-PVEXMBX02.xlnx.xilinx.com>
Message-ID: <20160706142121.GI19800@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > Hi Kedareswara
> > 
> > So looking at the device tree, you have the gmiitorgmii as an mdio
> > device. It will get probed as an mdio device, and from that you know
> > the address on the bus. However, your driver does not actually do
> > this. xilinx_gmii2rgmii.c is just a library of two functions, and does
> > not use any of this device tree information. You device tree binding
> > is completely bogus.
> > 
> > What i think is a much more logical structure, and fits the hardware,
> > which is what DT is all about, is to make your driver an mdio driver.
> > Also, have a phy-handle pointing to the PHY in the gmii_to_rgmii node.
> > You then no longer need the exported gmii2rgmii_phyprobe() function.
> > 
> > Next, you want gmiitorgmii driver to register a phy. The MAC driver
> > can then look this up using phy-handle:
> > 
> >        mdio {
> >                 #address-cells = <1>;
> >                 #size-cells = <0>;
> > 
> >                 phy: ethernet-phy at 0 {
> >                         reg = <0>;
> >                 };
> > 
> >                 gmii_to_rgmii: gmii-to-rgmii at 8 {
> >                         compatible = "xlnx,gmiitorgmii";
> >                         reg = <8>;
> > 			phy-handle = <&phy>;
> >                 };
> >        };
> 
> 
> Thanks for your inputs initially we too thought the similar implementation
> But the GMII2RGMII converter contains only one register and it is 
>  not compatible to the standard ethernet MII interface. Also it doesn't have
> a standard VID and PID registers So, during the mdio bus scan, this device will 
> not appear.

Hi Punnaiah

Use missed some subtlety in my description. I did not call the
GMII2RGMII a PHY device, i called it an MDIO device. These are
different things. Go look at the MDIO subsystem to figure out the
difference.

	Andrew
