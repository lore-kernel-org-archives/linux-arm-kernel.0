From: davem@davemloft.net (David Miller)
Date: Mon, 17 Aug 2015 17:27:11 -0700 (PDT)
Subject: [PATCH v1 2/2] drivers: net: xgene: Adding support for TSO
In-Reply-To: <1439847185-22046-3-git-send-email-isubramanian@apm.com>
References: <1439847185-22046-1-git-send-email-isubramanian@apm.com>
 <1439847185-22046-3-git-send-email-isubramanian@apm.com>
Message-ID: <20150817.172711.1231947431645678967.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Iyappan Subramanian <isubramanian@apm.com>
Date: Mon, 17 Aug 2015 14:33:05 -0700

> +			/* HW requires all header resides in the first buffer */
> +			if (skb_is_nonlinear(skb) &&
> +			    (skb_headlen(skb) < hdr_len)) {
> +				netdev_warn(ndev, "Headers are required to reside in header buffer\n");
> +				dev_kfree_skb(skb);
> +				return 0;
> +			}

You can't just drop the packet in this situation.

Instead, you must at least try to linearize the header to fit your
needs.
