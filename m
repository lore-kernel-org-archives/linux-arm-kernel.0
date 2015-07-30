From: albert.aribaud@3adev.fr (Albert ARIBAUD)
Date: Thu, 30 Jul 2015 18:13:21 +0200
Subject: [PATCH v8 1/5] mtd: nand: vf610_nfc: Freescale NFC for VF610,
 MPC5125 and others
In-Reply-To: <1438015365-15685-2-git-send-email-stefan@agner.ch>
References: <1438015365-15685-1-git-send-email-stefan@agner.ch>
 <1438015365-15685-2-git-send-email-stefan@agner.ch>
Message-ID: <20150730181321.3bd38db7.albert.aribaud@3adev.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stefan,

Le Mon, 27 Jul 2015 18:42:41 +0200, Stefan Agner <stefan@agner.ch> a
?crit :

> This driver supports Freescale NFC (NAND flash controller) found on
> Vybrid (VF610), MPC5125, MCF54418 and Kinetis K70. The driver has
> been tested on 8-bit and 16-bit NAND interface and supports ONFI
> parameter page reading.
> 
> [...]
> 
> diff --git a/drivers/mtd/nand/vf610_nfc.c b/drivers/mtd/nand/vf610_nfc.c
> new file mode 100644
> index 0000000..0da500e
> --- /dev/null
> +++ b/drivers/mtd/nand/vf610_nfc.c
> @@ -0,0 +1,640 @@
> [...]

... about line 708:

> +	err = devm_request_irq(nfc->dev, irq, vf610_nfc_irq, 0, DRV_NAME, mtd);
> +	if (err) {
> +		dev_err(nfc->dev, "Error requesting IRQ!\n");
> +		goto error;
> +	}
> +
> +	vf610_nfc_init_controller(nfc);

The call above is too early: vf610_nfc_init_controller() will test
for (nfc->chip.options & NAND_BUSWIDTH_16) but this option bit is only
set once nand_scan_ident() below has been run.

This has the effect that even when the DT node specifies a 16-bit wide
bus, the controller is configured for 8-bit mode at this point, which of
course causes read failures. I've experienced this with a Vybrid SoC
and a Micron MT29F4G16ABADAH4 16-bit NAND.

> +	/* first scan to find the device and get the page size */
> +	if (nand_scan_ident(mtd, 1, NULL)) {
> +		err = -ENXIO;
> +		goto error;
> +	}

Placing the call to vf610_nfc_init_controller() here, after the call
to nand_scan_ident() rather than before it, fixed the issue for me.

Cordialement,
Albert ARIBAUD
3ADEV
