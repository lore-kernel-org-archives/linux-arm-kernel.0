From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Tue, 06 May 2014 20:05:14 +0200
Subject: [PATCH v12 18/31] iommu/exynos: allow having multiple System
 MMUs for a master H/W
In-Reply-To: <1398584283-22846-19-git-send-email-shaik.ameer@samsung.com>
References: <1398584283-22846-1-git-send-email-shaik.ameer@samsung.com>
 <1398584283-22846-19-git-send-email-shaik.ameer@samsung.com>
Message-ID: <5369245A.1060001@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27.04.2014 09:37, Shaik Ameer Basha wrote:
> From: Cho KyongHo <pullip.cho@samsung.com>
>
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
>
> Signed-off-by: Cho KyongHo <pullip.cho@samsung.com>
> ---
>   drivers/iommu/exynos-iommu.c |  545 ++++++++++++++++++++++++++----------------
>   1 file changed, 335 insertions(+), 210 deletions(-)
>
> diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
> index fefedec3..c2e6365 100755
> --- a/drivers/iommu/exynos-iommu.c
> +++ b/drivers/iommu/exynos-iommu.c
> @@ -117,6 +117,10 @@
>   #define REG_PB1_EADDR		0x058
>
>   #define has_sysmmu(dev)		(dev->archdata.iommu != NULL)
> +#define for_each_sysmmu_list(dev, list_data)				\
> +	list_for_each_entry(list_data,					\
> +		&((struct exynos_iommu_owner *)dev->archdata.iommu)->mmu_list, \
> +		entry)

Sorry, NAK.

Please don't add this kind of complexity and business logic to low level 
code. We want the configuration functions to be simple, easy to read, 
maintain and extend.

The proper way to do it is to let the IOMMUs be grouped together on 
IOMMU subsystem level, so that each IOMMU consumer driver would see just 
one IOMMU, but then IOMMU driver callbacks would handle just particular 
instances of the IOMMU IP blocks, without any loops, lists and other 
crazy code...

Best regards,
Tomasz
