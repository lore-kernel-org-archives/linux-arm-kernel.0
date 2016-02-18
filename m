From: davem@davemloft.net (David Miller)
Date: Wed, 17 Feb 2016 23:43:21 -0500 (EST)
Subject: [PATCH v2 net-next 6/8] net: mvneta: bm: add support for
 hardware buffer management
In-Reply-To: <1455636823-14470-7-git-send-email-gregory.clement@free-electrons.com>
References: <1455636823-14470-1-git-send-email-gregory.clement@free-electrons.com>
 <1455636823-14470-7-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20160217.234321.1202099534402079240.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Date: Tue, 16 Feb 2016 16:33:41 +0100

>  	pp->dev = dev;
>  	SET_NETDEV_DEV(dev, &pdev->dev);
>  
> +	dev->features = NETIF_F_SG | NETIF_F_IP_CSUM | NETIF_F_TSO;
> +	dev->hw_features |= dev->features;
> +	dev->vlan_features |= dev->features;
> +	dev->priv_flags |= IFF_UNICAST_FLT;
> +	dev->gso_max_segs = MVNETA_MAX_TSO_SEGS;
> +
> +	err = register_netdev(dev);
> +	if (err < 0) {
> +		dev_err(&pdev->dev, "failed to register\n");
> +		goto err_free_stats;
> +	}
> +
> +	pp->id = dev->ifindex;
> +
> +	/* Obtain access to BM resources if enabled and already initialized */
> +	bm_node = of_parse_phandle(dn, "buffer-manager", 0);
> +	if (bm_node && bm_node->data) {

This set of changes has a lot of problems.

First, the exact moment you call register_netdev() your device must be
fully initialized because ->open() can be invoked immediately.  This
means you must take care of all of this buffer manager stuff before
calling register_netdev().

It must precisely be the last thing you invoke in your probe function
for this reason.

Also you are now adding conditionalized code to every fastpath in your
driver, that is rediculous and is going to hurt performance.

Add seperate code paths for the HWBM vs SWBM, and register a unique
set of netdev_ops as appropriate.
