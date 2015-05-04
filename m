From: daniel@fooishbar.org (Daniel Stone)
Date: Mon, 4 May 2015 12:34:51 +0100
Subject: [PATCH] drm/exynos: Fix build breakage on !DRM_EXYNOS_FIMD
In-Reply-To: <55472339.8040408@samsung.com>
References: <1430539706-2945-1-git-send-email-k.kozlowski.k@gmail.com>
 <55472339.8040408@samsung.com>
Message-ID: <CAPj87rM-utcjuWD+ZB7_m01X3qUsNnwJmabCYZAAQUkAdRabaQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 4 May 2015 at 08:43, Inki Dae <inki.dae@samsung.com> wrote:
> On 2015? 05? 02? 13:08, Krzysztof Kozlowski wrote:
>> Selecting CONFIG_FB_S3C disables CONFIG_DRM_EXYNOS_FIMD leading to build
>> error:
>
> No, eDP has no any dependency of FIMD but DECON. Just add dependency
> code like below,
>
>  config DRM_EXYNOS7_DECON
>         bool "Exynos DRM DECON"
> -       depends on DRM_EXYNOS
> +       depends on DRM_EXYNOS && !FB_S3C

But it does clearly and explicitly call fimd_dp_clock_enable from
exynos_dp_powero{n,ff}. So the dependency you're proposing seems
backwards: it's not an expression of the requirements of the current
code (that FIMD DP code be available, i.e. CONFIG_DRM_EXYNOS_FIMD is
selected), but an indirect expression of another dependency
(CONFIG_FB_S3C disables CONFIG_DRM_EXYNOS_FIMD, so disable
CONFIG_FB_S3C).

Additionally, as the call comes from exynos_dp_core.c, which is built
by CONFIG_DRM_EXYNOS_DP (an explicitly user-selectable option), why
shouldn't the dependency be there? Ah, because the dependency on DP is
for (DECON || FIMD), but as DECON doesn't provide
fimd_dp_clock_enable(), it doesn't seem like it would compile if you
selected DECON and not FIMD.

So, for me, the cleanest solution would be config DRM_EXYNOS_DP gains
a hard dependency on DRM_EXYNOS_FIMD, at least until it can be fixed
to compile without FIMD.

Cheers,
Daniel
