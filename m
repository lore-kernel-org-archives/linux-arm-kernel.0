From: Yalin.Wang@sonymobile.com (Wang, Yalin)
Date: Tue, 16 Sep 2014 09:53:55 +0800
Subject: [PATCH] arm64:free_initrd_mem should also free the memblock
In-Reply-To: <20140915185027.GC30737@arm.com>
References: <35FD53F367049845BC99AC72306C23D103CDBFBFB029@CNBJMBX05.corpusers.net>
 <20140915183334.GA30737@arm.com>
 <20140915184023.GF12361@n2100.arm.linux.org.uk>
 <20140915185027.GC30737@arm.com>
Message-ID: <35FD53F367049845BC99AC72306C23D103D6DB49160C@CNBJMBX05.corpusers.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

The reason that a want merge this patch is that
It confuse me when I debug memory issue by 
/sys/kernel/debug/memblock/reserved  debug file,
It show lots of un-correct reserved memory.
In fact, I also send a patch to cma driver part
For this issue too:
http://ozlabs.org/~akpm/mmots/broken-out/free-the-reserved-memblock-when-free-cma-pages.patch

I want to remove these un-correct memblock parts as much as possible,
so that I can see more correct info from /sys/kernel/debug/memblock/reserved
debug file .

Thanks



-----Original Message-----

On Mon, Sep 15, 2014 at 07:40:23PM +0100, Russell King - ARM Linux wrote:
> On Mon, Sep 15, 2014 at 07:33:34PM +0100, Will Deacon wrote:
> > On Fri, Sep 12, 2014 at 11:17:18AM +0100, Wang, Yalin wrote:
> > > this patch fix the memblock statics for memblock in file 
> > > /sys/kernel/debug/memblock/reserved
> > > if we don't call memblock_free the initrd will still be marked as 
> > > reserved, even they are freed.
> > > 
> > > Signed-off-by: Yalin Wang <yalin.wang@sonymobile.com>
> > > ---
> > >  arch/arm64/mm/init.c | 4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c index 
> > > 5472c24..34605c8 100644
> > > --- a/arch/arm64/mm/init.c
> > > +++ b/arch/arm64/mm/init.c
> > > @@ -334,8 +334,10 @@ static int keep_initrd;
> > >  
> > >  void free_initrd_mem(unsigned long start, unsigned long end)  {
> > > -	if (!keep_initrd)
> > > +	if (!keep_initrd) {
> > >  		free_reserved_area((void *)start, (void *)end, 0, "initrd");
> > > +		memblock_free(__pa(start), end - start);
> > > +	}
> > 
> > I don't think it makes any technical difference, but doing the 
> > memblock_free before the free_reserved_area makes more sense to me.
> 
> A better question is... should we even be doing this.  The memblock 
> information is used as a method to bring up the kernel and provide 
> early allocation.  Once the memory is handed over from memblock to the 
> normal kernel page allocators, we no longer care what happens to 
> memblock.
> 
> There is no need to free the initrd memory back into memblock.  In 
> fact, seeing the initrd location in 
> /sys/kernel/debug/memblock/reserved
> can be useful debug information in itself.

That's a fair point. Yang: do you have a specific use-case in mind for this?

I wondered if it might interact with our pfn_valid implementation, which uses memblock_is_memory, however memblock_free only deals with the reserved regions, so I now I can't see why this change is required either.

Will
