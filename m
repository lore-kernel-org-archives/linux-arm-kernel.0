From: moinejf@free.fr (Jean-Francois Moine)
Date: Wed, 29 Jun 2016 18:55:28 +0200
Subject: [linux-sunxi] [PATCH 1/3] clk: sunxi: Add a driver for the CCU
In-Reply-To: <a827aa49-dde3-23fb-7c44-0dc8fd61948b@xff.cz>
References: <bfb8ceb4-5445-3f43-0a16-bd0e83f2af22@xff.cz>
 <536aa072-d110-1b08-fa25-72c1645e2459@xff.cz>
 <20160629085116.caf701e214440cdf4b1045c8@free.fr>
 <a827aa49-dde3-23fb-7c44-0dc8fd61948b@xff.cz>
Message-ID: <20160629185528.e05dfde8724bf672882449a2@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 29 Jun 2016 17:30:51 +0200
Ond?ej Jirman <megi@xff.cz> wrote:

> >>> +	reg = readl(ccu->base + ccu->reg);
> >>> +	m_val = reg & m_mask;
> >>> +	p_val = reg & p_mask;
> >>> +
> >>> +	spin_lock(&ccu_lock);
> >>> +
> >>> +	/* increase p, then m */
> >>> +	if (ccu->p_width && p_val < (val & p_mask)) {
> >>> +		reg &= ~p_mask;
> >>> +		reg |= val & p_mask;
> >>> +		writel(reg, ccu->base + ccu->reg);
> >>> +		udelay(10);
> >>> +	}
> >>> +	if (ccu->m_width && m_val < (val & m_mask)) {
> >>> +		reg &= ~m_mask;
> >>> +		reg |= val & m_mask;
> >>> +		writel(reg, ccu->base + ccu->reg);
> >>> +		udelay(10);
> >>> +	}
> >>> +
> >>> +	/* set other factors */
> >>> +	reg &= ~(mask & ~(p_mask | m_mask));
> >>> +	reg |= val & ~(p_mask | m_mask);
> >>> +	writel(reg, ccu->base + ccu->reg);
> >>> +
> >>> +	/* decrease m */
> >>> +	if (ccu->m_width && m_val > (val & m_mask)) {
> >>> +		reg &= ~m_mask;
> >>> +		reg |= val & m_mask;
> >>> +		writel(reg, ccu->base + ccu->reg);
> >>> +		udelay(10);
> >>> +	}
> >>> +
> >>> +	/* wait for PLL stable */
> >>> +	if (ccu->lock_reg) {
> >>> +		u32 lock;
> >>> +
> >>> +		lock = BIT(ccu->lock_bit);
> >>> +		WARN_ON(readl_relaxed_poll_timeout(ccu->base + ccu->lock_reg,
> >>> +							reg, !(reg & lock),
> >>> +							100, 70000));
> >>> +	}
> > 	[snip]
> >>
> >> Any reason why you're waiting for the lock after decreasing m and not
> >> before? PLL output may till run too fast before reducing the postdivider
> >> potentially causing a crash. But I might be misunderstanding what m is
> >> exactly.
> > 
> > I just followed what is done in the function
> >  sunxi_clk_factors_set_flat_facotrs() from Allwinnertech:
> > 
> > 	1).try to increase factor p first
> > 	2).try to increase factor m first
> > 	3. write factor n & k
> > 	4. do pair things for 2). decease factor m
> > 	5. wait for PLL state stable
> > 	6.do pair things for 1).  decease factor p
> > 
> > As this is written, it seems m is a pre-divider.
> > 
> 
> Interesting. :) I've reverse engineered their arisc code, and there the
> order for setting up/changing PLL1 is:
> 
> 1. try to increase factor p first
> 2. try to increase factor m first
> 3. write factor n & k
> 4. wait for PLL state stable
> 5. do pair things for 2). decease factor m
> 6. do pair things for 1).  decease factor p
> 
> That's why I asked.
> 
> So all this depends on the design of this clock source. It may be
> different for different PLLs.

>From the SDK of the sun8i/9i families, this way to change the PLL
clocks is needed only for the PLL CPU of the SoCs sun8i7w (H3) and
sun8iw8 (other name unknown).

> Hard to know what to believe. Perhaps it would be possible to create a
> PLL stress tester that would try both approaches and see whether one of
> them is more stable/leads to creashes?

Not easy to do...

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
