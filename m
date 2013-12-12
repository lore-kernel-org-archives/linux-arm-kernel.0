From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 12 Dec 2013 13:42:23 +0100
Subject: [RFCv2 endianess 1/4] pwm: Add Freescale FTM PWM driver support
In-Reply-To: <d6985022e8aa4e21b618205ddf521d9f@BY2PR03MB505.namprd03.prod.outlook.com>
References: <1386309134-1822-1-git-send-email-Li.Xiubo@freescale.com>
 <1386309134-1822-2-git-send-email-Li.Xiubo@freescale.com>
 <04e52411558f44d99a603c288e2dcc50@BY2PR03MB505.namprd03.prod.outlook.com>
 <20131210101959.GE1809@e106331-lin.cambridge.arm.com>
 <e806828e7d4f488c88d7bd05bdd007d2@BY2PR03MB505.namprd03.prod.outlook.com>
 <d6985022e8aa4e21b618205ddf521d9f@BY2PR03MB505.namprd03.prod.outlook.com>
Message-ID: <20131212124222.GK11524@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 12, 2013 at 02:43:14AM +0000, Li.Xiubo at freescale.com wrote:
> Hi Mark,
> 
> 
> > > > > +static inline u32 fsl_pwm_readl(struct fsl_pwm_chip *fpc,
> > > > > +             const void __iomem *addr)
> > > > > +{
> > > > > +     if (likely(fpc->big_endian))
> > > > > +             return ioread32be(addr);
> > > > > +     else
> > > > > +             return readl(addr);
> > > > > +}
> > >
> > > It looks a little odd to to have two different accessors here.
> > >
> > > Could these not be unified somehow?
> > >
> > 
> > How about the following :
> > 
> > +static inline u32 fsl_pwm_readl(struct fsl_pwm_chip *fpc,
> > +			const void __iomem *addr)
> > +{
> > +	u32 val;
> > +
> > +	if (likely(fpc->big_endian))
> > +		val = be32_to_cpu(__raw_readl(addr));
> > +	else
> > +		val = le32_to_cpu(__raw_readl(addr));
> > +
> > +	rmb();
> > +
> > +	return val;
> > +}
> > +
> > +static inline void fsl_pwm_writel(struct fsl_pwm_chip *fpc,
> > +			u32 val, void __iomem *addr)
> > +{
> > +	wmb();
> > +
> > +	if (likely(fpc->big_endian))
> > +		__raw_writel(cpu_to_be32(val), addr);
> > +	else
> > +		__raw_writel(cpu_to_le32(val), addr);
> > +}
> > +
> > 
> > 
> 
> Or, will these be much better ?
> +++++++++++
> +static inline u32 fsl_pwm_readl(struct fsl_pwm_chip *fpc,
> +		const void __iomem *addr)
> +{
> +	u32 val;
> +
> +	if (likely(fpc->big_endian))
> +		val = be32_to_cpu((__force __be32)__raw_readl(addr));
> +	else
> +		val = le32_to_cpu((__force __le32)__raw_readl(addr));
> +
> +	rmb();
> +
> +	return val;
> +}
> +
> +static inline void fsl_pwm_writel(struct fsl_pwm_chip *fpc,
> +		u32 val, void __iomem *addr)
> +{
> +	wmb();
> +
> +	if (likely(fpc->big_endian))
> +		__raw_writel((__force u32)cpu_to_be32(val), addr);
> +	else
> +		__raw_writel((__force u32)cpu_to_le32(val), addr); }
> +
> -----------

I think perhaps what Mark may have meant was something like this:

	static inline u32 fsl_pwm_readl(struct fsl_pwm_chip *fpc,
					const void __iomem *addr)
	{
		u32 value = readl(addr);

		if (likely(fpc->big_endian))
			value = be32_to_cpu(value);
		else
			value = le32_to_cpu(value);

		return value;
	}

	static inline void fsl_pwm_writel(struct fsl_pwm_chip *fpc, u32 value,
					  const void __iomem *addr)
	{
		if (likely(fpc->big_endian))
			value = cpu_to_be32(value);
		else
			value = cpu_to_le32(value);

		writel(value, addr);
	}

That way you call the accessors only once, and do the conversion after
or before that.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131212/02d356b1/attachment.sig>
