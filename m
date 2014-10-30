From: a.hajda@samsung.com (Andrzej Hajda)
Date: Thu, 30 Oct 2014 12:01:35 +0100
Subject: [RFC 1/2] PM / Domains: Power on domain early during system resume
In-Reply-To: <1414654594.5114.8.camel@AMDC1943>
References: <1414072090-11293-1-git-send-email-k.kozlowski@samsung.com>
 <1414072090-11293-2-git-send-email-k.kozlowski@samsung.com>
 <7hk33iahvu.fsf@deeprootsystems.com> <1414654594.5114.8.camel@AMDC1943>
Message-ID: <54521A8F.5070808@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/30/2014 08:36 AM, Krzysztof Kozlowski wrote:
> On ?ro, 2014-10-29 at 10:46 -0700, Kevin Hilman wrote:
>> Krzysztof Kozlowski <k.kozlowski@samsung.com> writes:
>>
>>> When resuming the system the power domain has to be powered on early so
>>> any runtime PM aware devices could resume.
>>>
>>> This fixes following scenario reproduced on Exynos DRM:
>>> 1. Power domain is off before suspending the system.
>>> 2. System is suspended to RAM.
>>> 3. Resuming starts. The Exynos DRM driver resume callback is called.
>>> 4. The Exynos DRM driver calls drm_helper_resume_force_mode which turns
>>>    the screen on by calling exynos_dsi_dpms with DRM_MODE_DPMS_ON.
>> Dumb Q: if the device (and power domain) were off before (and during)
>> suspend, why are they being resumed?
>>
>> Shouldn't the resume path restore things to the same state they were
>> before suspend?
> One could expect that... but the Exynos DRM driver behaves differently
> (and some other drivers also). In resume method it calls
> drm_helper_resume_force_mode() which forces restoring mode setting
> configuration. Apparently setting a mode needs DPMS on:
> static void exynos_drm_crtc_commit(struct drm_crtc *crtc)
> {
> 	...
> 	exynos_drm_crtc_dpms(crtc, DRM_MODE_DPMS_ON);
> 	...
>
> The previous DPMS status (status during suspend) is completely ignored
> here.

Suspend callback switches off all connectors (thus all other devs in
their pipeline) by calling dpms_off,
in restore callback all devs are restored to their previous state by
calling appropriate dpms.
So I guess drm_helper_resume_force_mode() call at the end of resume is
incorrect.
On the other side it is present in many other drivers, so I am also
little bit confused.

Regards
Andrzej
