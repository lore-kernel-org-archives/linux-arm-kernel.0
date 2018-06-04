From: richardcochran@gmail.com (Richard Cochran)
Date: Mon, 4 Jun 2018 06:49:20 -0700
Subject: [PATCH 09/10] dpaa_eth: add support for hardware timestamping
In-Reply-To: <20180604070837.19265-10-yangbo.lu@nxp.com>
References: <20180604070837.19265-1-yangbo.lu@nxp.com>
 <20180604070837.19265-10-yangbo.lu@nxp.com>
Message-ID: <20180604134920.ezhe6jz5ntpnqyzj@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 04, 2018 at 03:08:36PM +0800, Yangbo Lu wrote:

> +if FSL_DPAA_ETH
> +config FSL_DPAA_ETH_TS
> +	bool "DPAA hardware timestamping support"
> +	select PTP_1588_CLOCK_QORIQ
> +	default n
> +	help
> +	  Enable DPAA hardware timestamping support.
> +	  This option is useful for applications to get
> +	  hardware time stamps on the Ethernet packets
> +	  using the SO_TIMESTAMPING API.
> +endif

You should drop this #ifdef.  In general, if a MAC supports time
stamping and PHC, then the driver support should simply be compiled
in.

[ When time stamping incurs a large run time performance penalty to
  non-PTP users, then it might make sense to have a Kconfig option to
  disable it, but that doesn't appear to be the case here. ]

> @@ -1615,6 +1635,24 @@ static int dpaa_eth_refill_bpools(struct dpaa_priv *priv)
>  	skbh = (struct sk_buff **)phys_to_virt(addr);
>  	skb = *skbh;
>  
> +#ifdef CONFIG_FSL_DPAA_ETH_TS
> +	if (priv->tx_tstamp &&
> +	    skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP) {

This condition fits on one line easily.

> +		struct skb_shared_hwtstamps shhwtstamps;
> +		u64 ns;

Local variables belong at the top of the function.

> +		memset(&shhwtstamps, 0, sizeof(shhwtstamps));
> +
> +		if (!dpaa_get_tstamp_ns(priv->net_dev, &ns,
> +					priv->mac_dev->port[TX],
> +					(void *)skbh)) {
> +			shhwtstamps.hwtstamp = ns_to_ktime(ns);
> +			skb_tstamp_tx(skb, &shhwtstamps);
> +		} else {
> +			dev_warn(dev, "dpaa_get_tstamp_ns failed!\n");
> +		}
> +	}
> +#endif
>  	if (unlikely(qm_fd_get_format(fd) == qm_fd_sg)) {
>  		nr_frags = skb_shinfo(skb)->nr_frags;
>  		dma_unmap_single(dev, addr, qm_fd_get_offset(fd) +
> @@ -2086,6 +2124,14 @@ static int dpaa_start_xmit(struct sk_buff *skb, struct net_device *net_dev)
>  	if (unlikely(err < 0))
>  		goto skb_to_fd_failed;
>  
> +#ifdef CONFIG_FSL_DPAA_ETH_TS
> +	if (priv->tx_tstamp &&
> +	    skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP) {

One line please.

> +		fd.cmd |= FM_FD_CMD_UPD;
> +		skb_shinfo(skb)->tx_flags |= SKBTX_IN_PROGRESS;
> +	}
> +#endif
> +
>  	if (likely(dpaa_xmit(priv, percpu_stats, queue_mapping, &fd) == 0))
>  		return NETDEV_TX_OK;
>  

Thanks,
Richard
