From: Dave.Martin@arm.com (Dave Martin)
Date: Wed, 30 Nov 2016 14:06:32 +0000
Subject: [RFC PATCH 00/29] arm64: Scalable Vector Extension core support
In-Reply-To: <583EB285.5050305@arm.com>
References: <1480102762-23647-1-git-send-email-Dave.Martin@arm.com>
 <7a35d1ae-73df-03a5-c9d6-1a52754acf25@redhat.com>
 <583EB285.5050305@arm.com>
Message-ID: <20161130140632.GL1574@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 30, 2016 at 11:05:41AM +0000, Szabolcs Nagy wrote:
> On 30/11/16 10:08, Florian Weimer wrote:
> > On 11/25/2016 08:38 PM, Dave Martin wrote:

[...]

> >>  * Discussion is needed on how userspace should detect/negotiate signal
> >>    frame size in order for this expansion mechanism to be workable.
> > 
> > I'm leaning towards a simple increase in the glibc headers (despite the ABI risk), plus a personality flag to
> > disable really wide vector registers in case this causes problems with old binaries.
> > 
> 
> if the kernel does not increase the size and libc
> does not add size checks then old binaries would
> work with new libc just fine..
> but that's non-conforming, posix requires the check.
> 
> if the kernel increases the size then it has to be
> changed in bionic and musl as well and old binaries
> may break.

Or we need a personality flag or similar to distinguish the two cases.

[...]

> > A more elaborate mechanism will likely introduce more bugs than it makes existing applications working, due to
> > its complexity.
> > 
> >> The remaining patches implement initial SVE support for Linux, with the
> >> following limitations:
> >>
> >>  * No KVM/virtualisation support for guests.
> >>
> >>  * No independent SVE vector length configuration per thread.  This is
> >>    planned, but will follow as a separate add-on series.
> > 
> > Per-thread register widths will likely make coroutine switching (setcontext) and C++ resumable
> > functions/executors quite challenging.
> > 
> 
> i'd assume it's undefined to context switch to a different
> thread or to resume a function on a different thread
> (because the implementation can cache thread local state
> on the stack: e.g. errno pointer).. of course this does
> not stop ppl from doing it, but the practice is questionable.

I don't have a view on this.

Cheers
---Dave
