From: scottwood@freescale.com (Scott Wood)
Date: Mon, 31 Aug 2015 19:49:51 -0500
Subject: [RFC][PATCH 2/2] crypto: caam - handle core endianness != caam
 endianness
In-Reply-To: <1440762608-7866-1-git-send-email-horia.geanta@freescale.com>
References: <1440762306-7764-1-git-send-email-horia.geanta@freescale.com>
 <1440762608-7866-1-git-send-email-horia.geanta@freescale.com>
Message-ID: <1441068591.4966.47.camel@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2015-08-28 at 14:50 +0300, Horia Geant? wrote:
>  
> -#ifdef __BIG_ENDIAN
> -#define wr_reg32(reg, data) out_be32(reg, data)
> -#define rd_reg32(reg) in_be32(reg)
> +#ifdef CONFIG_CRYPTO_DEV_FSL_CAAM_LE
> +#define caam16_to_cpu(value) le16_to_cpu(value)
> +#define cpu_to_caam16(value) cpu_to_le16(value)
> +#define caam32_to_cpu(value) le32_to_cpu(value)
> +#define cpu_to_caam32(value) cpu_to_le32(value)
> +#define caam64_to_cpu(value) le64_to_cpu(value)
> +#define cpu_to_caam64(value) cpu_to_le64(value)

What if we want to build a kernel that supports a chip with an LE CAAM and 
another chip with a BE CAAM (e.g. ls1043a plus ls2080a)?  This information 
needs to come at runtime.

> +#ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
> +#ifdef CONFIG_SOC_IMX7D

Likewise, why is there an ifdef for a particular SoC type?

-Scott
