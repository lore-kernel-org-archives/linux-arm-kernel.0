From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 16 Apr 2016 23:48:18 +0200
Subject: [PATCH] ARM: mach-imx: sdhci-esdhc-imx: initialize DMA mask
In-Reply-To: <570DFE34.6040206@intel.com>
References: <1460362846-2906-1-git-send-email-akurz@blala.de>
 <570DA8C3.5030206@nvidia.com> <570DFE34.6040206@intel.com>
Message-ID: <6297512.2KmasKu6UN@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 13 April 2016 11:07:16 Adrian Hunter wrote:
> On 13/04/16 05:02, Alexandre Courbot wrote:
> > On 04/13/2016 12:31 AM, Russell King - ARM Linux wrote:
> >> On Tue, Apr 12, 2016 at 09:25:04PM +0900, Alexandre Courbot wrote:

> > How long it will take for everyone to fix their drivers is another question,
> > since the device doesn't clearly break, but falls back to a degraded mode
> > with a warning.
> > 
> 
> It looks like DeviceTree, PCI and ACPI enumerated devices always set up a
> dma_mask.  I guess that just leaves devices enumerated from hard-coded
> platform data.  I will have a look for any more of those, and also send an
> email for affected people to check their device setup and drivers.
> 

I've had a look now too and found only these three device definitions
for any sdhci variant, everything else is either unused or DT-only:

arch/arm/mach-dove/common.c:    .name           = "sdhci-dove",
arch/arm/plat-samsung/devs.c:   .name           = "s3c-sdhci",
arch/arm/mach-imx/devices/platform-sdhci-esdhc-imx.c:   imx_sdhci_esdhc_imx_data_entry(MX25, "sdhci-esdhc-imx25", _id, _hwid)
arch/arm/mach-imx/devices/platform-sdhci-esdhc-imx.c:   imx_sdhci_esdhc_imx_data_entry(MX35, "sdhci-esdhc-imx35", _id, _hwid)

Out of these, the s3c and dove variants set a 32-bit DMA mask, so as
far as I can tell, only imx has the problem.

	Arnd
