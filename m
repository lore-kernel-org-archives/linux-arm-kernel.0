From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Thu, 22 Jan 2015 13:41:15 +0100
Subject: [PATCH v4 9/9] drm/exynos: add support for 'hdmi' clock
In-Reply-To: <54BE4F8E.50605@collabora.co.uk>
References: <1421756219-21037-1-git-send-email-m.szyprowski@samsung.com>
 <1421756219-21037-10-git-send-email-m.szyprowski@samsung.com>
 <54BE4F8E.50605@collabora.co.uk>
Message-ID: <54C0EFEB.6080201@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On 2015-01-20 13:52, Javier Martinez Canillas wrote:
> On 01/20/2015 01:16 PM, Marek Szyprowski wrote:
>> Mixed need to have hdmi clock enabled to properly perform power on/off
>> sequences, so add handling of this clock directly to the mixer driver.
>> Dependency between hdmi clock and mixer module has been observed on
>> Exynos4 based boards.
>>
>> Suggested-by: Andrzej Hajda<a.hajda@samsung.com>
>> Signed-off-by: Marek Szyprowski<m.szyprowski@samsung.com>
>> ---
>>   drivers/gpu/drm/exynos/exynos_mixer.c | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/exynos/exynos_mixer.c b/drivers/gpu/drm/exynos/exynos_mixer.c
>> index 820b76234ef4..e5ef1fccd8fb 100644
>> --- a/drivers/gpu/drm/exynos/exynos_mixer.c
>> +++ b/drivers/gpu/drm/exynos/exynos_mixer.c
>> @@ -72,6 +72,7 @@ struct mixer_resources {
>>   	spinlock_t		reg_slock;
>>   	struct clk		*mixer;
>>   	struct clk		*vp;
>> +	struct clk		*hdmi;
>>   	struct clk		*sclk_mixer;
>>   	struct clk		*sclk_hdmi;
>>   	struct clk		*mout_mixer;
>> @@ -774,6 +775,12 @@ static int mixer_resources_init(struct mixer_context *mixer_ctx)
>>   		return -ENODEV;
>>   	}
>>   
>> +	mixer_res->hdmi = devm_clk_get(dev, "hdmi");
> You need to update the Documentation/devicetree/bindings/video/exynos_mixer.txt
> DT binding docs to also mention the "hdmi" clock in the list of clocks.

Right, I've send an updated version of the patch.

> But as I mentioned in "[PATCH v2 0/6] Enable HDMI support on Exynos platforms"
> thread, while this seems to be enough to prevent the issue on Exynos4 is not
> enough on the Exynos5420/5422/5800 boards I've tested.
>
> So I wonder if $subject is fixing the root cause or just fixing a symptom and
> the cause is that the exynos_hdmi DPMS handler has to be executed before the
> exynos_mixer DPMS handler for DRM_MODE_DPMS_ON like is the case for DPMS_OFF
> after commit 245f98f269714 ("drm/exynos: hdmi: fix power order issue").

I'm aware of the issues with Exynos542x, I've tested it with Odroid XU3, 
but I
really have no idea how to fix it. The reference manual (both for power 
domain
and mixer/hdmi modules) also doesn't provide any useful information for this
case.

The issue with power on/off sequence definitely IS related to clock 
configuration,
but we didn't figure out how to solve it in a generic way. This will be 
handled in
Exynos HDMI and mixer drivers anyway, so the DTS part (at least for 
Exynos4 SoC)
will not change.

We would really like to have HDMI support for Exynos4 merged, especially 
that the
first version of the HDMI patches was posted in v3.16 times and now we 
are close
to v3.20 -next merge window end...

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
