From: stern@rowland.harvard.edu (Alan Stern)
Date: Tue, 19 Jan 2016 10:12:56 -0500 (EST)
Subject: [PATCH v3 1/1] USB: core: let USB device know device node
In-Reply-To: <4405270.vcz87Q878u@wuerfel>
Message-ID: <Pine.LNX.4.44L0.1601191009190.1727-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 19 Jan 2016, Arnd Bergmann wrote:

> On Tuesday 19 January 2016 11:08:59 Peter Chen wrote:
> > 
> > I am afraid I have no USB 3.0 PC running Linux.
> > 
> > > > - Which the value of hub->descriptor->bNbrPorts for root hub?
> > > 
> > > In the example above, the legacy root hub would have bNbrPorts set to 6 
> > > and the SS root hub would have bNbrPorts set to 3.
> > > 
> > 
> > Ok, so the maximum physical port number is 6 as well as bNbrports value.
> > The "reg" value at dts should be from 1 to 6. "reg" stands for physical
> > port number for individual physical port, eg if "reg" equals to 1, it
> > stands for the device connects at port 1, no matter the device is HS or
> > SS, it can use the node whose "reg" is 1.
> 
> As I understand it, you could have two devices that are both
> connected to port '1', when one is using HS and the other is using
> SS. This means that we can't use the same 'reg' value for both, and
> we have to define a particular way to disambiguate them.
> 
> As Alan says, there is an established ordering that just sorts the
> ports form 1 to 9 in the example, and that would be the most
> straightforward to use here.

There is even a documented callback (find_raw_port_number) in the
hc_driver structure for converting between the numbering schemes.  I
don't know if all the existing USB-3 host controller drivers implement
that callback, but they should.

> Alternatively, you could use one of the high bits of the 'reg' value
> to indicate which root hub is used. I'm sure that would work as
> well, but be less obvious.

It's probably best to stick with the same numbering that the hardware 
uses.

Alan Stern
