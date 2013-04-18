From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 18 Apr 2013 14:32:11 +0200
Subject: [PATCH 24/32 v2] dmaengine: ste_dma40: Supply full Device Tree
 parsing support
In-Reply-To: <20130418121253.GF27903@gmail.com>
References: <1366279934-30761-1-git-send-email-lee.jones@linaro.org>
 <1366279934-30761-25-git-send-email-lee.jones@linaro.org>
 <20130418121253.GF27903@gmail.com>
Message-ID: <201304181432.11503.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 18 April 2013, Lee Jones wrote:
> +Clients
> +Required properties:
> +- dmas: Comma separated list of dma channel requests
> +- dma-names: Names of the aforementioned requested channels
> +
> +Each dmas request consists of 4 cells:
> +  1. A phandle pointing to the DMA controller
> +  2. Device Type
> +  3. The DMA request line number (only when 'use fixed channel' is set)
> +  4. A 32bit mask specifying; mode, direction and endianess [NB: This list will grow]
> +        bit 1: Mode:
> +           0: Logical
> +           1: Physical
> +        bit 2: Direction:
> +           0: Mem to Mem
> +           1: Mem to Dev

You probably mean 

		0: Dev to mem

Related to this, I would recommend not listing bit numbers like this, since there
is some amount of confusion regarding how they are counted: zero-based on one-based
and LSB-to-MSB or MSB-to-LSB

You can completely avoid this problem by listing them as bit masks:

	0x00000002:
		Logical channel when unset
		Physical channel when set
	0x00000004:
		Direction from device when unset
		Direction to device when unset
	... 

> +		dmas = <&dma 13 0 0x8>, /* Logical - DevToMem */
> +		       <&dma 13 0 0x4>; /* Logical - MemToDev */

The bit in the example no longer matches the description.

> +
> +	switch (D40_DT_FLAGS_DIR(flags)) {
> +	case 0: cfg.dir = STEDMA40_MEM_TO_MEM; break;
> +	case 1: cfg.dir = STEDMA40_MEM_TO_PERIPH; break;
> +	}

Same typo above.

> +	if (cfg.dir == STEDMA40_PERIPH_TO_MEM)
> +		cfg.src_info.big_endian = D40_DT_FLAGS_BIG_ENDIAN(flags);
> +	if (cfg.dir == STEDMA40_MEM_TO_PERIPH)
> +		cfg.dst_info.big_endian = D40_DT_FLAGS_BIG_ENDIAN(flags);

You can fold these two into the switch statement above.

	Arnd
