From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 27 Oct 2010 17:47:11 -0400 (EDT)
Subject: [RFC] change the dma_unmap_single for arm
In-Reply-To: <20101027164355.GA24573@n2100.arm.linux.org.uk>
References: <AANLkTimO9m13=nLeYdS0+2Z2K_9MRfzR=VYtCDfV573s@mail.gmail.com>
	<20101027164355.GA24573@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.00.1010271740370.30152@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 27 Oct 2010, Russell King - ARM Linux wrote:

> On Wed, Oct 27, 2010 at 04:01:37PM +0200, saeed bishara wrote:
> > Hi,
> >       latest versions invalidates the buffer in order to overcome the
> > speculative prefetch. however, in some cases, specially network, the
> > data that DMAed can be much less that the buffer size, so it would be
> > more efficient - and correct for arm case - to use the received bytes
> > count rather than the buffer size. however, the linux API restricts
> > the size to be the same as the one passed to the dma_map_single -
> > which is the buffer size.
> >     the simplest solution that I can think of is to change the API
> > restriction, and make the drivers pass the received bytes count
> > instead of buffer size, the kernel also will provide a function to the
> > drivers  to permit using this hack.
> 
> The reason this isn't done is because some platforms have IOMMUs
> which have to be programmed (or deprogrammed) appropriately.  For
> this, it is important that the parameters are the same as the
> original map request.
> 
> Relaxing this restriction makes the API much more complex, and will
> probably cause additional pain to debug where people 'forget' to
> use the right buffer size(s).

What about an additional call for the unmap case where both the original 
buffer size and the actual used size are provided?  Simple sanity check 
would test for original_size >= used_size.  IOMMU would care about 
original_size while cache maintenance cares about used_size.


Nicolas
