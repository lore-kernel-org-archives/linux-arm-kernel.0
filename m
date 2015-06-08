From: davem@davemloft.net (David Miller)
Date: Sun, 07 Jun 2015 19:22:02 -0700 (PDT)
Subject: [PATCH] net: moxa: fix TX overrun memory leak
In-Reply-To: <1433511978-17666-1-git-send-email-jonas.jensen@gmail.com>
References: <1433511978-17666-1-git-send-email-jonas.jensen@gmail.com>
Message-ID: <20150607.192202.705812138482774611.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jonas Jensen <jonas.jensen@gmail.com>
Date: Fri,  5 Jun 2015 15:46:18 +0200

>  	desc = priv->tx_desc_base + (TX_REG_DESC_SIZE * tx_head);
>  
> -	spin_lock_irq(&priv->txlock);
> +	if (CIRC_SPACE(tx_head, tx_tail, TX_DESC_NUM) == 0) {
> +		priv->stats.tx_dropped++;
> +		goto out_unlock;
> +	}

You can't do this.

Whatever code creates this condition _must_ stop the TX queue
so that the core netdevice transmit layer does not call your
transmit method.
