From: davem@davemloft.net (David Miller)
Date: Tue, 16 Sep 2014 16:45:23 -0400 (EDT)
Subject: [Patch net-next v2 2/4] net: fec: add interrupt coalescence
 feature support
In-Reply-To: <1410890290-11248-3-git-send-email-Frank.Li@freescale.com>
References: <1410890290-11248-1-git-send-email-Frank.Li@freescale.com>
 <1410890290-11248-3-git-send-email-Frank.Li@freescale.com>
Message-ID: <20140916.164523.1376753359151264152.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: <Frank.Li@freescale.com>
Date: Wed, 17 Sep 2014 01:58:08 +0800

> +/* ENET interrupt coalescing macro define */
> +#define FEC_ITR_CLK_SEL		(0x1 << 30)
> +#define FEC_ITR_EN		(0x1 << 31)
> +#define FEC_ITR_ICFT(X)		((X & 0xFF) << 20)
> +#define FEC_ITR_ICTT(X)		((X) & 0xFFFF)
> +#define FEC_ITR_ICFT_DEFAULT	200  /* Set 200 frame count threshold */
> +#define FEC_ITR_ICTT_DEFAULT	1000 /* Set 1000us timer threshold */
 ...
> +static int
> +fec_enet_set_coalesce(struct net_device *ndev, struct ethtool_coalesce *ec)

The size of these fields in the register determines the limitations of
the various parameters that this chip can support.

Therefore you must validate the user's request and signal an error if
the user asks for coalescing parameters that don't fit into those
fields.
