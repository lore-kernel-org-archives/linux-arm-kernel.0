From: w@1wt.eu (Willy Tarreau)
Date: Thu, 12 Dec 2013 16:28:49 +0100
Subject: gcc miscompiles csum_tcpudp_magic() on ARMv5
In-Reply-To: <yw1xsityhzd1.fsf@unicorn.mansr.com>
References: <1386850444.22947.46.camel@sakura.staff.proxad.net>
 <20131212124015.GL4360@n2100.arm.linux.org.uk>
 <1386855390.22947.68.camel@sakura.staff.proxad.net>
 <yw1xppp2ji38.fsf@unicorn.mansr.com>
 <1386857410.22947.78.camel@sakura.staff.proxad.net>
 <20131212141926.GA31816@1wt.eu>
 <1386858504.22947.85.camel@sakura.staff.proxad.net>
 <yw1xd2l2jflc.fsf@unicorn.mansr.com> <20131212150745.GB31816@1wt.eu>
 <yw1xsityhzd1.fsf@unicorn.mansr.com>
Message-ID: <20131212152849.GC31816@1wt.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 12, 2013 at 03:18:18PM +0000, M?ns Rullg?rd wrote:
> Willy Tarreau <w@1wt.eu> writes:
> 
> >> >> Hmmm aren't you passing a 16-bit register directly to the ASM for
> >> >> being used as a 32-bit one ? This seems hasardous to me since
> >> >> nowhere you tell gcc how you're going to use the register.
> >> >
> >> > this is exactly what I'm complaining about, the arm code for
> >> > csum_tcpudp_nofold() in the kernel does exactly that.
> >> >
> >> >> Could you check if that fixes it :
> >> >> 
> >> >>  static inline uint32_t asm_add(uint16_t len, uint32_t sum)
> >> >>  {
> >> >>          uint32_t len32 = len;
> >> >
> >> > or change the asm_add() proto to take an "uint32_t len" instead, and yes
> >> > of course that fixes it.
> >> 
> >> It's a bug.  Please report it to the gcc developers.
> >
> > Here I don't agree with the generalization (and believe me I swear all the
> > day about gcc's bugs). It's a matter of ABI and availability or not of 16
> > bit registers or not. If the ASM supports 16-bit regs and the compiler is
> > allowed to emit 16-bit regs, then gcc will have no way to know whether it
> > must zero-extend the value first. If it's specified that "r" is necessarily
> > a 32-bit register then it should.
> 
> ARM has *only* 32-bit registers.
> 
> > Maybe the issue is in the ABI itself, I don't know if 16-bit values
> > are supposed to be zero-extended only when they're converted to 32-bit
> > or also when they're passed as arguments. The fact that it works
> > without inline may simply be a side effect of the different code (eg:
> > 16 lower bits of the register copied into another one).
> >
> > So one needs to look at the specs of the ABI to know where the 16-bit value
> > is supposed to be converted to 32-bit, then the faulty component must be
> > fixed (gcc or kernel code).
> 
> The ABI for function calls sign/zero-extends all arguments prior to the
> call.

OK then that's pretty clear, there's no ambiguity, thanks for the precision.

Willy
