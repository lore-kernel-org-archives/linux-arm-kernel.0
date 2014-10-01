From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Wed, 1 Oct 2014 19:45:52 +0200
Subject: [RFC PATCH] arm/arm64: KVM: Fix BE accesses to GICv2 EISR and
 ELRSR regs
In-Reply-To: <542C31FE.9080609@arm.com>
References: <1411913066-3787-1-git-send-email-christoffer.dall@linaro.org>
 <542C31FE.9080609@arm.com>
Message-ID: <20141001174552.GA12519@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andre,

On Wed, Oct 01, 2014 at 05:55:26PM +0100, Andre Przywara wrote:
> Hi Christoffer,
> 
> On 28/09/14 15:04, Christoffer Dall wrote:
> > The EIRSR and ELRSR registers are 32-bit registers on GICv2, and we
> > store these as an array of two such registers on the vgic vcpu struct.
> > However, we access them as a single 64-bit value or as a bitmap pointer
> > in the generic vgic code, which breaks BE support.
> > 
> > Instead, store them as u64 values on the vgic structure and do the
> > word-swapping in the assembly code, which already handles the byte order
> > for BE systems.
> 
> I am wondering if that approach isn't too involved.
> EISR and ELRSR are 32-bit registers, and AFAIK the GIC is always LE on
> the hardware side. So by claiming we have a 64bit register we introduce
> too much hassle, right?

You have to deal with this mess somehow, the question is just where.

> Wouldn't it be better to just fix the registers shortly before we
> actually use them?

if you're looking at it isolated, I agree completely, having those two
32-bit registers in the struct would be 'nicer'.  However, we already
jump through a lot of hoops here to store things in a way that makes it
possible for us to share code between 32-bit and 64-bit and between
gicv2 and gicv3, so it's not completely out of line.

> With my limited endianess experience: Wouldn't this patch solve the EISR
> part (copy & pasted, so "for eyes only" ;-)
> 
> @@ -92,13 +89,10 @@ static u64 vgic_v2_get_eisr(const struct kvm_vcpu *vcpu)
>  {
>  	u64 val;
> 
> -#if BITS_PER_LONG == 64
> -	val  = vcpu->arch.vgic_cpu.vgic_v2.vgic_eisr[1];
> +       val  = le32_to_cpu(vcpu->arch.vgic_cpu.vgic_v2.vgic_eisr[1]);

don't do this - the reverse instructions for dealing with the inner-word
endianness already takes place in the assembly code, so that's not the
problem.

>         val <<= 32;
> -       val |= vcpu->arch.vgic_cpu.vgic_v2.vgic_eisr[0];
> -#else
> -       val = *(u64 *)vcpu->arch.vgic_cpu.vgic_v2.vgic_eisr;
> -#endif
> +       val |= le32_to_cpu(vcpu->arch.vgic_cpu.vgic_v2.vgic_eisr[0]);

what that whole block above does, is that when an unsigned long is 64
bits, if you just convert the &eisr[0] pointer to an unsigned long *,
you'll get this on a LE system:

 | 63 .................. 32 | 31 .................. 0 |
 |          eisr[1]         |        eisr[0]          |

which is what you want, but on a BE system, you'll get:

 | 63 .................. 32 | 31 .................. 0 |
 |          eisr[0]         |        eisr[1]          |

which is obviously not what the caller expects.  The current code block
(before my patch) always gives you the first one, which is what you'd
want.


> +
>         return val;
>  }
> 
> (BTW: Wasn't that 64 bit optimization path the wrong way round here?)

Not sure I understand your question?

> 
> Please bear with me if this is complete nonsense, could well twisted my
> mind once too much ;-)
> 
> Still thinking about a clever solution for that strange sync_elrsr()
> thing ...
> 

You have to factor that into the equation and not split up the things,
that's where I think you go wrong.

I tried to do what you asked before, but it becomes a bloody mess, with
a more convoluted patch and resulting code path than what I suggest,
IMHO.

Try to write out the whole thing yourself and be very careful that
you're getting it right.

If you can come up with a way that works with the callers using
for_each_set_bit()  (open-coding that one doesn't exactly make that
twited vgic code any more pretty), then I'll be very happy to throw this
away and take yours.

Happy brain twisting :)

Thanks for looking at this stuff.

-Christoffer
