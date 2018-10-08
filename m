From: boris.brezillon@bootlin.com (Boris Brezillon)
Date: Mon, 8 Oct 2018 21:10:53 +0200
Subject: [PATCH v4 1/5] spi: spi-mem: Add driver for NXP FlexSPI controller
In-Reply-To: <1538997103-11152-2-git-send-email-yogeshnarayan.gaur@nxp.com>
References: <1538997103-11152-1-git-send-email-yogeshnarayan.gaur@nxp.com>
 <1538997103-11152-2-git-send-email-yogeshnarayan.gaur@nxp.com>
Message-ID: <20181008211053.71171cff@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon,  8 Oct 2018 16:41:39 +0530
Yogesh Gaur <yogeshnarayan.gaur@nxp.com> wrote:

> +/* Registers used by the driver */
> +#define FSPI_MCR0			0x00
> +#define FSPI_MCR0_AHB_TIMEOUT_MASK	GENMASK(31, 24)
> +#define FSPI_MCR0_IP_TIMEOUT_MASK	GENMASK(23, 16)

You never mask the IP_TIMEOUT val, so you don't need a _MASK macro
here. Just define

#define FSPI_MCR0_IP_TIMEOUT(x)		((x) < 16)

The same goes for any field that you don't need to mask.

The only case you might need a mask def is when you have the following
pattern:

	val = readl(reg);
	val &= ~XXXX_MASK;
	val |= XXXX(new_field_val);
	writel(val, reg);

> +#define FSPI_MCR0_LEARN_EN_MASK		BIT(15)
> +#define FSPI_MCR0_SCRFRUN_EN_MASK	BIT(14)
> +#define FSPI_MCR0_OCTCOMB_EN_MASK	BIT(13)

Drop the _MASK suffix for any single-bit field:

#define FSPI_MCR0_OCTCOMB_EN		BIT(13)
