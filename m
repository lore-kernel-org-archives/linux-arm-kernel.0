From: felipe.contreras@gmail.com (Felipe Contreras)
Date: Fri, 16 Dec 2011 02:53:21 +0200
Subject: [PATCH v4 4/4] OMAP3/4: iommu: adapt to runtime pm
In-Reply-To: <1323922709-6986-5-git-send-email-omar.ramirez@ti.com>
References: <1323922709-6986-1-git-send-email-omar.ramirez@ti.com>
 <1323922709-6986-5-git-send-email-omar.ramirez@ti.com>
Message-ID: <CAMP44s3Jb9DZLUyDVU_HmQbaJKp=2qym7Z6uauNchJh0fPL4hQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 15, 2011 at 6:18 AM, Omar Ramirez Luna <omar.ramirez@ti.com> wrote:
> Use runtime PM functionality interfaced with hwmod enable/idle
> functions, to replace direct clock operations, reset and sysconfig
> handling.
>
> Removed clk handling during interrupt, given that in order to receive one,
> the device should be powered on in advance. Now doing pm_runtime_get/put
> on iommu_enable/disable so it doesn't rely on others to keep the clocks on.
>
> Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
> ---
> ?arch/arm/mach-omap2/iommu2.c ? ? ? ? ? ? | ? 17 -----------
> ?arch/arm/mach-omap2/omap-iommu.c ? ? ? ? | ? ?1 -
> ?arch/arm/plat-omap/include/plat/iommu.h ?| ? ?2 -
> ?arch/arm/plat-omap/include/plat/iommu2.h | ? ?2 -
> ?drivers/iommu/omap-iommu.c ? ? ? ? ? ? ? | ? 44 ++++++++++++-----------------
> ?5 files changed, 18 insertions(+), 48 deletions(-)

Shouldn't pm_runtime_enable() be called in omap_iommu_init(), and
omap_iommu_probe() call pm_runtime_get_sync()/put() on the sections
where the device should be active?

Cheers.

-- 
Felipe Contreras
