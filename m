From: grant.likely@linaro.org (Grant Likely)
Date: Thu, 21 Nov 2013 13:23:22 +0000
Subject: [PATCHv5 4/9] iommu/tegra: smmu: register device to iommu
 dynamically
In-Reply-To: <528BDAAA.4000203@wwwdotorg.org>
References: <1384853593-32202-1-git-send-email-hdoyu@nvidia.com> <
 1384853593-32202-5-git-send-email-hdoyu@nvidia.com> <528BDAAA.4000203@
 wwwdotorg.org>
Message-ID: <20131121132322.EFDD1C40A2C@trevor.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 19 Nov 2013 14:39:54 -0700, Stephen Warren <swarren@wwwdotorg.org> wrote:
> On 11/19/2013 02:33 AM, Hiroshi Doyu wrote:
> > platform_devices are registered as IOMMU'able dynamically via
> > add_device() and remove_device().
> > 
> > Tegra SMMU can have multiple address spaces(AS). IOMMU'able devices
> > can belong to one of them. Multiple IOVA maps are created at boot-up,
> > which can be attached to devices later. We reserve 2 of them for
> > static assignment, AS[0] for system default, AS[1] for AHB clusters as
> > protected domain from others, where there are many traditional
> > pheripheral devices like USB, SD/MMC. They should be isolated from
> > some smart devices like host1x for system robustness. Even if smart
> > devices behaves wrongly, the traditional devices(SD/MMC, USB) wouldn't
> > be affected, and the system could continue most likely. DMA API(ARM)
> > needs ARM_DMA_USE_IOMMU to be enabled.
> 
> > diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
> 
> > +static int smmu_iommu_add_device(struct device *dev)
> > +{
> > +	int err = -EPROBE_DEFER;
> > +	u32 swgroups = dev->platform_data;
> > +	struct dma_iommu_mapping *map = NULL;
> > +
> > +	if (test_bit(TEGRA_SWGROUP_PPCS, swgroups))
> > +		map = smmu_handle->map[SYSTEM_PROTECTED];
> > +	else
> > +		map = smmu_handle->map[SYSTEM_DEFAULT];
> > +
> > +	if (map)
> > +		err = arm_iommu_attach_device(dev, map);
> > +	else
> > +		return -EPROBE_DEFER;
> 
> Given that patch 2 exists, if this test fails, then surely the
> appropriate error code is some fatal error, not -EPROBE_DEFER; any
> deferrals should have happened long before this point.

Will need to be revisited. Patching into the core really_probe() like
patch #2 does is a really bad approach which would mean that returning
EPROBE_DEFER is appropriate here.

g.
