From: mzoran@crowfest.net (Michael Zoran)
Date: Wed, 25 Jan 2017 05:35:17 -0800
Subject: [PATCH] arm64: dma-mapping: Fix dma_mapping_error() when
 bypassing SWIOTLB
In-Reply-To: <81482ad2-331a-df33-66a2-f5fedc0bd7bb@arm.com>
References: <20170124225200.a7qioswpxzh6agvd@raspberrypi-2.musicnaut.iki.fi>
 <9e74b2f91b0b4b649a898db47225e5ea3b6a0417.1485345401.git.robin.murphy@arm.com>
 <1485347826.2306.3.camel@crowfest.net>
 <CAK8P3a1qVsUSFCOKpbtVu0_uYb3qhzRr8edZxjrMaHnbgjmcBA@mail.gmail.com>
 <81482ad2-331a-df33-66a2-f5fedc0bd7bb@arm.com>
Message-ID: <1485351317.2306.7.camel@crowfest.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2017-01-25 at 12:54 +0000, Robin Murphy wrote:
> On 25/01/17 12:51, Arnd Bergmann wrote:
> > On Wed, Jan 25, 2017 at 1:37 PM, Michael Zoran <mzoran@crowfest.net
> > > wrote:
> > > On Wed, 2017-01-25 at 12:03 +0000, Robin Murphy wrote:
> > > > hen bypassing SWIOTLB on small-memory systems, we need to avoid
> > > > calling
> > > > into swiotlb_dma_mapping_error() in exactly the same way as we
> > > > avoid
> > > > swiotlb_dma_supported(), because the former also relies on
> > > > SWIOTLB
> > > > state
> > > > being initialised.
> > > 
> > > I didn't submit the initial ARM64 port of the RPI 3, so I don't
> > > know
> > > much about this.??But from a third personal point of view, this
> > > seems
> > > to side step the main issue here.
> > 
> > I think Robin's approach is fixing exactly the right part of the
> > code.
> > 
> > > From an ARM64 subsystem point of view, what exactly is the
> > > correct/recommended method for ensuring the mm subsystem is
> > > initialized
> > > correctly?
> > 
> > It is initialized correctly, the bug was calling the wrong helper
> > when swiotlb
> > is not used because we determined that we don't need it.
> > 
> > One concern from inspection:
> > 
> > > +static int __swiotlb_dma_mapping_error(struct device *hwdev,
> > > dma_addr_t addr)
> > > +{
> > > +???????if (swiotlb)
> > > +???????????????return swiotlb_dma_mapping_error(hwdev, addr);
> > > +???????return 1;
> > > +}
> > 
> > Shouldn't that be
> > 
> > ?????return addr == DMA_ERROR_CODE;
> > 
> > in the last line? Otherwise any addr is interpreted as an error,
> > which
> > seems wrong. Maybe I'm missing something obvious here.
> 
> Aw crap, copy/paste/brain error - thanks.
> 
> I'll have a nice strong cup of tea, actually engage thinking mode,
> and
> respin...
> 
> Robin.
> 
> > 
> > ????Arnd
> > 

I have an RPI 3 that I run in ARM64 mode all the time for personal use.
 If/when you have a patch ready, I'm more then willing to try it out
locally.

Just tell me the path of the git tree and branch that it's based on.

Thanks.
