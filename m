From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Wed, 18 May 2016 20:06:37 +0200
Subject: [PATCH v4 22/56] KVM: arm/arm64: vgic-new: Add MMIO handling
 framework
In-Reply-To: <573C9081.6080500@arm.com>
References: <1463392481-26583-1-git-send-email-andre.przywara@arm.com>
 <1463392481-26583-23-git-send-email-andre.przywara@arm.com>
 <20160518123115.GE3827@cbox> <573C9081.6080500@arm.com>
Message-ID: <20160518180637.GO6666@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 18, 2016 at 04:55:45PM +0100, Andre Przywara wrote:
> Hi,
> 
> ....
> 
> >> +
> >> +/* generate a mask that covers 1024 interrupts with <b> bits per IRQ */
> >> +#define VGIC_ADDR_IRQ_MASK(b) GENMASK_ULL(ilog2(b) + ilog2(1024) - \
> >> +					  ilog2(BITS_PER_BYTE) - 1, 0)
> >> +#define VGIC_ADDR_TO_INTID(addr, bits)  (((addr) & VGIC_ADDR_IRQ_MASK(bits)) * \
> >> +					64 / (bits) / 8)
> > 
> > In the comment we end up adding here, can we also describe why
> > (addr & <magic mask>) * <magic 64> / (bits) / <BITS_PER_BYTE OR BYTES_PER_ULL>
> > gives us what we need, because I don't get it.
> 
> The reason is: we deal with 8 bits per byte, but have
> bits-per-interrupts values bigger than 8. Doing the maths in floating
> point arithmetic would work fine:
> 
> (float)(addr & mask) * (8.0 / bits_per_IRQ)
> 
> So would this comment make sense?
> 
> /*
>  * Since we can have more than 8 bits per interrupt, we can't use
>  * "8 / bpi" as a multiplicand directly, so we use a
>  * fixed-point-arithmetic version of it tailored to cover at most 64
>  * bits per IRQ.
>  */
> 

Something like this certainly helps, here's another version which is
easier for me to understand, but you can take your pick:

 /*
  * (addr & mask) gives us the byte offset for the INT ID, so we want to
  * divide this with 'bytes per irq' to get the INT ID, which is given
  * by '(bits) / 8'.  But we do this with fixed-point-arithmetic and
  * take advantage of the fact that division by a fraction equals
  * multiplication with the inverted fraction, and scale up both the
  * numerator and denominator with 8 to support at most 64 bits per IRQ:
  */

At least I think we all agree that the approach works by now.

-Christoffer
