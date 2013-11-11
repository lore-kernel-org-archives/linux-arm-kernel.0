From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 11 Nov 2013 19:55:45 +0100
Subject: [PATCH v3 1/4] reset: Add Allwinner SoCs Reset Controller Driver
In-Reply-To: <1384165135.5191.5.camel@pizza.hi.pengutronix.de>
References: <1382707365-4776-1-git-send-email-maxime.ripard@free-electrons.com>
 <1382707365-4776-2-git-send-email-maxime.ripard@free-electrons.com>
 <1384165135.5191.5.camel@pizza.hi.pengutronix.de>
Message-ID: <20131111185545.GW26440@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Philipp,

On Mon, Nov 11, 2013 at 11:18:55AM +0100, Philipp Zabel wrote:
> > +static int sunxi_reset_assert(struct reset_controller_dev *rcdev,
> > +			      unsigned long id)
> > +{
> > +	struct sunxi_reset_data *data = container_of(rcdev,
> > +						     struct sunxi_reset_data,
> > +						     rcdev);
> > +	int bank = id / BITS_PER_LONG;
> > +	int offset = id % BITS_PER_LONG;
> > +	u32 reg = readl(data->membase + (bank * 4));
> > +
> > +	writel(reg & ~BIT(offset), data->membase + (bank * 4));
> 
> the reset core just passes through calls to reset_controller_assert
> directly, ...
> 
> > +
> > +	return 0;
> > +}
> > +
> > +static int sunxi_reset_deassert(struct reset_controller_dev *rcdev,
> > +				unsigned long id)
> > +{
> > +	struct sunxi_reset_data *data = container_of(rcdev,
> > +						     struct sunxi_reset_data,
> > +						     rcdev);
> > +	int bank = id / BITS_PER_LONG;
> > +	int offset = id % BITS_PER_LONG;
> > +	u32 reg = readl(data->membase + (bank * 4));
> > +
> > +	writel(reg | BIT(offset), data->membase + (bank * 4));
> 
> ... so those read-modify-write cycles in sunxi_reset_assert and here
> should be protected with a lock.

Right, I'll fix this in the v3.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131111/971e9f19/attachment.sig>
