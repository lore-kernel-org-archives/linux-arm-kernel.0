From: will.deacon@arm.com (Will Deacon)
Date: Mon, 3 Sep 2018 13:52:06 +0100
Subject: [PATCH 00/12] Avoid synchronous TLB invalidation for
 intermediate page-table entries on arm64
In-Reply-To: <20180831203234.7b8f4d13@roar.ozlabs.ibm.com>
References: <1535645747-9823-1-git-send-email-will.deacon@arm.com>
 <CA+55aFzMMU5RBhn52Lbzf-FXvx3inh5VPVZL613srY+dVU+Lxw@mail.gmail.com>
 <20180831110054.475a3534@roar.ozlabs.ibm.com>
 <CA+55aFyweLwdAeeLnPv1ceje2y9Qc2AkM+LdMzK_z29fFb96ug@mail.gmail.com>
 <20180831095417.GF13166@arm.com>
 <20180831101014.GG24124@hirez.programming.kicks-ass.net>
 <20180831203234.7b8f4d13@roar.ozlabs.ibm.com>
Message-ID: <20180903125205.GA12642@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 31, 2018 at 08:32:34PM +1000, Nicholas Piggin wrote:
> On Fri, 31 Aug 2018 12:10:14 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > On Fri, Aug 31, 2018 at 10:54:18AM +0100, Will Deacon wrote:
> > 
> > > Proposal below (omitted Linus because that seems to be the pattern elsewhere
> > > in the file and he's not going to shout at himself when things break :)
> > > Anybody I've missed?
> > > 
> > > Will
> > >   
> > > --->8  
> > > 
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index a5b256b25905..7224b5618883 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -9681,6 +9681,15 @@ S:	Maintained
> > >  F:	arch/arm/boot/dts/mmp*
> > >  F:	arch/arm/mach-mmp/
> > >  
> > > +MMU GATHER AND TLB INVALIDATION
> > > +M:	Will Deacon <will.deacon@arm.com>
> > > +M:	Nick Piggin <npiggin@gmail.com>
> 
> Oh gee, I suppose. powerpc hash is kind of interesting because it's
> crazy, Aneesh knows that code a lot better than I do. radix modulo
> some minor details of exact instructions is fairly like x86 (he 
> wrote a lot of that code too AFAIK).

Sure, as long as we have Power represented here. Would you rather add Aneesh
instead of yourself, or shall we just add you both?

> 
> > > +M:	Peter Zijlstra <peterz@infradead.org>
> > > +L:	linux-arch at vger.kernel.org
> 
> Maybe put linux-mm as well? Or should there just be one list?

If we do the landgrab on mmu_gather (which I think makes sense), then adding
both lists makes sense to me. I'll spin this as a proper patch, along with
Peter's code move.

> > > +S:	Maintained
> > > +F:	include/asm-generic/tlb.h
> > > +F:	arch/*/include/asm/tlb.h
> > > +
> > >  MN88472 MEDIA DRIVER
> > >  M:	Antti Palosaari <crope@iki.fi>
> > >  L:	linux-media at vger.kernel.org  
> > 
> > If we're going to do that (and I'm not opposed); it might make sense to
> > do something like the below and add:
> > 
> >  F:  mm/mmu_gather.c
> 
> I think that is a good idea regardless. How do feel about calling it
> tlb.c? Easier to type and autocompletes sooner.

No strong opinion on name, but I slightly prefer mmu_gather.c so that it
avoids any remote possibility of confusion with tlb.c vs hugetlb.c

Will
