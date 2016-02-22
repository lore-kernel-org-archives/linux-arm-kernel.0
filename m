From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 22 Feb 2016 20:02:27 +0000
Subject: [RFC PATCH 1/2] memremap: add arch specific hook for MEMREMAP_WB
 mappings
In-Reply-To: <CAKv+Gu9OWVgo+Qm85jPjY7xJ1UELm-4LYORHKF8Yy+_HuzmtGw@mail.gmail.com>
References: <1456149728-16706-1-git-send-email-ard.biesheuvel@linaro.org>
 <1456149728-16706-2-git-send-email-ard.biesheuvel@linaro.org>
 <CAPcyv4ivN9c8PHBR77vd36ovB28OETJUr6VYf_8gNtXgqEmATw@mail.gmail.com>
 <CAKv+Gu9OWVgo+Qm85jPjY7xJ1UELm-4LYORHKF8Yy+_HuzmtGw@mail.gmail.com>
Message-ID: <20160222200227.GF19428@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 22, 2016 at 08:17:11PM +0100, Ard Biesheuvel wrote:
> I am not exactly sure why ioremap_cache() does not use MT_MEMORY_RW
> attributes, but the ARM architecture simply does not allow mismatched
> attributes, so we cannot simply replace each instance of
> ioremap_cache() with memremap()
> 
> Perhaps Russell can explain?

ARM has had ioremap_cached() for a while - it was introduced in the
bitkeeper times of 2.6, so pre-git.  In those kernels, and into the
git era, pre-dating ARMv6 support, it was merely:

+#define ioremap_cached(cookie,size)    __arch_ioremap((cookie),(size),L_PTE_CACHEABLE)

which means that we got write-through cache behaviour for mappings
created by this, where supported, or if not, read-allocate writeback.
This was completely independent of the system memory mapping
attributes, which could be specified on the kernel command line.

This was originally used by pxa2xx-flash to provide faster flash
access on those systems - in other words, it's created to remap
devices with cacheable attributes.

When creating ARMv6 support, I ended up completely rewriting how
the memory attributes were handled, and so it then became this:

+#define ioremap_cached(cookie,size)    __arch_ioremap((cookie), (size), MT_DEVICE_CACHED)

which gives very similar behaviour, though we now default to RAWB
mappings, which fall back to WT on CPUs that don't support RAWB.
Again, independent of the system memory mapping.

Then, in 2013, with the advent of Xen, ioremap_cached() became
ioremap_cache() so that Xen would build on ARM, and to align it
with other architectures.  Whether ioremap_cached() actually was
suitable to become ioremap_cache(), I'm not sure, but that's
what happened.

Since it was just renamed, it preserves the original goal which is
to remap device memory with cacheable attributes, which may differ
from the cacheable attributes of the system RAM.  It has never
been intended for remapping system memory: none of the ioremap_*
family of functions on ARM were ever intended for that purpose.

However, some people did use it for that purpose on ARMv5 and
earlier architectures, where, due to the virtual cache architecture,
you could get away with remapping the same memory with differing
attributes without any problem.  With the advent of ARMv6
(pre-dating 2013), this was clearly stated as being illegal at
architecture level, but people were married to the idea - despite
me telling them not to.

So eventually, I had no other option than to add a code check to
ioremap*() which prevents any ioremap*() function from being used
on system memory - iow, memory that Linux maps itself either as
part of lowmem or via the kmap*() API - since an ioremap*()
mapping would conflict with those.

That's basically where we are today: ioremap*() does not permit
system memory to be remapped, even ioremap_cache().

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
