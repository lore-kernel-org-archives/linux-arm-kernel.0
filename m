From: sebastian@breakpoint.cc (Sebastian Andrzej Siewior)
Date: Wed, 3 Jun 2015 15:08:25 +0200
Subject: [PATCH v4 1/6] mtd: nand: vf610_nfc: Freescale NFC for VF610,
 MPC5125 and others
In-Reply-To: <1427300909-20825-2-git-send-email-stefan@agner.ch>
References: <1427300909-20825-1-git-send-email-stefan@agner.ch>
 <1427300909-20825-2-git-send-email-stefan@agner.ch>
Message-ID: <20150603130825.GA23991@breakpoint.cc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015-03-25 17:28:24 [+0100], Stefan Agner wrote:
> diff --git a/drivers/mtd/nand/vf610_nfc.c b/drivers/mtd/nand/vf610_nfc.c
> new file mode 100644
> index 0000000..23c1510
> --- /dev/null
> +++ b/drivers/mtd/nand/vf610_nfc.c
> @@ -0,0 +1,686 @@
?
> +static inline u32 vf610_nfc_read(struct vf610_nfc *nfc, uint reg)
> +{
> +	return readl(nfc->regs + reg);
> +}
> +
> +static inline void vf610_nfc_write(struct vf610_nfc *nfc, uint reg, u32 val)
> +{
> +	writel(val, nfc->regs + reg);
> +}
?

> +static void vf610_nfc_send_command(struct vf610_nfc *nfc, u32 cmd_byte1,
> +				   u32 cmd_code)
> +{
> +	void __iomem *reg = nfc->regs + NFC_FLASH_CMD2;
> +	u32 tmp;
> +
> +	vf610_nfc_clear_status(nfc);
> +
> +	tmp = __raw_readl(reg);
> +	tmp &= ~(CMD_BYTE1_MASK | CMD_CODE_MASK | BUFNO_MASK);
> +	tmp |= cmd_byte1 << CMD_BYTE1_SHIFT;
> +	tmp |= cmd_code << CMD_CODE_SHIFT;
> +	__raw_writel(tmp, reg);
> +}

Why readl() vs __raw_readl() dito for write?
vf610_nfc_{read|write} is good since for PPC we would need out_be32()
here instead.
It would be nice if you could abstract the __raw_ once as well. And I am
not sure if you need those at all since the former functions should work
here just fine.

Sebastian
