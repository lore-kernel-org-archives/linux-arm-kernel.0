From: peterz@infradead.org (Peter Zijlstra)
Date: Fri, 4 May 2018 20:01:05 +0200
Subject: [PATCH 1/6] locking/atomic, asm-generic: instrument ordering
 variants
In-Reply-To: <20180504173937.25300-2-mark.rutland@arm.com>
References: <20180504173937.25300-1-mark.rutland@arm.com>
 <20180504173937.25300-2-mark.rutland@arm.com>
Message-ID: <20180504180105.GS12217@hirez.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 04, 2018 at 06:39:32PM +0100, Mark Rutland wrote:
> Currently <asm-generic/atomic-instrumented.h> only instruments the fully
> ordered variants of atomic functions, ignoring the {relaxed,acquire,release}
> ordering variants.
> 
> This patch reworks the header to instrument all ordering variants of the atomic
> functions, so that architectures implementing these are instrumented
> appropriately.
> 
> To minimise repetition, a macro is used to generate each variant from a common
> template. The {full,relaxed,acquire,release} order variants respectively are
> then built using this template, where the architecture provides an
> implementation.
> 
> To stick to an 80 column limit while keeping the templates legible, the return
> type and function name of each template are split over two lines. For
> consistency, this is done even when not strictly necessary.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Will Deacon <will.deacon@arm.com>
> ---
>  include/asm-generic/atomic-instrumented.h | 1195 ++++++++++++++++++++++++-----
>  1 file changed, 1008 insertions(+), 187 deletions(-)

Is there really no way to either generate or further macro compress this?

This is stupid repetitive, we just got rid of all that endless copy
paste crap in atomic implementations and now we're going back to that.

Adding or changing atomic bits becomes horrifically painful because of this.
