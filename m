From: heiko@sntech.de (Heiko Stuebner)
Date: Tue, 07 Aug 2018 13:45:26 +0200
Subject: [PATCH 2/2] iommu/rockchip: Move irq request past
 pm_runtime_enable
In-Reply-To: <20180807085406.3863-3-marc.zyngier@arm.com>
References: <20180807085406.3863-1-marc.zyngier@arm.com>
 <20180807085406.3863-3-marc.zyngier@arm.com>
Message-ID: <2114757.JfhfUCyzvi@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, 7. August 2018, 10:54:06 CEST schrieb Marc Zyngier:
> Enabling the interrupt early, before power has been applied to the
> device, can result in an interrupt being delivered too early if:
> 
> - the IOMMU shares an interrupt with a VOP
> - the VOP has a pending interrupt (after a kexec, for example)
> 
> In these conditions, we end-up taking the interrupt without
> the IOMMU being ready to handle the interrupt (not powered on).
> 
> Moving the interrupt request past the pm_runtime_enable() call
> makes sure we can at least access the IOMMU registers. Note that
> this is only a partial fix, and that the VOP interrupt will still
> be screaming until the VOP driver kicks in, which advocates for
> a more synchronized interrupt enabling/disabling approach.
> 
> Fixes: 0f181d3cf7d98 ("iommu/rockchip: Add runtime PM support")
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>
