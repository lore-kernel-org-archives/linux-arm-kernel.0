From: t.figa@samsung.com (Tomasz Figa)
Date: Fri, 14 Mar 2014 17:12:03 +0100
Subject: [PATCH v11 20/27] iommu/exynos: allow having multiple System MMUs
 for a master H/W
In-Reply-To: <20140314141050.c8bedcb66532d277c496796d@samsung.com>
References: <20140314141050.c8bedcb66532d277c496796d@samsung.com>
Message-ID: <53232A53.4040708@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi KyongHo,

On 14.03.2014 06:10, Cho KyongHo wrote:
> Some master device descriptor like fimc-is which is an abstraction
> of very complex H/W may have multiple System MMUs. For those devices,
> the design of the link between System MMU and its master H/W is needed
> to be reconsidered.
>
> A link structure, sysmmu_list_data is introduced that provides a link
> to master H/W and that has a pointer to the device descriptor of a
> System MMU. Given a device descriptor of a master H/W, it is possible
> to traverse all System MMUs that must be controlled along with the
> master H/W.

NAK.

A device driver should handle particular hardware instances separately, 
without abstracting a virtual hardware instance consisting of multiple 
physical ones.

If such abstraction is needed, it should be done above the exynos-iommu 
driver, e.g. by something like iommu-composite driver that would 
aggregate several IOMMUs. Keep in mind that such IOMMUs in a group could 
be different, e.g. different Exynos SysMMU versions or even completely 
different IPs handled by different drivers.

Still, I don't think there is a real need for such abstraction. Instead, 
related drivers shall be fixed to properly handle multiple memory 
masters and their IOMMUs.

Best regards,
Tomasz
