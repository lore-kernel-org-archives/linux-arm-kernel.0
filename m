From: mika.westerberg@iki.fi (Mika Westerberg)
Date: Sun, 14 Nov 2010 10:25:02 +0200
Subject: [PATCH 4/4] ARM: memblock: convert reserve_crashkernel() to
	use memblock
In-Reply-To: <20101113130700.GA26105@n2100.arm.linux.org.uk>
References: <cover.1289292124.git.mika.westerberg@iki.fi>
	<07f23b6e32b1ee64287dc53803890052df6546f3.1289292124.git.mika.westerberg@iki.fi>
	<20101113130700.GA26105@n2100.arm.linux.org.uk>
Message-ID: <20101114082502.GA19331@gw.healthdatacare.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 13, 2010 at 01:07:00PM +0000, Russell King - ARM Linux wrote:
> On Tue, Nov 09, 2010 at 11:06:13AM +0200, Mika Westerberg wrote:
> >  static void __init reserve_crashkernel(void)
> >  {
> >  	unsigned long long crash_size, crash_base;
> > -	unsigned long long total_mem;
> >  	int ret;
> >  
> > -	total_mem = get_total_mem();
> > -	ret = parse_crashkernel(boot_command_line, total_mem,
> > +	/* this is necessary because of memblock_phys_mem_size() */
> > +	memblock_analyze();
> 
> I think you need to check with the memblock people whether its legal to
> call memblock_analyze() multiple times.  What do other arches do for
> this?

At least powerpc and sh do it like the above.

> Secondly, when paging_init() returns, bootmem has been initialized, and
> memory taken from bootmem to feed the zone allocators.  This memory is
> not registered back into memblock.  Allocations from memblock after
> paging_init() has returned will lead to overlaps with bootmem, and
> therefore corruption.

Ok.

> So, this code is better off left as-is, rather than trying to convert it
> to what mistakenly appears "the latest thing".

Yeah, sounds like it wasn't such a good idea. Please ignore this
patch then.

Thanks,
MW
