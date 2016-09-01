From: shawn.lin@rock-chips.com (Shawn Lin)
Date: Thu, 1 Sep 2016 11:23:42 +0800
Subject: [PATCH 2/2] arm64: dts: rockchip: add eMMC's power domain support
 for rk3399
In-Reply-To: <77f5cff1-80a2-76b3-40e9-f77caced2257@rock-chips.com>
References: <20160827134103.28160-1-xzy.xu@rock-chips.com>
 <20160827134103.28160-3-xzy.xu@rock-chips.com>
 <2ab8ab94-fa4d-2cd6-5805-a92ac5f9697e@rock-chips.com>
 <57C3A30B.5080707@rock-chips.com>
 <ceba6a89-6945-58c5-62e4-7d842cfa2312@rock-chips.com>
 <CAD=FV=W=LkVAm187hxp0Kbjxi5kSThwKnCMX+tr8SXQ-v_xQTQ@mail.gmail.com>
 <77f5cff1-80a2-76b3-40e9-f77caced2257@rock-chips.com>
Message-ID: <12451b81-321e-b661-8f1c-25c91bffba54@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2016/9/1 10:29, Ziyuan Xu ??:
> Hi,
>
>
> On 2016?09?01? 01:42, Doug Anderson wrote:
>> Hi,
>>
>> On Sun, Aug 28, 2016 at 8:25 PM, Shawn Lin <shawn.lin@rock-chips.com>
>> wrote:
>>> On 2016/8/29 10:50, Elaine Zhang wrote:
>>>>
>>>>
>>>> On 08/27/2016 11:05 PM, Shawn Lin wrote:
>>>>> On 2016/8/27 21:41, Ziyuan Xu wrote:
>>>>>> Control power domain for eMMC via genpd to reduce power consumption.
>>>>>>
>>>>>> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
>>>>>> Signed-off-by: Ziyuan Xu <xzy.xu@rock-chips.com>
>>>>>>
>>>>> It looks nice to me. But this should be merged after applying that[0]
>>>>> as your patch will break bind/unbind test for sdhci-of-arasan on
>>>>> rk3399
>>>>> without it[0]. Moreover, Elaine should make sure that upstreamed
>>>>> rockchip power domain stuff would not off pd for emmc, *otherwise*, I
>>>>> should update my patch to make sure we update clkmul every time when
>>>>> doing suspend 2 resume..
>>>>>
>>>>>
>>>> Forgot to say:
>>>> If use pd, Although there is no call to power odd the pd_emmc,
>>>> it will be power off when the system doing suspend 2 resume.
>>>> (Because the system call
>>>> __device_suspend_noirq->pm_genpd_suspend_noirq->rockchip_pd_power_off)
>>>
>>> Thanks for explaining this. I checked the code a bit and actually I
>>> don't need to updata clkmul since it was recorded, although it is still
>>> reset to 0x10 reading from syscon. So for that, we can now pick it
>>> up without waiting for my sdhci-of-arasan's update.
>>>
>>> Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>
>> This is fine to pick up _only_ if you don't care about suspend/resume.
>> If you care about suspend/resume then someone needs to first write a
>> patch that will re-init all "corecfg" values after power is turned on.
>
> Do you mean corecfg_clockmultiplier and corecfg_baseclkfreq, if yes, we
> don't need to strore/re-init it after resume.
> corecfg_clockmultiplier is only used to fetch host->clk_mul, and
> host->clk_mul has been a fixed value at run-time, unless driver unbind.
> The same as corecfg_clockmultiplier, corecfg_baseclkfreq is used to
> check the xin_clk at probe time, we don't reference it at run-time.

correct. That is why we don't need to update it even we power off pd.

> BTW, I have tested suspend/resume on rk3399 prior to this sumbit, eMMC
> works fine.
>
>>
>> Technically I think this should probably use "pm runtime" and not
>> normal suspend/resume hooks.  Any time we end up pm runtime suspended
>> then I think our power will go off (because of genpd?) and we need to
>> restore values.
>
> I understand your consideration. BUT genpd is in charge of on/off pd if
> the corresponding device node has "power-domains" property. RPM is
> unnecessary for this situation, we will not use autosuspend, right?

That is irrelevant to rpm as what we need is just to control genpd here.
If we need to support rmp, we need some extra patches to do it,
including genpd off, clk-disable, etc...

>
> @shawn, what's your opinion?
>
>>
>> I'm not sure if this should be done in a generic way where we try to
>> save and restore all values in the "sdhci_arasan_soc_ctl_map" or if we
>> should try to be smarter...

I am prone to keep it as-is, unless we see a stronge requirement for
coming users who argue that they have some extra corecfg_* need to
recovery due to whatever reason.:)

If we see something like this:

if(of_device_is_compatible(A))
  	update X
else if (of_device_is_compatible(B))
	update Y
.....

Then we could consider trying to save & restrore all the values.


>>
>>
>> -Doug
>>
>> _______________________________________________
>> Linux-rockchip mailing list
>> Linux-rockchip at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-rockchip
>>
>>
>>
>
>
>
>


-- 
Best Regards
Shawn Lin
