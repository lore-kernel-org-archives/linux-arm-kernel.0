From: Ian.Campbell@citrix.com (Ian Campbell)
Date: Tue, 28 Feb 2012 10:48:53 +0000
Subject: [PATCH-WIP 01/13] xen/arm: use r12 to pass the hypercall number
 to the hypervisor
In-Reply-To: <20120228102040.GB2063@linaro.org>
References: <alpine.DEB.2.00.1202231714590.23091@kaball-desktop>
 <1330019314-20865-1-git-send-email-stefano.stabellini@eu.citrix.com>
 <1330360043.8557.302.camel@zakaz.uk.xensource.com>
 <20120227180355.GB2023@linaro.org>
 <1330371219.10008.34.camel@dagon.hellion.org.uk>
 <20120228102040.GB2063@linaro.org>
Message-ID: <1330426133.31269.70.camel@zakaz.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2012-02-28 at 10:20 +0000, Dave Martin wrote:
> On Mon, Feb 27, 2012 at 07:33:39PM +0000, Ian Campbell wrote:
> > On Mon, 2012-02-27 at 18:03 +0000, Dave Martin wrote:
> > > > Since we support only ARMv7+ there are "T2" and "T3" encodings available
> > > > which do allow direct mov of an immediate into R12, but are 32 bit Thumb
> > > > instructions.
> > > > 
> > > > Should we use r7 instead to maximise instruction density for Thumb code?
> > > 
> > > The difference seems trivial when put into context, even if you code a
> > > special Thumb version of the code to maximise density (the Thumb-2 code
> > > which gets built from assembler in the kernel is very suboptimal in
> > > size, but there simply isn't a high proportion of asm code in the kernel
> > > anyway.)  I wouldn't consider the ARM/Thumb differences as an important
> > > factor when deciding on a register.
> > 
> > OK, that's useful information. thanks.
> > 
> > > One argument for _not_ using r12 for this purpose is that it is then
> > > harder to put a generic "HVC" function (analogous to the "syscall"
> > > syscall) out-of-line, since r12 could get destroyed by the call.
> > 
> > For an out of line syscall(2) wouldn't the syscall number either be in a
> > standard C calling convention argument register or on the stack when the
> > function was called, since it is just a normal argument at that point?
> > As you point out it cannot be passed in r12 (and could never be, due to
> > the clobbering).
> > 
> > The syscall function itself would have to move the arguments and syscall
> > nr etc around before issuing the syscall.
> > 
> > I think the same is true of a similar hypercall(2)
> > 
> > > If you don't think you will ever care about putting HVC out of line
> > > though, it may not matter.
> 
> If you have both inline and out-of-line hypercalls, it's hard to ensure
> that you never have to shuffle the registers in either case.

Agreed.

I think we want to optimise for the inline case since those are the
majority.

The only non-inline case is the special "privcmd ioctl" which is the
mechanism that allows the Xen toolstack to make hypercalls. It's
somewhat akin to syscall(2). By the time you get to it you will already
have done a system call for the ioctl, pulled the arguments from the
ioctl argument structure etc, plus such hypercalls are not really
performance critical.

> Shuffling can be reduced but only at the expense of strange argument
> ordering in some cases when calling from C -- the complexity is probably
> not worth it.  Linux doesn't bother for its own syscalls.
> 
> Note that even in assembler, a branch from one section to a label in
> another section may cause r12 to get destroyed, so you will need to be
> careful about how you code the hypervisor trap handler.  However, this
> is not different from coding exception handlers in general, so I don't
> know that it constitutes a conclusive argument on its own.

We are happy to arrange that this doesn't occur on our trap entry paths,
at least until the guest register state has been saved. Currently the
hypercall dispatcher is in C and gets r12 from the on-stack saved state.
We will likely eventually optimise the hypercall path directly in ASM
and in that case we are happy to take steps to ensure we don't clobber
r12 before we need it.

> My instinctive preference would therefore be for r7 (which also seems to
> be good enough for Linux syscalls) -- but it really depends how many
> arguments you expect to need to support.

Apparently r7 is the frame pointer for gcc in thumb mode which I think
is a good reason to avoid it.

We currently have some 5 argument hypercalls and there have been
occasional suggestions for interfaces which use 6 -- although none of
them have come to reality.

Ian.
