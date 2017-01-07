From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Sat, 7 Jan 2017 18:24:15 +0000
Subject: [PATCH WIP 4/4] ARM: remove compile time vector base for CP15 case
In-Reply-To: <20170107180227.GA8130@afzalpc>
References: <20170107171339.GA5044@afzalpc>
 <20170107172228.6451-1-afzal.mohd.ma@gmail.com>
 <20170107173832.GN14217@n2100.armlinux.org.uk>
 <20170107180227.GA8130@afzalpc>
Message-ID: <20170107182415.GO14217@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 07, 2017 at 11:32:27PM +0530, Afzal Mohammed wrote:
> Hi,
> 
> On Sat, Jan 07, 2017 at 05:38:32PM +0000, Russell King - ARM Linux wrote:
> > On Sat, Jan 07, 2017 at 10:52:28PM +0530, afzal mohammed wrote:
> 
> > > TODO:
> > > Kill off VECTORS_BASE completely - this would require to handle MMU
> > >  case as well as ARM_MPU scenario dynamically.
> 
> > Why do you think MMU doesn't already handle it?
> 
> i meant here w.r.t displaying vector base address in
> arch/arm/mm/init.c, i.e. dynamically get it based on Hivecs setting as
> either 0xffff0000 or 0x00000000

You mean:

        pr_notice("Virtual kernel memory layout:\n"
                        "    vector  : 0x%08lx - 0x%08lx   (%4ld kB)\n"
...
                        MLK(UL(CONFIG_VECTORS_BASE), UL(CONFIG_VECTORS_BASE) +
                                (PAGE_SIZE)),

As I've said, CONFIG_VECTORS_BASE is _always_ 0xffff0000 on MMU, so
this always displays 0xffff0000 - 0xffff1000 here.

> i had thought that for MMU case if Hivecs is not enabled,
> CONFIG_VECTOR_BASE has to be considered as 0x00000000 at least for the
> purpose of displaying exception base address.
> 
> One thing i have not yet understood is how CPU can take exception with
> it base address as 0x00000000 (for Hivecs not enabled case) virtual
> address as it is below Kernel memory map.

Older ARM CPUs without the V bit (ARMv3 and early ARMv4) expect the
vectors to be at virtual address zero.

Most of these systems place ROM at physical address 0, so when the CPU
starts from reset (with the MMU off) it starts executing from ROM.  Once
the MMU is initialised, RAM can be placed there and the ROM vectors
replaced.  The side effect of this is that NULL pointer dereferences
are not always caught... of course, it makes sense that the page at
address 0 is write protected even from the kernel, so a NULL pointer
write dereference doesn't corrupt the vectors.

How we handle it in Linux is that we always map the page for the vectors
at 0xffff0000, and then only map that same page at 0x00000000 if we have
a CPU that needs it there.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
