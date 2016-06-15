From: tfiga@chromium.org (Tomasz Figa)
Date: Wed, 15 Jun 2016 23:21:28 +0900
Subject: [PATCH v3 3/6] iommu/rockchip: support virtual iommu slave device
In-Reply-To: <1465992285-16187-4-git-send-email-zhengsq@rock-chips.com>
References: <1465992285-16187-1-git-send-email-zhengsq@rock-chips.com>
 <1465992285-16187-4-git-send-email-zhengsq@rock-chips.com>
Message-ID: <CAAFQd5AHj8dNrpXXP80k9qguBjEyGehbnGO=rCQU499Nm23yew@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shunqian,

On Wed, Jun 15, 2016 at 9:04 PM, Shunqian Zheng <zhengsq@rock-chips.com> wrote:
> An virtual master device like DRM need to attach to iommu
> domain to share the mapping with VOPs(the one with actual
> iommu slaves).
> DRM attaches to iommu and allocates buffers before VOPs enabled,
> which means there may have not real iommu devices can be used
> to do dma mapping.
>
> This patch creates a iommu when virtual master(group is NULL)
> attaching, so it can use this iommu even the real iommus disabled.
>
> Changes of V3:
> - Instead of registering virtual iommu in DTS, this patch
>   creates a iommu when attaching.
>
> Signed-off-by: Shunqian Zheng <zhengsq@rock-chips.com>
> Suggested-by: Tomasz Figa <tfiga@chromium.org>

To clarify, I don't really like the idea of virtual IOMMU, however it
is registered, dts or manually, but I don't think there is any other
reasonable way of dealing with allocations for subsystems such as DRM,
where there are multiple devices in one IOMMU domain. Having said
that, please see some minor comments inline.

> ---
>  drivers/iommu/rockchip-iommu.c | 133 +++++++++++++++++++++++++++++++++++++----
>  1 file changed, 122 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
> index 3c16ec3..82ecc99 100644
> --- a/drivers/iommu/rockchip-iommu.c
> +++ b/drivers/iommu/rockchip-iommu.c
[snip]
> @@ -878,6 +975,9 @@ static struct iommu_domain *rk_iommu_domain_alloc(unsigned type)
>         if (!rk_domain)
>                 return NULL;
>
> +       if (iommu_get_dma_cookie(&rk_domain->domain))
> +               goto err_dt;
> +

Shouldn't this belong to a separate patch? Actually, is this required?
If so, how this worked before?

>         /*
>          * rk32xx iommus use a 2 level pagetable.
>          * Each level1 (dt) and level2 (pt) table has 1024 4-byte entries.
> @@ -917,6 +1017,9 @@ static void rk_iommu_domain_free(struct iommu_domain *domain)
>         }
>
>         free_page((unsigned long)rk_domain->dt);
> +
> +       iommu_put_dma_cookie(&rk_domain->domain);
> +

See above.

Otherwise, with the above addressed, you can add my Reviewed-by.

Best regards,
Tomasz
