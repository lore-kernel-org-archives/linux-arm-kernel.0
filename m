From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Mon, 8 Feb 2010 15:52:40 -0500
Subject: [PATCH] ep93xx: Add support for Snapper CL15 module
In-Reply-To: <BD79186B4FD85F4B8E60E381CAEE190902152EC8@mi8nycmail19.Mi8.com>
References: <4B6B34D3.1010704@bluewatersys.com><BD79186B4FD85F4B8E60E381CAEE190902152BFB@mi8nycmail19.Mi8.com><4B6F1C71.7050104@bluewatersys.com><BD79186B4FD85F4B8E60E381CAEE190902152E91@mi8nycmail19.Mi8.com><4B707018.90304@bluewatersys.com>
	<BD79186B4FD85F4B8E60E381CAEE190902152EC8@mi8nycmail19.Mi8.com>
Message-ID: <BD79186B4FD85F4B8E60E381CAEE190902152ED3@mi8nycmail19.Mi8.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, February 08, 2010 1:27 PM, H Hartley Sweeten wrote:
> +#define SNAPPERCL15_NAND_BASE	(EP93XX_CS7_PHYS_BASE + SZ_16M)
> +
> +#define SNAPPERCL15_NAND_WPN	(1 << 8)  /* Write protect (active low) */
> +#define SNAPPERCL15_NAND_ALE	(1 << 9)  /* Address latch */
> +#define SNAPPERCL15_NAND_CLE	(1 << 10) /* Command latch */
> +#define SNAPPERCL15_NAND_CEN	(1 << 11) /* Chip enable (active low) */
> +#define SNAPPERCL15_NAND_RDY	(1 << 14) /* Device ready */
> +
> +#define NAND_CTRL_ADDR(chip) 	(chip->IO_ADDR_W + 0x40)
> +
> +static unsigned long nand_state;
> +
> +static void snappercl15_nand_cmd_ctrl(struct mtd_info *mtd, int cmd,
> +				      unsigned int ctrl)
> +{
> +	struct nand_chip *chip = mtd->priv;
> +	unsigned set;
> +
> +	if (ctrl & NAND_CTRL_CHANGE) {
> +		set = SNAPPERCL15_NAND_CEN | SNAPPERCL15_NAND_WPN;
> +
> +		if (ctrl & NAND_NCE)
> +			set &= ~SNAPPERCL15_NAND_CEN;
> +		if (ctrl & NAND_CLE)
> +			set |= SNAPPERCL15_NAND_CLE;
> +		if (ctrl & NAND_ALE)
> +			set |= SNAPPERCL15_NAND_ALE;
> +
> +		nand_state &= ~(SNAPPERCL15_NAND_CEN |
> +				SNAPPERCL15_NAND_CLE |
> +				SNAPPERCL15_NAND_ALE);
> +		nand_state |= set;
> +		__raw_writew(nand_state, NAND_CTRL_ADDR(chip));
> +	}
> +
> +	if (cmd != NAND_CMD_NONE)
> +		__raw_writew((cmd & 0xff) | nand_state, chip->IO_ADDR_W);
> +}
> 
> It's possible (though unlikely) for 'nand_state' to start off with an
> unknown value.  The upper layers could call the function without 
> NAND_CTRL_CHANGE set the first time.
> 
> You can use the gen_nand .probe callback to set the initial value.
> This keeps you from having to keep the static 'first' variable that
> used to be in the patch.

Actually, do you even need to save a cached value for 'nand_state'?

1) The write to NAND_CTRL_ADDR sets all the control lines.
2) The write to IO_ADDR_W 'writes' the command to the chip.

Do you really need to OR nand_state with the cmd?

Regards,
Hartley
