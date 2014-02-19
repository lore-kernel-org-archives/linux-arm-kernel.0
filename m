From: tj@kernel.org (Tejun Heo)
Date: Wed, 19 Feb 2014 09:42:00 -0500
Subject: [PATCH v6 01/18] libahci: Allow drivers to override start_engine
In-Reply-To: <1392811320-3132-2-git-send-email-hdegoede@redhat.com>
References: <1392811320-3132-1-git-send-email-hdegoede@redhat.com>
 <1392811320-3132-2-git-send-email-hdegoede@redhat.com>
Message-ID: <20140219144200.GB10134@htj.dyndns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Wed, Feb 19, 2014 at 01:01:43PM +0100, Hans de Goede wrote:
> diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
> index 2289efd..2c04211 100644
> --- a/drivers/ata/ahci.h
> +++ b/drivers/ata/ahci.h
> @@ -323,6 +323,8 @@ struct ahci_host_priv {
>  	u32			em_msg_type;	/* EM message type */
>  	struct clk		*clk;		/* Only for platforms supporting clk */
>  	void			*plat_data;	/* Other platform data */
> +	/* Optional ahci_start_engine override */
> +	void			(*start_engine)(struct ata_port *ap);

Can you please add that this gets initialized to the default during
save_initial_config and can be overridden anytime before the host is
activated?

> @@ -500,6 +501,9 @@ void ahci_save_initial_config(struct device *dev,
>  	hpriv->cap = cap;
>  	hpriv->cap2 = cap2;
>  	hpriv->port_map = port_map;
> +
> +	if (!hpriv->start_engine)
> +		hpriv->start_engine = ahci_start_engine;

Please update the function comment accordingly.

> -void ahci_start_engine(struct ata_port *ap)
> +static void ahci_start_engine(struct ata_port *ap)
>  {
>  	void __iomem *port_mmio = ahci_port_base(ap);
>  	u32 tmp;
> @@ -576,7 +580,6 @@ void ahci_start_engine(struct ata_port *ap)
>  	writel(tmp, port_mmio + PORT_CMD);
>  	readl(port_mmio + PORT_CMD); /* flush */
>  }
> -EXPORT_SYMBOL_GPL(ahci_start_engine);

Why are we making ahci_start_engine() static?  Wouldn't there likely
be users who would do more things before or after ahci_start_engine()?
Also, why is there no explanation of this change in the patch
description?

Thanks.

-- 
tejun
