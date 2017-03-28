From: davem@davemloft.net (David Miller)
Date: Mon, 27 Mar 2017 20:50:26 -0700 (PDT)
Subject: [PATCH v2] net: moxa: fix TX overrun memory leak
In-Reply-To: <1490617879-14014-1-git-send-email-jonas.jensen@gmail.com>
References: <1490617879-14014-1-git-send-email-jonas.jensen@gmail.com>
Message-ID: <20170327.205026.1935467634311224337.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jonas Jensen <jonas.jensen@gmail.com>
Date: Mon, 27 Mar 2017 14:31:19 +0200

> @@ -25,6 +25,7 @@
>  #include <linux/of_irq.h>
>  #include <linux/crc32.h>
>  #include <linux/crc32c.h>
> +#include <linux/circ_buf.h>
>  
>  #include "moxart_ether.h"
>  
> @@ -297,6 +298,7 @@ static void moxart_tx_finished(struct net_device *ndev)
>  		tx_tail = TX_NEXT(tx_tail);
>  	}
>  	priv->tx_tail = tx_tail;
> +	netif_wake_queue(ndev);
>  }
>  
>  static irqreturn_t moxart_mac_interrupt(int irq, void *dev_id)

Doing the wakeup unconditionally is very wasteful, you just need to do it
when enough space has been made available.

Therefore the wakeup should be more like:

	if (netif_queue_stopped(ndev) &&
	    moxart_tx_queue_space(ndev) >= MOXART_TX_WAKEUP_THRESHOLD)
		netif_wake_queue();

Otherwise you're just going to flap back and forth under high load and
get almost not packet batching at all, hurting performance.
