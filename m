From: thomas.petazzoni@bootlin.com (Thomas Petazzoni)
Date: Thu, 29 Mar 2018 13:42:59 +0200
Subject: [PATCH 1/2] net: mvneta: split rxq/txq init into SW and HW parts
In-Reply-To: <20180329181356.6489ee2e@xhacker.debian>
References: <20180329181220.61d63c92@xhacker.debian>
 <20180329181356.6489ee2e@xhacker.debian>
Message-ID: <20180329134259.3fe6165b@windsurf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Thu, 29 Mar 2018 18:13:56 +0800, Jisheng Zhang wrote:
> This is to prepare the suspend/resume improvement in next patch. The
> SW parts can be optimized out during resume.
> 
> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>

Thanks, I have two very minor nits below, but otherwise:

Acked-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>

> +/* Create a specified RX queue */
> +static int mvneta_rxq_init(struct mvneta_port *pp,
> +			   struct mvneta_rx_queue *rxq)
> +
> +{
> +	int ret;
> +
> +	ret = mvneta_rxq_sw_init(pp, rxq);
> +	if (ret)

Here you're testing if (ret), while in mvneta_txq_init(), in the same
situation, you're doing if (ret < 0). I don't have a preference for one
or the other, but having them consistent between the two lpaces would
be nice.

> -/* Create and initialize a tx queue */
> -static int mvneta_txq_init(struct mvneta_port *pp,
> -			   struct mvneta_tx_queue *txq)
> +static int mvneta_txq_sw_init(struct mvneta_port *pp,
> +			      struct mvneta_tx_queue *txq)
>  {
>  	int cpu;
>  
> @@ -2872,7 +2889,6 @@ static int mvneta_txq_init(struct mvneta_port *pp,
>  	txq->tx_stop_threshold = txq->size - MVNETA_MAX_SKB_DESCS;
>  	txq->tx_wake_threshold = txq->tx_stop_threshold / 2;
>  
> -

Spurious change.

Thanks!

Thomas Petazzoni
-- 
Thomas Petazzoni, CTO, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
