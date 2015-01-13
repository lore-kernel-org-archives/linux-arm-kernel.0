From: jy0922.shim@samsung.com (Joonyoung Shim)
Date: Tue, 13 Jan 2015 14:24:11 +0900
Subject: [PATCH v3 00/19] Exynos SYSMMU (IOMMU) integration with DT and
 DMA-mapping subsystem
In-Reply-To: <54B3F1B7.7090307@collabora.co.uk>
References: <1416395748-10731-1-git-send-email-m.szyprowski@samsung.com>
 <1417514366.21830.22.camel@collabora.co.uk> <54818768.3080303@samsung.com>
 <CABxcv=n=eNqbyBbOk1Wb87tCnnLZAJQurmCdeTOSqMZMbNaSHw@mail.gmail.com>
 <54AC93E0.8010705@samsung.com> <54ACFD69.1020500@collabora.co.uk>
 <54AD0293.70909@samsung.com> <54AEB384.2040005@collabora.co.uk>
 <54B36C5A.6050109@samsung.com> <54B3F1B7.7090307@collabora.co.uk>
Message-ID: <54B4ABFB.5000501@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 01/13/2015 01:09 AM, Javier Martinez Canillas wrote:
> Hello Joonyoung,
> 
> On 01/12/2015 07:40 AM, Joonyoung Shim wrote:
>>> And also making changes to the clocks in the clk-exynos5420 driver. Can
>>> you please explain the rationale for those changes? I'm asking because
>>> without your clock changes (only adding the DISP1 pd and making the
>>> devices as consumers), I've HDMI output too but video is even worse. This
>>> [0] is the minimal change I have on top of 3.19-rc3 to have some output.
>>>
>>
>> I just refer below patches,
>> http://comments.gmane.org/gmane.linux.kernel.samsung-soc/34576
>>
>> But i'm not sure whether DISP1 power domain is same case with MFC power domain.
>>
> 
> Thanks a lot for sharing those patches, now your changes are much more
> clear to me.
> 
>>>
>>> So there seems to be two issues here, one is the mixer and hdmi modules not
>>> being attached to the DISP1 power domain and another one is the clocks setup
>>> not being correct to have proper HDMI video output.
>>>  
>>
>> Hmm, i can see normal hdmi output still from latest upstream
>> kernel(3.19-rc4) with my kernel changes and u-boot changes(DISP1 power
>> domain disable) of prior mail on odroid xu3 board.
>>
> 
> I thought you said on another email that after commit 2ed127697eb1 which
> landed on 3.19-rc1 you had bad HDMI output?
> 
> In your changes, it was missing the SW_ACLK_400_DISP1 and USER_ACLK_400_DISP1
> clock mux outputs that goes to internal buses in the DISP1. Adding IDs for
> these in the exynos5420 clock driver and to the parent and input clock paris
> list in the DISP1 power domain gives me a good HDMI output on 3.19-rc2.
> 
> Also, the SW_ACLK_300_DISP1 and USER_ACLK_300_DISP1 are needed for the FIMD
> parent and input clock respectively. Adding those to the clocks list of the
> DISP1 power domain gives me working display + HDMI on my Exynos5800 Peach Pi.
> 
> These are the changes I have now [0]. Please let me know what you think.
> 

Good, it's working with your patch without u-boot changes and reverting
of commit 2ed127697eb.

>>>
>>> I didn't have this issue when testing your patch against 3.19-rc2. From your
>>> log I see that you are testing on a 3.18.1. So maybe makes sense to test with
>>> the latest kernel version since this HDMI issue qualifies as an 3.19-rc fix?
>>>
>>> Since commit 2ed127697eb1 ("PM / Domains: Power on the PM domain right after attach completes")
>>> that landed in 3.19-rc1, I see that the power domain is powered on when a
>>> device is attached. So maybe that is what makes a difference here?
>>>
>>
>> I'm not sure, but i get same error results from 3.19-rc4. Did you test
>> using exynos drm driver? I used modetest of libdrm
>>
> 
> Yes, I was not able to trigger that by running modetest but by turning off
> my HDMI monitor and then turning it on again. When the monitor is turned
> on then I see a "Power domain power-domain disable failed" and the imprecise
> external abort error.
> 
> I had to disable CONFIG_DRM_EXYNOS_DP in order to trigger though and that
> is why I was not able to reproduce it before.
> 
> I think though that this is a separate issue of the HDMI not working since
> power domains should be able to have many consumers devices and I see that
> other power domains are used that way.
> 

OK, we need more investigation.

Thanks.
