From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Wed, 13 Dec 2017 10:42:33 +0100
Subject: [PATCH] ARM: exynos_defconfig - enable CONFIG_EXYNOS_IOMMU
In-Reply-To: <20171212213110.20893-1-shuahkh@osg.samsung.com>
References: <CGME20171212213136epcas2p45d4b1a2489e341f38362ca59b35977ec@epcas2p4.samsung.com>
 <20171212213110.20893-1-shuahkh@osg.samsung.com>
Message-ID: <d7d38ca9-ca53-8cb1-6c8a-c219ec94f005@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shuah,

On 2017-12-12 22:31, Shuah Khan wrote:
> EXYNOS_IOMMU is disabled in exynos_defconfig since it is known to cause
> boot failures on Exynos Chrome-books. The recommendation is for IOMMU to
> be enabled manually on systems as needed.
>
> A recent exynos_drm change added a warning message when EXYNOS_IOMMU is
> disabled. It is necessary to enable it to avoid the warning messages.
> A few initial tests have shown that enabling EXYNOS_IOMMU might be safe
> on Exynos Chrome-books.
>
> Enable CONFIG_EXYNOS_IOMMU in exynos_defconfig.
>
> Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>

Due to some other changes in the order of operations during boot process,
power domains are initialized very early and because of the temporary
lack of devices (which are not yet added to the system), are turned off.

This practically stops FIMD for scanning framebuffer very early during
boot, before IOMMU gets initialized and "solves" the issue, which was
the reason to disable Exynos IOMMU by default.

Like I've already said, I've checked Exynos Snow Chromebook boots fine
with IOMMU support enabled, both with v4.15-rc3 and linux-next.

Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

> ---
>   arch/arm/configs/exynos_defconfig | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
> index f1d7834..0ccd5eb 100644
> --- a/arch/arm/configs/exynos_defconfig
> +++ b/arch/arm/configs/exynos_defconfig
> @@ -281,6 +281,7 @@ CONFIG_DEVFREQ_GOV_POWERSAVE=y
>   CONFIG_DEVFREQ_GOV_USERSPACE=y
>   CONFIG_ARM_EXYNOS_BUS_DEVFREQ=y
>   CONFIG_DEVFREQ_EVENT_EXYNOS_NOCP=y
> +CONFIG_EXYNOS_IOMMU=y
>   CONFIG_EXTCON=y
>   CONFIG_EXTCON_MAX14577=y
>   CONFIG_EXTCON_MAX77693=y

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
