From: stephen.neuendorffer@xilinx.com (Stephen Neuendorffer)
Date: Mon, 23 May 2011 08:00:15 -0700
Subject: [PATCH 2/2] drivers/amba: probe via device tree
In-Reply-To: <20110521233558.GA17672@n2100.arm.linux.org.uk>
References: <1305829704-11774-1-git-send-email-robherring2@gmail.com>
	<20110519233958.GB18181@ponder.secretlab.ca>
	<4DD66B8A.5040404@gmail.com> <201105201621.03801.arnd@arndb.de>
	<4DD68614.6090209@gmail.com>
	<a42f0c27-2811-4b68-bedf-7dfaa7bff6ff@VA3EHSMHS025.ehs.local>
	<20110521233558.GA17672@n2100.arm.linux.org.uk>
Message-ID: <1007bcf2-7786-4f03-bff7-8d8af83939f1@VA3EHSMHS019.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Russell King - ARM Linux [mailto:linux at arm.linux.org.uk]
> Sent: Saturday, May 21, 2011 4:36 PM
> To: Stephen Neuendorffer
> Cc: Rob Herring; Arnd Bergmann; devicetree-discuss at lists.ozlabs.org;
Jeremy Kerr; linux-arm-
> kernel at lists.infradead.org
> Subject: Re: [PATCH 2/2] drivers/amba: probe via device tree
> 
> On Fri, May 20, 2011 at 09:08:17AM -0700, Stephen Neuendorffer wrote:
> > > That is how it is currently, but the reality is that I only have 1
bus
> > > with both ARM Primecell peripherals and other peripherals which
are
> > > standard platform bus devices. i2c-designware is one example. It
is on
> > > the APB just like the pl011 uart. So do you propose I create a
amba
> > > driver for it? It has no peripheral ID registers, so that may not
even
> > work.
> >
> > Same here.  I don't know what the right solution for it is, but I
find
> > amba_bus
> > solution to get in the way more than help.  I had to hack the
etm/etb
> > driver
> > and the amba_bus to shreds to get it to work for me at all.
> 
> Well then you're doing something totally wrong then.  All you need to
> do to get an amba_device working is provide an apb_clk as a dummy
clock
> if you have no control over it, and declare an amba_device structure
> with the relevant physical base addresses and irq.  There's no need to
> hack anything "to shreds" to get it work work - there's nothing
platform
> specific in drivers/bus/amba.c.
> 
> That is proven by it being used on several ARM dev platforms and
several
> ST Ericsson SoCs - and it's actually ST Ericsson driving the addition
of
> the various new features to the bus level of AMBA.
> 
> So I think you're doing something wrong, rather than there being
anything
> wrong with the code.

To be specific (whether this is 'to shreds' or not, you can decide).

1. amba_bus expects the old ARM primcell ID. The one in the new A9 IP
appears to be different. (b105900d instead of b105f00d)

2. Not only does amba_bus reference apb_pclk, but the driver directly
references emu_src_clk. Neither of these has direct analogs on our
hardware.

3. Implementing the workaround for 2 that you've described requires a
dummy implementation of the 'standard' clock stuff, which is currently
not implemented by mach-xilinx, because we simply haven't needed it. 
Is the right solution here to add more machine-specific code?

4. etm is old, we have ptm and other custom cores, but the driver
combines the etm and etb functionality together. 

OK, some of this is trivial to fix, but some of it isn't.

At this point, I've sortof come full circle.  Since the mainline driver
doesn't solve the problem anyway, we'll probably just look at driving
the
trace hardware from userspace for the moment, until we figure out what
should be exported from a kernelspace driver.

I'm very intrigued by the OMAP strategy that uses platform_bus.  When I
get to return to this, I'll have to look into it in more depth.

Steve



This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.
