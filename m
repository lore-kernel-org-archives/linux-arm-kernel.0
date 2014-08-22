From: davem@davemloft.net (David Miller)
Date: Thu, 21 Aug 2014 21:39:29 -0700 (PDT)
Subject: [PATCH v5 1/2] net: moxa: clear TX descriptor length bits
In-Reply-To: <1408544322-32023-1-git-send-email-jonas.jensen@gmail.com>
References: <1408459784-9385-1-git-send-email-jonas.jensen@gmail.com>
 <1408544322-32023-1-git-send-email-jonas.jensen@gmail.com>
Message-ID: <20140821.213929.2048600939729474726.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jonas Jensen <jonas.jensen@gmail.com>
Date: Wed, 20 Aug 2014 16:18:42 +0200

> @@ -348,7 +348,8 @@ static int moxart_mac_start_xmit(struct sk_buff *skb, struct net_device *ndev)
>  
>  	txdes1 = readl(desc + TX_REG_OFFSET_DESC1);
>  	txdes1 |= TX_DESC1_LTS | TX_DESC1_FTS;
> -	txdes1 &= ~(TX_DESC1_FIFO_COMPLETE | TX_DESC1_INTR_COMPLETE);
> +	txdes1 &= ~(TX_DESC1_FIFO_COMPLETE | TX_DESC1_INTR_COMPLETE |
> +		    TX_DESC1_BUF_SIZE_MASK);
>  	txdes1 |= (len & TX_DESC1_BUF_SIZE_MASK);
>  	writel(txdes1, desc + TX_REG_OFFSET_DESC1);
>  	writel(TX_DESC0_DMA_OWN, desc + TX_REG_OFFSET_DESC0);

Like others I wonder why the existing descriptor value is being read
at all.

It's inefficient and completely unnecessary, you can just compute a new
value from scratch, and that way all of these "uncleared field" issues
just automatically disappear.
