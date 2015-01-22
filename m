From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Thu, 22 Jan 2015 14:20:28 +0100
Subject: [PATCH v4 9/9] drm/exynos: add support for 'hdmi' clock
In-Reply-To: <54C0F23F.3030804@collabora.co.uk>
References: <1421756219-21037-1-git-send-email-m.szyprowski@samsung.com>
 <1421756219-21037-10-git-send-email-m.szyprowski@samsung.com>
 <54BE4F8E.50605@collabora.co.uk> <54C0EFEB.6080201@samsung.com>
 <54C0F23F.3030804@collabora.co.uk>
Message-ID: <54C0F91C.7070301@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On 2015-01-22 13:51, Javier Martinez Canillas wrote:
> Hello Marek,
>
> On 01/22/2015 01:41 PM, Marek Szyprowski wrote:
>>>>    
>>>> +	mixer_res->hdmi = devm_clk_get(dev, "hdmi");
>>> You need to update the Documentation/devicetree/bindings/video/exynos_mixer.txt
>>> DT binding docs to also mention the "hdmi" clock in the list of clocks.
>> Right, I've send an updated version of the patch.
>>
> Great thanks.
>   
>>> But as I mentioned in "[PATCH v2 0/6] Enable HDMI support on Exynos platforms"
>>> thread, while this seems to be enough to prevent the issue on Exynos4 is not
>>> enough on the Exynos5420/5422/5800 boards I've tested.
>>>
>>> So I wonder if $subject is fixing the root cause or just fixing a symptom and
>>> the cause is that the exynos_hdmi DPMS handler has to be executed before the
>>> exynos_mixer DPMS handler for DRM_MODE_DPMS_ON like is the case for DPMS_OFF
>>> after commit 245f98f269714 ("drm/exynos: hdmi: fix power order issue").
>> I'm aware of the issues with Exynos542x, I've tested it with Odroid XU3,
>> but I
>> really have no idea how to fix it. The reference manual (both for power
>> domain
>> and mixer/hdmi modules) also doesn't provide any useful information for this
>> case.
>>
> Yeah, I'm in the same situation. All the documentation I had access to doesn't
> now explain what's happening.

Just to let you know. The problem with power domain failure to turn off 
is something
orthogonal to 'Unhandled fault: external abort on non-linefetch' issue 
in drm mixer
driver. It looks that even if domains reports that it failed to turn 
off, it somehow
disabled the power, because this 'external abort' issue happens on 
Odroid XU3 when
driver tries to access mixer registers with power domain turned off. It 
must be
something badly broken in Exynos DRM HDMI/Mixer handling of runtime pm, 
because
such scenario can be easily triggered simply by running
"libdrm/modetest -M exynos -s 16 at 13:1920x1080".

It looks that in case of Exynos4 access to mixer registers in case of 
disabled power
domain doesn't have such terrible results and thus the driver is somehow 
working well.

>> The issue with power on/off sequence definitely IS related to clock
>> configuration,
>> but we didn't figure out how to solve it in a generic way. This will be
>> handled in
>> Exynos HDMI and mixer drivers anyway, so the DTS part (at least for
>> Exynos4 SoC)
>> will not change.
>>
>> We would really like to have HDMI support for Exynos4 merged, especially
>> that the
>> first version of the HDMI patches was posted in v3.16 times and now we
>> are close
>> to v3.20 -next merge window end...
>>
> Sorry, I didn't mean to imply that $subject should be blocked. I agree with
> you that the power on/off sequence has to be fixed in the hdmi and mixer
> drivers and is orthogonal to the DTS changes. That's why I also decided to
> finally post my "Add HDMI support for Exynos5420 platform" [0] series too.

Thanks. I hope that both series will get merged to v3.20 what will bring 
more
attention to this problem.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
