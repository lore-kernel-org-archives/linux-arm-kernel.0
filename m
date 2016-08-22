From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 22 Aug 2016 23:03:02 +0200
Subject: Problem with atomic accesses in pstore on some ARM CPUs
In-Reply-To: <20160815221518.GD1120@svinekod>
References: <CABXOdTfT7xMfiBvRuUS1hsVs=q5q2wY1x1Z8oCyyJNFckM0g0A@mail.gmail.com>
 <CABXOdTfHX_ZB1CuM7hzU5LCZPYdHvBSatN9Nen=rb8r1rXhz-g@mail.gmail.com>
 <20160815221518.GD1120@svinekod>
Message-ID: <11973430.JhDduGIT84@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, August 15, 2016 11:15:18 PM CEST Mark Rutland wrote:
> On Tue, Aug 16, 2016 at 08:02:53AM -0700, Guenter Roeck wrote:
> > On Tue, Aug 16, 2016 at 6:21 AM, Will Deacon <will.deacon@arm.com> wrote:
> > > On Tue, Aug 16, 2016 at 06:14:53AM -0700, Guenter Roeck wrote:
> > >> On Tue, Aug 16, 2016 at 3:32 AM, Robin Murphy <robin.murphy@arm.com> wrote:
> > >> > On 16/08/16 00:19, Guenter Roeck wrote:
> > >> >> we are having a problem with atomic accesses in pstore on some ARM
> > >> >> CPUs (specifically rk3288 and rk3399). With those chips, atomic
> > >> >> accesses fail with both pgprot_noncached and pgprot_writecombine
> > >> >> memory. Atomic accesses do work when selecting PAGE_KERNEL protection.
> > >> >
> > >> > What's the pstore backed by? I'm guessing it's not normal DRAM.
> > >> >
> > >>
> > >> it is normal DRAM.
> > >
> > > In which case, why does it need to be mapped with weird attributes?
> > > Is there an alias in the linear map you can use?
> > >
> > 
> > I don't really _want_ to do anything besides using pstore as-is, or,
> > in other words, to have the upstream kernel work with the affected
> > systems.
> > 
> > The current pstore code runs the following code for memory with
> > pfn_valid() = true.
> > 
> >         if (memtype)
> >                 prot = pgprot_noncached(PAGE_KERNEL);
> >         else
> >                 prot = pgprot_writecombine(PAGE_KERNEL);
> >         ...
> >         vaddr = vmap(pages, page_count, VM_MAP, prot);
> > 
> > It then uses the memory pointed to by vaddr for atomic operations.
> 
> This means that the generic ramoops / pstore code is making non-portable
> assumptions about memory types.
> 
> So _something_ has to happen to that code.

If we have both a cacheable and a noncacheable mapping for the
same DRAM area, things get even worse across many architectures.

IIRC PowerPC will trigger a checkstop if it encounters a valid
cache line for a noncacheable mapping.

If there is only one mapping, this is not a problem, but we probably
want to avoid having a write-back cache here, in case something
serious goes wrong and all the cache is invalidated but the pstore
is used for post-mortem analysis.

	Arnd
