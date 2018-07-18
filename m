From: efault@gmx.de (Mike Galbraith)
Date: Wed, 18 Jul 2018 12:28:48 +0200
Subject: [PATCH RT v2] arm64: fpsimd: use a local_lock() in addition to
 local_bh_disable()
In-Reply-To: <20180718092741.pah2lubzo2a7tkmu@linutronix.de>
References: <20180517124006.ohygrrpg7z2moqqt@linutronix.de>
 <20180522131004.3012953c@gandalf.local.home>
 <20180522172115.fpqguqlsq6bavtxy@linutronix.de>
 <20180522132429.6f1dcf92@gandalf.local.home>
 <20180522173333.aawadhkcekzvrswp@linutronix.de>
 <20180711092555.268adf7f@gandalf.local.home>
 <20180711133157.bvrza5vmthu6lwjd@linutronix.de>
 <20180711093346.782af07a@gandalf.local.home>
 <20180713174937.5ddaqpylalcmc3jq@linutronix.de>
 <1531519424.23898.68.camel@gmx.de>
 <20180718092741.pah2lubzo2a7tkmu@linutronix.de>
Message-ID: <1531909728.6904.84.camel@gmx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2018-07-18 at 11:27 +0200, Sebastian Andrzej Siewior wrote:
> On 2018-07-14 00:03:44 [+0200], Mike Galbraith wrote:
> > > This seems to make work (crypto chacha20-neon + cyclictest). I have no
> > > EFI so I have no clue if saving SIMD while calling to EFI works.
> > 
> > All is not well on cavium test box.  I'm seeing random errors ala...
> > 
> > ./include/linux/fs.h:3137:11: internal compiler error: Segmentation fault
> > ./include/linux/bio.h:175:1: internal compiler error: in grokdeclarator, at c/c-decl.c:7023
> > 
> > ...during make -j96 (2*cpus) kbuild.  Turns out 4.14-rt has this issue
> > as well, which is unsurprising if it's related to fpsimd woes.  Box
> > does not exhibit the issue with NONRT kernels, PREEMPT or NOPREEMPT.
> > 
> > To file under FWIW, arm64 configured SLE15-RT, 4.12 based kernel
> > containing virgin @stable arch/arm64/kernel/fpsimd.c, does not exhibit
> > the problem. (relevant? dunno, it may be unrelated to fpsimd.c).
> 
> Okay, so you did not test this because you can't compile.

Nope, the running kernel, the one that is doing the segfaulting etc,
has the patches applied.

It is exhibiting that symptom because those patches do not cure this
symptom, one which I verified to be present in virgin 4.14-rt as well. 
The pseudo-patch I sent, disabling preemption where it is assumed to be
disabled instead, does cure it.  With preemption so disabled, I can
beat on affected kernels (>=4.14-rt) as long as I like.

This particular 48 core Cavium is very slow, maybe that makes it easier
to reproduce, dunno.  According to pipe-test, the thing is essentially
a dozen RPi super-glued together.  pipe-test pinned to a single core
can only context switch at ~40KHz with PREEMPT_RT, or ~90 with
NOPREEMPT, comparable to measurement done in real deal RPi.

	-Mike
