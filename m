From: andrew@lunn.ch (Andrew Lunn)
Date: Sat, 8 Dec 2012 12:53:06 +0100
Subject: [RFC v1 05/16] arm: plat-orion: introduce
 orion_{alloc,free}_cpu_win() functions
In-Reply-To: <1354917879-32073-6-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1354917879-32073-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1354917879-32073-6-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20121208115306.GF25315@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas

> + * Free an address decoding window, given its base address.
> + */
> +int __init orion_free_cpu_win(const struct orion_addr_map_cfg *cfg,
> +			      const u32 base)
> +{
> +	int win;
> +
> +	for (win = 0; win < cfg->num_wins; win++) {
> +		void __iomem *addr = cfg->win_cfg_base(cfg, win);
> +		u32 winbase = readl(addr + WIN_BASE_OFF);
> +		u32 ctrl = readl(addr + WIN_CTRL_OFF);
> +
> +		if (!(ctrl & WIN_CTRL_ENABLE))
> +			continue;
> +
> +		if (winbase == (base & 0xffff0000)) {
> +			orion_disable_cpu_win(cfg, win);
> +			return 0;
> +		}
> +	}
> +
> +	return -EINVAL;
> +}


Not a big issue, but i would of put the test for WIN_CTRL_ENABLE
inside the matched winbase if statement, also differing the readl for
ctrl to only when its needed.

     Andrew
