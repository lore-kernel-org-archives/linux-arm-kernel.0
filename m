From: nico@fluxnic.net (Nicolas Pitre)
Date: Fri, 16 Sep 2011 16:44:39 -0400 (EDT)
Subject: [PATCH 01/19] ARM: sort the meminfo array earlier
In-Reply-To: <4E73A1AC.20709@codeaurora.org>
References: <1316156850-31013-1-git-send-email-nico@fluxnic.net>
	<1316156850-31013-2-git-send-email-nico@fluxnic.net>
	<4E73858A.9050106@codeaurora.org>
	<alpine.LFD.2.00.1109161345560.20358@xanadu.home>
	<4E73A1AC.20709@codeaurora.org>
Message-ID: <alpine.LFD.2.00.1109161557150.20358@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 16 Sep 2011, Stephen Boyd wrote:

> On 09/16/11 11:09, Nicolas Pitre wrote:
> > On Fri, 16 Sep 2011, Stephen Boyd wrote:
> >
> >
> >> This looks like:
> >>
> >>     return clamp(bank_pfn_start(a) - bank_pfn_start(b), -1, 1);
> > Won't work.  The pfn is of an unsigned type, hence the subtraction 
> > result will also be unsigned.  The code above looks a bit odd, but there 
> > is an implicit cast to a signed result with the result stored into a 
> > long.
> >
> > What would have been even clearer, and possibly more efficient as well, 
> > is something like this:
> >
> > 	if (bank_pfn_start(a) < bank_pfn_start(b))
> > 		return -1;
> > 	if (bank_pfn_start(a) > bank_pfn_start(b))
> > 		return 1;
> > 	return 0;
> 
> Ok so
> 
>     return clamp_t(long, bank_pfn_start(a) - bank_pfn_start(b), -1, 1); 
> 
> 
> ?

Well...

Given that the pfn range typically fits into an int, having a simple:

	return bank_pfn_start(a) - bank_pfn_start(b);

should be all that is needed here, since the expected return value is 
either <0, 0, or >0.  But that assumes that physical memory will always 
be representable with less than 44 bits, and that's a bad assumption to 
make these days.  Even your usage of clamp_t() is broken the same way, 
just like the current code in fact.

So probably using bank_phys_start() instead of bank_pfn_start() would 
already be slightly more efficient, given that reducing the range with a 
pfn is not going to help when PHYSADDR_t is a 64-bit type.  Then having 
direct comparisons like I proposed would be the best that can be 
achieved in C.


Nicolas
