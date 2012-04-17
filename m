From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 17 Apr 2012 20:51:11 +0200
Subject: [PATCH 09/13] SPEAr: clk: Add Auxiliary Synthesizer clock
In-Reply-To: <e5ea0b5c1511fe29d1b452fb3095f4380db58455.1334660432.git.viresh.kumar@st.com>
References: <cover.1334660431.git.viresh.kumar@st.com>
 <e5ea0b5c1511fe29d1b452fb3095f4380db58455.1334660432.git.viresh.kumar@st.com>
Message-ID: <20120417185111.GH3852@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 17, 2012 at 04:45:41PM +0530, Viresh Kumar wrote:
> All SPEAr SoC's contain Auxiliary Synthesizers. Their Fout is derived based on
> values of eq, x and y.
> 
> +static unsigned long clk_aux_recalc_rate(struct clk_hw *hw,
> +		unsigned long parent_rate)
> +{
> +	struct clk_aux *aux = to_clk_aux(hw);
> +	unsigned int num = 1, den = 1, val, eqn;
> +	unsigned long flags = 0;
> +
> +	if (aux->lock)
> +		spin_lock_irqsave(aux->lock, flags);
> +
> +	val = readl_relaxed(aux->reg);
> +
> +	if (aux->lock)
> +		spin_unlock_irqrestore(aux->lock, flags);
> +

A single read is atomic and needs no lock.

> +struct clk *clk_register_aux(const char *aux_name, const char *gate_name,
> +		const char *parent_name, unsigned long flags, void __iomem *reg,
> +		struct aux_clk_masks *masks, struct aux_rate_tbl *rtbl,
> +		u8 rtbl_cnt, spinlock_t *lock, struct clk **gate_clk)
> +{
> +	struct clk_aux *aux;
> +	struct clk *clk, *tgate_clk;
> +
> +	if (!aux_name || !gate_name || !parent_name || !reg || !rtbl ||
> +			!rtbl_cnt) {
> +		pr_err("Invalid arguments passed");
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	aux = kzalloc(sizeof(*aux), GFP_KERNEL);
> +	if (!aux) {
> +		pr_err("could not allocate aux clk\n");
> +		return NULL;
> +	}

This PTR_ERR stuff really is a pain in the ass, it's way too easy to get
it wrong. IS_ERR_OR_NULL might be a good idea, but IS_ERR is just
insane.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
