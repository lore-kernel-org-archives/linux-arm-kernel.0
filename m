From: will.deacon@arm.com (Will Deacon)
Date: Tue, 28 Oct 2014 13:59:44 +0000
Subject: [RFC V3] arm/arm64:add CONFIG_HAVE_ARCH_BITREVERSE to support
 rbit instruction
In-Reply-To: <35FD53F367049845BC99AC72306C23D103E010D1825A@CNBJMBX05.corpusers.net>
References: <35FD53F367049845BC99AC72306C23D103E010D18254@CNBJMBX05.corpusers.net>
 <35FD53F367049845BC99AC72306C23D103E010D18257@CNBJMBX05.corpusers.net>
 <35FD53F367049845BC99AC72306C23D103E010D18259@CNBJMBX05.corpusers.net>
 <20141027104848.GD8768@arm.com>
 <35FD53F367049845BC99AC72306C23D103E010D1825A@CNBJMBX05.corpusers.net>
Message-ID: <20141028135944.GC29706@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 28, 2014 at 01:34:42AM +0000, Wang, Yalin wrote:
> > From: Will Deacon [mailto:will.deacon at arm.com]
> > > +++ b/arch/arm/include/asm/bitrev.h
> > > @@ -0,0 +1,28 @@
> > > +#ifndef __ASM_ARM_BITREV_H
> > > +#define __ASM_ARM_BITREV_H
> > > +
> > > +static __always_inline __attribute_const__ u32 __arch_bitrev32(u32 x)
> > > +{
> > > +	if (__builtin_constant_p(x)) {
> > > +		x = (x >> 16) | (x << 16);
> > > +		x = ((x & 0xFF00FF00) >> 8) | ((x & 0x00FF00FF) << 8);
> > > +		x = ((x & 0xF0F0F0F0) >> 4) | ((x & 0x0F0F0F0F) << 4);
> > > +		x = ((x & 0xCCCCCCCC) >> 2) | ((x & 0x33333333) << 2);
> > > +		return ((x & 0xAAAAAAAA) >> 1) | ((x & 0x55555555) << 1);
> > > +	}
> > > +	__asm__ ("rbit %0, %1" : "=r" (x) : "r" (x));
> > 
> > I think you need to use %w0 and %w1 here, otherwise you bit-reverse the 64-
> > bit register.
> For arm64 in arch/arm64/include/asm/bitrev.h.
> I have use __asm__ ("rbit %w0, %w1" : "=r" (x) : "r" (x));
> For arm , I use __asm__ ("rbit %0, %1" : "=r" (x) : "r" (x));
> Am I right ?

Yup, sorry, I didn't realise this patch covered both architectures. It would
probably be a good idea to split it into 3 parts: a core part, then the two
architectural bits.

Will
