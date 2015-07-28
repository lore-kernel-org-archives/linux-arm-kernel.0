From: will.deacon@arm.com (Will Deacon)
Date: Tue, 28 Jul 2015 09:47:40 +0100
Subject: [RFC V2] arm64:use set_fixmap_offset to make it more clear
In-Reply-To: <21A5B6D3-B813-4DC3-B392-009991B9CA00@gmail.com>
References: <A5D61263-B664-469F-9F49-160D6E17F432@gmail.com>
 <9A8FA704-5D35-404B-BEBE-C92AF25505C3@gmail.com>
 <21A5B6D3-B813-4DC3-B392-009991B9CA00@gmail.com>
Message-ID: <20150728084740.GC29209@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 28, 2015 at 07:31:20AM +0100, yalin wang wrote:
> 
> > On Jul 24, 2015, at 19:52, yalin wang <yalin.wang2010@gmail.com> wrote:
> > 
> > A little change to patch_map() function,
> > use set_fixmap_offset() to make code more clear.
> > 
> > Signed-off-by: yalin wang <yalin.wang2010@gmail.com>
> > ---
> > arch/arm64/kernel/insn.c | 5 ++---
> > 1 file changed, 2 insertions(+), 3 deletions(-)
> > 
> > diff --git a/arch/arm64/kernel/insn.c b/arch/arm64/kernel/insn.c
> > index dd9671c..f341866 100644
> > --- a/arch/arm64/kernel/insn.c
> > +++ b/arch/arm64/kernel/insn.c
> > @@ -101,9 +101,8 @@ static void __kprobes *patch_map(void *addr, int fixmap)
> > 		return addr;
> > 
> > 	BUG_ON(!page);
> > -	set_fixmap(fixmap, page_to_phys(page));
> > -
> > -	return (void *) (__fix_to_virt(fixmap) + (uintaddr & ~PAGE_MASK));
> > +	return (void *)set_fixmap_offset(fixmap, page_to_phys(page) +
> > +			(uintaddr & ~PAGE_MASK));
> > }
> > 
> > static void __kprobes patch_unmap(int fixmap)
> > -- 
> > 1.9.1
> > 
> Marinas,
> this V2 patch can build without warning even CONFIG_DEBUG_SET_MODULE_RONX enabled,
> could you review it.
> Thanks.

I queued this already for 4.3. There's a (benign) sparse warning about the
addr parameter to patch_map being overridden by the local scope of
set_fixmap_offset which could be solved with a healthy portion of
underscores in the core code.

Will
