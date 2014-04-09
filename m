From: computersforpeace@gmail.com (Brian Norris)
Date: Wed, 9 Apr 2014 10:40:12 -0700
Subject: [PATCH v5 1/8] mtd: spi-nor: copy the SPI NOR commands to a new
 header file
In-Reply-To: <1393238262-8622-2-git-send-email-b32955@freescale.com>
References: <1393238262-8622-1-git-send-email-b32955@freescale.com>
 <1393238262-8622-2-git-send-email-b32955@freescale.com>
Message-ID: <20140409174012.GD32070@ld-irv-0074>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 24, 2014 at 06:37:35PM +0800, Huang Shijie wrote:
> This patch adds a new header :spi-nor.h,
> and copies all the SPI NOR commands and relative macros into this new header.
...
> diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
> new file mode 100644
> index 0000000..483fc2a
> --- /dev/null
> +++ b/include/linux/mtd/spi-nor.h
> @@ -0,0 +1,55 @@
> +#ifndef __LINUX_MTD_SPI_NOR_H
> +#define __LINUX_MTD_SPI_NOR_H
> +

You're missing a copyright and license header. Please submit one against
l2-mtd.git/spinor, preferably after the patch series I just sent out
that renames a few things here.

Regarding copyright assignments (also an issue with spi-nor.c): please
carry the original copyright from m25p80.c, and add your own or your
employer's wherever your work was a significant addition.

> +/* Flash opcodes. */
> +#define	OPCODE_WREN		0x06	/* Write enable */
> +#define	OPCODE_RDSR		0x05	/* Read status register */
> +#define	OPCODE_WRSR		0x01	/* Write status register 1 byte */
> +#define	OPCODE_NORM_READ	0x03	/* Read data bytes (low frequency) */
> +#define	OPCODE_FAST_READ	0x0b	/* Read data bytes (high frequency) */
> +#define	OPCODE_DUAL_READ        0x3b    /* Read data bytes (Dual SPI) */
> +#define	OPCODE_QUAD_READ        0x6b    /* Read data bytes (Quad SPI) */
> +#define	OPCODE_PP		0x02	/* Page program (up to 256 bytes) */
> +#define	OPCODE_BE_4K		0x20	/* Erase 4KiB block */
> +#define	OPCODE_BE_4K_PMC	0xd7	/* Erase 4KiB block on PMC chips */
> +#define	OPCODE_BE_32K		0x52	/* Erase 32KiB block */
> +#define	OPCODE_CHIP_ERASE	0xc7	/* Erase whole flash chip */
> +#define	OPCODE_SE		0xd8	/* Sector erase (usually 64KiB) */
> +#define	OPCODE_RDID		0x9f	/* Read JEDEC ID */
> +#define	OPCODE_RDCR             0x35    /* Read configuration register */
> +
> +/* 4-byte address opcodes - used on Spansion and some Macronix flashes. */
> +#define	OPCODE_NORM_READ_4B	0x13	/* Read data bytes (low frequency) */
> +#define	OPCODE_FAST_READ_4B	0x0c	/* Read data bytes (high frequency) */
> +#define	OPCODE_DUAL_READ_4B	0x3c    /* Read data bytes (Dual SPI) */
> +#define	OPCODE_QUAD_READ_4B	0x6c    /* Read data bytes (Quad SPI) */
> +#define	OPCODE_PP_4B		0x12	/* Page program (up to 256 bytes) */
> +#define	OPCODE_SE_4B		0xdc	/* Sector erase (usually 64KiB) */
> +
> +/* Used for SST flashes only. */
> +#define	OPCODE_BP		0x02	/* Byte program */
> +#define	OPCODE_WRDI		0x04	/* Write disable */
> +#define	OPCODE_AAI_WP		0xad	/* Auto address increment word program */
> +
> +/* Used for Macronix and Winbond flashes. */
> +#define	OPCODE_EN4B		0xb7	/* Enter 4-byte mode */
> +#define	OPCODE_EX4B		0xe9	/* Exit 4-byte mode */
> +
> +/* Used for Spansion flashes only. */
> +#define	OPCODE_BRWR		0x17	/* Bank register write */
> +
> +/* Status Register bits. */
> +#define	SR_WIP			1	/* Write in progress */
> +#define	SR_WEL			2	/* Write enable latch */
> +/* meaning of other SR_* bits may differ between vendors */
> +#define	SR_BP0			4	/* Block protect 0 */
> +#define	SR_BP1			8	/* Block protect 1 */
> +#define	SR_BP2			0x10	/* Block protect 2 */
> +#define	SR_SRWD			0x80	/* SR write protect */
> +
> +#define SR_QUAD_EN_MX           0x40    /* Macronix Quad I/O */
> +
> +/* Configuration Register bits. */
> +#define CR_QUAD_EN_SPAN		0x2     /* Spansion Quad I/O */
> +
> +#endif

Brian
