From: davem@davemloft.net (David Miller)
Date: Sun, 10 Jun 2018 12:35:51 -0700 (PDT)
Subject: [PATCH] net: thunderx: prevent concurrent data re-writing by
 nicvf_set_rx_mode
In-Reply-To: <20180608092759.28059-1-Vadim.Lomovtsev@caviumnetworks.com>
References: <20180608092759.28059-1-Vadim.Lomovtsev@caviumnetworks.com>
Message-ID: <20180610.123551.885190586229525170.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Vadim Lomovtsev <Vadim.Lomovtsev@caviumnetworks.com>
Date: Fri,  8 Jun 2018 02:27:59 -0700

> +	/* Save message data locally to prevent them from
> +	 * being overwritten by next ndo_set_rx_mode call().
> +	 */
> +	spin_lock(&nic->rx_mode_wq_lock);
> +	mode = vf_work->mode;
> +	mc = vf_work->mc;
> +	vf_work->mc = NULL;
> +	spin_unlock(&nic->rx_mode_wq_lock);

At the moment you drop this lock, the memory behind 'mc' can be
freed up by:

> +	spin_lock(&nic->rx_mode_wq_lock);
> +	kfree(nic->rx_mode_work.mc);

And you'll crash when you dereference it above via
__nicvf_set_rx_mode_task().
