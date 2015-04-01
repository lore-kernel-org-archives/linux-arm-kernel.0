From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Wed, 01 Apr 2015 19:31:25 +0200
Subject: [RFC PATCH v3 2/2] clk: exynos5420: Make sure MDMA0 clock is
 enabled during suspend
In-Reply-To: <551BDA0A.7010704@collabora.co.uk>
References: <1427730803-28635-1-git-send-email-javier.martinez@collabora.co.uk>
 <1427730803-28635-3-git-send-email-javier.martinez@collabora.co.uk>
 <CA+Ln22FBpuzR06qCsVc7SXtLX2mhf901vDE5D-mT1+ijZ2G3sg@mail.gmail.com>
 <551976F1.1000605@collabora.co.uk>
 <CAM4voanL3A=dS8Z-ovi_-EDi9ctyaxZkvjajp+3ZjyNAnqR1aQ@mail.gmail.com>
 <551AFCCE.4050404@collabora.co.uk> <551BD07E.2090506@samsung.com>
 <551BDA0A.7010704@collabora.co.uk>
Message-ID: <551C2B6D.4010001@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Javier,

On 01/04/15 13:44, Javier Martinez Canillas wrote:
> On 04/01/2015 01:03 PM, Sylwester Nawrocki wrote:
>> On 31/03/15 22:00, Javier Martinez Canillas wrote:
>>> On 03/31/2015 04:38 PM, Abhilash Kesavan wrote:
>>>> javier.martinez at collabora.co.uk> wrote:
>>>> I had a look at this some more today. The problem actually occurs when the
>>>> mdma0 clock's parent - aclk266_g2d gets disabled. The run-time pm support
>>>> in the dma driver disables mdma0 and in turn aclk266_g2d which causes the
>>>> issue.
>>>> From the User Manual, it appears that aclk266_g2d should be gated only when
>>>> certain bits in the clock gating status register are 0. I cannot say for
>>>> certain, but our gating the aclk266_g2d clock without the CG_STATUS bits
>>>> being 0 could be a cause of the suspend failure.
>>>>
>>>
>>> Thanks a lot for the explanation. I see the NOTE at the bottom of section
>>> 7.9.1.159 CLK_GATE_BUS_TOP that mentions that. I'll add this information
>>> to the commit message when posting as a proper patch instead of a RFC.
>>>
>>> I confirmed that changing the patch to prevent "aclk266_g2d" to be gated
>>> instead of "mdm0" also makes the system to resume correctly from suspend
>>> so I'll change that on the patch as well.
>>>
>>> I see that many of the Exynos5420 clocks (including "aclk266_g2d") use the
>>> CLK_IGNORE_UNUSED flag but AFAIU it only prevents the common clock framework
>>> to disable the clocks on init but doesn't prevent the clocks to be disabled
>>> if all the clock childs are gated so the parent is gated as well.
>>>
>>>> As the CG_STATUS bits are not being checked anywhere in the kernel I think
>>>> aclk266_g2d (and others in GATE_BUS_TOP) should not be gated. I am OK with
>>>
>>> For now I'll just add "aclk266_g2d" but later if needed all the GATE_BUS_TOP
>>> clocks (and others) that should only be gated when CG_STATUS is 0 can be
>>> added. My patch iterates over a list of clocks to be kept during suspend even
>>> when there is only one for now so adding more later if needed will be trivial.
>>
>> It's not clear what subsystems affect state of the CG_STATUSx registers, it
>> would be good if we could get more information on that. They are in the PMU
>> block and are related to LPI (Low Power Interface handshaking), but what
>> subsystems/peripheral blocks exactly are associated with them it's not clear
>> from the documentation.
> 
> Yes, I've been looking at the docs again and found out a couple of things:
> 
> * Each GC_STATUSx register bit is associated with an IP hw block
> * Some LPI_MASKx registers maps exactly with the GC_STATUSx (i.e: 0 and 1)
>   and others maps only partially (i.e: LPI_MASK2 and GC_STATUS2)

The CG_STATUSx and LPI_MASKx bits meaning is not matching according to
documentation I have. I guess you've got something newer than REV0.00?

> So it is related to LPI as you said and both LPI_MASKx and GC_STATUSx are
> part of the PMU register address space.
> 
> In the particular case of aclk266_g2d, the doc says that the clock can only
> be gated when CG_STATUS0[20] and CG_STATUS0[21] are 0. These are associated
> with the SSS and SSS_SLIM respectively which AFAIU are crypto h/w modules.

In my Exynos5420 UM ACLK_266_G2D is associated with CG_STATUS0 register
bits 22, 21, which in turn correspond to NR3D and DIS IP blocks, i.e.
the camera subsystem. Such a dependency would be rather surprising.

>> I think it's essential to understand what triggers changes in CG_STATUSx
>> registers, before we start checking their value in the clock driver.
>>
> 
> Indeed, we should really understand what the status on these registers
> means. Also is not clear from the docs how much time should be waited,
> how long until giving up, etc.

Exactly, I checked some kernels from http://opensource.samsung.com
(e.g. SM-N900_JB_Opensource.zip) for CG_STATUSx, but I didn't find anything
related to these registers yet, except the address macro definitions
and debug traces in the power domains driver.

>> Also it might be that there are indeed some clocks which must stay enabled
>> over suspend/resume cycle, then the approach with enabling/disabling clocks
>> in the clock driver might not be such a hack as it looks at first sight.
>>
> 
> Having a clock driver to both a provider and consumer feels hacky to me as
> well but I didn't find a better way to solve this issue... another option
> is to have this workaround to solve the S2R issue while we figure out what
> the the state in the CG_STATUSx really mean.

Let's try to diagnose the issue best we can, then we would choose the most
accurate bug fix.

-- 
Regards,
Sylwester
