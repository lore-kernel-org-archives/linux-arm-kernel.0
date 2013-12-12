From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 12 Dec 2013 18:02:50 +0000
Subject: [PATCH] arm64: Correct virt_addr_valid
In-Reply-To: <20131212175753.GG3382@arm.com>
References: <1386724982-16997-1-git-send-email-lauraa@codeaurora.org>
 <1386724982-16997-2-git-send-email-lauraa@codeaurora.org>
 <20131211104429.GE26730@mudshark.cambridge.arm.com>
 <20131211110618.GG4360@n2100.arm.linux.org.uk>
 <20131211172635.GJ26730@mudshark.cambridge.arm.com>
 <20131211211333.GI4360@n2100.arm.linux.org.uk>
 <20131212175753.GG3382@arm.com>
Message-ID: <20131212180249.GV4360@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 12, 2013 at 05:57:54PM +0000, Catalin Marinas wrote:
> On Wed, Dec 11, 2013 at 09:13:33PM +0000, Russell King - ARM Linux wrote:
> > There is actually a concern here, and that's if the v:p translation isn't
> > linear, could it return false results?
> > 
> > According to my grep skills, we have one platform where this is true -
> > Realview:
> > 
> >  * 256MB @ 0x00000000 -> PAGE_OFFSET
> >  * 512MB @ 0x20000000 -> PAGE_OFFSET + 0x10000000
> >  * 256MB @ 0x80000000 -> PAGE_OFFSET + 0x30000000
> > 
> > The v:p translation is done via:
> > 
> >          ((virt) >= PAGE_OFFSET2 ? (virt) - PAGE_OFFSET2 + 0x80000000 : \
> >           (virt) >= PAGE_OFFSET1 ? (virt) - PAGE_OFFSET1 + 0x20000000 : \
> >           (virt) - PAGE_OFFSET)
> > 
> > Now the questions - what do values below PAGE_OFFSET give us?  Very
> > large numbers, which pfn_valid() should return false for.  What about
> > values > PAGE_OFFSET2 + 256MB?  The same.
> > 
> > So this all _looks_ fine.  Wait a moment, what about highmem?  Let's say
> > that the last 256MB is only available as highmem, and let's go back to
> > Laura's patch:
> > 
> > old:
> > #define	virt_addr_valid(kaddr)	(((void *)(kaddr) >= (void *)PAGE_OFFSET) && \
> > 				 ((void *)(kaddr) < (void *)high_memory))
> > new:
> > #define	virt_addr_valid(kaddr)	pfn_valid(__pa(kaddr) >> PAGE_SHIFT)
> > 
> > The former _excludes_ highmem, but the latter _includes_ it.
> > 
> > virt_addr_valid(v) should only ever return _true_ for the lowmem area,
> > never anywhere else - that's part of its point.  It's there to answer
> > the question "is this a valid virtual pointer which I can dereference".
> > 
> > So... We actually need a combination of both of these tests.
> 
> Just to avoid any confusion, on arm64 we don't have non-linear v:p
> translation as there is plenty of VA space to live with holes. So the
> original patch is fine.

The point I make above actually has nothing to do with non-linear v:p
translations.
