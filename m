From: jiang.liu@linux.intel.com (Jiang Liu)
Date: Wed, 17 Jun 2015 17:02:20 +0800
Subject: [PATCH] ahci, msix: Fix build error for !PCI_MSI
In-Reply-To: <20150617084852.GL4914@rric.localhost>
References: <1433526566-21136-1-git-send-email-rric@kernel.org>
 <20150616132434.GO10428@rric.localhost>
 <20150616201341.GD22637@mtj.duckdns.org>
 <20150617084852.GL4914@rric.localhost>
Message-ID: <5581379C.3090607@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015/6/17 16:48, Robert Richter wrote:
> From fd984f3be22f27b8d3c4cf577dbbf0a39792ea89 Mon Sep 17 00:00:00 2001
> From: Robert Richter <rrichter@cavium.com>
> Date: Wed, 17 Jun 2015 10:33:22 +0200
> Subject: [PATCH] ahci, msix: Fix build error for !PCI_MSI
> MIME-Version: 1.0
> Content-Type: text/plain; charset=UTF-8
> Content-Transfer-Encoding: 8bit
> 
> Fixing a build error if PCI_MSI is unset:
> 
>  drivers/ata/ahci.c: In function ?msix_get_desc?:
>  drivers/ata/ahci.c:1210:2: error: ?struct pci_dev? has no member named ?msi_list?
> 
> Catched by Fengguang's build bot.
> 
> Reported-by: kbuild test robot <fengguang.wu@intel.com>
> Signed-off-by: Robert Richter <rrichter@cavium.com>
> ---
>  drivers/ata/ahci.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index bdedaa4f9d7b..99cc9526ae95 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -1205,13 +1205,14 @@ static inline void ahci_gtf_filter_workaround(struct ata_host *host)
>  
>  static struct msi_desc *msix_get_desc(struct pci_dev *dev, u16 entry)
>  {
> +#ifdef CONFIG_PCI_MSI
>  	struct msi_desc *desc;
>  
>  	list_for_each_entry(desc, &dev->msi_list, list) {
>  		if (desc->msi_attrib.entry_nr == entry)
>  			return desc;
>  	}
> -
> +#endif
Hi Robert,
	While at it, could you please help to use  for_each_pci_msi_entry()
from include/linux/msi.h instead of hard-coding? We are trying to refine
the msi_list related code,
so we don't need to touch this code again later.
Thanks!
Gerry

>  	return NULL;
>  }
>  
> 
