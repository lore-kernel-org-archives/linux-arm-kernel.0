From: pullip.cho@samsung.com (Cho KyongHo)
Date: Tue, 18 Mar 2014 22:01:28 +0900
Subject: [PATCH v11 20/27] iommu/exynos: allow having multiple System MMUs
 for a master H/W
In-Reply-To: <53232A53.4040708@samsung.com>
References: <20140314141050.c8bedcb66532d277c496796d@samsung.com>
 <53232A53.4040708@samsung.com>
Message-ID: <20140318220128.564740c88d06b86c9c5c10e3@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 14 Mar 2014 17:12:03 +0100, Tomasz Figa wrote:
> Hi KyongHo,
> 
> On 14.03.2014 06:10, Cho KyongHo wrote:
> > Some master device descriptor like fimc-is which is an abstraction
> > of very complex H/W may have multiple System MMUs. For those devices,
> > the design of the link between System MMU and its master H/W is needed
> > to be reconsidered.
> >
> > A link structure, sysmmu_list_data is introduced that provides a link
> > to master H/W and that has a pointer to the device descriptor of a
> > System MMU. Given a device descriptor of a master H/W, it is possible
> > to traverse all System MMUs that must be controlled along with the
> > master H/W.
> 
> NAK.
> 
> A device driver should handle particular hardware instances separately, 
> without abstracting a virtual hardware instance consisting of multiple 
> physical ones.
> 
> If such abstraction is needed, it should be done above the exynos-iommu 
> driver, e.g. by something like iommu-composite driver that would 
> aggregate several IOMMUs. Keep in mind that such IOMMUs in a group could 
> be different, e.g. different Exynos SysMMU versions or even completely 
> different IPs handled by different drivers.
> 
> Still, I don't think there is a real need for such abstraction. Instead, 
> related drivers shall be fixed to properly handle multiple memory 
> masters and their IOMMUs.
> 

G2D, Scalers and FIMD of Exynos5420 has 2 System MMUs while aother SoC like
Exynos5250 does not.

I don't understand why you are negative to this approach.
This is the simplest than the others.

Let me show you an example.
FIMC-IS driver just controls MCU in FIMC-IS subsystem and the firmware of
the MCU controls all other peripherals in the subsystem. Each peripherals
have their own System MMU. Moreover, the configuration of the peripherals
varies according to the SoCs.

If System MMU driver accepts multiple masters, everything is done in DT.
But I worry that it is not easy if System MMU driver does not support
multiple masters. 

Thank you.

KyongHo
