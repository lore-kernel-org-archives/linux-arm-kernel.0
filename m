From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Tue, 07 Apr 2015 12:59:04 +0200
Subject: [RFC PATCH v3 2/2] clk: exynos5420: Make sure MDMA0 clock is
 enabled during suspend
In-Reply-To: <CAM4voakS8PnatqRTW5gkD0NNKD9gW9Tuv5p-ekxFhKN5NcuBCQ@mail.gmail.com>
References: <1427730803-28635-1-git-send-email-javier.martinez@collabora.co.uk>	<1427730803-28635-3-git-send-email-javier.martinez@collabora.co.uk>	<CA+Ln22FBpuzR06qCsVc7SXtLX2mhf901vDE5D-mT1+ijZ2G3sg@mail.gmail.com>	<551976F1.1000605@collabora.co.uk>	<CAM4voanL3A=dS8Z-ovi_-EDi9ctyaxZkvjajp+3ZjyNAnqR1aQ@mail.gmail.com>	<551AFCCE.4050404@collabora.co.uk>	<551BD07E.2090506@samsung.com>	<551BDA0A.7010704@collabora.co.uk>	<551C2B6D.4010001@samsung.com>	<551C71A5.1070903@collabora.co.uk>
 <CAM4voakS8PnatqRTW5gkD0NNKD9gW9Tuv5p-ekxFhKN5NcuBCQ@mail.gmail.com>
Message-ID: <5523B878.8040304@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Abhilash,

On 04/02/2015 02:22 PM, Abhilash Kesavan wrote:
> Hi,
> 
> On Thu, Apr 2, 2015 at 4:01 AM, Javier Martinez Canillas
> <javier.martinez@collabora.co.uk> wrote:
>> Hello Sylwester,
>>
>> On 04/01/2015 07:31 PM, Sylwester Nawrocki wrote:
>>> On 01/04/15 13:44, Javier Martinez Canillas wrote:
>>>> On 04/01/2015 01:03 PM, Sylwester Nawrocki wrote:
>>>>> It's not clear what subsystems affect state of the CG_STATUSx registers, it
>>>>> would be good if we could get more information on that. They are in the PMU
>>>>> block and are related to LPI (Low Power Interface handshaking), but what
>>>>> subsystems/peripheral blocks exactly are associated with them it's not clear
>>>>> from the documentation.
>>>>
>>>> Yes, I've been looking at the docs again and found out a couple of things:
>>>>
>>>> * Each GC_STATUSx register bit is associated with an IP hw block
>>>> * Some LPI_MASKx registers maps exactly with the GC_STATUSx (i.e: 0 and 1)
>>>>   and others maps only partially (i.e: LPI_MASK2 and GC_STATUS2)
>>>
>>> The CG_STATUSx and LPI_MASKx bits meaning is not matching according to
>>> documentation I have. I guess you've got something newer than REV0.00?
>>>
>>
>> My Exynos5420 UM is Revision 1.00 dated February 2014 and GC_STATUS0 bits
>> maps LPI_MASK0 with the exception of bit 16 (NR3D) that is not mentioned
>> in GC_STATUS0, there is a hole between 15 (DIS) and 17 (FIMC_SCALERP).
>>
>> GC_STATUS1 maps exactly with LPI_MASK1 and GC_STATUS2 and LPI_MASK2 have
>> the same bits from 0 to 5 and then differ from there.
>>
>>>> So it is related to LPI as you said and both LPI_MASKx and GC_STATUSx are
>>>> part of the PMU register address space.
>>>>
>>>> In the particular case of aclk266_g2d, the doc says that the clock can only
>>>> be gated when CG_STATUS0[20] and CG_STATUS0[21] are 0. These are associated
>>>> with the SSS and SSS_SLIM respectively which AFAIU are crypto h/w modules.
>>>
>>> In my Exynos5420 UM ACLK_266_G2D is associated with CG_STATUS0 register
>>> bits 22, 21, which in turn correspond to NR3D and DIS IP blocks, i.e.
>>> the camera subsystem. Such a dependency would be rather surprising.
>>>
>>
>> Sorry, it was a typo error and I actually meant CG_STATUS0 21 and 22 but
>> these correspond in the documentation I've to 21 (SSS) and 22 (SSS_SLIM).
>>
>> As I mentioned before, DIS correspond to CG_STATUS0 15 and NR3D doesn't
>> have a corresponding bit in CG_STATUS0. But I don't know if that is an
>> error in the doc I've since is suspicious that is the only difference
>> between LPI_MASK0 and CG_STATUS0.
>>
>>>>> I think it's essential to understand what triggers changes in CG_STATUSx
>>>>> registers, before we start checking their value in the clock driver.
>>>>>
>>>>
>>>> Indeed, we should really understand what the status on these registers
>>>> means. Also is not clear from the docs how much time should be waited,
>>>> how long until giving up, etc.
>>>
>>> Exactly, I checked some kernels from http://opensource.samsung.com
>>> (e.g. SM-N900_JB_Opensource.zip) for CG_STATUSx, but I didn't find anything
>>> related to these registers yet, except the address macro definitions
>>> and debug traces in the power domains driver.
>>>
>>
>> Yes, I also looked in the ChromiumOS v3.8 kernel but didn't find anything.
>>
>>>>> Also it might be that there are indeed some clocks which must stay enabled
>>>>> over suspend/resume cycle, then the approach with enabling/disabling clocks
>>>>> in the clock driver might not be such a hack as it looks at first sight.
>>>>>
>>>>
>>>> Having a clock driver to both a provider and consumer feels hacky to me as
>>>> well but I didn't find a better way to solve this issue... another option
>>>> is to have this workaround to solve the S2R issue while we figure out what
>>>> the the state in the CG_STATUSx really mean.
>>>
>>> Let's try to diagnose the issue best we can, then we would choose the most
>>> accurate bug fix.
>>>
>>
>> Sounds good to me.
> 
> Based on the earlier comments I was trying to isolate if:
> 1) s2r fails because we gate aclk266_g2d (but it is one of those
> clocks that needs to be always on prior to suspend).
> 2) s2r fails because we gate aclk266_g2d when CG_STATUS0[21:20] bits
> are not 0 (thus not following the spec).
> 

Thanks a lot for continue looking at this. I didn't have time to dig
deeper on this since last week.

> As I did not have access to the hardware guys who could possibly
> confirm 1), I decided to
> a) find a configuration where CG_STATUS0 allows gating of the
> aclk266_g2d clock (i.e. CG_STATUS0[22:21] are 0).
> b) disable the aclk266_g2d clock using such a configuration.
> c) check s2r.
> 
> I found a configuration [1] which gave the following after boot-up:

I think you forgot the reference for [1] right? Since with latest
linux-next (20150402) I got:

> # devmem 0x10040914
> 0xFD800014 (CG_STATUS0[22:21] is 0)

# devmem 0x10040914
0xFFE00000 (CG_STATUS0[22:21] is 1)

> # devmem 0x10020700
> 0xC6F8DE9F (aclk266_g2d is enabled)
>
> At this point s2r works.
> 
> I rebooted the board with the same config as above and then disabled
> aclk266_g2d.
> 
> # devmem 0x10020700 32 0xC6F8DE9D
> # devmem 0x10020700
> 0xC6F8DE9D (aclk266_g2d is disabled)
> # devmem 0x10040914
> 0xFD800014
> 
> and tried s2r - It fails.
>
> From the results, disabling the clock seems to cause the issue rather
> than the CG_STATUS violation. This is all a little confusing, so
> please let me know if I have missed something.
>

So IIUC the CG_STATUS0 bits were a red herring and the real problem
is that the aclk266_g2d needs to be enabled during suspend (although
we still don't know why).

It seems were are at a dead end now. Without being able to ask the HW
Samsung folks we would never know what's going on here...

I can re-post my patches to keep aclk266_g2d enabled during suspend
in the clk driver if that is the least bad option. But it would be
great to solve this issue otherwise S2R will remain to be broken for
Exynos5420 which will be really sad.

> Regards,
> Abhilash
> 

Best regards,
Javier
