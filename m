From: jbarnes@virtuousgeek.org (Jesse Barnes)
Date: Fri, 29 Apr 2011 09:27:12 -0700
Subject: [Linaro-mm-sig] [RFC] ARM DMA mapping TODO, v1
In-Reply-To: <1304062523.2513.235.camel@pasglop>
References: <201104212129.17013.arnd@arndb.de>
	<201104281428.56780.arnd@arndb.de>
	<20110428131531.GK17290@n2100.arm.linux.org.uk>
	<201104281629.52863.arnd@arndb.de>
	<20110428143440.GP17290@n2100.arm.linux.org.uk>
	<BANLkTinhm7ar1mf1D-dSMiLtw5hRNY36RA@mail.gmail.com>
	<1304036962.2513.202.camel@pasglop> <4DBA5194.7080609@vmware.com>
	<1304062523.2513.235.camel@pasglop>
Message-ID: <20110429092712.5bbd6948@jbarnes-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 29 Apr 2011 17:35:23 +1000
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> 
> > I've been doing some thinking over the years on how we could extend that 
> > functionality to other architectures. The reason we need those is 
> > because some x86 processors (early AMDs and, I think VIA c3) dislike 
> > multiple mappings of the same pages with conflicting caching attributes.
> > 
> > What we really want to be able to do is to unmap pages from the linear 
> > kernel map, to avoid having to transition the linear kernel map every 
> > time we change other mappings.
> >
> > The reason we need to do this in the first place is that AGP and modern 
> > GPUs has a fast mode where snooping is turned off.
> 
> Right. Unfortunately, unmapping pages from the linear mapping is
> precisely what I cannot give you on powerpc :-(
> 
> This is due to our tendency to map it using the largest page size
> available. That translates to things like:
> 
>  - On hash based ppc64, I use 16M pages. I can't "break them up" due to
> the limitation of the processor of having a single page size per segment
> (and we use 1T segments nowadays). I could break the whole thing down to
> 4K but that would very seriously affect system performances.
> 
>  - On embedded, I map it using 1G pages. I suppose I could break it up
> since it's SW loaded but here too, system performance would suffer. In
> addition, we rely on ppc32 embedded to have the first 768M of the linear
> mapping and on ppc64 embedded, the first 1G, mapped using bolted TLB
> entries, which we can really only do using very large entries
> (respectively 256M and 1G) that can't be broken up.
>  
> So you need to make sure whatever APIs you come up with will work on
> architectures where memory -has- to be cachable and coherent and you
> cannot play with the linear mapping. But that won't help with our
> non-coherent embedded systems :-(

You must be making it sound worse than it really is, otherwise how
would an embedded platform like the above deal with a display engine
that needed a large, contiguous chunk of uncached memory for the
display buffer?  If the CPU is actively speculating into it and
overwriting blits etc it would never work...  Or do you do such
reservations up front at 1G granularity??

> Right. We should still shoot HW designers who give up coherency for the
> sake of 3D benchmarks. It's insanely stupid.

Ah if it were that simple. :)  There are big costs to implementing full
coherency for all your devices, as you well know, so it's just not a
question of benchmark optimization.

-- 
Jesse Barnes, Intel Open Source Technology Center
