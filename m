From: hdoyu@nvidia.com (Hiroshi Doyu)
Date: Fri, 4 May 2012 08:33:58 +0200
Subject: [PATCHv3 3/4] iommu/tegra: smmu: Refrain from accessing to AHB
In-Reply-To: <4FA2C4E9.2080509@wwwdotorg.org>
References: <1336061147-10245-1-git-send-email-hdoyu@nvidia.com><1336061147-10245-3-git-send-email-hdoyu@nvidia.com><4FA2C4E9.2080509@wwwdotorg.org>
Message-ID: <20120504.093358.2098007825524274078.hdoyu@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCHv3 3/4] iommu/tegra: smmu: Refrain from accessing to AHB
Date: Thu, 3 May 2012 19:48:25 +0200
Message-ID: <4FA2C4E9.2080509@wwwdotorg.org>

> On 05/03/2012 10:05 AM, Hiroshi DOYU wrote:
> > Use "tegra_ahb_enable_smmu()" to inform AHB that SMMU is
> > ready, instead of directly aceessing AHB registers.
> 
> You need to make the Kconfig option for the SMMU either depend on or
> select the TEGRA_AHB option. If you don't, then if someone disables the
> AHB driver, the SMMU driver may still build, yet fail to link since the
> AHB API it calls doesn't exist.
> 
> > diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
> 
> > @@ -398,10 +388,8 @@ static void smmu_setup_regs(struct smmu_device *smmu)
> >  
> >  	smmu_flush_regs(smmu, 1);
> >  
> > -	val = ahb_read(smmu, AHB_XBAR_CTRL);
> > -	val |= AHB_XBAR_CTRL_SMMU_INIT_DONE_DONE <<
> > -		AHB_XBAR_CTRL_SMMU_INIT_DONE_SHIFT;
> > -	ahb_write(smmu, val, AHB_XBAR_CTRL);
> > +	err = tegra_ahb_enable_smmu(smmu->ahb);
> > +	return err;
> 
> You can just "return tegra_ahb_..." here.
> 
> > @@ -911,14 +899,16 @@ static int tegra_smmu_probe(struct platform_device *pdev)
> 
> > +	smmu->ahb = of_parse_phandle(pdev->dev.of_node, "ahb", 0);
> 
> Hmm, "ahb" should probably be "nvidia,ahb".

Does this mean the following in dts?

	ahb: ahb at 6000c004 {
		compatible = "nvidia,tegra30-ahb";
		reg = <0x6000c004 0x14c>; /* AHB Arbitration + Gizmo Controller */
	};

	smmu: smmu at 7000f000 {
		nvidia,ahb = &ahb;
	};      ^^^^^^^^^^
