From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 20 May 2016 14:20:52 +0200
Subject: [PATCH V5 6/7] iommu/msm: Use writel_relaxed and add a barrier
In-Reply-To: <3164695.VzCnHHyi7r@wuerfel>
References: <1463741694-1735-1-git-send-email-sricharan@codeaurora.org>
 <1463741694-1735-7-git-send-email-sricharan@codeaurora.org>
 <3164695.VzCnHHyi7r@wuerfel>
Message-ID: <2864715.kytdDZX8IX@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 20 May 2016 13:44:10 Arnd Bergmann wrote:
> >  #define GET_CTX_REG(reg, base, ctx) \
> >                               (readl((base) + (reg) + ((ctx) << CTX_SHIFT)))
> >  
> > -#define SET_GLOBAL_REG(reg, base, val)       writel((val), ((base) + (reg)))
> > +/*
> > + * The writes to the global/context registers needs to be synced only after
> > + * all the configuration writes are done. So use relaxed accessors and
> > + * a barrier at the end.
> > + */
> > +#define SET_GLOBAL_REG_RELAXED(reg, base, val) \
> > +                            writel_relaxed((val), ((base) + (reg)))
> >  
> > -#define SET_CTX_REG(reg, base, ctx, val) \
> > -                     writel((val), ((base) + (reg) + ((ctx) << CTX_SHIFT)))
> > +#define SET_CTX_REG_RELAXED(reg, base, ctx, val) \
> > +             writel_relaxed((val), ((base) + (reg) + ((ctx) << CTX_SHIFT)))
> 
> Please add the relaxed accessors first in a separate patch, and then
> change over one user at a time before you remove the non-relaxed ones.
> 
> It's hard to believe that all users are actually performance critical,
> so start with the ones that gain the most performance. As commented above,
> some of the conversions seem particularly fishy and it's likely that
> a slow reset() function should not be fixed by making reset() faster
> but by calling it less often.

One more thing, please also convert them into inline functions when you modify
them, and use normal names such as

static inline void msm_iommu_write(struct msm_iommu_dev *iommu, unsigned int reg, u32 val)
{
	writel(val, iommu->base + reg);
}

static inline void msm_iommu_context_write(struct msm_iommu_ctx_dev *ctx, unsigned int reg, u32 val)
{
	writel(val, ctx->iommu->base + ctx << CTX_SHIFT + reg, val);
}

	Arnd
