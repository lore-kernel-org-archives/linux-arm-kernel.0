From: Dave.Martin@arm.com (Dave P Martin)
Date: Thu, 26 Mar 2015 13:19:14 +0000
Subject: [PATCH] ARM: force linker to use PIC veneers
In-Reply-To: <CAKv+Gu9CDnFSiRrntzTDZDFhb3Cq1M-Dt_xKxvNUszZJpSrzpg@mail.gmail.com>
References: <CAKv+Gu-MpvAnkEd2L_OPGpDv5cnCZACvzuQ9LbG8O5kjDRQUwQ@mail.gmail.com>
 <20150324135439.GC3579@e103592.cambridge.arm.com>
 <CAKv+Gu9NeqOTjUux9S7p5o89T1tc9ACraC0D53Y=CCTNzZXKMg@mail.gmail.com>
 <20150325104603.GA3560@e103592.cambridge.arm.com>
 <20150326113648.GC8656@n2100.arm.linux.org.uk>
 <CAKv+Gu8ktOUcQrGOwMfbt8s2QG+RFdnKBykVfhXPTLSUFtWQyA@mail.gmail.com>
 <20150326122203.GG8656@n2100.arm.linux.org.uk>
 <CAKv+Gu-ctXuiM2mcgbqfkBkP_96tivjac0jv+XJ48XSpqRf=Yg@mail.gmail.com>
 <20150326125334.GA27016@e103592.cambridge.arm.com>
 <CAKv+Gu9CDnFSiRrntzTDZDFhb3Cq1M-Dt_xKxvNUszZJpSrzpg@mail.gmail.com>
Message-ID: <20150326131913.GA6140@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 26, 2015 at 01:05:09PM +0000, Ard Biesheuvel wrote:
> On 26 March 2015 at 13:53, Dave P Martin <Dave.Martin@arm.com> wrote:
> > On Thu, Mar 26, 2015 at 12:24:01PM +0000, Ard Biesheuvel wrote:
> >> On 26 March 2015 at 13:22, Russell King - ARM Linux
> >> <linux@arm.linux.org.uk> wrote:
> >> > On Thu, Mar 26, 2015 at 01:20:16PM +0100, Ard Biesheuvel wrote:
> >
> > [...]
> >
> >> >> Any specific concerns? The --pic-veneer switch dates back to 2009, so
> >> >> it's been around for a while
> >> >
> >> > BX.  Not every CPU supports BX.
> >> >
> >>
> >> The bx is used for the Thumb -> ARM switch inside the veneer only, so
> >> if you build for ARM these won't appear in the output
> >
> > Agreed that's what's _supposed_ to happen.
> >
> > Note that --use-blx is an override and might introduce BXs into a kernel
> > that otherwise doesn't have them.  But in any case, this option doesn't
> > show a benefit for the scenario under discussion, hence my dropping the
> > request (conditional on THUMB2_KERNEL in any case).
> >
> 
> Actually, i am not quite sure. I hadn't realised that there is no
> branch-without-link counterpart of 'blx <label>' so even if I still
> potted a number of bx pc/nop sequences, I can't really say if there
> were quite as many as before.

Where not out of range, the compiler should just branch to the
destination, with no veneer.  This would apply to optimised tail-
calls, for example -- but with an ordinary branch, not BX.  The
linker would only ever fix it up as B{L}X for one of two reasons:
either the destination is in a different instruction set, or
Thumb code is branching to a veneer (veneers are always ARM).

THUMB2_KERNEL generates a kernel which is very nearly 100% Thumb
code, so BX should be very rare when veneers are not involved.

> > Ard, can you should build a couple of !THUMB2_KERNEL/pre-v5
> > configurations with your change and check, just to be sure?
> >
> 
> Will do.
> 

Cheers
---Dave
