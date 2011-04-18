From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 18 Apr 2011 08:56:03 +0200
Subject: [PATCH V14 3/4] ptp: Added a clock driver for the IXP46x.
In-Reply-To: <dbee2487a57fd7f41e4efbbd2ddfb1313b8d71bc.1303107532.git.richard.cochran@omicron.at>
References: <cover.1303107532.git.richard.cochran@omicron.at>
	<dbee2487a57fd7f41e4efbbd2ddfb1313b8d71bc.1303107532.git.richard.cochran@omicron.at>
Message-ID: <201104180856.04186.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 18 April 2011, Richard Cochran wrote:
> +static void ixp_rx_timestamp(struct port *port, struct sk_buff *skb)
> +{
> +       struct skb_shared_hwtstamps *shhwtstamps;
> +       struct ixp46x_ts_regs *regs;
> +       u64 ns;
> +       u32 ch, hi, lo, val;
> +       u16 uid, seq;
> +
> +       if (!port->hwts_rx_en)
> +               return;
> +
> +       ch = PORT2CHANNEL(port);
> +
> +       regs = (struct ixp46x_ts_regs __iomem *) IXP4XX_TIMESYNC_BASE_VIRT;
> +
> +       val = __raw_readl(&regs->channel[ch].ch_event);
> +
> +       if (!(val & RX_SNAPSHOT_LOCKED))
> +               return;
> +
> +       lo = __raw_readl(&regs->channel[ch].src_uuid_lo);
> +       hi = __raw_readl(&regs->channel[ch].src_uuid_hi);
> +

I guess you should use readl(), not __raw_readl() here. The __raw_* functions
are not meant for device drivers.

	Arnd
