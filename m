From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Mon, 8 Feb 2016 11:26:56 +0100
Subject: [PATCH 1/6] irqchip: add the Alpine MSIX interrupt controller
In-Reply-To: <56B86391.1030609@arm.com>
References: <1454922971-17405-1-git-send-email-antoine.tenart@free-electrons.com>
 <1454922971-17405-2-git-send-email-antoine.tenart@free-electrons.com>
 <56B86391.1030609@arm.com>
Message-ID: <20160208102656.GA4117@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

On Mon, Feb 08, 2016 at 09:44:49AM +0000, Marc Zyngier wrote:
> On 08/02/16 09:16, Antoine Tenart wrote:
> > +
> > +/* MSIX message address format: local GIC target */
> > +#define ALPINE_MSIX_SPI_TARGET_CLUSTER0		BIT(16)
> > +
> > +struct alpine_msix_data {
> > +	spinlock_t msi_map_lock;
> > +	u32 addr_high;
> > +	u32 addr_low;
> 
> As this looks to be a physical address, please consider using phys_addr_t.

Sure.

[?]

> > +static int alpine_msix_init(struct device_node *node,
> > +			    struct device_node *parent)
> > +{
> > +	struct alpine_msix_data *priv;
> > +	struct resource res;
> > +	int ret;
> > +
> > +	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
> > +	if (!priv)
> > +		return -ENOMEM;
> > +
> > +	spin_lock_init(&priv->msi_map_lock);
> > +
> > +	ret = of_address_to_resource(node, 0, &res);
> > +	if (ret) {
> > +		pr_err("Failed to allocate resource\n");
> > +		goto err_priv;
> > +	}
> > +
> > +	priv->addr_high = upper_32_bits((u64)res.start);
> > +	priv->addr_low = lower_32_bits(res.start) + ALPINE_MSIX_SPI_TARGET_CLUSTER0;
> 
> This is a bit odd. If you always set bit 16, why isn't that reflected in
> the base address coming from the DT?

The 20 least significant bits of addr_low provide direct information
regarding the interrupt destination, so I thought it would be clearer
to have this explicitly in the driver so that we know what those bits
mean.

What do you think?


Thanks for the review!

Antoine

-- 
Antoine T?nart, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160208/bd26f3fe/attachment-0001.sig>
