From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu, 19 Oct 2017 09:18:10 +0200
Subject: [RFC 06/12] mtd: nand: add reworked Marvell NAND controller driver
In-Reply-To: <20171018143629.29302-7-miquel.raynal@free-electrons.com>
References: <20171018143629.29302-1-miquel.raynal@free-electrons.com>
 <20171018143629.29302-7-miquel.raynal@free-electrons.com>
Message-ID: <20171019091810.13f54c78@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 18 Oct 2017 16:36:23 +0200
Miquel Raynal <miquel.raynal@free-electrons.com> wrote:


> +
> +enum marvell_nfc_variant {
> +	MARVELL_NFC_VARIANT_PXA3XX,
> +	MARVELL_NFC_VARIANT_ARMADA370,
> +	MARVELL_NFC_VARIANT_ARMADA_8K,
> +};
> +
> +/*
> + * NAND controller capabilities for distinction between compatible strings
> + *
> + * @variant:		Board type
> + * @max_cs_nb:		Number of Chip Select lines available
> + * @max_rb_nb:		Number of Ready/Busy lines available
> + * @legacy_of_bindings	Indicates if DT parsing must be done using the old
> + *			fashion way
> + */
> +struct marvell_nfc_caps {
> +	enum marvell_nfc_variant variant;

Do you really need this variant field. It seems you're only using it to
detect if you should MUX the NAND pins using the Special Function
registers on armada8k. Maybe you should just have:

	bool need_system_controller;

and set it to true for the "armada8k" compatible.

> +	unsigned int max_cs_nb;
> +	unsigned int max_rb_nb;
> +	bool legacy_of_bindings;
> +};
> +
