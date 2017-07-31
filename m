From: alexander.shishkin@linux.intel.com (Alexander Shishkin)
Date: Mon, 31 Jul 2017 13:02:16 +0300
Subject: [PATCH 2/2] perf/aux: Ensure aux_wakeup represents most recent
 wakeup index
In-Reply-To: <1501260863-14687-2-git-send-email-will.deacon@arm.com>
References: <1501260863-14687-1-git-send-email-will.deacon@arm.com>
 <1501260863-14687-2-git-send-email-will.deacon@arm.com>
Message-ID: <87lgn4udp3.fsf@ashishki-desk.ger.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Will Deacon <will.deacon@arm.com> writes:

> The aux_watermark member of struct ring_buffer represents the period (in
> terms of bytes) at which wakeup events should be generated when data is
> written to the aux buffer in non-snapshot mode. On hardware that cannot
> generate an interrupt when the aux_head reaches an arbitrary wakeup index

Curious: how do you support non-snapshot trace collection on such
hardware?

> (such as ARM SPE), the aux_head sampled from handle->head in
> perf_aux_output_{skip,end} may in fact be past the wakeup index. This

I think this is also true of hw where the interrupt is not
precise. Thanks for looking at this.

> can lead to wakeup slowly falling behind the head. For example, consider
> the case where hardware can only generate an interrupt on a page-boundary
> and the aux buffer is initialised as follows:
>
>   // Buffer size is 2 * PAGE_SIZE
>   rb->aux_head = rb->aux_wakeup = 0
>   rb->aux_watermark = PAGE_SIZE / 2
>
> following the first perf_aux_output_begin call, the handle is
> initialised with:
>
>   handle->head = 0
>   handle->size = 2 * PAGE_SIZE
>   handle->wakeup = PAGE_SIZE / 2
>
> and the hardware will be programmed to generate an interrupt at
> PAGE_SIZE.
>
> When the interrupt is raised, the hardware head will be at PAGE_SIZE,
> so calling perf_aux_output_end(handle, PAGE_SIZE) puts the ring buffer
> into the following state:
>
>   rb->aux_head = PAGE_SIZE
>   rb->aux_wakeup = PAGE_SIZE / 2
>   rb->aux_watermark = PAGE_SIZE / 2
>
> and then the next call to perf_aux_output_begin will result in:
>
>   handle->head = handle->wakeup = PAGE_SIZE
>
> for which the semantics are unclear and, for a smaller aux_watermark
> (e.g. PAGE_SIZE / 4), then the wakeup would in fact be behind head at
> this point.
>
> This patch fixes the problem by rounding down the aux_head (as sampled
> from the handle) to the nearest aux_watermark boundary when updating
> rb->aux_wakeup, therefore taking into account any overruns by the
> hardware.

Let's add a small comment to the @aux_wakeup field definition? Other
than that,

Acked-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>

>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Reported-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
>  kernel/events/ring_buffer.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
> index 330df5a7f762..8e511e52fc1b 100644
> --- a/kernel/events/ring_buffer.c
> +++ b/kernel/events/ring_buffer.c
> @@ -455,7 +455,7 @@ void perf_aux_output_end(struct perf_output_handle *handle, unsigned long size)
>  
>  	if (aux_head - rb->aux_wakeup >= rb->aux_watermark) {
>  		wakeup = true;
> -		rb->aux_wakeup += rb->aux_watermark;
> +		rb->aux_wakeup = rounddown(aux_head, rb->aux_watermark);
>  	}
>  
>  	if (wakeup) {
> @@ -490,7 +490,7 @@ int perf_aux_output_skip(struct perf_output_handle *handle, unsigned long size)
>  	aux_head = rb->user_page->aux_head = rb->aux_head;
>  	if (aux_head - rb->aux_wakeup >= rb->aux_watermark) {
>  		perf_output_wakeup(handle);
> -		rb->aux_wakeup += rb->aux_watermark;
> +		rb->aux_wakeup = rounddown(aux_head, rb->aux_watermark);
>  		handle->wakeup = rb->aux_wakeup + rb->aux_watermark;
>  	}
>  
> -- 
> 2.1.4
