From: peterz@infradead.org (Peter Zijlstra)
Date: Wed, 5 Oct 2016 17:10:57 +0200
Subject: [RFC] arm64: Enforce observed order for spinlock and data
In-Reply-To: <54b18de220f61747bf1c3cdf2a1b9447@codeaurora.org>
References: <1475257257-23072-1-git-send-email-bdegraaf@codeaurora.org>
 <20160930193231.GA2521@remoulade>
 <66a031ac2405e352ab0d5f19d7ddb8e9@codeaurora.org>
 <20161001181101.GA17554@remoulade>
 <b86926dc0203384522e0e6ce18bbb132@codeaurora.org>
 <20161004101208.GA18083@leverpostej>
 <884bd5d3a9a1bcf2a276130ffc17412a@codeaurora.org>
 <20161004191159.GA32596@leverpostej>
 <54b18de220f61747bf1c3cdf2a1b9447@codeaurora.org>
Message-ID: <20161005151057.GJ3142@twins.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 05, 2016 at 10:55:57AM -0400, bdegraaf at codeaurora.org wrote:
> On 2016-10-04 15:12, Mark Rutland wrote:
> >Hi Brent,
> >
> >Could you *please* clarify if you are trying to solve:
> >
> >(a) a correctness issue (e.g. data corruption) seen in practice.
> >(b) a correctness issue (e.g. data corruption) found by inspection.
> >(c) A performance issue, seen in practice.
> >(d) A performance issue, found by inspection.
> >
> >Any one of these is fine; we just need to know in order to be able to
> >help effectively, and so far it hasn't been clear.

Brent, you forgot to state which: 'a-d' is the case here.

> I found the problem.
> 
> Back in September of 2013, arm64 atomics were broken due to missing barriers
> in certain situations, but the problem at that time was undiscovered.
> 
> Will Deacon's commit d2212b4dce596fee83e5c523400bf084f4cc816c went in at
> that
> time and changed the correct cmpxchg64 in lockref.c to cmpxchg64_relaxed.
> 
> d2212b4 appeared to be OK at that time because the additional barrier
> requirements of this specific code sequence were not yet discovered, and
> this change was consistent with the arm64 atomic code of that time.
> 
> Around February of 2014, some discovery led Will to correct the problem with
> the atomic code via commit 8e86f0b409a44193f1587e87b69c5dcf8f65be67, which
> has an excellent explanation of potential ordering problems with the same
> code sequence used by lockref.c.
> 
> With this updated understanding, the earlier commit
> (d2212b4dce596fee83e5c523400bf084f4cc816c) should be reverted.
> 
> Because acquire/release semantics are insufficient for the full ordering,
> the single barrier after the store exclusive is the best approach, similar
> to Will's atomic barrier fix.

This again does not in fact describe the problem.

What is the problem with lockref, and how (refer the earlier a-d
multiple choice answer) was this found.

Now, I have been looking, and we have some idea what you _might_ be
alluding to, but please explain which accesses get reordered how and
cause problems.
