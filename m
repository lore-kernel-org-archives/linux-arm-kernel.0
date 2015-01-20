From: jy0922.shim@samsung.com (Joonyoung Shim)
Date: Tue, 20 Jan 2015 20:12:59 +0900
Subject: [PATCH v3 00/19] Exynos SYSMMU (IOMMU) integration with DT and
 DMA-mapping subsystem
In-Reply-To: <54B5B721.4070309@collabora.co.uk>
References: <1416395748-10731-1-git-send-email-m.szyprowski@samsung.com>
 <1417514366.21830.22.camel@collabora.co.uk> <54818768.3080303@samsung.com>
 <CABxcv=n=eNqbyBbOk1Wb87tCnnLZAJQurmCdeTOSqMZMbNaSHw@mail.gmail.com>
 <54AC93E0.8010705@samsung.com> <54ACFD69.1020500@collabora.co.uk>
 <54AD0293.70909@samsung.com> <54AEB384.2040005@collabora.co.uk>
 <54B36C5A.6050109@samsung.com> <54B3F1B7.7090307@collabora.co.uk>
 <54B4ABFB.5000501@samsung.com> <54B5B5F6.3030607@collabora.co.uk>
 <54B5B721.4070309@collabora.co.uk>
Message-ID: <54BE383B.5030505@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 01/14/2015 09:24 AM, Javier Martinez Canillas wrote:
> On 01/14/2015 01:19 AM, Javier Martinez Canillas wrote:
>>
>> I dug further on this issue and found that the cause is that the exynos_mixer
>> driver needs some clocks (CLK_HDMI and CLK_SCLK_HDMI) grabbed by exynos_hdmi
>> to be kept enabled after hdmi_poweroff (drivers/gpu/drm/exynos/exynos_hdmi.c).
>>
>> Otherwise, any access to mixer device registers leads to an imprecise external
>> abort error. The following change [0] to the Exynos DRM HDMI driver makes the
>> issue to not happen and I can successfully execute:
>>
>> # echo 1 > /sys/devices/platform/exynos-drm/graphics/fb0/blank
>> # echo 0 > /sys/devices/platform/exynos-drm/graphics/fb0/blank
>>

Did you execute this operation repeatedly? Still i get error when i
execute this more than twice with your change [0].

Thanks.

>> Only not disabling the hdmi clock [1]: is enough but doing so makes sometimes the
>> DISP1 power domain disabling fails. It doesn't seem to have side effect though
>> since I also see the signal in the HDMI display to go standby and then on again.
>>
>> # echo 0 > /sys/devices/platform/exynos-drm/graphics/fb0/blank
>> # echo 1 > /sys/devices/platform/exynos-drm/graphics/fb0/blank
>> [   63.089080] Power domain disp1-power-domain disable failed
>> # echo 0 > /sys/devices/platform/exynos-drm/graphics/fb0/blank
>> #
>>
>> That error message when both clocks are not disabled on hdmi_poweroff() though.
>>
> 
> This should be: "That error message is not shown when both clocks are disabled".
> 
> Best regards,
> Javier
> 
