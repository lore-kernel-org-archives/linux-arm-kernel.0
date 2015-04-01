From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Thu, 02 Apr 2015 00:31:01 +0200
Subject: [RFC PATCH v3 2/2] clk: exynos5420: Make sure MDMA0 clock is
 enabled during suspend
In-Reply-To: <551C2B6D.4010001@samsung.com>
References: <1427730803-28635-1-git-send-email-javier.martinez@collabora.co.uk>
 <1427730803-28635-3-git-send-email-javier.martinez@collabora.co.uk>
 <CA+Ln22FBpuzR06qCsVc7SXtLX2mhf901vDE5D-mT1+ijZ2G3sg@mail.gmail.com>
 <551976F1.1000605@collabora.co.uk>
 <CAM4voanL3A=dS8Z-ovi_-EDi9ctyaxZkvjajp+3ZjyNAnqR1aQ@mail.gmail.com>
 <551AFCCE.4050404@collabora.co.uk> <551BD07E.2090506@samsung.com>
 <551BDA0A.7010704@collabora.co.uk> <551C2B6D.4010001@samsung.com>
Message-ID: <551C71A5.1070903@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Sylwester,

On 04/01/2015 07:31 PM, Sylwester Nawrocki wrote:
> On 01/04/15 13:44, Javier Martinez Canillas wrote:
>> On 04/01/2015 01:03 PM, Sylwester Nawrocki wrote:
>>> It's not clear what subsystems affect state of the CG_STATUSx registers, it
>>> would be good if we could get more information on that. They are in the PMU
>>> block and are related to LPI (Low Power Interface handshaking), but what
>>> subsystems/peripheral blocks exactly are associated with them it's not clear
>>> from the documentation.
>> 
>> Yes, I've been looking at the docs again and found out a couple of things:
>> 
>> * Each GC_STATUSx register bit is associated with an IP hw block
>> * Some LPI_MASKx registers maps exactly with the GC_STATUSx (i.e: 0 and 1)
>>   and others maps only partially (i.e: LPI_MASK2 and GC_STATUS2)
> 
> The CG_STATUSx and LPI_MASKx bits meaning is not matching according to
> documentation I have. I guess you've got something newer than REV0.00?
>

My Exynos5420 UM is Revision 1.00 dated February 2014 and GC_STATUS0 bits
maps LPI_MASK0 with the exception of bit 16 (NR3D) that is not mentioned
in GC_STATUS0, there is a hole between 15 (DIS) and 17 (FIMC_SCALERP).

GC_STATUS1 maps exactly with LPI_MASK1 and GC_STATUS2 and LPI_MASK2 have
the same bits from 0 to 5 and then differ from there.
 
>> So it is related to LPI as you said and both LPI_MASKx and GC_STATUSx are
>> part of the PMU register address space.
>> 
>> In the particular case of aclk266_g2d, the doc says that the clock can only
>> be gated when CG_STATUS0[20] and CG_STATUS0[21] are 0. These are associated
>> with the SSS and SSS_SLIM respectively which AFAIU are crypto h/w modules.
> 
> In my Exynos5420 UM ACLK_266_G2D is associated with CG_STATUS0 register
> bits 22, 21, which in turn correspond to NR3D and DIS IP blocks, i.e.
> the camera subsystem. Such a dependency would be rather surprising.
> 

Sorry, it was a typo error and I actually meant CG_STATUS0 21 and 22 but
these correspond in the documentation I've to 21 (SSS) and 22 (SSS_SLIM).

As I mentioned before, DIS correspond to CG_STATUS0 15 and NR3D doesn't
have a corresponding bit in CG_STATUS0. But I don't know if that is an
error in the doc I've since is suspicious that is the only difference
between LPI_MASK0 and CG_STATUS0.

>>> I think it's essential to understand what triggers changes in CG_STATUSx
>>> registers, before we start checking their value in the clock driver.
>>>
>> 
>> Indeed, we should really understand what the status on these registers
>> means. Also is not clear from the docs how much time should be waited,
>> how long until giving up, etc.
> 
> Exactly, I checked some kernels from http://opensource.samsung.com
> (e.g. SM-N900_JB_Opensource.zip) for CG_STATUSx, but I didn't find anything
> related to these registers yet, except the address macro definitions
> and debug traces in the power domains driver.
>

Yes, I also looked in the ChromiumOS v3.8 kernel but didn't find anything.
 
>>> Also it might be that there are indeed some clocks which must stay enabled
>>> over suspend/resume cycle, then the approach with enabling/disabling clocks
>>> in the clock driver might not be such a hack as it looks at first sight.
>>>
>> 
>> Having a clock driver to both a provider and consumer feels hacky to me as
>> well but I didn't find a better way to solve this issue... another option
>> is to have this workaround to solve the S2R issue while we figure out what
>> the the state in the CG_STATUSx really mean.
> 
> Let's try to diagnose the issue best we can, then we would choose the most
> accurate bug fix.
> 

Sounds good to me.

Best regards,
Javier
