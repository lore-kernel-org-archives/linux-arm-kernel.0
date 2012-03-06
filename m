From: davem@davemloft.net (David Miller)
Date: Tue, 06 Mar 2012 16:20:17 -0500 (EST)
Subject: [PATCH v5] lpc32xx: Added ethernet driver
In-Reply-To: <1331067664-9124-1-git-send-email-stigge@antcom.de>
References: <1331067664-9124-1-git-send-email-stigge@antcom.de>
Message-ID: <20120306.162017.761246743182346842.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Roland Stigge <stigge@antcom.de>
Date: Tue,  6 Mar 2012 22:01:04 +0100

> +#define RXSTATUS_STATUS_ERROR \
> +	(RXSTATUS_NODESC | RXSTATUS_OVERRUN | RXSTATUS_ALIGN | RXSTATUS_RANGE \
> +	 | RXSTATUS_LENGTH | RXSTATUS_SYMBOL | RXSTATUS_CRC)

Should be:

#define RXSTATUS_STATUS_ERROR \
	(RXSTATUS_NODESC | RXSTATUS_OVERRUN | RXSTATUS_ALIGN | RXSTATUS_RANGE | \
	 RXSTATUS_LENGTH | RXSTATUS_SYMBOL | RXSTATUS_CRC)

> +static int lpc_eth_hard_start_xmit(struct sk_buff *skb,
> +	struct net_device *ndev);

Should be:

static int lpc_eth_hard_start_xmit(struct sk_buff *skb,
				   struct net_device *ndev);

> +struct txrx_desc_t {
> +	u32 packet;
> +	u32 control;
> +};
> +struct rx_status_t {
> +	u32 statusinfo;
> +	u32 statushashcrc;
> +};

What is the endianness of these descriptors?  Based upon the answer to
that question use __be32 or __le32  instead of u32.

> +static void __lpc_eth_clock_enable(struct netdata_local *pldat,
> +	int enable)

Should be:

static void __lpc_eth_clock_enable(struct netdata_local *pldat,
				   int enable)

And you should also use "bool" for enable and pass in true/false
at the call sites.

> +	writel((LPC_MACINT_RXDONEINTEN | LPC_MACINT_TXDONEINTEN),
> +		LPC_ENET_INTENABLE(regbase));

Should be:

	writel((LPC_MACINT_RXDONEINTEN | LPC_MACINT_TXDONEINTEN),
	       LPC_ENET_INTENABLE(regbase));

> +	/* Setup base addresses in hardware to point to buffers and
> +	   descriptors */

Should be:

	/* Setup base addresses in hardware to point to buffers and
	 * descriptors.
	 */

> +	writel((ENET_TX_DESC - 1),
> +		LPC_ENET_TXDESCRIPTORNUMBER(pldat->net_base));

All of these writel() calls are improperly indented on the second and
any subsequent lines just like the one I pointed out above, fix them
all.

> +MODULE_LICENSE("GPL");
> +

Tailing empty line in this file, please remove.
