From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 16 Jul 2014 13:42:18 +0200
Subject: [PATCH v3 7/8] ata: Add support for the Tegra124 SATA controller
In-Reply-To: <53C65E96.9070508@redhat.com>
References: <1405500863-19696-1-git-send-email-mperttunen@nvidia.com>
 <1405500863-19696-8-git-send-email-mperttunen@nvidia.com>
 <53C65E96.9070508@redhat.com>
Message-ID: <20140716114217.GA18977@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 16, 2014 at 01:14:30PM +0200, Hans de Goede wrote:
> On 07/16/2014 10:54 AM, Mikko Perttunen wrote:
[...]
> > +enum sata_clks {
> > +	AHCI_CLK_SATA		= 0,
> > +	AHCI_CLK_SATA_OOB	= 1,
> > +	AHCI_CLK_CML1		= 2,
> > +	AHCI_CLK_PLL_E		= 3
> > +};
> 
> You should mention that having the clocks in this order is mandatory
> in Documentation/devicetree/bindings/ata/tegra-sata.txt / in
> "[PATCH v3 1/8] of: Add NVIDIA Tegra SATA controller binding"

This is precisely why I said that using a library for resources is a bad
idea. Why on earth would we want to mandate a specific order? The clock
bindings specifically have the clock-names so that the order in which
the clocks are listed in the clocks property doesn't matter. Now because
of these library helpers we can no longer do that, but instead need to
fix the order.

So we're now in a position where a Linux-specific driver, worse
actually, a Linux helper library dictates what the device tree binding
must look like. This obviously conflicts with what device tree people
have been recommending for years.

What this also means is that since the DT bindings are ABI, the libahci
platform library code effectively becomes an ABI too.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140716/e4e58de7/attachment.sig>
