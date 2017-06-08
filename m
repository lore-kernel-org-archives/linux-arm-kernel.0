From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 8 Jun 2017 17:06:44 +0100
Subject: [PATCH] mm: vmalloc: simplify vread/vwrite to use existing
 mappings
In-Reply-To: <20170607182052.31447-1-ard.biesheuvel@linaro.org>
References: <20170607182052.31447-1-ard.biesheuvel@linaro.org>
Message-ID: <20170608160644.GM4902@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 07, 2017 at 06:20:52PM +0000, Ard Biesheuvel wrote:
> The current safe path iterates over each mapping page by page, and
> kmap()'s each one individually, which is expensive and unnecessary.
> Instead, let's use kern_addr_valid() to establish on a per-VMA basis
> whether we may safely derefence them, and do so via its mapping in
> the VMALLOC region. This can be done safely due to the fact that we
> are holding the vmap_area_lock spinlock.

This doesn't sound correct if you look at the definition of
kern_addr_valid().  For example, x86-32 has:

/*
 * kern_addr_valid() is (1) for FLATMEM and (0) for
 * SPARSEMEM and DISCONTIGMEM
 */
#ifdef CONFIG_FLATMEM
#define kern_addr_valid(addr)   (1)
#else
#define kern_addr_valid(kaddr)  (0)
#endif

The majority of architectures simply do:

#define kern_addr_valid(addr)   (1)

So, the result is that on the majority of architectures, we're now
going to simply dereference 'addr' with very little in the way of
checks.

I think this makes these functions racy - the point at which the
entry is placed onto the vmalloc list is quite different from the
point where the page table entries for it are populated (which
happens with the lock dropped.)  So, I think this is asking for
an oops.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
