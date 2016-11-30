From: Dave.Martin@arm.com (Dave Martin)
Date: Wed, 30 Nov 2016 12:06:54 +0000
Subject: [RFC PATCH 00/29] arm64: Scalable Vector Extension core support
In-Reply-To: <7a35d1ae-73df-03a5-c9d6-1a52754acf25@redhat.com>
 <CAH=s-POegNL2HLV3EGPt=b-jrJ4OOwpBFTfysMaX0TNgSw=3Hg@mail.gmail.com>
Message-ID: <20161130120654.GJ1574@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 30, 2016 at 11:08:50AM +0100, Florian Weimer wrote:
> On 11/25/2016 08:38 PM, Dave Martin wrote:
> >The Scalable Vector Extension (SVE) [1] is an extension to AArch64 which
> >adds extra SIMD functionality and supports much larger vectors.
> >
> >This series implements core Linux support for SVE.
> >
> >Recipents not copied on the whole series can find the rest of the
> >patches in the linux-arm-kernel archives [2].
> >
> >
> >The first 5 patches "arm64: signal: ..." factor out the allocation and
> >placement of state information in the signal frame.  The first three
> >are prerequisites for the SVE support patches.
> >
> >Patches 04-05 implement expansion of the signal frame, and may remain
> >controversial due to ABI break issues:
> >
> > * Discussion is needed on how userspace should detect/negotiate signal
> >   frame size in order for this expansion mechanism to be workable.
> 
> I'm leaning towards a simple increase in the glibc headers (despite the ABI
> risk), plus a personality flag to disable really wide vector registers in
> case this causes problems with old binaries.

I'm concerned here that there may be no sensible fixed size for the
signal frame.  We would make it ridiculously large in order to minimise
the chance of hitting this problem again -- but then it would be
ridiculously large, which is a potential problem for massively threaded
workloads.

Or we could be more conservative, but risk a re-run of similar ABI
breaks in the future.

A personality flag may also discourage use of larger vectors, even
though the vast majority of software will work fine with them.

> A more elaborate mechanism will likely introduce more bugs than it makes
> existing applications working, due to its complexity.

Yes, I was a bit concerned about this when I tried to sketch something
out.

[...]

> > * No independent SVE vector length configuration per thread.  This is
> >   planned, but will follow as a separate add-on series.
> 
> Per-thread register widths will likely make coroutine switching (setcontext)
> and C++ resumable functions/executors quite challenging.
> 
> Can you detail your plans in this area?
> 
> Thanks,
> Florian

I'll also respond to Yao's question here, since it's closely related:

On Wed, Nov 30, 2016 at 09:56:14AM +0000, Yao Qi wrote:

[...]

> If I read "independent SVE vector length configuration per thread"
> correctly, SVE vector length can be different in each thread, so the
> size of vector registers is different too.  In GDB, we describe registers
> by "target description" which is per process, not per thread.
> 
> -- 
> Yao (??)

So, my key goal is to support _per-process_ vector length control.

>From the kernel perspective, it is easiest to achieve this by providing
per-thread control since that is the unit that context switching acts
on.

How useful it really is to have threads with different VLs in the same
process is an open question.  It's theoretically useful for runtime
environments, which may want to dispatch code optimised for different
VLs -- changing the VL on-the-fly within a single thread is not
something I want to encourage, due to overhead and ABI issues, but
switching between threads of different VLs would be more manageable.

However, I expect mixing different VLs within a single process to be
very much a special case -- it's not something I'd expect to work with
general-purpose code.

Since the need for indepent VLs per thread is not proven, we could

 * forbid it -- i.e., only a thread-group leader with no children is
permitted to change the VL, which is then inherited by any child threads
that are subsequently created

 * permit it only if a special flag is specified when requesting the VL
change

 * permit it and rely on userspace to be sensible -- easiest option for
the kernel.


For setcontext/setjmp, we don't save/restore any SVE state due to the
caller-save status of SVE, and I would not consider it necessary to
save/restore VL itself because of the no-change-on-the-fly policy for
this.

I'm not familiar with resumable functions/executors -- are these in
the C++ standards yet (not that that would cause me to be familiar
with them... ;)  Any implementation of coroutines (i.e.,
cooperative switching) is likely to fall under the "setcontext"
argument above.

Thoughts?

---Dave
