From: kevin.wells@nxp.com (Kevin Wells)
Date: Thu, 17 Mar 2011 23:08:06 +0100
Subject: [PATCH 3/9] lpc2k: clk API
In-Reply-To: <1300377264-10843-4-git-send-email-ithamar.adema@team-embedded.nl>
References: <1300377264-10843-1-git-send-email-ithamar.adema@team-embedded.nl>
	<1300377264-10843-4-git-send-email-ithamar.adema@team-embedded.nl>
Message-ID: <083DF309106F364B939360100EC290F80B15AC2B3B@eu1rdcrdc1wx030.exi.nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> +struct clk {
> +	int		refcount;
> +	struct clk	*parent;
> +	unsigned long	rate;
> +
> +	u32		enable_mask;
> +
> +	long		(*round_rate)(struct clk *clk, unsigned long rate);
> +	int		(*set_rate)(struct clk *clk, unsigned long rate);
> +	unsigned long	(*get_rate)(struct clk *clk);
> +	int		(*set_parent)(struct clk *clk, struct clk *parent);
> +};
> +
> +static DEFINE_MUTEX(clocks_mutex);

I tried this lock mechanism and occasionally I get warnings when mutex
checking is enabled and multiple calls occur to the clk_* functions
with active clock management. Spinlocks might be better, but maybe some
one else can chime in here.

> +
> +/*-----------------------------------------------------------------------
> --
> + * Standard clock functions defined in include/linux/clk.h
> + *-----------------------------------------------------------------------
> --*/
> +
