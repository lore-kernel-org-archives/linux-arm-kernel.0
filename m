From: nico@fluxnic.net (Nicolas Pitre)
Date: Fri, 16 Sep 2011 14:09:39 -0400 (EDT)
Subject: [PATCH 01/19] ARM: sort the meminfo array earlier
In-Reply-To: <4E73858A.9050106@codeaurora.org>
References: <1316156850-31013-1-git-send-email-nico@fluxnic.net>
	<1316156850-31013-2-git-send-email-nico@fluxnic.net>
	<4E73858A.9050106@codeaurora.org>
Message-ID: <alpine.LFD.2.00.1109161345560.20358@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 16 Sep 2011, Stephen Boyd wrote:

> On 9/16/2011 12:07 AM, Nicolas Pitre wrote:
> > @@ -875,6 +876,12 @@ static struct machine_desc * __init setup_machine_tags(unsigned int nr)
> >  	return mdesc;
> >  }
> >  
> > +static int __init meminfo_cmp(const void *_a, const void *_b)
> > +{
> > +	const struct membank *a = _a, *b = _b;
> > +	long cmp = bank_pfn_start(a) - bank_pfn_start(b);
> > +	return cmp < 0 ? -1 : cmp > 0 ? 1 : 0;
> 
> This looks like:
> 
>     return clamp(bank_pfn_start(a) - bank_pfn_start(b), -1, 1);

Won't work.  The pfn is of an unsigned type, hence the subtraction 
result will also be unsigned.  The code above looks a bit odd, but there 
is an implicit cast to a signed result with the result stored into a 
long.

What would have been even clearer, and possibly more efficient as well, 
is something like this:

	if (bank_pfn_start(a) < bank_pfn_start(b))
		return -1;
	if (bank_pfn_start(a) > bank_pfn_start(b))
		return 1;
	return 0;

But the goal here was to simply move the code, changing it would warrant 
a separate patch.

> > diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
> > index 91bca355cd..7080f10cc2 100644
> > --- a/arch/arm/mm/init.c
> > +++ b/arch/arm/mm/init.c
> > @@ -318,19 +317,10 @@ static void arm_memory_present(void)
> >  }
> >  #endif
> >  
> > -static int __init meminfo_cmp(const void *_a, const void *_b)
> > -{
> > -	const struct membank *a = _a, *b = _b;
> > -	long cmp = bank_pfn_start(a) - bank_pfn_start(b);
> > -	return cmp < 0 ? -1 : cmp > 0 ? 1 : 0;
> > -}
> > -
> >  void __init arm_memblock_init(struct meminfo *mi, struct machine_desc *mdesc)
> >  {
> >  	int i;
> >  
> > -	sort(&meminfo.bank, meminfo.nr_banks, sizeof(meminfo.bank[0]), meminfo_cmp, NULL);
> > -
> 
> Why not call sanity_check_meminfo() here?

That could be done as well.  However the populating of the meminfo array 
is done in kernel/setup.c, so it made sense to move the sort there as 
this could be improved upon eventually to make the memory bank parser a 
bit more robust against problems such as overlapping memory ranges which 
was the subject of a somewhat entertaining thread recently.  But I don't 
have a strong opinion about this.


Nicolas
