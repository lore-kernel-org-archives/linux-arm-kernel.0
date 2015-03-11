From: Jean-Philippe.Brucker@arm.com (Jean-Philippe Brucker)
Date: Wed, 11 Mar 2015 19:06:57 +0000
Subject: [PATCH v2 4/5] ARM: add 32bit support to GICv3
In-Reply-To: <550056B2.90505@arm.com>
References: <1425320432-6325-1-git-send-email-jean-philippe.brucker@arm.com>
 <1425320432-6325-5-git-send-email-jean-philippe.brucker@arm.com>
 <550056B2.90505@arm.com>
Message-ID: <20150311190657.GA2271@e106794-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 11, 2015 at 02:52:34PM +0000, Vladimir Murzin wrote:
> Hi Jean,
> 
> On 02/03/15 18:20, Jean-Philippe Brucker wrote:
> > Implement the system and memory-mapped register accesses in
> > asm/arch_gicv3.h for 32bit architectures.
> > 
> > This patch is a straightforward translation of the arm64 header. 64bit
> > accesses are done in two times and don't need atomicity: TYPER is
> > read-only, and the upper-word of IROUTER is always zero on 32bit
> > architectures.
> > 
> > Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
> > ---
> >  arch/arm/include/asm/arch_gicv3.h | 182 ++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 182 insertions(+)
> >  create mode 100644 arch/arm/include/asm/arch_gicv3.h
> > 
> > diff --git a/arch/arm/include/asm/arch_gicv3.h b/arch/arm/include/asm/arch_gicv3.h
> > new file mode 100644
> > index 0000000..c2c3603
> > --- /dev/null
> > +++ b/arch/arm/include/asm/arch_gicv3.h
> > @@ -0,0 +1,182 @@

[...]

> > +static inline void gic_write_sre(u32 val)
> > +{
> > +	asm volatile("mcr " __stringify(ICC_SRE) : : "r" (val));
> > +	isb();
> > +}
> > +
> > +/*
> > + * Even in 32bit systems that use LPAE, there is no guarantee that the I/O
> > + * interface provides true 64bit atomic accesses, so using strd/ldrd doesn't
> > + * make much sense.
> > + * Moreover, 64bit I/O emulation is extremely difficult to implement on
> > + * AArch32, since the syndrome register doesn't provide any information for
> > + * them.
> > + * Consequently, the following IO helpers use 32bit accesses.
> > + *
> > + * There are only two registers that need 64bit accesses in this driver:
> > + * - GICD_IROUTERn, contain the affinity values associated to each interrupt.
> > + *   The upper-word (aff3) will always be 0, so there is no need for a lock.
> > + * - GICR_TYPER is an ID register and doesn't need atomicity.
> > + */
> > +static void gic_write_irouter(u64 val, volatile void __iomem *addr)
> 
> Any reason not to be inlined like other functions do?
> 
No, it should be inlined. Good catch!

Thanks,
Jean
