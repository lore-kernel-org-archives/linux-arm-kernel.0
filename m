From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 19 Nov 2015 15:17:28 +0000
Subject: Executable mapping of on-chip registers through /dev/mem?
In-Reply-To: <564CC192.1000907@gmail.com>
References: <564CC192.1000907@gmail.com>
Message-ID: <20151119151728.GZ8644@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 18, 2015 at 10:21:06AM -0800, Florian Fainelli wrote:
> It turns out, that we can re-create that condition just that by opening
> /dev/mem and calling mmap() with PROT_EXEC, giving the physical base
> address of the register range (0xF000_0000 typically on these
> platforms), and a mapping size which spans the entire register range
> (32MB), although smaller mapping size also exhibit the problem, just a
> little slower.

There's two ways of looking at this:
1. the kernel should protect against it and prevent you creating an
   executable /dev/mem mapping
2. only root can create these mappings (provided the permissions are
   set sanely on /dev/mem) and this is just another way for root to
   hang themselves.

Someone may have valid reasons to be able to open /dev/mem, map it
executable, and execute code there - for example, an expansion ROM,
some platform specific code, etc.  So I'd be very nervous about
changing the behaviour and causing userspace regressions.

In my mind, it's a case of "if it hurts when I do X then don't do X".

> Tracing through the calls from drivers/char/mem.c, we have this:
> 
> drivers/char/mem.c:
> mmap_mem()
> 	ARM does define __HAVE_PHYS_MEM_ACCESS_PROT and we have
> CONFIG_MEM_DMA_BUFFERABLE=y for our V7 builds here
> 
> arch/arm/mm/mmu.c:
> 	-> phys_mem_access_prot()
> 		-> !pfn_valid(pfn) is true
> 			-> pgprot_uncached()
> 
> If I do change the pgprot value to also include the XN bit, this problem
> never occurs, because we satisfy the piece of hardware checking for the
> executable bit (or lack, thereof) in the mapping.

Yes, but you're changing the permissions that _any_ pgprot_uncached()
mapping gets to be different from what the user requested.  At best,
if we're saying we want to deny executable mappings of /dev/mem, we
should return an error if userspace tries to request such a mapping.

However, there's an issue here which is not obvious: when you don't
have an XN bit, then the kernel has assumptions that when you request
read but without execute permission, you'll end up with read _and_
execute permission.  In other words, on older CPUs, even if you
request in userspace a PROT_READ mapping, the kernel will silently
translate that to PROT_READ | PROT_EXEC internally.  So denying a
PROT_EXEC mapping will result in /dev/mem being useless on older CPUs
as you'd never be able to create any mapping of it.

> What is is not really clear to me, is whether we are creating a new
> mapping of this 32MB register range on this SoC, with an uncached
> mapping + executable bit set, or we are modifying the existing mapping
> in that case?

You're creating a new mapping in the userspace address range, it's not
a new mapping in kernel space.

> - having a better way to determine if the pfn falls within existing
> register mappings? But without a map_io() or putting that information in
> Device Tree, how am I sure this is an exhaustive range?

Is there really some problem with having userspace avoid using
PROT_EXEC when mapping /dev/mem, which all round seems to be the
correct solution here ?

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
