From: clabbe.montjoie@gmail.com (Corentin Labbe)
Date: Mon, 14 Nov 2016 13:33:50 +0100
Subject: [PATCH 3/5] net: thunderx: Fix configuration of L3/L4 length
 checking
In-Reply-To: <1479120886-13425-4-git-send-email-sunil.kovvuri@gmail.com>
References: <1479120886-13425-1-git-send-email-sunil.kovvuri@gmail.com>
 <1479120886-13425-4-git-send-email-sunil.kovvuri@gmail.com>
Message-ID: <20161114123350.GA2449@Red>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 14, 2016 at 04:24:44PM +0530, sunil.kovvuri at gmail.com wrote:
> From: Sunil Goutham <sgoutham@cavium.com>
> 
> This patch fixes enabling of HW verification of L3/L4 length and
> TCP/UDP checksum which is currently being cleared. Also fixed VLAN
> stripping config which is being cleared when multiqset is enabled.
> 
> Signed-off-by: Sunil Goutham <sgoutham@cavium.com>
> ---
>  drivers/net/ethernet/cavium/thunder/nicvf_queues.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/cavium/thunder/nicvf_queues.c b/drivers/net/ethernet/cavium/thunder/nicvf_queues.c
> index f0e0ca6..3050177 100644
> --- a/drivers/net/ethernet/cavium/thunder/nicvf_queues.c
> +++ b/drivers/net/ethernet/cavium/thunder/nicvf_queues.c
> @@ -538,9 +538,12 @@ static void nicvf_rcv_queue_config(struct nicvf *nic, struct queue_set *qs,
>  	mbx.rq.cfg = (1ULL << 62) | (RQ_CQ_DROP << 8);
>  	nicvf_send_msg_to_pf(nic, &mbx);
>  
> -	nicvf_queue_reg_write(nic, NIC_QSET_RQ_GEN_CFG, 0, 0x00);
> -	if (!nic->sqs_mode)
> +	if (!nic->sqs_mode && (qidx == 0)) {
> +		/* Enable checking L3/L4 length and TCP/UDP checksums */
> +		nicvf_queue_reg_write(nic, NIC_QSET_RQ_GEN_CFG, 0,
> +				      ((1 << 24) | (1 << 23) | (1 << 21)));

Hello

You could use the BIT() macro here

Regards
