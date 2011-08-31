From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Wed, 31 Aug 2011 13:52:08 +0300
Subject: [PATCH] iommu: omap_iovmm: support non page-aligned buffers in
	iommu_vmap
In-Reply-To: <1314646569-16738-1-git-send-email-ohad@wizery.com>
References: <1314646569-16738-1-git-send-email-ohad@wizery.com>
Message-ID: <CAK=Wgbb06Z0_8OKFf6MKjYe+SJN16Mh9PA6z_T+cpSpB9EKHFw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 29, 2011 at 10:36 PM, Ohad Ben-Cohen <ohad@wizery.com> wrote:
> From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>
> omap_iovmm requires page-aligned buffers, and that sometimes causes
> omap3isp failures (i.e. whenever the buffer passed from userspace is not
> page-aligned).
>
> Remove this limitation by rounding the address of the first page entry
> down, and adding the offset back to the device address.

I'm having second thoughts about this.

Obviously it works for omap3isp and its users because the buffer gets
mapped and everyone is happy.

But I'm not sure this is a valid IOMMU interface that the kernel
should have, because effectively we're now mapping physical memory
which nobody asked us to, and which might contain sensitive stuff we
don't want to give the device (e.g. a remote processor which might be
running rogue code) access to.

Thoughts ?

>
> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Acked-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
> [ohad at wizery.com: slightly edited the commit log]
> Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
> ---
> A fix by Laurent that was waiting until omap's iommu lands in drivers/.
>
> Generally we're not extending omap-iovmm anymore, but this fixes a real
> breakage for omap3isp users, so there's no point in delaying it until
> the generic DMA API is ready and we've migrated.
>
> Thanks Laurent!
>
> ?drivers/iommu/omap-iovmm.c | ? 32 ++++++++++++++++++++++++--------
> ?1 files changed, 24 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/iommu/omap-iovmm.c b/drivers/iommu/omap-iovmm.c
> index 5e7f97d..d28a256 100644
> --- a/drivers/iommu/omap-iovmm.c
> +++ b/drivers/iommu/omap-iovmm.c
> @@ -27,6 +27,15 @@
>
> ?static struct kmem_cache *iovm_area_cachep;
>
> +/* return the offset of the first scatterlist entry in a sg table */
> +static unsigned int sgtable_offset(const struct sg_table *sgt)
> +{
> + ? ? ? if (!sgt || !sgt->nents)
> + ? ? ? ? ? ? ? return 0;
> +
> + ? ? ? return sgt->sgl->offset;
> +}
> +
> ?/* return total bytes of sg buffers */
> ?static size_t sgtable_len(const struct sg_table *sgt)
> ?{
> @@ -39,11 +48,17 @@ static size_t sgtable_len(const struct sg_table *sgt)
> ? ? ? ?for_each_sg(sgt->sgl, sg, sgt->nents, i) {
> ? ? ? ? ? ? ? ?size_t bytes;
>
> - ? ? ? ? ? ? ? bytes = sg->length;
> + ? ? ? ? ? ? ? bytes = sg->length + sg->offset;
>
> ? ? ? ? ? ? ? ?if (!iopgsz_ok(bytes)) {
> - ? ? ? ? ? ? ? ? ? ? ? pr_err("%s: sg[%d] not iommu pagesize(%x)\n",
> - ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?__func__, i, bytes);
> + ? ? ? ? ? ? ? ? ? ? ? pr_err("%s: sg[%d] not iommu pagesize(%u %u)\n",
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?__func__, i, bytes, sg->offset);
> + ? ? ? ? ? ? ? ? ? ? ? return 0;
> + ? ? ? ? ? ? ? }
> +
> + ? ? ? ? ? ? ? if (i && sg->offset) {
> + ? ? ? ? ? ? ? ? ? ? ? pr_err("%s: sg[%d] offset not allowed in internal "
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? "entries\n", __func__, i);
> ? ? ? ? ? ? ? ? ? ? ? ?return 0;
> ? ? ? ? ? ? ? ?}
>
> @@ -164,8 +179,8 @@ static void *vmap_sg(const struct sg_table *sgt)
> ? ? ? ? ? ? ? ?u32 pa;
> ? ? ? ? ? ? ? ?int err;
>
> - ? ? ? ? ? ? ? pa = sg_phys(sg);
> - ? ? ? ? ? ? ? bytes = sg->length;
> + ? ? ? ? ? ? ? pa = sg_phys(sg) - sg->offset;
> + ? ? ? ? ? ? ? bytes = sg->length + sg->offset;
>
> ? ? ? ? ? ? ? ?BUG_ON(bytes != PAGE_SIZE);
>
> @@ -405,8 +420,8 @@ static int map_iovm_area(struct iommu_domain *domain, struct iovm_struct *new,
> ? ? ? ? ? ? ? ?u32 pa;
> ? ? ? ? ? ? ? ?size_t bytes;
>
> - ? ? ? ? ? ? ? pa = sg_phys(sg);
> - ? ? ? ? ? ? ? bytes = sg->length;
> + ? ? ? ? ? ? ? pa = sg_phys(sg) - sg->offset;
> + ? ? ? ? ? ? ? bytes = sg->length + sg->offset;
>
> ? ? ? ? ? ? ? ?flags &= ~IOVMF_PGSZ_MASK;
>
> @@ -600,7 +615,7 @@ u32 omap_iommu_vmap(struct iommu_domain *domain, struct omap_iommu *obj, u32 da,
> ? ? ? ?if (IS_ERR_VALUE(da))
> ? ? ? ? ? ? ? ?vunmap_sg(va);
>
> - ? ? ? return da;
> + ? ? ? return da + sgtable_offset(sgt);
> ?}
> ?EXPORT_SYMBOL_GPL(omap_iommu_vmap);
>
> @@ -620,6 +635,7 @@ omap_iommu_vunmap(struct iommu_domain *domain, struct omap_iommu *obj, u32 da)
> ? ? ? ? * 'sgt' is allocated before 'omap_iommu_vmalloc()' is called.
> ? ? ? ? * Just returns 'sgt' to the caller to free
> ? ? ? ? */
> + ? ? ? da &= PAGE_MASK;
> ? ? ? ?sgt = unmap_vm_area(domain, obj, da, vunmap_sg,
> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?IOVMF_DISCONT | IOVMF_MMIO);
> ? ? ? ?if (!sgt)
> --
> 1.7.4.1
>
>
