From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 22 Jan 2016 11:18:07 +0100
Subject: [PATCH v3 1/1] USB: core: let USB device know device node
In-Reply-To: <20160122065901.GA31145@shlinux2>
References: <Pine.LNX.4.44L0.1601211015010.2275-100000@iolanthe.rowland.org>
 <2930830.FLp5q7oBTi@wuerfel> <20160122065901.GA31145@shlinux2>
Message-ID: <2404899.20LhULZo7N@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 22 January 2016 14:59:01 Peter Chen wrote:
> On Thu, Jan 21, 2016 at 11:24:21PM +0100, Arnd Bergmann wrote:
> > On Thursday 21 January 2016 10:21:15 Alan Stern wrote:
> > > On Thu, 21 Jan 2016, Arnd Bergmann wrote:
> > > > On Thursday 21 January 2016 17:48:32 Peter Chen wrote:
> > 		hub at 1 { /* external hub, superspeed mode class 9/subclass 0/proto 3 */
> > 			compatible = "usb2109,0812.591",
> > 				     "usb2109,0812",
> > 				     "usb2109,class9.0.3",
> > 				     "usb2109,class9.0",
> > 				     "usb2109,class9";
> > 			compatible = "usb2109,0812";
> 
> Do we really need to write "compatible" so complicated?

The binding mandates it this way, but I guess we could decide to
make it a Linux-specific extension that we allow some of them to
be left out.

> > 			#address-cells = <1>;
> > 			#size-cells = <0>;
> > 			reg = <1>;
> > 
> > 			communications at 4 { /* superspeed ethernet device */
> > 				compatible = "usb0b95,1790.100",
> > 					     "usb0b95,1790",
> > 					     "usb0b95,class255.255.0",
> > 					     "usb0b95,class255.255",
> > 					     "usb0b95,class255",
> > 					     "usbif0b95,1790.100",
> > 					     "usbif0b95,1790",
> > 					     "usbif0b95,class255.255.0",
> > 					     "usbif0b95,class255.255,
> > 					     "usbif0b95,class255";
> > 				reg = <4>;
> > 			};
> > 
> > 			storage at 1 { /* superspeed flash drive */
> > 				compatible = "usb1234,5678.600",
> > 					     "usb1234,5678",
> > 					     "usbif1234,class8.6.80",
> > 					     "usbif1234,class8.6",
> > 					     "usbif1234,class8",
> > 					     "usbif,class8.6.80",
> > 					     "usbif,class8.6",
> > 					     "usbif,class8";
> > 				reg = <1>;
> > 			};
> > 		};
> > 	
> > 		hub at 3 { /* same external  hub, highspeed mode */
> > 			compatible = "usb2109,0812.591",
> > 				     "usb2109,0812",
> > 				     "usb2109,class9.0.1",
> > 				     "usb2109,class9.0",
> > 				     "usb2109,class9";
> > 
> > 			#address-cells = <1>;
> > 			#size-cells = <0>;
> > 			reg = <3>;
> > 
> 
> Why "reg" is 3 here?

My mistake. It should be hub at 1 and reg=<1>;

I accidentally confused the port number and the device number.

> > 				wireless at 0,1 { /* bluetooth config 0, if 1 */
> > 					compatible = "usbif0a12,0001.134.config0.1",
> > 							"usbif0a12,0001.config0.1",
> > 							"usbif0a12,class224.1.1",
> > 							"usbif0a12,class224.1",
> > 							"usbif0a12,class224",
> > 							"usbif,class224.1.1",
> > 							"usbif,class224.1",
> > 							"usbif,class224";
> > 					reg = <0 0>;
> > 				};
> > 			};
> > 		};
> > 	};
> > 
> > In that description, I have included all four kinds of nodes from
> > the spec: host controller, device (wireless at 2), interface (wireless at 0.1,
> > wireless at 0.2) and combined (hub at 1, hub at 3, storage at 1, communications at 4).
> > 
> > Peter's example only contained hubs in combined nodes, no device or
> > interface nodes. I wonder if the code is able to parse all four
> > kinds of nodes though, and if we actually need that.
> > 
> 
> My proposal patch only handles the node under the USB device, not include
> the USB interfaces under such device, we can add it after finalize
> how to describe it at device tree.

We should at least handle the case of multiple hubs connected to one
another I think. No need to limit it to directly connected devices
when it's easy enough to do hubs as well.

> > Do we have a 'struct device' for each interface?
> > 
> 
> Yes, we have, but there are different 'struct device' between USB device
> and USB interfaces under this USB device. See usb_set_configuration,
> drivers/usb/core/message.c

Ok, got it. So we can set the of_node pointer of a struct usb_interface
to the child node of the usb->interface->usb_dev that matches the
configuration/interface tuple.

For combined device nodes (class 0 device, single configuration, single
interface), I suppose we have both a 'struct usb_device' and a 'struct
usb_interface' that we could attach the of_node to, but we can
decide to always just use one of the two, to avoid having the
same of_node pointer in multiple 'struct device' instances.

Or we simplify it so we always put the of_node just in the usb_device
or the usb_interface, even if both are listed.

> > Is it possible to have a hub in an interface of a multifunction device
> > or are they always single-configuration single-interface devices?
> > 
> 
> I have not seen such kinds of devices, but it is possible in theory.

Ok, so if the USB spec allows it, we should probably try to handle it too.

	Arnd
