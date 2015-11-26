From: simon.guinot@sequanux.org (Simon Guinot)
Date: Thu, 26 Nov 2015 17:45:40 +0100
Subject: [PATCH 06/13] net: mvneta: enable mixed egress processing using
 HR timer
In-Reply-To: <1448178839-3541-7-git-send-email-mw@semihalf.com>
References: <1448178839-3541-1-git-send-email-mw@semihalf.com>
 <1448178839-3541-7-git-send-email-mw@semihalf.com>
Message-ID: <20151126164540.GH4665@kw.sim.vm.gnt>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marcin,

On Sun, Nov 22, 2015 at 08:53:52AM +0100, Marcin Wojtas wrote:
> Mixed approach allows using higher interrupt threshold (increased back to
> 15 packets), useful in high throughput. In case of small amount of data
> or very short TX queues HR timer ensures releasing buffers with small
> latency.
> 
> Along with existing tx_done processing by coalescing interrupts this
> commit enables triggering HR timer each time the packets are sent.
> Time threshold can also be configured, using ethtool.
> 
> Signed-off-by: Marcin Wojtas <mw@semihalf.com>
> Signed-off-by: Simon Guinot <simon.guinot@sequanux.org>
> ---
>  drivers/net/ethernet/marvell/mvneta.c | 89 +++++++++++++++++++++++++++++++++--
>  1 file changed, 85 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
> index 9c9e858..f5acaf6 100644
> --- a/drivers/net/ethernet/marvell/mvneta.c
> +++ b/drivers/net/ethernet/marvell/mvneta.c
> @@ -21,6 +21,8 @@
>  #include <linux/module.h>
>  #include <linux/interrupt.h>
>  #include <linux/if_vlan.h>
> +#include <linux/hrtimer.h>
> +#include <linux/ktime.h>

ktime.h is already included by hrtimer.h.

>  #include <net/ip.h>
>  #include <net/ipv6.h>
>  #include <linux/io.h>
> @@ -226,7 +228,8 @@
>  /* Various constants */
>  
>  /* Coalescing */
> -#define MVNETA_TXDONE_COAL_PKTS		1
> +#define MVNETA_TXDONE_COAL_PKTS		15
> +#define MVNETA_TXDONE_COAL_USEC		100

Maybe we should keep the default configuration and let the user choose
to enable (or not) this feature ?

>  #define MVNETA_RX_COAL_PKTS		32
>  #define MVNETA_RX_COAL_USEC		100
>  
> @@ -356,6 +359,11 @@ struct mvneta_port {
>  	struct net_device *dev;
>  	struct notifier_block cpu_notifier;
>  
> +	/* Egress finalization */
> +	struct tasklet_struct tx_done_tasklet;
> +	struct hrtimer tx_done_timer;
> +	bool timer_scheduled;

I think we could use hrtimer_is_queued() instead of introducing a new
variable.

[...]

Simon
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151126/87426bb2/attachment.sig>
