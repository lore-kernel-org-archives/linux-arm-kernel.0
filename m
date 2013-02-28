From: davem@davemloft.net (David Miller)
Date: Thu, 28 Feb 2013 15:39:42 -0500 (EST)
Subject: [PATCH 1/1 net-next] fec: net: put tx to napi poll function to
 fix dead lock
In-Reply-To: <1362023060-10277-1-git-send-email-Frank.Li@freescale.com>
References: <1362023060-10277-1-git-send-email-Frank.Li@freescale.com>
Message-ID: <20130228.153942.1205752844713252540.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Frank Li <Frank.Li@freescale.com>
Date: Thu, 28 Feb 2013 11:44:20 +0800

> +	int tx_pkts = fec_enet_tx(ndev);
> +
> +	if (tx_pkts)
> +		return budget;

This isn't right, you don't want to finish the NAPI poll because
TX work was done.

Ignore the TX work for poll completion purposes, see
drivers/net/ethernet/broadcom/tg3.c:tg3_poll_work() for
example.
