From: mathias.nyman@linux.intel.com (Mathias Nyman)
Date: Mon, 25 Sep 2017 12:59:23 +0300
Subject: [PATCH v2][for 4.14] xhci: allow TRACE to work with EVENT ring
 dequeue
In-Reply-To: <1506110113-21707-1-git-send-email-awallis@codeaurora.org>
References: <1506110113-21707-1-git-send-email-awallis@codeaurora.org>
Message-ID: <59C8D37B.6080505@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22.09.2017 22:55, Adam Wallis wrote:
> inc_deq() currently bails earlier for EVENT rings than the common return
> point of the function, due to the fact that EVENT rings do not have
> link TRBs. The unfortunate side effect of this is that the very useful
> trace_xhci_inc_deq() function is not called/usable for EVENT ring
> debug.

True, makes sense to trace the event ring deq ptr as well.

>
> This patch provides a refactor by removing the multiple return exit
> points into a single return which additionally allows for all rings to
> use the trace function.
>
> Signed-off-by: Adam Wallis <awallis@codeaurora.org>
> ---
> Changes in v2: undo accidental line removal at end of patch
>
>   drivers/usb/host/xhci-ring.c | 32 ++++++++++++++++----------------
>   1 file changed, 16 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
> index a944365..3960ba9 100644
> --- a/drivers/usb/host/xhci-ring.c
> +++ b/drivers/usb/host/xhci-ring.c
> @@ -171,23 +171,23 @@ static void inc_deq(struct xhci_hcd *xhci, struct xhci_ring *ring)
>   	if (ring->type == TYPE_EVENT) {
>   		if (!last_trb_on_seg(ring->deq_seg, ring->dequeue)) {
>   			ring->dequeue++;
> -			return;
> +		} else {
> +			if (last_trb_on_ring(ring, ring->deq_seg,
> +				ring->dequeue))
> +				ring->cycle_state ^= 1;
> +			ring->deq_seg = ring->deq_seg->next;
> +			ring->dequeue = ring->deq_seg->trbs;
> +		}
> +	} else {
> +		/* All other rings have link trbs */
> +		if (!trb_is_link(ring->dequeue)) {
> +			ring->dequeue++;
> +			ring->num_trbs_free++;
> +		}
> +		while (trb_is_link(ring->dequeue)) {
> +			ring->deq_seg = ring->deq_seg->next;
> +			ring->dequeue = ring->deq_seg->trbs;

The added level of indentation makes it a little bit messier.
How about just using goto out; instead of return?

out:
	trace_xhci_inc_deq(ring);

-Mathias
