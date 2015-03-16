From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Mon, 16 Mar 2015 18:36:53 +0100
Subject: [PATCH 1/1] ARM: dts: don't make DP a consumer of DISP1 on
 Exynos5250
In-Reply-To: <5506E5D4.1020300@collabora.co.uk>
References: <1426320716-28137-1-git-send-email-javier.martinez@collabora.co.uk>
 <5506C945.5030603@suse.de> <5506E5D4.1020300@collabora.co.uk>
Message-ID: <550714B5.1020503@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On 03/16/2015 03:16 PM, Javier Martinez Canillas wrote:
>> 
>> Tested-by: Andreas F?rber <afaerber@suse.de>
>> 
>> This fixes the display on the Spring Chromebook as well!
>>
> 
> Thanks for testing Andreas but this patch seems to only solve a symptom
> rather than the root cause.
> 
> Since the error happens again when disabling and enabling the display:
> 
> # echo 1 > /sys/devices/platform/exynos-drm/graphics/fb0/blank
> disp1-power-domain: Power-off latency exceeded, new value 225333 ns
> # echo 0 > /sys/devices/platform/exynos-drm/graphics/fb0/blank
> exynos-dp 145b0000.dp-controller: EDID data does not include any extensions.
> exynos-dp 145b0000.dp-controller: EDID Read success!
> exynos-dp 145b0000.dp-controller: Link Training Clock Recovery success
> exynos-dp 145b0000.dp-controller: Link Training success!
> exynos-dp 145b0000.dp-controller: Timeout of video streamclk ok
> exynos-dp 145b0000.dp-controller: unable to config video
> 
> So what happens is that if the DISP1 power domain is powered off and
> then powered on again, the display fails to be enabled.
> 
> Making the dp controller a consumer of the DISP1 pd only made this to
> trigger on boot since the driver probe was deferred and the DISP1 pd
> was turned off and on again on exynos-drm probe.
> 
> It seems that the kernel is not enabling everything that is needed for
> the power domain and it is working on boot just because the bootloader
> initialized everything properly.
> 
> This is similar to the problem we had in Exynos5420 and that was fixed
> by Andrzej in the series "Fix power domains handling on exynos542x" [0].
> So probably a similar solution is needed.
> 

Actually, is more similar to the problem we had when trying to get
HDMI working on Exynos5420 that was solved by the following commits:

885601002998 clk: exynos5420: Add IDs for clocks used in DISP1 power domain
ea08de16eb1b ARM: dts: Add DISP1 power domain for exynos5420

> Andrzej,
> 
> I looked at the Exynos5250 manual and I didn't find anything obvious
> that is missing in the DISP1 pd dev node but the asynchronous bridges
> clocks needed on Exynos5420 was also not well documented so I don't
> know if I'm missing something.
> 
> Do you know what could be missing here? Otherwise I think your patch
> to add the DISP1 pd in the DT should be reverted to have display
> working again on Exynos5250 boards.
>

So my guess is that is missing the attached devices' parent and input clocks
to allow the Exynos PD driver to re-parent the devices input clocks when the
domain is powered off and on.

The Exynos5250 documentation is not as clear as the Exynos5420 on that regard
and also the clocks in the clk-exynos5250.c driver don't match exactly the
names used in the Exynos5250 manual I've access to. So is not clear to me what
are the needed clocks.

Best regards,
Javier
