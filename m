From: shuahkhan@gmail.com (Shuah Khan)
Date: Wed, 28 Nov 2018 16:01:10 -0700
Subject: remove the ->mapping_error method from dma_map_ops V2
In-Reply-To: <20181128194708.GP30658@n2100.armlinux.org.uk>
References: <CAHk-=wg5+rXK8dpjkSmK7tuz29VfxVWNEwmTVYB409mmyLkeew@mail.gmail.com>
 <20181128174545.GJ30658@n2100.armlinux.org.uk>
 <CAHk-=whnz4Kty6cas11bc2Gh=9zTzeeRS2k=dV9Hfc4B=xnHkQ@mail.gmail.com>
 <20181128.112717.149234960284639699.davem@davemloft.net>
 <20181128194708.GP30658@n2100.armlinux.org.uk>
Message-ID: <CAKocOOO2jELMaVh85m3V562ewCBDRUMJ1q_xoq7DgvUiagpTjQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 28, 2018 at 12:48 PM Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:
>
> On Wed, Nov 28, 2018 at 11:27:17AM -0800, David Miller wrote:
> > From: Linus Torvalds <torvalds@linux-foundation.org>
> > Date: Wed, 28 Nov 2018 10:00:06 -0800
> >
> > > Not all memory is accessible even to the kernel. If you have memory
> > > that shows up in the last page of phys_addr_t, you just mark it
> > > reserved at boot-time.
> >
> > It's not the physical memory at the end that needs to be reserved.
> >
> > It's the IOMMU mapping arena.
>
> True, if and only if you have an IOMMU.
>
> Where there isn't an IOMMU, then we'd have to reserve every page that
> that translates to a bus address in the top 4K of dma_addr_t on any
> bus in the system - that means knowing early in the kernel
> initialisation about all buses in the system so we can detect and
> reserve these pages.
>

The arch and platform differences/confusion as to "what is DMA error
value" is the reason why dma_mapping_error is part dma ops. I
understand that iy would make sense to reduce the overhead of an
additional call, however, I am not sure if would be trivial change to
address this.

I was down this path of trying to address the missing mapping error
checks a few years ago and introduced dma_mapping_error checks in the
DMA DEBUG API. As you might already know that there is no common
definition for the mapping error.

Quick look at the defines shows:

#define CALGARY_MAPPING_ERROR 0
#define S390_MAPPING_ERROR  (~(dma_addr_t) 0x0)
#define SPARC_MAPPING_ERROR (~(dma_addr_t)0x0)

This is the reason why there is a arch or in some cases bus specific
mapping_error ops is needed.
We could unify this and fix all these first. I haven't looked at the
patch set closely, maybe you are already doing this.

thanks,
-- Shuah
