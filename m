From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 03 Nov 2014 19:08:21 +0100
Subject: [PATCH 07/17] bus: mvebu-mbus: suspend/resume support
In-Reply-To: <1414151970-6626-8-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1414151970-6626-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1414151970-6626-8-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <5457C495.7080403@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

[...]

>  struct mvebu_mbus_state {
>  	void __iomem *mbuswins_base;
>  	void __iomem *sdramwins_base;
> +	void __iomem *mbusbridge_base;

Here you store the information about the availability of the register needed
for suspend/resume ...

[...]


> +static int mvebu_mbus_suspend(void)
> +{
> +	struct mvebu_mbus_state *s = &mbus_state;
> +	int win;
> +
> +	for (win = 0; win < s->soc->num_wins; win++) {
> +		void __iomem *addr = s->mbuswins_base +
> +			s->soc->win_cfg_offset(win);
> +
> +		s->wins[win].base = readl(addr + WIN_BASE_OFF);
> +		s->wins[win].ctrl = readl(addr + WIN_CTRL_OFF);
> +
> +		if (win >= s->soc->num_remappable_wins)
> +			continue;
> +
> +		s->wins[win].remap_lo = readl(addr + WIN_REMAP_LO_OFF);
> +		s->wins[win].remap_hi = readl(addr + WIN_REMAP_HI_OFF);
> +	}
> +
> +	if (s->mbusbridge_base) {
> +		s->mbus_bridge_ctrl = readl(s->mbusbridge_base +
> +					    MBUS_BRIDGE_CTRL_OFF);
> +		s->mbus_bridge_base = readl(s->mbusbridge_base +
> +					    MBUS_BRIDGE_BASE_OFF);
> +	}

... so here could you exit with an error if the register is not available.
Then it would prevent to enter in suspend instead of crashing the system.


Thanks,

Gregory



-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
