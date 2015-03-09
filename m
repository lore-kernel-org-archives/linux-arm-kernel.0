From: yong.wu@mediatek.com (Yong Wu)
Date: Mon, 9 Mar 2015 20:16:26 +0800
Subject: [PATCH 2/5] iommu/mediatek: Add mt8173 IOMMU driver
In-Reply-To: <vnkwwq2unj2y.fsf@mitchelh-linux.qualcomm.com>
References: <1425638900-24989-1-git-send-email-yong.wu@mediatek.com>
 <1425638900-24989-3-git-send-email-yong.wu@mediatek.com>
 <vnkwwq2unj2y.fsf@mitchelh-linux.qualcomm.com>
Message-ID: <1425903386.13300.33.camel@mhfsdcap03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Mitchel,
     Thanks very much for your review.

On Fri, 2015-03-06 at 09:15 -0800, Mitchel Humpherys wrote:
> On Fri, Mar 06 2015 at 02:48:17 AM, <yong.wu@mediatek.com> wrote:
> > From: Yong Wu <yong.wu@mediatek.com>
> >
> > This patch adds support for mediatek m4u (MultiMedia Memory Management Unit).
> > Currently this only supports m4u gen 2 with 2 levels of page table on mt8173.
> 
> [...]
> 
> > +static int mtk_iommu_invalidate_tlb(const struct mtk_iommu_info *piommu,
> > +				    int isinvall, unsigned int iova_start,
> > +				    unsigned int iova_end)
> > +{
> > +	void __iomem *m4u_base = piommu->m4u_base;
> > +	u32 val;
> > +	u64 start, end;
> > +
> > +	start = sched_clock();
> > +
> > +	if (!isinvall) {
> > +		iova_start = round_down(iova_start, SZ_4K);
> > +		iova_end = round_up(iova_end, SZ_4K);
> > +	}
> > +
> > +	val = F_MMU_INV_EN_L2 | F_MMU_INV_EN_L1;
> > +
> > +	writel(val, m4u_base + REG_INVLID_SEL);
> > +
> > +	if (isinvall) {
> > +		writel(F_MMU_INV_ALL, m4u_base + REG_MMU_INVLD);
> > +	} else {
> > +		writel(iova_start, m4u_base + REG_MMU_INVLD_SA);
> > +		writel(iova_end, m4u_base + REG_MMU_INVLD_EA);
> > +		writel(F_MMU_INV_RANGE, m4u_base + REG_MMU_INVLD);
> > +
> > +		while (!readl(m4u_base + REG_MMU_CPE_DONE)) {
> > +			end = sched_clock();
> > +			if (end - start >= 100000000ULL) {
> > +				dev_warn(piommu->dev, "invalid don't done\n");
> > +				writel(F_MMU_INV_ALL, m4u_base + REG_MMU_INVLD);
> > +			}
> > +		};
> 
> Superfluous `;'.  Also, maybe you should be using readl_poll_timeout?
   Thanks.
   For the "readl_poll_timeout", My base is 3.19-rc7 and robin's patch.
it don't have this interface.  I will try to add it in the next version.
> 
> > +		writel(0, m4u_base + REG_MMU_CPE_DONE);
> > +	}
> > +
> > +	return 0;
> > +}
> 
> 
> 
> -Mitch
> 
