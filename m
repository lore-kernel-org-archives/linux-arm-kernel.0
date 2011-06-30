From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 30 Jun 2011 12:23:54 +0100
Subject: [PATCH] mtd: OneNAND: samsung: Write DMA support
In-Reply-To: <1309430735.23597.165.camel@sauron>
References: <20110608101804.GA5527@july> <1309420530.23597.153.camel@sauron>
	<20110630091951.GQ21898@n2100.arm.linux.org.uk>
	<1309430735.23597.165.camel@sauron>
Message-ID: <20110630112354.GW21898@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 30, 2011 at 01:45:31PM +0300, Artem Bityutskiy wrote:
> Hi,
> 
> On Thu, 2011-06-30 at 10:19 +0100, Russell King - ARM Linux wrote:
> > Which is that this code is trying to work around the restriction in the
> > DMA API that dma_map_single() can only take virtual addresses in the
> > kernel direct mapped region.
> 
> OK.
> 
> > The key thing here is that with CPUs which lookup by virtual address,
> > like ARMs, you _must_ handle the cache aliases associated with the mapping
> > which you are accessing the memory via.
> > 
> > This means if you are accessing a DMA buffer at address X, and address X
> > is cacheable, address X needs cache maintainence performed on it.  Address
> > Y, which may correspond with the same memory as X through a different
> > mapping is no good.  It has to be X.
> 
> Jut to make sure I understand the issue (I am not good at all in this
> stuff, this is why I CCed the arm ML):
> 
> * if I vmalloc a buffer, I and up with physical memory which has 2
> mappings - X which is the direct kernel mapping and Y, which is the
> vmalloc mapping.
> * The DMA API takes care only about direct mapping in terms of CPU cache
> flushing and invalidating. The vmalloc mapping is not taken care of.
> 
> And this may cause memory corruptions.
> 
> Correct?

Yes.

> > However, there is NO API for mapping DMA buffers from vmalloc space.
> > What we do now have are a pair of functions which must be used _correctly_
> > (iow, one before and one after) to ensure that virtual cached architectures
> > can access the data correctly - and its documented at the bottom of
> > cachetlb.txt.
> 
> OK, so you do not say it is fundamentally impossible to DMA vmalloc'ed
> memory, it is just that no one bothered to invent an API for this.

It is not impossible, and XFS has had exactly the same issues - but
remember that XFS has to work with the block layer with drivers which
have no idea that the memory they're writing/reading may be also mapped
into vmalloc space.  The two functions at the bottom of cachetlb.txt were
invented to allow XFS to do this.

> > As this is something which keeps coming up in connection with MTD, it
> > may be a good idea if MTD gave driver authors a helping hand with DMA
> > setup/teardown so that the chances of driver authors getting this right
> > is greater...
> 
> Yes, or the MTD community may push back all hacks and force someone to
> invent the API...

It's probably going to be better to have a MTD block API for DMA which
provides a scatterlist to the MTD block driver, and which knows whether
the memory is from vmalloc.  When it is, it takes care of the flushing
via those two functions I referred to in cachetlb.txt.

This keeps the magic out of the individual MTD block drivers, and stops
them replicating the same mistakes time and time again - and also means
that you won't have to teach everyone about this.

It doesn't make sense for the DMA API to deal with vmalloc - MTD is
one of the very few (the only?) subsystems which does this.
