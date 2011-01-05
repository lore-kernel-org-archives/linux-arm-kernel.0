From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 5 Jan 2011 21:04:48 +0000
Subject: still nfs problems [Was: Linux 2.6.37-rc8]
In-Reply-To: <AANLkTimzzBsdtWcZtP5E_CH1hUZugGMoaHOiMdQJf764@mail.gmail.com>
References: <1294254337.16957.13.camel@mulgrave.site>
	<AANLkTi=VZUxNFd7n-qwf5aiOeK5rkk8qBmo+kOpgg7up@mail.gmail.com>
	<1294256169.16957.18.camel@mulgrave.site>
	<20110105200008.GJ8638@n2100.arm.linux.org.uk>
	<1294259637.16957.25.camel@mulgrave.site>
	<AANLkTimzzBsdtWcZtP5E_CH1hUZugGMoaHOiMdQJf764@mail.gmail.com>
Message-ID: <20110105210448.GM8638@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 05, 2011 at 12:48:32PM -0800, Linus Torvalds wrote:
> (You can also force the problem with vmalloc() an then following the
> kernel page tables, but I hope nobody does that any more. I suspect
> I'm wrong, though, there's probably code that mixes vmalloc and
> physical page accesses in various drivers)

Should vmalloc_to_page() (84 users)/vmalloc_to_pfn() (17 users) be
deprecated then? ;)

However, we seem have new ways of doing this - rather than asking
vmalloc() for some memory, and then getting at the pages by following
the page tables, we now have ways to create mappings using arrays of
struct pages and access them via their already known mappings:

- vm_map_ram(struct page **pages, unsigned int count, int node, pgprot_t prot)
- map_kernel_range_noflush(unsigned long addr, unsigned long size, pgprot_t prot, struct page **pages)
- map_vm_area(struct vm_struct *area, pgprot_t prot, struct page ***pages)
- vmap(struct page **pages, unsigned int count, unsigned long flags, pgprot_t prot)

So really it's the same problem, just created by some other easier
to use methods.
