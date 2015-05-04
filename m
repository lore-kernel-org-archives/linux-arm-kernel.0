From: a.hajda@samsung.com (Andrzej Hajda)
Date: Mon, 04 May 2015 15:15:13 +0200
Subject: [PATCH] drm/exynos: Fix build breakage on !DRM_EXYNOS_FIMD
In-Reply-To: <5547696D.8000300@gmail.com>
References: <1430539706-2945-1-git-send-email-k.kozlowski.k@gmail.com>
 <55472339.8040408@samsung.com>
 <CAPj87rM-utcjuWD+ZB7_m01X3qUsNnwJmabCYZAAQUkAdRabaQ@mail.gmail.com>
 <5547696D.8000300@gmail.com>
Message-ID: <554770E1.2000401@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,


On 05/04/2015 02:43 PM, Krzysztof Kozlowski wrote:
> 2015-05-04 20:34 GMT+09:00 Daniel Stone <daniel@fooishbar.org>:
>> Hi,
>>
>> On 4 May 2015 at 08:43, Inki Dae <inki.dae@samsung.com> wrote:
>>> On 2015? 05? 02? 13:08, Krzysztof Kozlowski wrote:
>>>> Selecting CONFIG_FB_S3C disables CONFIG_DRM_EXYNOS_FIMD leading to build
>>>> error:
>>>
>>> No, eDP has no any dependency of FIMD but DECON. Just add dependency
>>> code like below,
>>>
>>>  config DRM_EXYNOS7_DECON
>>>         bool "Exynos DRM DECON"
>>> -       depends on DRM_EXYNOS
>>> +       depends on DRM_EXYNOS && !FB_S3C
> 
> Actually my commit message was not detailed enough. The FB_S3C here
> won't solve the issue because you may:
> 1, disable FIMD and FB_S3C,
> 2, enabke DECON and DP,
> and it won't compile.
> 
> Currently the FIMD must be enabled if DRM_EXYNOS_DP is enabled.
> 
>>
>> But it does clearly and explicitly call fimd_dp_clock_enable from
>> exynos_dp_powero{n,ff}. So the dependency you're proposing seems
>> backwards: it's not an expression of the requirements of the current
>> code (that FIMD DP code be available, i.e. CONFIG_DRM_EXYNOS_FIMD is
>> selected), but an indirect expression of another dependency
>> (CONFIG_FB_S3C disables CONFIG_DRM_EXYNOS_FIMD, so disable
>> CONFIG_FB_S3C).
>>
>> Additionally, as the call comes from exynos_dp_core.c, which is built
>> by CONFIG_DRM_EXYNOS_DP (an explicitly user-selectable option), why
>> shouldn't the dependency be there? Ah, because the dependency on DP is
>> for (DECON || FIMD), but as DECON doesn't provide
>> fimd_dp_clock_enable(), it doesn't seem like it would compile if you
>> selected DECON and not FIMD.
>>
>> So, for me, the cleanest solution would be config DRM_EXYNOS_DP gains
>> a hard dependency on DRM_EXYNOS_FIMD, at least until it can be fixed
>> to compile without FIMD.
> 
> Right, you correctly pointed current dependencies. Still it looks little
> hacky because EXYNOS_DP may work with FIMD or DECON. 

Are you sure? I have not seen any chipset having DECON and DP. In all
chipsets known to me DP is always accompanied by FIMD. I guess it can
change in the future, but for now hard dependency on FIMD seems to be OK
- it just reflects hardware design.
Of course this is just my humble opinion :)

Regards
Andrzej

It does not really
> need FIMD. Using ifdefs in headers is not uncommon - many core
> subsystems do this that way to provide stubs.
> 
> Probably the cleanest way would be to provide by FIMD and DECON a common
> interface for DP for such operation, something like:
> struct exynos_drm_crtc {
> 	struct drm_crtc                 base;
> 	...
> 	void (*clock_enable)(struct exynos_drm_crtc *crtc, bool enable)
> );
> 
> which, if non-NULL, will be called by exynos_dp_core.c:
> static void exynos_dp_poweron(struct exynos_dp_device *dp)
> {
> 	...
> 	if (crtc->clock_enable)
> 		crtc->clock_enable(crtc, true);
> }
> 
> What do you think?
> 
> Best regards,
> Krzysztof
> 
