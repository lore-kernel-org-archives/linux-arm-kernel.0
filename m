From: inki.dae@samsung.com (Inki Dae)
Date: Mon, 4 May 2015 23:31:38 +0900
Subject: [PATCH] drm/exynos: Fix build breakage on !DRM_EXYNOS_FIMD
In-Reply-To: <CAPj87rM-utcjuWD+ZB7_m01X3qUsNnwJmabCYZAAQUkAdRabaQ@mail.gmail.com>
References: <1430539706-2945-1-git-send-email-k.kozlowski.k@gmail.com>
 <55472339.8040408@samsung.com>
 <CAPj87rM-utcjuWD+ZB7_m01X3qUsNnwJmabCYZAAQUkAdRabaQ@mail.gmail.com>
Message-ID: <CAAQKjZM7ROus=zUK5n2Sk2psobEUMZo_Aom-u5eWaTu4S+0aEA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-05-04 20:34 GMT+09:00 Daniel Stone <daniel@fooishbar.org>:
> Hi,
>
> On 4 May 2015 at 08:43, Inki Dae <inki.dae@samsung.com> wrote:
>> On 2015? 05? 02? 13:08, Krzysztof Kozlowski wrote:
>>> Selecting CONFIG_FB_S3C disables CONFIG_DRM_EXYNOS_FIMD leading to build
>>> error:
>>
>> No, eDP has no any dependency of FIMD but DECON. Just add dependency
>> code like below,
>>
>>  config DRM_EXYNOS7_DECON
>>         bool "Exynos DRM DECON"
>> -       depends on DRM_EXYNOS
>> +       depends on DRM_EXYNOS && !FB_S3C
>
> But it does clearly and explicitly call fimd_dp_clock_enable from
> exynos_dp_powero{n,ff}. So the dependency you're proposing seems
> backwards: it's not an expression of the requirements of the current
> code (that FIMD DP code be available, i.e. CONFIG_DRM_EXYNOS_FIMD is
> selected), but an indirect expression of another dependency
> (CONFIG_FB_S3C disables CONFIG_DRM_EXYNOS_FIMD, so disable
> CONFIG_FB_S3C).
>
> Additionally, as the call comes from exynos_dp_core.c, which is built
> by CONFIG_DRM_EXYNOS_DP (an explicitly user-selectable option), why
> shouldn't the dependency be there? Ah, because the dependency on DP is
> for (DECON || FIMD), but as DECON doesn't provide
> fimd_dp_clock_enable(), it doesn't seem like it would compile if you

Please know that the output data of DECON and FIMD can go to DSI or
Panel directly not through eDP. This means that they - FIMD and eDP or
DECON and eDP - have hardware dependency each other. DECON driver
missed this - only one of Linux framebuffer and DRM KMS driver should
be selected because Linux framebuffer and DRM KMS drivers control same
hardware. So the reason that DECON driver should have dependency on
eDP is not because dp core functions are called by FIMD driver.

In addition, from hw point of view, eDP has depencency on DECON and
FIMD because eDP cannot work itself without DECON or FIMD. Therefore,
if DECON or FIMD is not selected, then eDP should also be disabled  so
that user cannot disable eDP with FIMD because FIMD driver calls eDP's
functions directly. My missing point was that even though we add
!S3C_FB to DECON Kconfig, we can disable eDP with FIMD so build error
can still occur. The best way to resolve this issue would be to move
the functions called by FIMD driver directly to Exynos specific KMS
structure such as exynos crtc - eDP driver implements encoder which
know crtc to FIMD or DECON. The directly call was not good way.

Thanks,
Inki Dae

> selected DECON and not FIMD.
>
> So, for me, the cleanest solution would be config DRM_EXYNOS_DP gains
> a hard dependency on DRM_EXYNOS_FIMD, at least until it can be fixed
> to compile without FIMD.
>
> Cheers,
> Daniel
> _______________________________________________
> dri-devel mailing list
> dri-devel at lists.freedesktop.org
> http://lists.freedesktop.org/mailman/listinfo/dri-devel
