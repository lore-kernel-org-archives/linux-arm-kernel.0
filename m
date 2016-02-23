From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 23 Feb 2016 11:58:35 +0000
Subject: [RFC PATCH 1/2] memremap: add arch specific hook for MEMREMAP_WB
 mappings
In-Reply-To: <CAKv+Gu9gwnuu7hnYpjv7ozuKYmC8ApMakSJmYvQMaevNEd5zvA@mail.gmail.com>
References: <1456149728-16706-1-git-send-email-ard.biesheuvel@linaro.org>
 <1456149728-16706-2-git-send-email-ard.biesheuvel@linaro.org>
 <CAPcyv4ivN9c8PHBR77vd36ovB28OETJUr6VYf_8gNtXgqEmATw@mail.gmail.com>
 <CAKv+Gu9OWVgo+Qm85jPjY7xJ1UELm-4LYORHKF8Yy+_HuzmtGw@mail.gmail.com>
 <20160222200227.GF19428@n2100.arm.linux.org.uk>
 <CAKv+Gu9gwnuu7hnYpjv7ozuKYmC8ApMakSJmYvQMaevNEd5zvA@mail.gmail.com>
Message-ID: <20160223115835.GI19428@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 22, 2016 at 09:35:24PM +0100, Ard Biesheuvel wrote:
> OK, thanks for the historical context.
> 
> So what is your opinion on this series, i.e., to wire up memremap() to
> remap arbitrary memory regions into the vmalloc area with MT_MEMORY_RW
> attributes, and at the same time lift the restriction that the region
> must be disjoint from memory covered by lowmem or kmap?

The historical context is still present, because pxa2xx-flash has
been converted to use memremap() from ioremap_cache() - possibly
inappropriately.

I've already described the semantics of ioremap_cache(), which are
to always create a cacheable mapping irrespective of the system
memory mapping type.  However, memremap() says that MEMREMAP_WB
matches system RAM, which on ARM it doesn't right now.

Changing it to MT_MEMORY_RW would satisfy that comment against
memremap(), but at the same time changes what happens with
pxa2xx-flash - the memory region (which is not system RAM) then
changes with the cache status of system RAM.

So, I'm not that happy about the memremap() stuff right now, and
I don't like the idea of making memremap() conform to its stated
requirements without first preventing pxa2xx-flash being affected
by such a change.

Perhaps we need to reinstate the original ioremap_cached() API for
pxa2xx-flash, and then switch memremap() to MT_MEMORY_RW - that
would seem to result in the expected behaviour by all parties.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
