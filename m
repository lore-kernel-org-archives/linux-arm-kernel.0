From: scottwood@freescale.com (Scott Wood)
Date: Wed, 2 Sep 2015 17:33:32 -0500
Subject: [RFC][PATCH 2/2] crypto: caam - handle core endianness != caam
 endianness
In-Reply-To: <BY1PR03MB1404538A6C4D0A85F7DD2E7080690@BY1PR03MB1404.namprd03.prod.outlook.com>
References: <1440762306-7764-1-git-send-email-horia.geanta@freescale.com>
 <1440762608-7866-1-git-send-email-horia.geanta@freescale.com>
 <1441068591.4966.47.camel@freescale.com>
 <BY1PR03MB1404538A6C4D0A85F7DD2E7080690@BY1PR03MB1404.namprd03.prod.outlook.com>
Message-ID: <1441233212.4966.174.camel@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2015-09-02 at 01:25 -0500, Porosanu Alexandru-B06830 wrote:
> Hi Scott,
> 
> > -----Original Message-----
> > From: Wood Scott-B07421
> > Sent: 1 septembrie 2015 03:50
> > To: Geanta Neag Horia Ioan-B05471
> > Cc: Herbert Xu; Catalin Marinas; Will Deacon; linux-crypto at vger.kernel.org;
> > 
> > David S. Miller; linux-arm-kernel at lists.infradead.org; linux-
> > kernel at vger.kernel.org; Milhoan Victoria-B42089; Cornelius Steven-
> > STEVENEC; Estevam Fabio-R49496; Porosanu Alexandru-B06830
> > Subject: Re: [RFC][PATCH 2/2] crypto: caam - handle core endianness !=
> > caam endianness
> > 
> > On Fri, 2015-08-28 at 14:50 +0300, Horia Geant? wrote:
> > > 
> > > -#ifdef __BIG_ENDIAN
> > > -#define wr_reg32(reg, data) out_be32(reg, data)
> > > -#define rd_reg32(reg) in_be32(reg)
> > > +#ifdef CONFIG_CRYPTO_DEV_FSL_CAAM_LE
> > > +#define caam16_to_cpu(value) le16_to_cpu(value)
> > > +#define cpu_to_caam16(value) cpu_to_le16(value)
> > > +#define caam32_to_cpu(value) le32_to_cpu(value)
> > > +#define cpu_to_caam32(value) cpu_to_le32(value)
> > > +#define caam64_to_cpu(value) le64_to_cpu(value)
> > > +#define cpu_to_caam64(value) cpu_to_le64(value)
> > 
> > What if we want to build a kernel that supports a chip with an LE CAAM and
> > another chip with a BE CAAM (e.g. ls1043a plus ls2080a)?  This information
> > needs to come at runtime.
> [AP] We're currently targeting local SEC (where local means SEC is on the 
> SoC). Having this information at run-time will add some penalty as opposed 
> to having these accessory as macros.

It is important to be able to have one kernel that works on multiple SoCs.  
You could perhaps have a config option that optimizes one way or another 
(with a check that refuses to probe on the wrong-endian hardware) but please 
have a runtime check for the default configuration.  Otherwise the most 
likely result is that default configs won't enable CAAM support at all.

How severe is the performance penalty?  Perhaps the decision can be made at a 
higher level for performance-critical parts of the driver (e.g. replace the 
entire calling function rather than each I/O access)?  Have the hardware 
designers been made aware of the performance consequence of their 
inconsistency?

-Scott
