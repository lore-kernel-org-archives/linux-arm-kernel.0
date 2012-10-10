From: dave.martin@linaro.org (Dave Martin)
Date: Wed, 10 Oct 2012 12:15:17 +0100
Subject: [PATCH] ARM: backtrace: avoid crash on large invalid fp value
In-Reply-To: <1349851572-9967-1-git-send-email-toddpoynor@google.com>
References: <1349851572-9967-1-git-send-email-toddpoynor@google.com>
Message-ID: <20121010111517.GC2131@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 09, 2012 at 11:46:12PM -0700, Todd Poynor wrote:
> Invalid frame pointer (signed) -4 <= fp <= -1 defeats check for too high
> on overflow.
> 
> Signed-off-by: Todd Poynor <toddpoynor@google.com>
> ---
>  arch/arm/kernel/stacktrace.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/kernel/stacktrace.c b/arch/arm/kernel/stacktrace.c
> index 00f79e5..6315162 100644
> --- a/arch/arm/kernel/stacktrace.c
> +++ b/arch/arm/kernel/stacktrace.c
> @@ -31,7 +31,7 @@ int notrace unwind_frame(struct stackframe *frame)
>  	high = ALIGN(low, THREAD_SIZE);
>  
>  	/* check current frame pointer is within bounds */
> -	if (fp < (low + 12) || fp + 4 >= high)
> +	if (fp < (low + 12) || fp >= high - 4)
>  		return -EINVAL;
>  
>  	/* restore the registers from the stack frame */

sp and fp can still be complete garbage in the case of a corrupted frame,
so low + 12 can still overflow and cause us to read beyond the stack base.

A more robust patch might be as follows.  This also checks for misaligned
fp and sp values, since those indicate corruption and there can be no
sensible way to interpret the resulting frame in that case.

Also, according to the definition of current_thread_info(),
IS_ALIGNED(sp, THREAD_SIZE) indicates a full stack extending from sp
to sp + THREAD_SIZE, and not an empty stack extending from sp -
THREAD_SIZE to sp.  We cannot backtrace this situation anyway, since
that would imply that the frame record extends beyond the stack...
but this patch tidies it up in the interest of clarity.

Cheers
---Dave

(untested)

diff --git a/arch/arm/kernel/stacktrace.c b/arch/arm/kernel/stacktrace.c
index 00f79e5..fec82be 100644
--- a/arch/arm/kernel/stacktrace.c
+++ b/arch/arm/kernel/stacktrace.c
@@ -28,10 +28,20 @@ int notrace unwind_frame(struct stackframe *frame)
 
 	/* only go to a higher address on the stack */
 	low = frame->sp;
-	high = ALIGN(low, THREAD_SIZE);
+	if (!IS_ALIGNED(fp, 4))
+		return -EINVAL;
+
+	/*
+	 * low + 1 here ensures that high > sp, consistent with the
+	 * definition of current_thread_info().
+	 * We subtract 1 to compute the highest allowable byte address.
+	 * Otherwise, we might get high == 0 which would confuse our
+	 * comparisons.
+	 */
+	high = ALIGN(low + 1, THREAD_SIZE) - 1;
 
 	/* check current frame pointer is within bounds */
-	if (fp < (low + 12) || fp + 4 >= high)
+	if (fp < 12 || fp - 12 < low || fp > high)
 		return -EINVAL;
 
 	/* restore the registers from the stack frame */
@@ -39,6 +49,10 @@ int notrace unwind_frame(struct stackframe *frame)
 	frame->sp = *(unsigned long *)(fp - 8);
 	frame->pc = *(unsigned long *)(fp - 4);
 
+	/* Do not claim the frame is valid if if is obviously corrupt: */
+	if (!IS_ALIGNED(frame->fp, 4))
+		return -EINVAL;
+
 	return 0;
 }
 #endif
