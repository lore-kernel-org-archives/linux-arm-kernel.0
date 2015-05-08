From: vinod.koul@intel.com (Vinod Koul)
Date: Fri, 8 May 2015 10:06:16 +0530
Subject: [PATCH v2 1/5] Documentation: dmaengine: pxa-dma design
In-Reply-To: <1428781236-25806-2-git-send-email-robert.jarzmik@free.fr>
References: <1428781236-25806-1-git-send-email-robert.jarzmik@free.fr>
 <1428781236-25806-2-git-send-email-robert.jarzmik@free.fr>
Message-ID: <20150508043616.GY3521@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 11, 2015 at 09:40:32PM +0200, Robert Jarzmik wrote:
> Document the new design of the pxa dma driver.
> 
> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
> ---
>  Documentation/dmaengine/pxa_dma.txt | 157 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 157 insertions(+)
>  create mode 100644 Documentation/dmaengine/pxa_dma.txt
> 
> diff --git a/Documentation/dmaengine/pxa_dma.txt b/Documentation/dmaengine/pxa_dma.txt
> new file mode 100644
> index 0000000..63db9fe
> --- /dev/null
> +++ b/Documentation/dmaengine/pxa_dma.txt
> @@ -0,0 +1,157 @@
> +PXA/MMP - DMA Slave controller
> +==============================
> +
> +Constraints
> +-----------
> +  a) Transfers hot queuing
> +     A driver submitting a transfer and issuing it should be granted the transfer
> +     is queued even on a running DMA channel.
this is bit confusing, esp latter part.. do you mean "A driver submitting a
transfer and issuing it should be granted the transfer queue even on a
running DMA channel" ??

> +     This implies that the queuing doesn't wait for the previous transfer end,
> +     and that the descriptor chaining is not only done in the irq/tasklet code
> +     triggered by the end of the transfer.
how is it differenat than current dmaengine semantics where you say
issue_pending() is invoked when current transfer finished? Here is you have
to do descriptor chaining so bit it.
> +
> +  b) All transfers having asked for confirmation should be signaled
> +     Any issued transfer with DMA_PREP_INTERRUPT should trigger a callback call.
> +     This implies that even if an irq/tasklet is triggered by end of tx1, but
> +     at the time of irq/dma tx2 is already finished, tx1->complete() and
> +     tx2->complete() should be called.
> +
> +  c) Channel residue calculation
> +     A channel should be able to report how much advanced is a transfer. The
in a							    ^^^^
> +     granularity is still descriptor based.
This is not pxa specfic

> +
> +  d) Channel running state
> +     A driver should be able to query if a channel is running or not. For the
> +     multimedia case, such as video capture, if a transfer is submitted and then
> +     a check of the DMA channel reports a "stopped channel", the transfer should
> +     not be issued until the next "start of frame interrupt", hence the need to
> +     know if a channel is in running or stopped state.
How do you query that?

> +
> +  e) Bandwidth guarantee
> +     The PXA architecture has 4 levels of DMAs priorities : high, normal, low.
> +     The high prorities get twice as much bandwidth as the normal, which get twice
> +     as much as the low priorities.
> +     A driver should be able to request a priority, especially the real-time
> +     ones such as pxa_camera with (big) throughputs.
and how..?

> +
> +  f) Transfer reusability
> +     An issued and finished transfer should be "reusable". The choice of
> +     "DMA_CTRL_ACK" should be left to the client, not the dma driver.
again how is this pxa specfic, if not documented we should move this to
dmaengine documentation

-- 
~Vinod
