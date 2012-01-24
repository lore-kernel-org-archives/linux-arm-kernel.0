From: hdoyu@nvidia.com (Hiroshi Doyu)
Date: Tue, 24 Jan 2012 14:41:21 +0100
Subject: [PATCH 2/2] ARM: IOMMU: Tegra30: Add iommu_ops for SMMU driver
In-Reply-To: <20120123154310.GC6269@8bytes.org>
References: <1325747509-29665-1-git-send-email-hdoyu@nvidia.com><1325747509-29665-3-git-send-email-hdoyu@nvidia.com><20120123154310.GC6269@8bytes.org>
Message-ID: <20120124.154121.1062920821192552748.hdoyu@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH 2/2] ARM: IOMMU: Tegra30: Add iommu_ops for SMMU driver
Date: Mon, 23 Jan 2012 16:43:10 +0100
Message-ID: <20120123154310.GC6269@8bytes.org>

> > +	}
> > +
> > +	spin_unlock_irqrestore(&as->lock, flags);
> > +
> > +	domain->priv = NULL;
> > +	dev_dbg(smmu->dev, "smmu_as@%p\n", as);
> > +}
> > +
> > +static int smmu_iommu_attach_dev(struct iommu_domain *domain,
> > +				 struct device *dev)
> > +{
> > +	struct smmu_as *as = domain->priv;
> > +	struct smmu_device *smmu = as->smmu;
> 
> Hmm, this looks like there is a 1-1 mapping between hardware SMMU
> devices and domains. This is not consistent with IOMMU-API semantics
> where a domain can contain devices behind different SMMUs. Please fix
> that.

Actually I really like the concept of this "domain" now, which hides
the H/W hierarchy from users.

But in Tegra SMMU/GART case, there's a single one IOMMU device in the
system. Keeping a iommu device list in a domain and iterating iommu
device list in each iommu_ops seem to be so nice, but I'm afraid that
this may be a bit too much when one already knows that there's only
one IOMMU device in the system.

If there's no actual problem for 1-1 mapping between IOMMU H/Ws and
domains, I think that it may not so bad to keep the original code(1-1)
for GART and SMMU. What do you think?
