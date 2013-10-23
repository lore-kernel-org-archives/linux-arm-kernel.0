From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 23 Oct 2013 16:33:54 +0800
Subject: [PATCH 4/4] imx: add PCI fixup for PEX860X on Gateworks board
In-Reply-To: <1382503888-3962-5-git-send-email-tharvey@gateworks.com>
References: <1382503888-3962-1-git-send-email-tharvey@gateworks.com>
 <1382503888-3962-5-git-send-email-tharvey@gateworks.com>
Message-ID: <20131023083352.GP2839@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 22, 2013 at 09:51:28PM -0700, Tim Harvey wrote:

<snip>

> @@ -78,6 +80,37 @@ static int ksz9031rn_phy_fixup(struct phy_device *dev)
>  	return 0;
>  }
>  
> +/*
> + * fixup for PLX PEX8909 bridge to configure GPIO1-7 as output High
> + * as they are used for slots1-7 PERST#
> + */
> +static void mx6_ventana_pciesw_early_fixup(struct pci_dev *dev)

Please use 'imx' instead of 'mx' where you need an imx prefix.  In this
case, it's even fine without the prefix.  So I just drop the 'mx6_' from
function name, and applied the patch.  Thanks.

Shawn

> +{
> +	u32 dw;
> +
> +	if (!of_machine_is_compatible("gw,ventana"))
> +		return;
> +
> +	if (dev->devfn != 0)
> +		return;
> +
> +	pci_read_config_dword(dev, 0x62c, &dw);
> +	dw |= 0xaaa8; // GPIO1-7 outputs
> +	pci_write_config_dword(dev, 0x62c, dw);
> +
> +	pci_read_config_dword(dev, 0x644, &dw);
> +	dw |= 0xfe;   // GPIO1-7 output high
> +	pci_write_config_dword(dev, 0x644, dw);
> +
> +	msleep(100);
> +}
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_PLX, 0x8609,
> +	mx6_ventana_pciesw_early_fixup);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_PLX, 0x8606,
> +	mx6_ventana_pciesw_early_fixup);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_PLX, 0x8604,
> +	mx6_ventana_pciesw_early_fixup);
> +
>  static int ar8031_phy_fixup(struct phy_device *dev)
>  {
>  	u16 val;
> -- 
> 1.7.9.5
> 
