From: kesavan.abhilash@gmail.com (Abhilash Kesavan)
Date: Tue, 7 Apr 2015 19:41:07 +0530
Subject: [RFC PATCH v3 2/2] clk: exynos5420: Make sure MDMA0 clock is
 enabled during suspend
In-Reply-To: <5523B878.8040304@collabora.co.uk>
References: <1427730803-28635-1-git-send-email-javier.martinez@collabora.co.uk>
 <1427730803-28635-3-git-send-email-javier.martinez@collabora.co.uk>
 <CA+Ln22FBpuzR06qCsVc7SXtLX2mhf901vDE5D-mT1+ijZ2G3sg@mail.gmail.com>
 <551976F1.1000605@collabora.co.uk>
 <CAM4voanL3A=dS8Z-ovi_-EDi9ctyaxZkvjajp+3ZjyNAnqR1aQ@mail.gmail.com>
 <551AFCCE.4050404@collabora.co.uk> <551BD07E.2090506@samsung.com>
 <551BDA0A.7010704@collabora.co.uk> <551C2B6D.4010001@samsung.com>
 <551C71A5.1070903@collabora.co.uk>
 <CAM4voakS8PnatqRTW5gkD0NNKD9gW9Tuv5p-ekxFhKN5NcuBCQ@mail.gmail.com>
 <5523B878.8040304@collabora.co.uk>
Message-ID: <CAM4voanig_BQrEKGA0YYX_80Gvbtmau3zwz7mQUKtvNMCO-LuQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Javier,

On Tue, Apr 7, 2015 at 4:29 PM, Javier Martinez Canillas
<javier.martinez@collabora.co.uk> wrote:
> Hello Abhilash,
>
> On 04/02/2015 02:22 PM, Abhilash Kesavan wrote:
>> Hi,
>>
>> On Thu, Apr 2, 2015 at 4:01 AM, Javier Martinez Canillas
>> <javier.martinez@collabora.co.uk> wrote:
>>> Hello Sylwester,
>>>
>>> On 04/01/2015 07:31 PM, Sylwester Nawrocki wrote:
>>>> On 01/04/15 13:44, Javier Martinez Canillas wrote:
>>>>> On 04/01/2015 01:03 PM, Sylwester Nawrocki wrote:
>>>>>> It's not clear what subsystems affect state of the CG_STATUSx registers, it
>>>>>> would be good if we could get more information on that. They are in the PMU
>>>>>> block and are related to LPI (Low Power Interface handshaking), but what
>>>>>> subsystems/peripheral blocks exactly are associated with them it's not clear
>>>>>> from the documentation.
>>>>>
>>>>> Yes, I've been looking at the docs again and found out a couple of things:
>>>>>
>>>>> * Each GC_STATUSx register bit is associated with an IP hw block
>>>>> * Some LPI_MASKx registers maps exactly with the GC_STATUSx (i.e: 0 and 1)
>>>>>   and others maps only partially (i.e: LPI_MASK2 and GC_STATUS2)
>>>>
>>>> The CG_STATUSx and LPI_MASKx bits meaning is not matching according to
>>>> documentation I have. I guess you've got something newer than REV0.00?
>>>>
>>>
>>> My Exynos5420 UM is Revision 1.00 dated February 2014 and GC_STATUS0 bits
>>> maps LPI_MASK0 with the exception of bit 16 (NR3D) that is not mentioned
>>> in GC_STATUS0, there is a hole between 15 (DIS) and 17 (FIMC_SCALERP).
>>>
>>> GC_STATUS1 maps exactly with LPI_MASK1 and GC_STATUS2 and LPI_MASK2 have
>>> the same bits from 0 to 5 and then differ from there.
>>>
>>>>> So it is related to LPI as you said and both LPI_MASKx and GC_STATUSx are
>>>>> part of the PMU register address space.
>>>>>
>>>>> In the particular case of aclk266_g2d, the doc says that the clock can only
>>>>> be gated when CG_STATUS0[20] and CG_STATUS0[21] are 0. These are associated
>>>>> with the SSS and SSS_SLIM respectively which AFAIU are crypto h/w modules.
>>>>
>>>> In my Exynos5420 UM ACLK_266_G2D is associated with CG_STATUS0 register
>>>> bits 22, 21, which in turn correspond to NR3D and DIS IP blocks, i.e.
>>>> the camera subsystem. Such a dependency would be rather surprising.
>>>>
>>>
>>> Sorry, it was a typo error and I actually meant CG_STATUS0 21 and 22 but
>>> these correspond in the documentation I've to 21 (SSS) and 22 (SSS_SLIM).
>>>
>>> As I mentioned before, DIS correspond to CG_STATUS0 15 and NR3D doesn't
>>> have a corresponding bit in CG_STATUS0. But I don't know if that is an
>>> error in the doc I've since is suspicious that is the only difference
>>> between LPI_MASK0 and CG_STATUS0.
>>>
>>>>>> I think it's essential to understand what triggers changes in CG_STATUSx
>>>>>> registers, before we start checking their value in the clock driver.
>>>>>>
>>>>>
>>>>> Indeed, we should really understand what the status on these registers
>>>>> means. Also is not clear from the docs how much time should be waited,
>>>>> how long until giving up, etc.
>>>>
>>>> Exactly, I checked some kernels from http://opensource.samsung.com
>>>> (e.g. SM-N900_JB_Opensource.zip) for CG_STATUSx, but I didn't find anything
>>>> related to these registers yet, except the address macro definitions
>>>> and debug traces in the power domains driver.
>>>>
>>>
>>> Yes, I also looked in the ChromiumOS v3.8 kernel but didn't find anything.
>>>
>>>>>> Also it might be that there are indeed some clocks which must stay enabled
>>>>>> over suspend/resume cycle, then the approach with enabling/disabling clocks
>>>>>> in the clock driver might not be such a hack as it looks at first sight.
>>>>>>
>>>>>
>>>>> Having a clock driver to both a provider and consumer feels hacky to me as
>>>>> well but I didn't find a better way to solve this issue... another option
>>>>> is to have this workaround to solve the S2R issue while we figure out what
>>>>> the the state in the CG_STATUSx really mean.
>>>>
>>>> Let's try to diagnose the issue best we can, then we would choose the most
>>>> accurate bug fix.
>>>>
>>>
>>> Sounds good to me.
>>
>> Based on the earlier comments I was trying to isolate if:
>> 1) s2r fails because we gate aclk266_g2d (but it is one of those
>> clocks that needs to be always on prior to suspend).
>> 2) s2r fails because we gate aclk266_g2d when CG_STATUS0[21:20] bits
>> are not 0 (thus not following the spec).
>>
>
> Thanks a lot for continue looking at this. I didn't have time to dig
> deeper on this since last week.
>
>> As I did not have access to the hardware guys who could possibly
>> confirm 1), I decided to
>> a) find a configuration where CG_STATUS0 allows gating of the
>> aclk266_g2d clock (i.e. CG_STATUS0[22:21] are 0).
>> b) disable the aclk266_g2d clock using such a configuration.
>> c) check s2r.
>>
>> I found a configuration [1] which gave the following after boot-up:
>
> I think you forgot the reference for [1] right? Since with latest

Yes, looks like I missed that. There are the changes I had:

diff --git a/arch/arm/boot/dts/exynos5420.dtsi
b/arch/arm/boot/dts/exynos5420.dtsi
index c0e98cf..3a9e21a 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -379,6 +379,7 @@
                        #dma-cells = <1>;
                        #dma-channels = <8>;
                        #dma-requests = <1>;
+                       status = "disabled";
                };

                mdma1: mdma at 11C10000 {
diff --git a/drivers/clk/samsung/clk-exynos5420.c
b/drivers/clk/samsung/clk-exynos5420.c
index 07d666c..38cb896 100644
--- a/drivers/clk/samsung/clk-exynos5420.c
+++ b/drivers/clk/samsung/clk-exynos5420.c
@@ -898,6 +898,7 @@ static struct samsung_gate_clock
exynos5x_gate_clks[] __initdata = {
        GATE(CLK_G2D, "g2d", "aclk333_g2d", GATE_IP_G2D, 3, 0, 0),
        GATE(CLK_SMMU_MDMA0, "smmu_mdma0", "aclk266_g2d", GATE_IP_G2D, 5, 0, 0),
        GATE(CLK_SMMU_G2D, "smmu_g2d", "aclk333_g2d", GATE_IP_G2D, 7, 0, 0),
+       GATE(CLK_SLIMSSS, "slimsss", "aclk266_g2d", GATE_IP_G2D, 12, 0, 0),

        GATE(0, "aclk200_fsys", "mout_user_aclk200_fsys",
                        GATE_BUS_FSYS0, 9, CLK_IGNORE_UNUSED, 0),
diff --git a/include/dt-bindings/clock/exynos5420.h
b/include/dt-bindings/clock/exynos5420.h
index 99da0d1..9459911 100644
--- a/include/dt-bindings/clock/exynos5420.h
+++ b/include/dt-bindings/clock/exynos5420.h
@@ -196,6 +196,7 @@
 #define CLK_ACLK432_CAM                518
 #define CLK_ACLK_FL1550_CAM    519
 #define CLK_ACLK550_CAM                520
+#define CLK_SLIMSSS            521

 /* mux clocks */
 #define CLK_MOUT_HDMI          640

These changes gave me CG_STATUS0[22:21] as 0. I noticed that of the 2
CG_STATUS0 bits one did not turn 0 even when the mdma0 clock was kept
on. I decided to add the clock slimsss as it was the other clock
sourced from aclk266_g2d and noticed that the other bits turned 0.

> linux-next (20150402) I got:
>
>> # devmem 0x10040914
>> 0xFD800014 (CG_STATUS0[22:21] is 0)
>
> # devmem 0x10040914
> 0xFFE00000 (CG_STATUS0[22:21] is 1)
>
>> # devmem 0x10020700
>> 0xC6F8DE9F (aclk266_g2d is enabled)
>>
>> At this point s2r works.
>>
>> I rebooted the board with the same config as above and then disabled
>> aclk266_g2d.
>>
>> # devmem 0x10020700 32 0xC6F8DE9D
>> # devmem 0x10020700
>> 0xC6F8DE9D (aclk266_g2d is disabled)
>> # devmem 0x10040914
>> 0xFD800014
>>
>> and tried s2r - It fails.
>>
>> From the results, disabling the clock seems to cause the issue rather
>> than the CG_STATUS violation. This is all a little confusing, so
>> please let me know if I have missed something.
>>
>
> So IIUC the CG_STATUS0 bits were a red herring and the real problem
> is that the aclk266_g2d needs to be enabled during suspend (although
> we still don't know why).
>
> It seems were are at a dead end now. Without being able to ask the HW
> Samsung folks we would never know what's going on here...

Yes, though it increasingly looks like aclk266_g2d needs to stay ON
and we should use your patch that keeps it enabled prior to suspend.

Regards,
Abhilash
>
> I can re-post my patches to keep aclk266_g2d enabled during suspend
> in the clk driver if that is the least bad option. But it would be
> great to solve this issue otherwise S2R will remain to be broken for
> Exynos5420 which will be really sad.
>
>> Regards,
>> Abhilash
>>
>
> Best regards,
> Javier
