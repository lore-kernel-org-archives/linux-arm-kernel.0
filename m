From: dave.martin@linaro.org (Dave Martin)
Date: Tue, 28 Feb 2012 10:20:40 +0000
Subject: [PATCH-WIP 01/13] xen/arm: use r12 to pass the hypercall number
 to the hypervisor
In-Reply-To: <1330371219.10008.34.camel@dagon.hellion.org.uk>
References: <alpine.DEB.2.00.1202231714590.23091@kaball-desktop>
 <1330019314-20865-1-git-send-email-stefano.stabellini@eu.citrix.com>
 <1330360043.8557.302.camel@zakaz.uk.xensource.com>
 <20120227180355.GB2023@linaro.org>
 <1330371219.10008.34.camel@dagon.hellion.org.uk>
Message-ID: <20120228102040.GB2063@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 27, 2012 at 07:33:39PM +0000, Ian Campbell wrote:
> On Mon, 2012-02-27 at 18:03 +0000, Dave Martin wrote:
> > On Mon, Feb 27, 2012 at 04:27:23PM +0000, Ian Campbell wrote:
> > > On Thu, 2012-02-23 at 17:48 +0000, Stefano Stabellini wrote:
> > > > We need a register to pass the hypercall number because we might not
> > > > know it at compile time and HVC only takes an immediate argument.
> > > > 
> > > > Among the available registers r12 seems to be the best choice because it
> > > > is defined as "intra-procedure call scratch register".
> > > 
> > > R12 is not accessible from the 16 bit "T1" Thumb encoding of mov
> > > immediate (which can only target r0..r7).
> > 
> > This is untrue.  The important instructions, like MOV Rd, Rn can access
> > all the regs.  But anyway, there is no such thing as a Thumb-1 kernel,
> > so we won't really care.
> 
> I did say "mov immediate", which is the one which matters when loading a
> constant hypercall number (the common case). AFAIK the "mov Rd, #imm" T1
> encoding cannot access all registers.
> 
> The "mov rd,rn" form only helps for syscall(2) like functions, which are
> unusual, at least for Xen, although as Stefano says, they do exist.

Apologies -- looks like I misread you here.  I agree, but it's probably
a minor issue nonetheless.

> 
> > > Since we support only ARMv7+ there are "T2" and "T3" encodings available
> > > which do allow direct mov of an immediate into R12, but are 32 bit Thumb
> > > instructions.
> > > 
> > > Should we use r7 instead to maximise instruction density for Thumb code?
> > 
> > The difference seems trivial when put into context, even if you code a
> > special Thumb version of the code to maximise density (the Thumb-2 code
> > which gets built from assembler in the kernel is very suboptimal in
> > size, but there simply isn't a high proportion of asm code in the kernel
> > anyway.)  I wouldn't consider the ARM/Thumb differences as an important
> > factor when deciding on a register.
> 
> OK, that's useful information. thanks.
> 
> > One argument for _not_ using r12 for this purpose is that it is then
> > harder to put a generic "HVC" function (analogous to the "syscall"
> > syscall) out-of-line, since r12 could get destroyed by the call.
> 
> For an out of line syscall(2) wouldn't the syscall number either be in a
> standard C calling convention argument register or on the stack when the
> function was called, since it is just a normal argument at that point?
> As you point out it cannot be passed in r12 (and could never be, due to
> the clobbering).
> 
> The syscall function itself would have to move the arguments and syscall
> nr etc around before issuing the syscall.
> 
> I think the same is true of a similar hypercall(2)
> 
> > If you don't think you will ever care about putting HVC out of line
> > though, it may not matter.

If you have both inline and out-of-line hypercalls, it's hard to ensure
that you never have to shuffle the registers in either case.

Shuffling can be reduced but only at the expense of strange argument
ordering in some cases when calling from C -- the complexity is probably
not worth it.  Linux doesn't bother for its own syscalls.

Note that even in assembler, a branch from one section to a label in
another section may cause r12 to get destroyed, so you will need to be
careful about how you code the hypervisor trap handler.  However, this
is not different from coding exception handlers in general, so I don't
know that it constitutes a conclusive argument on its own.

My instinctive preference would therefore be for r7 (which also seems to
be good enough for Linux syscalls) -- but it really depends how many
arguments you expect to need to support.

Cheers
---Dave
