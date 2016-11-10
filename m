From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Thu, 10 Nov 2016 09:45:48 -0700
Subject: [PATCH] PCI: mvebu: Take control of mbus windows setup by the
 firmware
In-Reply-To: <20161110093037.376ae79d@free-electrons.com>
References: <20161026174440.GA24717@obsidianresearch.com>
 <20161110093037.376ae79d@free-electrons.com>
Message-ID: <20161110164548.GC22004@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 10, 2016 at 09:30:37AM +0100, Thomas Petazzoni wrote:
> Hello,
> 
> On Wed, 26 Oct 2016 11:44:40 -0600, Jason Gunthorpe wrote:
> > The firmware may setup the mbus to access PCI-E and indicate this
> > has happened with a ranges mapping for the PCI-E ID. If this happens
> > then the mbus setup and the pci dynamic setup conflict, creating
> > problems.
> > 
> > Have PCI-E assume control of the firmware specified default mapping by
> > setting the value of the bridge window to match the firmware mapping.
> > 
> > Signed-off-by: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
> 
> Sorry for the late feedback. I am not sure to fully understand what you
> are trying to do here.

> However, one thing that confuses me specifically is how can the kernel
> get any MBus mapping set up by the firmware? Indeed, when the
> mvebu-mbus driver initializes, it destroys all existing MBus windows
> that might have been left by the firmware/bootloader:

Sort of, yes, it wipes out the hardware, but then it parses the DT
and puts back the ranges via mbus_dt_setup.

The issue is what happens if mbus_dt_setup adds a mapping for PCI
aperature from the firmware's DT - in this case the PCI driver does not
know that the mbus driver created the mapping and becomes unable to
manipulate the mbus windows due to the conflict detection logic.

The solution is to have the PCI driver read the current state of the
mbus window - out of the mbus registers that were programmed from the
DT ranges by mbus_dt_setup. Then it knows to delete the DT described
window before setting a new window and the conflicts are avoided.

> Why does Linux needs to rely on what the firmware has setup in terms of
> MBus windows? Why can't Linux just find out the right BAR base/size
> like it is doing for all other devices?

Unfortunately that is sort of how DT is expected to work, in my case I
have DT sub nodes off the PCI device in DT and I need DT address
translation to work for those nodes.

In DT land the PCI stuff expects the firmware to provide a complete
address map, and my firmware does, but in doing so I hit this bug :)

Jason
