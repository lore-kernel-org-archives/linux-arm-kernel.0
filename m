From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Tue, 18 Feb 2014 11:59:47 -0700
Subject: [PATCH v3 3/3] PCI: ARM: add support for generic PCI host
 controller
In-Reply-To: <20140218184420.GD2010@mudshark.cambridge.arm.com>
References: <1392726043-31088-1-git-send-email-will.deacon@arm.com>
 <1392726043-31088-4-git-send-email-will.deacon@arm.com>
 <20140218182142.GF29304@obsidianresearch.com>
 <20140218184420.GD2010@mudshark.cambridge.arm.com>
Message-ID: <20140218185947.GA22340@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 18, 2014 at 06:44:20PM +0000, Will Deacon wrote:
> On Tue, Feb 18, 2014 at 06:21:42PM +0000, Jason Gunthorpe wrote:
> > On Tue, Feb 18, 2014 at 12:20:43PM +0000, Will Deacon wrote:
> > > +
> > > +    // BUS_ADDRESS(3)  CPU_PHYSICAL(2)  SIZE(2)
> > > +    ranges = <0x1000000 0x0 0x00000000  0x0 0x00000000  0x0 0x00010000>,
> >                                            ^^^^^^^^^^^^^^
> > 
> > This probably shouldn't be 0 in the example, nor in your kvm tool
> > output. For example purposes any value will do.
> 
> Hmm, so kvmtool actually provides a PC ioport at 0x0, which is handy since
> there's an 8250 down there. That means we have:
> 
> 0x0    - 0x6200  : Weird PC stuff
> 0x6200 - 0x10000 : PCI IO space
> 
> Should I just change everything to be offset by 0x6200?

Just to be clear, kvm has reserved the first 64k of physical address
space for this IO window? The 0 is fine then, but it isn't typical of
real hardware.

Regarding the 0x6200.. There are two conflicting issues there :(
 - You really don't want to let the PCI core assign resources to that
   range, it probably won't work.
 - You probably need that range mapped into the ARM IO window, and the
   PCI driver is the thing doing that

The PCI core already has a black out for low IO ports, I think it
already covers the usual PC suspects so you are probably fine with
what you have for KVM.

Jason
