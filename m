From: sachin.kamat@linaro.org (Sachin Kamat)
Date: Sat, 24 May 2014 10:27:05 +0530
Subject: [PATCH V5 00/20] ARM: exynos: cpuidle: Move the driver to
 drivers/cpuidle
In-Reply-To: <537FBE42.7050608@gmail.com>
References: <1397212815-16068-1-git-send-email-daniel.lezcano@linaro.org>
 <534BA3CF.6030701@linaro.org> <535943B2.8030308@samsung.com>
 <0b4201cf613f$80c91750$825b45f0$@samsung.com>
 <537E438C.8060600@samsung.com> <537F6A02.2040606@linaro.org>
 <537FBE42.7050608@gmail.com>
Message-ID: <CAK9yfHypHFy-oTfXiePUi9Sqoe=Q0fcsL+vOf7U8Fk7hQOwvmA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24 May 2014 03:01, Tomasz Figa <tomasz.figa@gmail.com> wrote:
> Hi Daniel,
>
> On 23.05.2014 17:32, Daniel Lezcano wrote:
>> On 05/22/2014 08:35 PM, Kukjin Kim wrote:
>>> On 04/26/14 20:05, Kukjin Kim wrote:
>>>> Tomasz Figa wrote:
>>>>>
>>>>> On 14.04.2014 11:01, Daniel Lezcano wrote:
>>>>>>
>>>>>> Hi Kukjin,
>>>>>>
>>>>>> I believe I addressed all the comments. Is it possible to take this
>>>>>> patchset for next ?
>>>>>
>>>> Sure ;-)
>>>>
>>>>> +1.
>>>>>
>>>>> Also when applying you might add
>>>>>
>>>>> Reviewed-by: Tomasz Figa<t.figa@samsung.com>
>>>>>
>>>>> to any patches that don't have it yet.
>>>>>
>>>> Tomasz, thanks for your review.
>>>>
>>>> I will take this series, "moving exynos-cpuidle into drivers/cpuidle"
>>>> into samsung tree if Rafael is OK on that.
>>>>
>>> Daniel,
>>>
>>> Can you please check/test the functionality your series with using my
>>> for-next because there were merge conflicts with mcpm-exynos stuff...?
>>
>> Hi Kukjin,
>>
>> I tested the latest tree. Unfortunately it panics when unplugging cpu1:
>>
>> [    3.124189] Unable to handle kernel paging request at virtual address
>> f8400024
>> [    3.129950] pgd = c0004000
>> [    3.132626] [f8400024] *pgd=6f7f7841, *pte=00000000, *ppte=00000000
>> [    3.138877] Internal error: Oops: 827 [#1] PREEMPT SMP ARM
>> [    3.192782] r3 : f8400024  r2 : f8180800  r1 : ee836e44  r0 : f8400024
>> [    3.199293] Flags: nZCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM
>> Segment kernel
>> [    3.206673] Control: 10c5387d  Table: 6e37c04a  DAC: 00000015
>> [    3.212398] Process swapper/0 (pid: 0, stack limit = 0xc0510240)
>> [    3.218388] Stack: (0xc0511ef4 to 0xc0512000)
>> [    3.222728] 1ee0: 00000030 c02b20f8 ee836e40
>> [    3.230894] 1f00: c001234c 6e880000 c0511f34 40018a80 00000000
>> 00000000 00000000 00000015
>> [    3.239053] 1f20: 4000404a 10c5387d 00000041 00f00000 00000000
>> 00000000 c02b20e4 edc4a540
>> [    3.247212] 1f40: c038dacc eefc5cf8 c050ecf0 c0543210 00000000
>> c0012460 00000001 c0543210
>> [    3.255371] 1f60: eefc5cf8 c02b2148 b9f92927 00000000 c054326c
>> c02b0968 b9f92927 00000000
>> [    3.263530] 1f80: c0510000 c0518480 c038dacc c0510000 c0510000
>> c0518480 c038dacc eefc5cf8
>> [    3.271689] 1fa0: c0543210 c004e990 c0511fb4 c03873b8 00000000
>> c04f90c8 00000000 c04d4b18
>> [    3.279848] 1fc0: ffffffff ffffffff c04d457c 00000000 00000000
>> c04f90c8 00000000 10c5387d
>> [    3.288007] 1fe0: c0518410 c04f90c4 c051bd5c 4000406a 00000000
>> 40008074 00000000 00000000
>> [    3.296184] [<c0019c5c>] (exynos_enter_aftr) from [<c02b20f8>]
>> (idle_finisher+0x14/0x20)
>> [    3.304247] [<c02b20f8>] (idle_finisher) from [<c001234c>]
>> (cpu_suspend_abort+0x0/0x14)
>> [    3.312226] [<c001234c>] (cpu_suspend_abort) from [<00000000>] (
>> (null))
>> [    3.318994] Code: e34f3840 e3500010 11a00002 01a00003 (e5804000)
>> [    3.325069] ---[ end trace fca911f75a18c040 ]---
>>
>>
>> After git bisecting I falls on this commit:
>>
>> commit b3205dea8fbf6db9b1e46a0dad19a0712fdff44f
>> Author: Sachin Kamat <sachin.kamat@linaro.org>
>> Date:   Tue May 13 07:13:44 2014 +0900
>>
>>     ARM: EXYNOS: Map SYSRAM through generic DT bindings
>>
>>     Instead of hardcoding the SYSRAM details for each SoC,
>>     pass this information through device tree (DT) and make
>>     the code SoC agnostic. Generic DT SRAM bindings are
>>     used for achieving this.
>>
>>     Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
>>     Acked-by: Arnd Bergmann <arnd@arndb.de>
>>     Acked-by: Heiko Stuebner <heiko@sntech.de>
>>     Reviewed-by: Tomasz Figa <t.figa@samsung.com>
>>     Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
>>
>>
>> ... which is before my series is applied.
>>
>> So I am not able to tell yet if my series is correctly rebased or not.
>>
>> And before someone asks me, yes I updated the dtb :)
>
> The driver seemed to be working fine for me on Exynos4210-TRATS board
> (with right bootloader, which supports AFTR).
>
> Still, a quick look at the code reveals use of S5P_VA_SYSRAM macro, in
> case of certain SoC revisions, which is not valid any longer, after
> SYSRAM started to be mapped dynamically. As you can see in platsmp.c,
> the new dynamic mapping is stored in sysram_base_addr variable, which is
> static right now.
>
> My proposed fix would be to make it non-static, declare it in one of
> existing private headers (common.h probably) and use it in pm.c instead
> of S5P_VA_SYSRAM.

Yes, that is right. Just like the way it is done for sysram_ns_base_addr
in common.h

-- 
With warm regards,
Sachin
