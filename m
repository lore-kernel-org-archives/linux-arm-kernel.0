From: tj@kernel.org (Tejun Heo)
Date: Sat, 18 Jan 2014 23:46:43 -0500
Subject: [RFC v3 01/13] libahci: Allow drivers to override start_engine
In-Reply-To: <1390088935-7193-2-git-send-email-hdegoede@redhat.com>
References: <1390088935-7193-1-git-send-email-hdegoede@redhat.com>
 <1390088935-7193-2-git-send-email-hdegoede@redhat.com>
Message-ID: <20140119044643.GH3640@htj.dyndns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello, Hans.

On Sun, Jan 19, 2014 at 12:48:43AM +0100, Hans de Goede wrote:
>  void ahci_start_engine(struct ata_port *ap)
>  {
>  	void __iomem *port_mmio = ahci_port_base(ap);
> +	struct ahci_host_priv *hpriv = ap->host->private_data;
>  	u32 tmp;
>  
> +	if (hpriv->start_engine) {
> +		hpriv->start_engine(ap);
> +		return;
> +	}
> +

I'd much prefer if the driver always calls hpriv->start_engine() which
is initialized to the default callback during common init and then
overridden if necessary.

Thanks.

-- 
tejun
