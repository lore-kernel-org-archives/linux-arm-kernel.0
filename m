From: kirill@shutemov.name (Kirill A. Shutemov)
Date: Sat, 10 Jan 2015 02:35:40 +0200
Subject: Linux 3.19-rc3
In-Reply-To: <20150109232707.GA6325@e104818-lin.cambridge.arm.com>
References: <CA+55aFwsxoyLb9OWMSCL3doe_cz_EQtKsEFCyPUYn_T87pbz0A@mail.gmail.com>
 <54AE7D53.2020305@redhat.com>
 <20150108134520.GC14200@e104818-lin.cambridge.arm.com>
 <54AEBE84.6090307@redhat.com>
 <20150108173408.GF17290@e104818-lin.cambridge.arm.com>
 <54AED10C.7090305@redhat.com>
 <CA+55aFwpwkjRnTzBe2K0y+2DOH1F=5SpJkYe=P5z8ps5_1PQHQ@mail.gmail.com>
 <20150109232707.GA6325@e104818-lin.cambridge.arm.com>
Message-ID: <20150110003540.GA32037@node.dhcp.inet.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 09, 2015 at 11:27:07PM +0000, Catalin Marinas wrote:
> On Thu, Jan 08, 2015 at 07:21:02PM +0000, Linus Torvalds wrote:
> > The only excuse for 64kB pages is "my hardware TLB is complete crap,
> > and I have very specialized server-only loads".
> 
> I would make a slight correction: s/and/or/.
> 
> I agree that for a general purpose system (and even systems like web
> hosting servers), 64KB is overkill; 16KB may be a better compromise.
> 
> There are however some specialised loads that benefit from this. The
> main example here is virtualisation where if both guest and host use 4
> levels of page tables each (that's what you may get with 4KB pages on
> arm64), a full TLB miss in both stages of translation (the ARM
> terminology for nested page tables) needs up to _24_ memory accesses
> (though cached). Of course, once the TLB warms up, there will be much
> less but for new mmaps you always get some misses.
> 
> With 64KB pages (in the host usually), you can reduce the page table
> levels to three or two (the latter for 42-bit VA) or you could even
> couple this with some insanely huge pages (512MB, the next up from 64KB)
> to decrease the number of levels further.
> 
> I see three main advantages: the usual reduced TLB pressure (which
> arguably can be solved with bigger TLBs), less TLB misses and, pretty
> important with virtualisation, the cost of the TLB miss due to a reduced
> number of levels. But that's for the user to balance the advantages and
> disadvantages you already mentioned based on the planned workload (e.g.
> host configured with 64KB pages while guests use 4KB).
> 
> Another aspect on ARM is the TLB flushing on (large) MP systems. With a
> larger page size, we reduce the number of TLB operation (in-hardware)
> broadcasting between CPUs (we could use non-broadcasting ops and IPIs,
> not sure they are any faster though).

With bigger page size there's also reduction in number of entities to
handle by kernel: less memory occupied by struct pages, fewer pages on
lru, etc.

Managing a lot of memory (TiB scale) with 4k chunks is just insane.
We will need to find a way to cluster memory together to manage it
reasonably. Whether it bigger base page size or some other mechanism.
Maybe THP? ;)

-- 
 Kirill A. Shutemov
