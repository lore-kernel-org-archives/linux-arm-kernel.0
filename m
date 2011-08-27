From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Sat, 27 Aug 2011 20:31:25 +0400
Subject: [PATCH] usb: ehci: fix update qtd->token in qh_append_tds
In-Reply-To: <1314456515-16419-1-git-send-email-ming.lei@canonical.com>
References: <1314456515-16419-1-git-send-email-ming.lei@canonical.com>
Message-ID: <4E591BDD.10600@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 27-08-2011 18:48, ming.lei at canonical.com wrote:

> From: Ming Lei<ming.lei@canonical.com>

> This patch fixs one performance bug on ARM Cortex A9 dual core platform,
> which has been reported on quite a few ARM machines(OMAP4, Tegra 2, snowball...),
> see details from link of https://bugs.launchpad.net/bugs/709245.

> In fact, one mb() on ARM is enough to flush L2 cache, but
> 'dummy->hw_token = token;' after mb() is added just for obeying
> correct mb() usage.

> The patch has been tested ok on OMAP4 panda A1 board, the performance
> of 'dd' over usb mass storage can be increased from 4~5MB/sec to
> 14~16MB/sec after applying this patch.

> Signed-off-by: Ming Lei<ming.lei@canonical.com>
> ---
>   drivers/usb/host/ehci-q.c |   14 ++++++++++++++
>   1 files changed, 14 insertions(+), 0 deletions(-)

> diff --git a/drivers/usb/host/ehci-q.c b/drivers/usb/host/ehci-q.c
> index 0917e3a..65b5021 100644
> --- a/drivers/usb/host/ehci-q.c
> +++ b/drivers/usb/host/ehci-q.c
> @@ -1082,6 +1082,20 @@ static struct ehci_qh *qh_append_tds (
>   			wmb ();
>   			dummy->hw_token = token;
>
> +			/* The mb() below is added to make sure that
> +			 * 'token' can be writen into qtd, so that ehci
> +			 * HC can see the up-to-date qtd descriptor. On
> +			 * some archs(at least on ARM Cortex A9 dual core),
> +			 * writing into coherenet memory doesn't mean the
> +			 * value written can reach physical memory
> +			 * immediately, and the value may be buffered
> +			 * inside L2 cache. 'dummy->hw_token = token;'

    You meant 'token = dummy->hw_token;'?

> +			 * after mb() is added for obeying correct mb()
> +			 * usage.
> +			 * */
> +			mb();
> +			token = dummy->hw_token;
> +
>   			urb->hcpriv = qh_get (qh);
>   		}
>   	}

WBR, Sergei
