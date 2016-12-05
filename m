From: Dave.Martin@arm.com (Dave Martin)
Date: Mon, 5 Dec 2016 15:12:33 +0000
Subject: [RFC PATCH 00/29] arm64: Scalable Vector Extension core support
In-Reply-To: <20161202215646.s2xymph6d6jlyrv3@localhost>
References: <7a35d1ae-73df-03a5-c9d6-1a52754acf25@redhat.com>
 <CAH=s-POegNL2HLV3EGPt=b-jrJ4OOwpBFTfysMaX0TNgSw=3Hg@mail.gmail.com>
 <20161130120654.GJ1574@e103592.cambridge.arm.com>
 <20161202215646.s2xymph6d6jlyrv3@localhost>
Message-ID: <20161205151232.GU1574@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 02, 2016 at 09:56:46PM +0000, Yao Qi wrote:
> On 16-11-30 12:06:54, Dave Martin wrote:
> > So, my key goal is to support _per-process_ vector length control.
> > 
> > From the kernel perspective, it is easiest to achieve this by providing
> > per-thread control since that is the unit that context switching acts
> > on.
> >
> 
> Hi, Dave,
> Thanks for the explanation.
> 
> > How useful it really is to have threads with different VLs in the same
> > process is an open question.  It's theoretically useful for runtime
> > environments, which may want to dispatch code optimised for different
> > VLs -- changing the VL on-the-fly within a single thread is not
> > something I want to encourage, due to overhead and ABI issues, but
> > switching between threads of different VLs would be more manageable.
> 
> This is a weird programming model.

I may not have explained that very well.

What I meant is, you have two threads communicating with one another,
say.  Providing that they don't exchange data using a VL-dependent
representation, it should not matter that the two threads are running
with different VLs.

This may make sense if a particular piece of work was optimised for a
particular VL: you can pick a worker thread with the correct VL and
dispatch the job there for best performance.

I wouldn't expect this ability to be exploited except by specialised
frameworks.

> > However, I expect mixing different VLs within a single process to be
> > very much a special case -- it's not something I'd expect to work with
> > general-purpose code.
> > 
> > Since the need for indepent VLs per thread is not proven, we could
> > 
> >  * forbid it -- i.e., only a thread-group leader with no children is
> > permitted to change the VL, which is then inherited by any child threads
> > that are subsequently created
> > 
> >  * permit it only if a special flag is specified when requesting the VL
> > change
> > 
> >  * permit it and rely on userspace to be sensible -- easiest option for
> > the kernel.
> 
> Both the first and the third one is reasonable to me, but the first one
> fit well in existing GDB design.  I don't know how useful it is to have
> per-thread VL, there may be some workloads can be implemented that way.
> GDB needs some changes to support "per-thread" target description.

OK -- I'll implement for per-thread for now, but this can be clarified
later.

Cheers
---Dave
