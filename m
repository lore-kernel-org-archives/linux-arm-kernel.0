From: anfei.zhou@gmail.com (anfei)
Date: Tue, 19 Jan 2010 21:05:47 +0800
Subject: flush_dcache_page does too much?
In-Reply-To: <20100119001636.GA4401@desktop>
References: <20100118131346.GA11589@desktop>
	<20100118133304.GA29645@n2100.arm.linux.org.uk>
	<20100118135431.GA12496@desktop>
	<20100118140005.GD2695@n2100.arm.linux.org.uk>
	<20100118141530.GA13394@desktop>
	<20100118144418.GE2695@n2100.arm.linux.org.uk>
	<20100118145731.GA14523@desktop>
	<20100118150152.GF2695@n2100.arm.linux.org.uk>
	<20100119001636.GA4401@desktop>
Message-ID: <20100119130547.GA6285@desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Tue, Jan 19, 2010 at 08:16:36AM +0800, anfei wrote:
> On Mon, Jan 18, 2010 at 03:01:52PM +0000, Russell King - ARM Linux wrote:
> > On Mon, Jan 18, 2010 at 10:57:31PM +0800, anfei wrote:
> > > On Mon, Jan 18, 2010 at 02:44:18PM +0000, Russell King - ARM Linux wrote:
> > > > On Mon, Jan 18, 2010 at 10:15:30PM +0800, anfei wrote:
> > > > > On Mon, Jan 18, 2010 at 02:00:05PM +0000, Russell King - ARM Linux wrote:
> > > > > > On Mon, Jan 18, 2010 at 09:54:31PM +0800, anfei wrote:
> > > > > > > Do you mean this implementation can ensure the coherence between write
> > > > > > > and shared mmapings?  But it's easy to reproduce the alias problem by
> > > > > > > this simple testcase (w/o error handler) on omap2430 with VIPT cache:
> > > > > > 
> > > > > > Your program doesn't do anything to identify any problem.  You don't
> > > > > > even say _what_ problem you see with this program.
> > > > > > 
> > > > > Sorry for that.
> > > > > 
> > > > > > If you have a specific case which fails, please show the problem, please
> > > > > > describe exactly the behaviour that you see, and what you expect to see.
> > > > 
> > > > Are you using a write allocate cache?
> > > 
> > > I guess not, because this line is neccessary to reproduce the issue:
> > > 	tmp = *(addr+0);
> > > If it's write allocate, this line may not be neccessary, since it's just
> > > a read (and cache the data).
> > 
> > It makes no sense then - without write allocate, writes will go straight
> > through to the underlying page, bypassing the cache.
> > 
> Because of the read, the write is cache hitted too even on read allocate:
>        *(addr+0) = 0x44444444;	<- bypass the cache
>        tmp = *(addr+0);		<- read allocate
>        *(addr+1) = 0x77777777;	<- same cacheline, cache hitted
> 
> So the two write values are cached, then the sequence in sys_write
> cannot guarantee the coherence:
> 	kmap_atomic(page);
> 	copy to page;
> 	kunmap_atomic(page);
> 	flush_dcache_page(page);
> 
> It should call flush_dcache_page() at the beginning too in order to
> flush the shared mapping.  Actually, I think it's better to split this
> function into two, such as:
> 	flush_dcache_user_page(page);
> 	copy to page;
> 	kunmap_atomic(page);
> 	flush_dcache_kern_page(page);
> 
> And this patch seems to fix it, any other fs doesn't call it need to add
> that too.
> 
Do you think this is a bug and I can send the patch, or it's the problem
of the test case?

Thanks,
Anfei.
> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 96ac6b0..07056fb 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -2196,6 +2196,9 @@ again:
>  		if (unlikely(status))
>  			break;
>  
> +		if (mapping_writably_mapped(mapping))
> +			flush_dcache_page(page);
> +
>  		pagefault_disable();
>  		copied = iov_iter_copy_from_user_atomic(page, i, offset, bytes);
>  		pagefault_enable();
