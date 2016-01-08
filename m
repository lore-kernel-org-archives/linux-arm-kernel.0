From: tj@kernel.org (Tejun Heo)
Date: Fri, 8 Jan 2016 11:36:10 -0500
Subject: [PATCH 3/4] drivers: ata: wake port before DMA stop for ALPM
In-Reply-To: <1452211413-1350-4-git-send-email-f.fainelli@gmail.com>
References: <1452211413-1350-1-git-send-email-f.fainelli@gmail.com>
 <1452211413-1350-4-git-send-email-f.fainelli@gmail.com>
Message-ID: <20160108163610.GS1898@mtj.duckdns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Thu, Jan 07, 2016 at 04:03:32PM -0800, Florian Fainelli wrote:
> diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
> index d61740e78d6d..b6664c579f9a 100644
> --- a/drivers/ata/libahci.c
> +++ b/drivers/ata/libahci.c
> @@ -595,6 +595,58 @@ int ahci_stop_engine(struct ata_port *ap)
>  	void __iomem *port_mmio = ahci_port_base(ap);
>  	u32 tmp;
>  
> +	/*
> +	 * On some controllers, stopping a port's DMA engine
> +	 * while the port is in ALPM state (partial or slumber)
> +	 * results in failures on subsequent DMA engine starts.
> +	 * For those controllers, put the port back in active
> +	 * state before stopping it's DMA engine.
> +	 */
> +	if (ap->flags2 & ATA_FLAG2_WAKE_BEFORE_STOP) {
...

So, I'm not too comfortable with open coding ALPM switching in
ahci_stop_engine().  Shouldn't it be possible to update and/or
refactor and reuse ahci_set_lpm()?

> --- a/include/linux/libata.h
> +++ b/include/linux/libata.h
> @@ -236,6 +236,8 @@ enum {
>  
>  	/* bits 24:31 of ap->flags are reserved for LLD specific flags */
>  
> +	/* struct ata_port flags2 */
> +	ATA_FLAG2_WAKE_BEFORE_STOP = (1 << 0), /* wake link before DMA stop */

What's wrong with bits 2-5 in ATA_FLAG_* space?  Also, should this be
a ahci priv flag?

Thanks.

-- 
tejun
