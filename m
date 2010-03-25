From: maz@misterjones.org (Marc Zyngier)
Date: Thu, 25 Mar 2010 05:44:30 +0000
Subject: [PATCH v2] PL330: Add PL330 DMA controller driver
In-Reply-To: <4BAAD5BB.7050101@samsung.com>
References: <4BAAD5BB.7050101@samsung.com>
Message-ID: <20100325054430.165311fa@taxman.wild-wind.fr.eu.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 25 Mar 2010 12:17:15 +0900
Joonyoung Shim <jy0922.shim@samsung.com> wrote:

> +/* instruction set functions */
> +static inline int pl330_dmaaddh(u8 *desc_pool_virt, u16 imm, bool ra)
> +{
> +	u8 opcode = DMAADDH | (ra << 1);
> +
> +	writeb(opcode, desc_pool_virt++);

desc_pool_virt is a virtual address (from dma_alloc_coherent). In such
case, write[bwl] seems to be the wrong interface. I suggest the
following code:

	*desc_pool_virt++ = opcode;

> +	writew(imm, desc_pool_virt);

Does anything ensure that this won't generate an unaligned access?

> +	return 3;
> +}

	M.
-- 
I'm the slime oozin' out from your TV set...
