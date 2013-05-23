From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Thu, 23 May 2013 11:27:54 -0600
Subject: [PATCH 0/9] Switch internal registers address to 0xF1 on Armada
 370/XP
In-Reply-To: <20130523115321.660fa521@skate>
References: <201305221633.46705.arnd@arndb.de> <20130522170643.54a2b9d2@skate>
 <201305221735.11815.arnd@arndb.de> <20130522180842.7edcc3ee@skate>
 <20130522163557.GC27348@1wt.eu> <20130522184250.1d5f2f10@skate>
 <20130522164936.GE31290@titan.lakedaemon.net>
 <20130522185757.60091a66@skate>
 <20130522181953.GD12320@obsidianresearch.com>
 <20130523115321.660fa521@skate>
Message-ID: <20130523172754.GA2821@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 23, 2013 at 11:53:21AM +0200, Thomas Petazzoni wrote:

> This is not a problem, because the MBus Bridge Window {Base,Control}
> Register tell the CPU that memory accesses between addresses X and Y
> are for MBus windows, and the other accesses are for the DRAM.

Okay, I see, you are minimizing the size of the memory hole, sounds
good.

> > You can combine this idea with the CP15 signalling mechanism. Check
> > CP15 and use it to alter the DTB, similar to how ATAGs are used to
> > fixup the DTB. Don't relocate the registers.
> 
> Where would the code doing this would sit? Remember, this is a
> temporary solution that we want to get rid of after some time. So I've
> been very careful in this proposal to only touch mvebu-specific code.

Well, there are three elements here:
 1) Remove ARMADA_370_XP_REGS_PHYS_BASE and related (looks nearly done now)
 2) Adjust the FDT/DT before it is used based on CP15
 3) Support early printk

#1 looks like it is done when the mbus driver is merged, ie
   we will soon have full dynamic support for the internal regs base
#2 can be done in the machine's init_early, nothing will touch
   internal regs prior to init_early
#3 is for expert use, so the rules can be a bit different:
   - Patch the XP/370 specific early printk code to look in CP15
     to compute the base address
   - .. or rely on a CONFIG_XXX to set the serial base address
   - .. or parse the FDT to find the serial port, requiring
     that the developer has made the FDT match the bootloader.

So, I'm not sure what common code would need to be touched, do you see
something else?

Jason
