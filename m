From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 15 Aug 2012 13:30:01 +0000
Subject: [PATCH v2 04/31] arm64: MMU definitions
In-Reply-To: <1344966752-16102-5-git-send-email-catalin.marinas@arm.com>
References: <1344966752-16102-1-git-send-email-catalin.marinas@arm.com>
 <1344966752-16102-5-git-send-email-catalin.marinas@arm.com>
Message-ID: <201208151330.02112.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 14 August 2012, Catalin Marinas wrote:
>
> +/*
> + * TCR flags.
> + */
> +#define TCR_TxSZ(x)		(((64 - (x)) << 16) | ((64 - (x)) << 0))
> +#define TCR_IRGN_NC		((0 << 8) | (0 << 24))
> +#define TCR_IRGN_WBWA		((1 << 8) | (1 << 24))
> +#define TCR_IRGN_WT		((2 << 8) | (2 << 24))
> +#define TCR_IRGN_WBnWA		((3 << 8) | (3 << 24))
> +#define TCR_IRGN_MASK		((3 << 8) | (3 << 24))
> +#define TCR_ORGN_NC		((0 << 10) | (0 << 26))
> +#define TCR_ORGN_WBWA		((1 << 10) | (1 << 26))
> +#define TCR_ORGN_WT		((2 << 10) | (2 << 26))
> +#define TCR_ORGN_WBnWA		((3 << 10) | (3 << 26))
> +#define TCR_ORGN_MASK		((3 << 10) | (3 << 26))
> +#define TCR_SHARED		((3 << 12) | (3 << 28))
> +#define TCR_TG0_64K		(1 << 14)
> +#define TCR_TG1_64K		(1 << 30)
> +#define TCR_IPS_40BIT		(2 << 32)
> +#define TCR_ASID16		(1 << 36)
> +

As a matter of coding style, I would much prefer tables like this to be
written as

#define TCR_IRGN_MASK		0x0000000003000300
#define TCR_IRGN_WBnWA		0x0000000003000300
#define TCR_IRGN_WT		0x0000000002000200
#define TCR_IRGN_WBWA		0x0000000001000100
#define TCR_IRGN_NC		0x0000000000000000

#define TCR_ORGN_MASK		0x000000000c000c00
#define TCR_ORGN_WBnWA		0x000000000c000c00
#define TCR_ORGN_WT		0x0000000008000800
#define TCR_ORGN_WBWA		0x0000000004000400
#define TCR_ORGN_NC		0x0000000000000000

The advantage of this is that you can visually compare the bitmasks
to a hex dump, and if you are suffering from endian-confused documentation
authors, there is no ambiguity about which end of the word is bit zero.

	Arnd
