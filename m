From: davem@davemloft.net (David Miller)
Date: Mon, 29 Sep 2014 15:52:00 -0400 (EDT)
Subject: [PATCH v5 2/3] net: Add Keystone NetCP ethernet driver
In-Reply-To: <1411667317-1163-3-git-send-email-santosh.shilimkar@ti.com>
References: <1411667317-1163-1-git-send-email-santosh.shilimkar@ti.com>
 <1411667317-1163-3-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <20140929.155200.2231132602322345812.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Date: Thu, 25 Sep 2014 13:48:36 -0400

> +static inline int gbe_phy_link_status(struct gbe_slave *slave)
> +{
> +	if (!slave->phy)
> +		return 1;
> +
> +	if (slave->phy->link)
> +		return 1;
> +
> +	return 0;
> +}

Please use 'bool' as the return type and return 'true' or 'false'.

Do not use 'inline' in foo.c files, let the compiler decide.  Please
audit this entire submission for this problem.

> +static int gbe_port_reset(struct gbe_slave *slave)
> +{
> +	u32 i, v;
> +
> +	/* Set the soft reset bit */
> +	writel_relaxed(SOFT_RESET, GBE_REG_ADDR(slave, emac_regs, soft_reset));

This driver seems to use relaxed readl and writel for almost everything.

That absolutely cannot be right.  For example, here, you depend upon the
ordering of this writel_relaxed() to reset the chip relative to the
real_relaxed() you subsequently do to check ths bits.

I seriously think that *_relaxed() should only be done in very special
circumstances where 1) the performance matters and 2) the validity of
the usage has been put under a microscope and fully documented with huge
comments above the *_relaxed() calls.

If you cannot reduce and properly document the really necessary *_relaxed()
uses, just convert them all to non-_relaxed() for now.

I'm also warning you ahead of time that since nobody else seems to feel
like reviewing this enormous submission, you are going to have to get used
to me pushing back on these changes over and over for small things like
coding style and structural/API issues until some reviews it on a higher
level.

I really don't want to apply this series until someone thinks seriously
about the driver's design and the long term ramifications of having a
driver like this in the tree with so many random TX etc. hooks.
