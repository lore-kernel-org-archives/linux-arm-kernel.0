From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 23 Oct 2014 16:02:06 +0200
Subject: [PATCH v2 11/18] iommu: exynos: remove useless device_add/remove
 callbacks
In-Reply-To: <54477EDA.3060104@samsung.com>
References: <1410868485-4143-1-git-send-email-m.szyprowski@samsung.com>
 <2779319.yKiT9EDCse@wuerfel> <54477EDA.3060104@samsung.com>
Message-ID: <1987006.J2W7PED0yz@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 22 October 2014 11:54:34 Marek Szyprowski wrote:
> On 2014-10-22 11:26, Arnd Bergmann wrote:
> > On Wednesday 22 October 2014 11:15:00 Alban Browaeys wrote:
> >> Le mardi 16 septembre 2014 ? 13:54 +0200, Marek Szyprowski a ?crit :
> >>> The driver doesn't need to do anything important in device add/remove
> >>> callbacks, because initialization will be done from device-tree specific
> >>> callbacks added later. IOMMU groups created by current code were never
> >>> used.
> >>>
> >>> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> >>
> >> The exyons iommu init fails if those are removed, that is it never reach
> >> init_done:
> >> 1. exynos_iommu_setup
> >> 2. - exynos_iommu_init
> >> 3. ---bus_set_iommu
> >> 4. ------ add_iommu_group
> >>
> >> that is (4) add_iommu_group returns ENODEV to bus_set_iommu, the latter
> >> doing so to exynos_iommu_init. Which thus error out before the init_done
> >> is set to true.
> > On a related note, I found that the exynos iommu driver does not check
> > for the presence of an exynos iommu before calling bus_set_iommu,
> > and this breaks multiplatform kernels.
> >
> > Please fix.
> 
> For the time being please apply this patch: 
> https://lkml.org/lkml/2014/8/5/163
> 
> The proper solution will be applied when driver will be adapted to common of
> iommu support, which is still under discussion.
> 

The patch looks good.

Acked-by: Arnd Bergmann <arnd@arndb.de>

Can you send it to the iommu maintainer please?

	Arnd
