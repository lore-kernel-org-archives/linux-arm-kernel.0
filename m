From: ming.lei@canonical.com (Ming Lei)
Date: Thu, 1 Sep 2011 10:33:47 +0800
Subject: [PATCH 3/3] add dma_coherent_write_sync calls to USB EHCI driver
In-Reply-To: <1314826214-22428-4-git-send-email-msalter@redhat.com>
References: <1314826214-22428-1-git-send-email-msalter@redhat.com>
	<1314826214-22428-4-git-send-email-msalter@redhat.com>
Message-ID: <CACVXFVPZYj8-rCxCV6rVjSB=aa2P5vd3-jBqU1403je+fatcjw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Sep 1, 2011 at 5:30 AM, Mark Salter <msalter@redhat.com> wrote:
> The EHCI driver polls DMA coherent memory for control data written by the
> driver. On some architectures, such as ARMv7, the writes from the driver
> may get delayed in a write buffer even though it is written to DMA coherent
> memory. This delay led to serious performance issues on an ARMv7 based
> platform using a USB disk drive. Before using this patch, 'hdparm -t' showed
> a read speed of 5.7MB/s. After applying this patch, hdparm showed 23.5MB/s.
>
> Signed-off-by: Mark Salter <msalter@redhat.com>
> ---
> ?drivers/usb/host/ehci-q.c | ? ?7 ++++++-
> ?1 files changed, 6 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/usb/host/ehci-q.c b/drivers/usb/host/ehci-q.c
> index 0917e3a..75d9838 100644
> --- a/drivers/usb/host/ehci-q.c
> +++ b/drivers/usb/host/ehci-q.c
> @@ -114,6 +114,7 @@ qh_update (struct ehci_hcd *ehci, struct ehci_qh *qh, struct ehci_qtd *qtd)
> ? ? ? ?/* HC must see latest qtd and qh data before we clear ACTIVE+HALT */
> ? ? ? ?wmb ();
> ? ? ? ?hw->hw_token &= cpu_to_hc32(ehci, QTD_TOGGLE | QTD_STS_PING);
> + ? ? ? dma_coherent_write_sync();

It is not needed at all, just before the qh is linked into hw queue,
there is one
wmb to handle sync of qh correctly. Even the wmb can be removed as the patch
I have posted out in usb mail list.

> ?}
>
> ?/* if it weren't for a common silicon quirk (writing the dummy into the qh
> @@ -404,6 +405,7 @@ qh_completions (struct ehci_hcd *ehci, struct ehci_qh *qh)
> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?wmb();
> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?hw->hw_token = cpu_to_hc32(ehci,
> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?token);
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? dma_coherent_write_sync();

It is in a cold path, and if adding the helper or not does not matter.

> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?goto retry_xacterr;
> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?}
> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?stopped = 1;
> @@ -753,8 +755,10 @@ qh_urb_transaction (
> ? ? ? ?}
>
> ? ? ? ?/* by default, enable interrupt on urb completion */
> - ? ? ? if (likely (!(urb->transfer_flags & URB_NO_INTERRUPT)))
> + ? ? ? if (likely(!(urb->transfer_flags & URB_NO_INTERRUPT))) {
> ? ? ? ? ? ? ? ?qtd->hw_token |= cpu_to_hc32(ehci, QTD_IOC);
> + ? ? ? ? ? ? ? dma_coherent_write_sync();

It is not needed at all, the wmb in qh_append_tds will handle sync of
qtd correctly.

> + ? ? ? }
> ? ? ? ?return head;
>
> ?cleanup:
> @@ -1081,6 +1085,7 @@ static struct ehci_qh *qh_append_tds (
> ? ? ? ? ? ? ? ? ? ? ? ?/* let the hc process these next qtds */
> ? ? ? ? ? ? ? ? ? ? ? ?wmb ();
> ? ? ? ? ? ? ? ? ? ? ? ?dummy->hw_token = token;
> + ? ? ? ? ? ? ? ? ? ? ? dma_coherent_write_sync();

It is the only one which does make sense up to now, see discussion in

      http://marc.info/?t=131472029700001&r=1&w=2
      http://marc.info/?t=131445642100002&r=1&w=2

thanks,
--
Ming Lei
