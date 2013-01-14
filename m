From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 14 Jan 2013 13:07:07 +0000
Subject: [PATCH v5 02/14] ARM: Section based HYP idmap
In-Reply-To: <20130114110756.GA10209@redhat.com>
References: <20130108183811.46302.58543.stgit@ubuntu>
 <20130108183848.46302.77369.stgit@ubuntu> <20130114102721.GB4751@redhat.com>
 <20130114104952.GA4939@mudshark.cambridge.arm.com>
 <20130114110756.GA10209@redhat.com>
Message-ID: <20130114130707.GA23505@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 14, 2013 at 01:07:56PM +0200, Gleb Natapov wrote:
> Ah, of course. This is ident map so by definition it cannot map phys
> addresses above 4G. And since __virt_to_phys() suppose to work only on
> ident map it's OK to returns unsigned long.

Let's get this right... the lack of correct definition in these
comments needs correction.

Firstly, __virt_to_phys() is an ARM-arch private function.  Only
ARM-arch private code should be using it - it must not be used outside
that context.

Secondly, it's "public" counterpart, virt_to_phys(), and itself are
valid _only_ for what we call the "kernel direct map", which are the
addresses corresponding with the lowmem pages mapped from PAGE_OFFSET
up to the _start_ of vmalloc space.  No other mapping is valid for this.

That means that addresses in the identity mapping, if the identity
mapping is outside of the range {PAGE_OFFSET..vmalloc start}, are _not_
valid for virt_to_phys().

The same is true of their counterparts, __phys_to_virt() and
phys_to_virt().  These are _only_ valid for physical addresses
corresponding to the pages mapped in as "lowmem" and they will return
addresses for that mapping of the pages.

Both these functions are invalid when used on highmem pages.
*virt_to_phys() is invalid when used on pointers returned from
ioremap(), vmalloc(), vmap(), dma_alloc_coherent(), and any other
interface which remaps memory.
