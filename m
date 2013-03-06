From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Wed, 6 Mar 2013 16:04:12 -0700
Subject: [PATCH 04/10] bus: introduce an Marvell EBU MBus driver
In-Reply-To: <20130306222712.GP23237@titan.lakedaemon.net>
References: <1362577426-12804-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1362577426-12804-5-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130306190821.GA4689@obsidianresearch.com>
 <20130306202710.15a6aa2c@skate>
 <20130306202447.GA4916@obsidianresearch.com>
 <20130306214036.62fc93b9@skate>
 <20130306215031.GB4916@obsidianresearch.com>
 <20130306222712.GP23237@titan.lakedaemon.net>
Message-ID: <20130306230412.GA5870@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 06, 2013 at 05:27:12PM -0500, Jason Cooper wrote:
> On Wed, Mar 06, 2013 at 02:50:31PM -0700, Jason Gunthorpe wrote:
> > On Wed, Mar 06, 2013 at 09:40:36PM +0100, Thomas Petazzoni wrote:
> ...
> > > Again, I don't see the point of making the DT binding more complex than
> > > the one being proposed here, and you haven't given any really
> > > compelling arguments except that it is not to your taste. I believe
> > > we're reaching a point where things start to be a matter of taste, and
> > > so unless you're writing the code and doing the work yourself, you also
> > > have to accept that other people might have different visions of how
> > > things should be handled, and therefore have different tastes.
> > > 
> > > How can we make progress on this, in a *reasonable* way?
> > 
> > Well, as you say, we've pretty much completed presenting arguments for
> > each view on this subject, so it is really up to the gatekeepers of
> > the stable DT 'ABI' to decide on how they want this all to look in the
> > end, IMHO.
> > 
> > Jason C/Andrew L/Arnd?
> 
> I'm inclined to agree with Thomas.  Since the the first Kirkwood DT
> board was added to the tree, it's been pounded into me that DT
> *describes hardware*.  Not how random bootloader X happened to configure
> it.

I'm not sure this is what we are discussing, certainly it isn't what I
was talking about...

The discussion was around the SOC specific tables in the driver and if
they should be in DT or C code. These tables very much describe the
hardware, and are copied from similar tables in the Marvell manuals.

For instance I repeated this idea:

   ranges =<MAPDEF(1, 0xe0, MAPDEF_NOMASK)  0xFE000000  0x10000 // boot rom
            MAPDEF(1, 0x3f, MAPDEF_NOMASK)  0xFD000000  0x10000 // devbus-boot
            MAPDEF(1, 0xxx, MAPDEF_NOMASK)  0xFF000000  0x10000 // internal-regs
             [..]

At the stanza of MBUS driver's bus. Each line represents a MBUS target
(this is a physical HW IP block). The MAPDEF is a SOC specific 'target
id' that is currently living in tables in the driver. This value is
directly compatible with the mbus window register and is defined by
Marvell. The 2nd number is the CPU base address of that window, and
the last is the size.

Per OF conventions the base address should be the value the bootloader
left it at - but that is not important, the value could be 0. A
dynamic MBUS driver would go through each item in the ranges, find
an address range and program a window with the MAPDEF from the DT. It
would then write the base address back into the DT (at runtime!) so
that the entire DT remains conistent with the current state of the
hardware.

An initial implementation without dynamic address allocation would
just have the mbus driver directly use the 2nd value as the base
address.

The attraction to this model is that the association of later DT
stanza's to MBUS targets is extremely clear:

       nor@0 {
          compatible = 'linux mtd nor driver';
          regs = <MAPDEF(1, 0xab, MAPDEF_NOMASK) 0x10000>;
      }

We can now tell directly that 'linux mtd nor driver' is behind MBUS
target 0xab, and the OF code already knows the base for this MBUS
target from the ranges property, as modified by the MBUS driver. The
MBUS driver also knows which targets to configure windows for
immediately at boot without having to consult internal tables. Plus we
don't need to modify the NOR driver to call out to MBUS window
functions to fetch an address.

There are a few other variants on how to do this in DT, but they all
come down to modeling the MBUS target using a ranges property and
having the mbus driver adjust the range mapping at runtime.

> At this point, we have at least a few release cycles to shake out a
> standard DT binding for Marvell SoCs.  Currently, not a single product
> ships with a DT-enabled bootloader.  Not even the development boards
> created by Marvell.  So I'm fine with Thomas' bindings as they stand
> *and* fine with adjusting them over the next few releases as needed.

I think this is a fine idea. Thomas's driver is a much better starting
place to do stuff like the above!

Regards,
Jason
