From: peterz@infradead.org (Peter Zijlstra)
Date: Wed, 28 Nov 2018 17:40:58 +0100
Subject: [PATCH 2/2] arm64: preempt: Provide our own implementation of
 asm/preempt.h
In-Reply-To: <CAKv+Gu9s-=M-mU+249-X1jQ7_Z60vWO1cXK1AP0CwKCmaQQSdg@mail.gmail.com>
References: <1543347902-21170-1-git-send-email-will.deacon@arm.com>
 <1543347902-21170-3-git-send-email-will.deacon@arm.com>
 <CAKv+Gu9s-=M-mU+249-X1jQ7_Z60vWO1cXK1AP0CwKCmaQQSdg@mail.gmail.com>
Message-ID: <20181128164058.GB2131@hirez.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 28, 2018 at 04:35:42PM +0100, Ard Biesheuvel wrote:
> On Tue, 27 Nov 2018 at 20:44, Will Deacon <will.deacon@arm.com> wrote:
> >
> > The asm-generic/preempt.h implementation doesn't make use of the
> > PREEMPT_NEED_RESCHED flag, since this can interact badly with load/store
> > architectures which rely on the preempt_count word being unchanged across
> > an interrupt.
> >
> > However, since we're a 64-bit architecture and the preempt count is
> > only 32 bits wide, we can simply pack it next to the resched flag and
> > load the whole thing in one go, so that a dec-and-test operation doesn't
> > need to load twice.
> >
> 
> Since the actual preempt count is a lot narrower than 32 bits, x86
> just uses bit 31.
> 
> So what is the reason for using two different words?

See commit:

  ba1f14fbe709 ("sched: Remove PREEMPT_NEED_RESCHED from generic code")
