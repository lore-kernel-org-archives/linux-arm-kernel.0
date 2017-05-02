From: ashok.raj@intel.com (Raj, Ashok)
Date: Tue, 2 May 2017 09:44:01 -0700
Subject: [PATCH 1/2] PCI: Add new PCIe Fabric End Node flag,
 PCI_DEV_FLAGS_NO_RELAXED_ORDERING
In-Reply-To: <758d0e431c732fe133e7b0e660bde5fc1beccdba.1493678834.git.leedom@chelsio.com>
References: <cover.1493678834.git.leedom@chelsio.com>
 <758d0e431c732fe133e7b0e660bde5fc1beccdba.1493678834.git.leedom@chelsio.com>
Message-ID: <20170502164400.GA26406@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Casey


On Mon, May 01, 2017 at 04:13:50PM -0700, Casey Leedom wrote:
> The new flag PCI_DEV_FLAGS_NO_RELAXED_ORDERING indicates that the Relaxed
> Ordering Attribute should not be used on Transaction Layer Packets destined
> for the PCIe End Node so flagged.  Initially flagged this way are Intel
> E5-26xx Root Complex Ports which suffer from a Flow Control Credit
> Performance Problem and AMD A1100 ARM ("SEATTLE") Root Complex Ports which
> don't obey PCIe 3.0 ordering rules which can lead to Data Corruption.
> ---
>  drivers/pci/quirks.c | 38 ++++++++++++++++++++++++++++++++++++++
>  include/linux/pci.h  |  2 ++
>  2 files changed, 40 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index f754453..4ae78b3 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -3979,6 +3979,44 @@ static void quirk_tw686x_class(struct pci_dev *pdev)
>  			      quirk_tw686x_class);
>  
>  /*
> + * Some devices have problems with Transaction Layer Packets with the Relaxed
> + * Ordering Attribute set.  Such devices should mark themselves and other
> + * Device Drivers should check before sending TLPs with RO set.
> + */
> +static void quirk_relaxedordering_disable(struct pci_dev *dev)
> +{
> +	dev->dev_flags |= PCI_DEV_FLAGS_NO_RELAXED_ORDERING;
> +}
> +
> +/*
> + * Intel E5-26xx Root Complex has a Flow Control Credit issue which can
> + * cause performance problems with Upstream Transaction Layer Packets with
> + * Relaxed Ordering set.
> + */
> +DECLARE_PCI_FIXUP_CLASS_EARLY(0x8086, 0x6f02, PCI_CLASS_NOT_DEFINED, 8,
> +			      quirk_relaxedordering_disable);
> +DECLARE_PCI_FIXUP_CLASS_EARLY(0x8086, 0x6f04, PCI_CLASS_NOT_DEFINED, 8,
> +			      quirk_relaxedordering_disable);
> +DECLARE_PCI_FIXUP_CLASS_EARLY(0x8086, 0x6f08, PCI_CLASS_NOT_DEFINED, 8,
> +			      quirk_relaxedordering_disable);
> +

You might want to add the RP ID's for both HSX/BDX. Tne entire range 
is 2F01H-2F0EH & 6F01H-6F0EH.

Cheers,
Ashok
