From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 16 Jul 2013 17:21:58 -0600
Subject: [PATCH v2 10/22] iommu/tegra: smmu: Move IOMMU to core_initcall
In-Reply-To: <1373021097-32420-11-git-send-email-hdoyu@nvidia.com>
References: <1373021097-32420-1-git-send-email-hdoyu@nvidia.com>
 <1373021097-32420-11-git-send-email-hdoyu@nvidia.com>
Message-ID: <51E5D596.3030002@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/05/2013 04:44 AM, Hiroshi Doyu wrote:
> Move IOMMU to core_initcall in order to instanciate this device earlier
> than others since IOMMU driver needs to reigster other platform
> devices as IOMMU'able.

If both the AHB and SMMU driver are core_initcall, there's no guarantee
at all re: which order they'll get probed in. Deferred probe won't help
here, since I don't think it's guaranteed to be repeated, so if the
probe order is:

1) SMMU (fails since AHB isn't available)
2) AHB

... then the SMMU might not get probed until /much/ later; probably
after devices that are affected by the SMMU are probed.

However, it all works out if the probe order just accidentally happens
to be:

1) AHB
2) SMMU.

So, this really doesn't look like a viable solution.
