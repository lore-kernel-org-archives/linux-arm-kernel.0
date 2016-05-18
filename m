From: andre.przywara@arm.com (Andre Przywara)
Date: Wed, 18 May 2016 16:55:45 +0100
Subject: [PATCH v4 22/56] KVM: arm/arm64: vgic-new: Add MMIO handling
 framework
In-Reply-To: <20160518123115.GE3827@cbox>
References: <1463392481-26583-1-git-send-email-andre.przywara@arm.com>
 <1463392481-26583-23-git-send-email-andre.przywara@arm.com>
 <20160518123115.GE3827@cbox>
Message-ID: <573C9081.6080500@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

....

>> +
>> +/* generate a mask that covers 1024 interrupts with <b> bits per IRQ */
>> +#define VGIC_ADDR_IRQ_MASK(b) GENMASK_ULL(ilog2(b) + ilog2(1024) - \
>> +					  ilog2(BITS_PER_BYTE) - 1, 0)
>> +#define VGIC_ADDR_TO_INTID(addr, bits)  (((addr) & VGIC_ADDR_IRQ_MASK(bits)) * \
>> +					64 / (bits) / 8)
> 
> In the comment we end up adding here, can we also describe why
> (addr & <magic mask>) * <magic 64> / (bits) / <BITS_PER_BYTE OR BYTES_PER_ULL>
> gives us what we need, because I don't get it.

The reason is: we deal with 8 bits per byte, but have
bits-per-interrupts values bigger than 8. Doing the maths in floating
point arithmetic would work fine:

(float)(addr & mask) * (8.0 / bits_per_IRQ)

So would this comment make sense?

/*
 * Since we can have more than 8 bits per interrupt, we can't use
 * "8 / bpi" as a multiplicand directly, so we use a
 * fixed-point-arithmetic version of it tailored to cover at most 64
 * bits per IRQ.
 */

Cheers,
Andre.
