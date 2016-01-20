From: hzpeterchen@gmail.com (Peter Chen)
Date: Wed, 20 Jan 2016 11:48:39 +0800
Subject: [PATCH v3 1/1] USB: core: let USB device know device node
In-Reply-To: <Pine.LNX.4.44L0.1601191009190.1727-100000@iolanthe.rowland.org>
References: <4405270.vcz87Q878u@wuerfel>
 <Pine.LNX.4.44L0.1601191009190.1727-100000@iolanthe.rowland.org>
Message-ID: <20160120034839.GA16222@shlinux2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 19, 2016 at 10:12:56AM -0500, Alan Stern wrote:
> On Tue, 19 Jan 2016, Arnd Bergmann wrote:
> 
> > On Tuesday 19 January 2016 11:08:59 Peter Chen wrote:
> > > 
> > > I am afraid I have no USB 3.0 PC running Linux.
> > > 
> > > > > - Which the value of hub->descriptor->bNbrPorts for root hub?
> > > > 
> > > > In the example above, the legacy root hub would have bNbrPorts set to 6 
> > > > and the SS root hub would have bNbrPorts set to 3.
> > > > 
> > > 
> > > Ok, so the maximum physical port number is 6 as well as bNbrports value.
> > > The "reg" value at dts should be from 1 to 6. "reg" stands for physical
> > > port number for individual physical port, eg if "reg" equals to 1, it
> > > stands for the device connects at port 1, no matter the device is HS or
> > > SS, it can use the node whose "reg" is 1.
> > 
> > As I understand it, you could have two devices that are both
> > connected to port '1', when one is using HS and the other is using
> > SS. This means that we can't use the same 'reg' value for both, and
> > we have to define a particular way to disambiguate them.
> > 
> > As Alan says, there is an established ordering that just sorts the
> > ports form 1 to 9 in the example, and that would be the most
> > straightforward to use here.
> 
> There is even a documented callback (find_raw_port_number) in the
> hc_driver structure for converting between the numbering schemes.  I
> don't know if all the existing USB-3 host controller drivers implement
> that callback, but they should.
> 
> > Alternatively, you could use one of the high bits of the 'reg' value
> > to indicate which root hub is used. I'm sure that would work as
> > well, but be less obvious.
> 
> It's probably best to stick with the same numbering that the hardware 
> uses.

Seems we are talking about root hub, not the device in the
root hub. So for multiple ports controller, we have to own node for 
root hub. Assume your example, there is a genesys HUB at physical
port 1, I suggest a dts node description like below, please correct
me if anything wrong.

&usb1 {
	roothub_1: nxp at 1 {
		compatible = "usb15a2,007d";
		reg = <0x01>;

		hub: genesys at 1 {
			compatible = "usb05e3,0608";
			reg = <0x01>;
		};
	};

	roothub_2: nxp at 2 {
		compatible = "usb15a2,007d";
		reg = <0x02>;
	};

	...

	roothub_7: nxp at 7 {
		compatible = "usb15a2,007d";
		reg = <0x07>;

		hub: genesys at 1 {
			compatible = "usb05e3,0608";
			reg = <0x01>;
		};
	};

	...

	roothub_9: nxp at 9 {
		compatible = "usb15a2,007d";
		reg = <0x09>;
	};
};

-- 

Best Regards,
Peter Chen
