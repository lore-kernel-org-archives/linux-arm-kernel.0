From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Wed, 10 Aug 2016 13:41:55 -0400
Subject: [PATCH] exynos-drm: Fix display manager failing to start without
 IOMMU problem
In-Reply-To: <1470850251-9150-1-git-send-email-shuahkh@osg.samsung.com>
References: <1470850251-9150-1-git-send-email-shuahkh@osg.samsung.com>
Message-ID: <CABxcv=nWLjcNJM+R-KeeUgLt5FPV+uhhdWemjw=OU4mY+77FVA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Shuah,

On Wed, Aug 10, 2016 at 1:30 PM, Shuah Khan <shuahkh@osg.samsung.com> wrote:
> Fix exynos_drm_gem_create_ioctl() attempts to allocate non-contiguous GEM
> memory without IOMMU. In this case, there is no point in attempting to
> allocate non-contiguous memory, only to return error during the next step
> from exynos_drm_framebuffer_init() which leads to display manager failing
> to start.
>
> Check if non-contiguous GEM memory is requested without IOMMU. If so,
> allocate contiguous GEM memory to help display manager start.
>
> Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
> ---
>  drivers/gpu/drm/exynos/exynos_drm_gem.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/drivers/gpu/drm/exynos/exynos_drm_gem.c b/drivers/gpu/drm/exynos/exynos_drm_gem.c
> index 4c4cb0e..4719116 100644
> --- a/drivers/gpu/drm/exynos/exynos_drm_gem.c
> +++ b/drivers/gpu/drm/exynos/exynos_drm_gem.c
> @@ -266,6 +266,20 @@ int exynos_drm_gem_create_ioctl(struct drm_device *dev, void *data,
>         struct exynos_drm_gem *exynos_gem;
>         int ret;
>
> +       /*
> +        * Check if non-contiguous GEM memory is requested without IOMMU.
> +        * If so, allocate contiguous GEM memory.
> +        *
> +        * There is no point in attempting to allocate non-contiguous memory,
> +        * only to return error from exynos_drm_framebuffer_init() which leads
> +        * to display manager failing to start.
> +       */
> +       if (!is_drm_iommu_supported(dev) &&
> +           (args->flags & EXYNOS_BO_NONCONTIG)) {
> +               args->flags &= ~EXYNOS_BO_NONCONTIG;
> +               args->flags |= EXYNOS_BO_CONTIG;
> +       }
> +

I'm not a DRM expert so I don't know if this is the correct way to
handle this. But the approach sounds sensible to me.

Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

Best regards,
Javier
