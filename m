From: alexandru.porosanu@freescale.com (Porosanu Alexandru)
Date: Wed, 2 Sep 2015 06:25:20 +0000
Subject: [RFC][PATCH 2/2] crypto: caam - handle core endianness != caam
 endianness
In-Reply-To: <1441068591.4966.47.camel@freescale.com>
References: <1440762306-7764-1-git-send-email-horia.geanta@freescale.com>
 <1440762608-7866-1-git-send-email-horia.geanta@freescale.com>
 <1441068591.4966.47.camel@freescale.com>
Message-ID: <BY1PR03MB1404538A6C4D0A85F7DD2E7080690@BY1PR03MB1404.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Scott,

> -----Original Message-----
> From: Wood Scott-B07421
> Sent: 1 septembrie 2015 03:50
> To: Geanta Neag Horia Ioan-B05471
> Cc: Herbert Xu; Catalin Marinas; Will Deacon; linux-crypto at vger.kernel.org;
> David S. Miller; linux-arm-kernel at lists.infradead.org; linux-
> kernel at vger.kernel.org; Milhoan Victoria-B42089; Cornelius Steven-
> STEVENEC; Estevam Fabio-R49496; Porosanu Alexandru-B06830
> Subject: Re: [RFC][PATCH 2/2] crypto: caam - handle core endianness !=
> caam endianness
> 
> On Fri, 2015-08-28 at 14:50 +0300, Horia Geant? wrote:
> >
> > -#ifdef __BIG_ENDIAN
> > -#define wr_reg32(reg, data) out_be32(reg, data)
> > -#define rd_reg32(reg) in_be32(reg)
> > +#ifdef CONFIG_CRYPTO_DEV_FSL_CAAM_LE
> > +#define caam16_to_cpu(value) le16_to_cpu(value)
> > +#define cpu_to_caam16(value) cpu_to_le16(value)
> > +#define caam32_to_cpu(value) le32_to_cpu(value)
> > +#define cpu_to_caam32(value) cpu_to_le32(value)
> > +#define caam64_to_cpu(value) le64_to_cpu(value)
> > +#define cpu_to_caam64(value) cpu_to_le64(value)
> 
> What if we want to build a kernel that supports a chip with an LE CAAM and
> another chip with a BE CAAM (e.g. ls1043a plus ls2080a)?  This information
> needs to come at runtime.
[AP] We're currently targeting local SEC (where local means SEC is on the SoC). Having this information at run-time will add some penalty as opposed to having these accessory as macros.
For "remote" SEC (e.g. PCI-E connected devices like C29x, LS2, etc.), taking into account that the PCI-E bus is little endian, it should be the PCI-E driver's job to translate host's endianness to EP's endianness (and vice-versa). This is something that needs to be discussed, especially since such a driver isn't currently available in the community.

> 
> > +#ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
> > +#ifdef CONFIG_SOC_IMX7D
> 
> Likewise, why is there an ifdef for a particular SoC type?
> 
> -Scott

Thanks,

Alex P.
