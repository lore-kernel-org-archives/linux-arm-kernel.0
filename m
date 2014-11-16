From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 16 Nov 2014 16:52:11 +0000
Subject: some question about TCR setting
In-Reply-To: <CAOVJa8GB=pk4SFEArcEGWF8g12105F_9YUL0hH5k+WW6=WWOBg@mail.gmail.com>
References: <CAOVJa8HBYkTMCJFKC=+UwjgPp4odm5UV-oUQXu17ctv2+HkpRg@mail.gmail.com>
 <20141114104246.GA25828@leverpostej>
 <CAOVJa8Fx4yiSU0O7HTaYEKOrRdtWve4JGeN0cWRXDsBMyV_8Mg@mail.gmail.com>
 <20141114135531.GA27768@leverpostej>
 <CAOVJa8GB=pk4SFEArcEGWF8g12105F_9YUL0hH5k+WW6=WWOBg@mail.gmail.com>
Message-ID: <20141116165211.GL4042@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 16, 2014 at 06:53:57PM +0800, vichy wrote:
> hi Mark:
> 
> > Consider CONFIG_HIGHPTE. The physical address space can be larger than
> > the virtual address space, in which case not everything can be
> > permanently mapped.
> if those page tables are not mapped into the virtual address space,
> how OS create them?
> (AFAIK, once System.M is enabled, the processor cannot access where
> page table doesn't map to)
> except those page tables are created before System.M enabled.

The OS temporarily maps the page tables into virtual space to update
them.  Once updated, the OS unmaps the page tables.

However, forget this detail - the MMU page table walker knows nothing
about the virtual address space: MMU page table walks do not happen in
the virtual address space, they happen in the physical address space.
So, it makes no odds what so ever whether the table is mapped or not.

> BTW, why we need to set page table walk attribute as sharable and
> inner/outer cacheable?

The access type is included on the bus along with the address and other
attributes.  This includes whether it's sharable, and the cache attributes.
A MMU page walker may be implemented such that it is capable of accessing
L2 cache.

In that case, we would want the MMU page walker to be able to read from
the L2 cache, which would need the access to be marked as "normal memory,
cacheable" so that the cache is searched for a matching line.  This in
turn means that software does not have to flush page table updates all
the way back to the physical memory - merely flushing them out of the L1
cache is sufficient.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
