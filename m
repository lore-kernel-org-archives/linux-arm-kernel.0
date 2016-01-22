From: hzpeterchen@gmail.com (Peter Chen)
Date: Fri, 22 Jan 2016 14:59:01 +0800
Subject: [PATCH v3 1/1] USB: core: let USB device know device node
In-Reply-To: <2930830.FLp5q7oBTi@wuerfel>
References: <Pine.LNX.4.44L0.1601211015010.2275-100000@iolanthe.rowland.org>
 <2930830.FLp5q7oBTi@wuerfel>
Message-ID: <20160122065901.GA31145@shlinux2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 21, 2016 at 11:24:21PM +0100, Arnd Bergmann wrote:
> On Thursday 21 January 2016 10:21:15 Alan Stern wrote:
> > On Thu, 21 Jan 2016, Arnd Bergmann wrote:
> > 
> > > On Thursday 21 January 2016 17:48:32 Peter Chen wrote:
> > > > 
> > > > > 
> > > > > So two hubs at ports 1 and 2 of the USB controller that integrates
> > > > > the root hub and shares a device node with it.
> > > > > 
> > > > Ok, so the "reg" is the address for certain root hub (HS or SS), not
> > > > the unity address for the whole controller, if it is, do we really
> > > > need to add two nodes for one physical port, HS and SS will not be used
> > > > at the same time. And if the reg is the same, how can we know
> > > > which node is from current recognized device.
> > > 
> > > The "reg" is the address that the parent device uses to talk to the child
> > > device. If you know which of the two that child is attached to, then I
> > > think you don't need both, but I think we have to use the entire addressing.
> > > 
> > > In Alan's example, there are six HS ports and three SS ports, but as I
> > > understand it, there is no guarantee that the numbering between the two
> > > is identical, and that the three SS ports always refer to the three HS
> > > ports. In particular for devices soldered on-board (rather than connected
> > > through a standard plug), I would guess that it is possible to connect
> > > them to separate child devices though I have to admit that I do not
> > > understand enough of the standard to know for sure.
> > 
> > The spec allows for a lot of flexibility.  It even allows for "tier 
> > mismatches", in which (for example) the SS connection for a particular 
> > port is routed directly to the root hub while the HS connection for the 
> > same port is routed through an intermediate hub!
> > 
> > There is only one major constraint: With the exception of hubs, no USB
> > device is allowed to use both the SS and the HS buses at the same time.  
> > A device has to decide on one speed and use only the corresponding bus.
> > USB-3 hubs, on the other hand, are required to connect to both buses.  
> > They appear as two separate logical devices: a SS hub on the SS bus and
> > a HS hub on the HS bus.
> 
> Ok, thanks for the explanation. This means there is no strict relation
> between the SS and HS ports and we have to represent them separately.
> 
> I can also see what you explained now on my PC by plugging in a couple
> of devices into a hub on a single SS port:
> 
> /:  Bus 04.Port 1: Dev 1, Class=root_hub, Driver=xhci_hcd/2p, 5000M
>     |__ Port 1: Dev 2, If 0, Class=Hub, Driver=hub/4p, 5000M
>         |__ Port 1: Dev 4, If 0, Class=Mass Storage, Driver=usb-storage, 5000M
>         |__ Port 4: Dev 3, If 0, Class=Vendor Specific Class, Driver=ax88179_178a, 5000M
> /:  Bus 03.Port 1: Dev 1, Class=root_hub, Driver=xhci_hcd/2p, 480M
>     |__ Port 1: Dev 3, If 0, Class=Hub, Driver=hub/4p, 480M
>         |__ Port 2: Dev 5, If 0, Class=Wireless, Driver=btusb, 12M
>         |__ Port 2: Dev 5, If 1, Class=Wireless, Driver=btusb, 12M
> 
> In this case, the DT representation would be
> 
> 
> 	usb at ... { /* host controller and root hub */
> 		compatible = "xhci-generic";
> 		#address-cells = <1>;
> 		#size-cells = <0>;
> 
> 		hub at 1 { /* external hub, superspeed mode class 9/subclass 0/proto 3 */
> 			compatible = "usb2109,0812.591",
> 				     "usb2109,0812",
> 				     "usb2109,class9.0.3",
> 				     "usb2109,class9.0",
> 				     "usb2109,class9";
> 			compatible = "usb2109,0812";

Do we really need to write "compatible" so complicated?

> 			#address-cells = <1>;
> 			#size-cells = <0>;
> 			reg = <1>;
> 
> 			communications at 4 { /* superspeed ethernet device */
> 				compatible = "usb0b95,1790.100",
> 					     "usb0b95,1790",
> 					     "usb0b95,class255.255.0",
> 					     "usb0b95,class255.255",
> 					     "usb0b95,class255",
> 					     "usbif0b95,1790.100",
> 					     "usbif0b95,1790",
> 					     "usbif0b95,class255.255.0",
> 					     "usbif0b95,class255.255,
> 					     "usbif0b95,class255";
> 				reg = <4>;
> 			};
> 
> 			storage at 1 { /* superspeed flash drive */
> 				compatible = "usb1234,5678.600",
> 					     "usb1234,5678",
> 					     "usbif1234,class8.6.80",
> 					     "usbif1234,class8.6",
> 					     "usbif1234,class8",
> 					     "usbif,class8.6.80",
> 					     "usbif,class8.6",
> 					     "usbif,class8";
> 				reg = <1>;
> 			};
> 		};
> 	
> 		hub at 3 { /* same external  hub, highspeed mode */
> 			compatible = "usb2109,0812.591",
> 				     "usb2109,0812",
> 				     "usb2109,class9.0.1",
> 				     "usb2109,class9.0",
> 				     "usb2109,class9";
> 
> 			#address-cells = <1>;
> 			#size-cells = <0>;
> 			reg = <3>;
> 

Why "reg" is 3 here?

> 			wireless at 2 { /* bluetooth device */
> 				compatible = "usb0a12,0001.134",
> 					     "usb0a12,0001",
> 					     "usb0a12,class224.1.1",
> 					     "usb0a12,class224.1",
> 					     "usb0a12,class224",
> 					     "usb0a12,class224.1.1",
> 					     "usb0a12,class224.1",
> 					     "usb0a12,class224";
> 				#address-cells = <1>;
> 				#size-cells = <0>;
> 				reg = <2>;
> 
> 				wireless at 0,0 { /* bluetooth config 0, if 0 */
> 					compatible = "usbif0a12,0001.134.config0.0",
> 							"usbif0a12,0001.config0.0",
> 							"usbif0a12,class224.1.1",
> 							"usbif0a12,class224.1",
> 							"usbif0a12,class224",
> 							"usbif,class224.1.1",
> 							"usbif,class224.1",
> 							"usbif,class224";
> 					reg = <0 0>;
> 				};
> 
> 				wireless at 0,1 { /* bluetooth config 0, if 1 */
> 					compatible = "usbif0a12,0001.134.config0.1",
> 							"usbif0a12,0001.config0.1",
> 							"usbif0a12,class224.1.1",
> 							"usbif0a12,class224.1",
> 							"usbif0a12,class224",
> 							"usbif,class224.1.1",
> 							"usbif,class224.1",
> 							"usbif,class224";
> 					reg = <0 0>;
> 				};
> 			};
> 		};
> 	};
> 
> In that description, I have included all four kinds of nodes from
> the spec: host controller, device (wireless at 2), interface (wireless at 0.1,
> wireless at 0.2) and combined (hub at 1, hub at 3, storage at 1, communications at 4).
> 
> Peter's example only contained hubs in combined nodes, no device or
> interface nodes. I wonder if the code is able to parse all four
> kinds of nodes though, and if we actually need that.
> 

My proposal patch only handles the node under the USB device, not include
the USB interfaces under such device, we can add it after finalize
how to describe it at device tree.

> Do we have a 'struct device' for each interface?
> 

Yes, we have, but there are different 'struct device' between USB device
and USB interfaces under this USB device. See usb_set_configuration,
drivers/usb/core/message.c

> Is it possible to have a hub in an interface of a multifunction device
> or are they always single-configuration single-interface devices?
> 

I have not seen such kinds of devices, but it is possible in theory.

-- 

Best Regards,
Peter Chen
