From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 6 Dec 2010 15:21:20 +0100
Subject: [RFC PATCH 06/18] ARM: LPAE: Introduce the 3-level page table
	format definitions
In-Reply-To: <AANLkTimEdNj71v-oiKKho27DWcZbxOWtO6M4eLg2NDRE@mail.gmail.com>
References: <20101025085812.25275.55757.stgit@e102109-lin.cambridge.arm.com>
	<201010252025.24128.arnd@arndb.de>
	<AANLkTimEdNj71v-oiKKho27DWcZbxOWtO6M4eLg2NDRE@mail.gmail.com>
Message-ID: <201012061521.20346.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 06 December 2010, Christoffer Dall wrote:
> Sorry for jumping in here at such a late hour...
> >
> >> > Are there any significant differences to Linux between setting up page
> >> > tables for a 32 bit VA space or a 40 bit IPA space, other than the
> >> > size of the PGD?
> >>
> >> ...
> >>
> >> If KVM would reuse the existing pgd/pmd/pte Linux macros, it would
> >> indeed be restricted to 32-bit IPA (sizeof(long)). You may need to
> >> define different macros to use either a pfn or long long as address
> >> input.
> 
> I'm not even sure it would be a big advantage to re-use the macros for
> KVM. Sure, creating separate macros may duplicate some bit-shifting
> logic, but my guess is that code will be easier to read if using
> separate macros for the 2-nd stage translation in KVM. One might also
> imagine specific virtualization-oriented bits which could be
> explicitly names or directly targeted in macros that don't have to
> handle both standard non-virt tables and 2-nd stage translation
> tables.
> 
> At least from my experience writing KVM code, it's difficult enough to
> make it clear to anyone reading the code which address space exactly
> is being referenced at which time.

Good point. My thoughts were that we basically treat KVM guests as
processes with 40 bit virtual address space though, so the kernel
would be using them directly.

> So this depends on what the use would be. True, if you wanted a guest
> that used more than 4GB of memory AND you wanted QEMU to be able to
> readily access all of that, then yes, it would be difficult on a
> 32-bit architecture.
> 
> But QEMU doesn't really use the mmap'ed areas backing physical memory
> for anything - it's merely a way of telling KVM how much physical
> memory should be given to the guest, and the kernel side conveniently
> uses get_user_pages() to access that memory. Instead, QEMU could
> simply call an IOCTL to KVM telling it something like
> register_user_memory(long long base_phys_addr, long long size); and
> KVM could just allocate physical pages to back that without them being
> mapped on the host side. An individual page could be mapped in as
> needed for emulation and mapped out again. I don't see a huge
> performance hit for such a solution.

Ok.
 
> But as you both suggest, 32-bit physical address space is probably
> going to be more than needed for initial uses of ARM virtual machines.

Right. Note that as long as we keep the guest mapped into the qemu
address space, we're limited to something between 0.5 and 3 GB of 
guest physical address space, but even that is likely enough for the
near future.

	Arnd
