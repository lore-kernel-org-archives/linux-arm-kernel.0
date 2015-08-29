From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Sat, 29 Aug 2015 19:39:38 +0900
Subject: [PATCH] ARM: exynos_defconfig: Enable big.LITTLE CPUidle support
In-Reply-To: <CABxcv=m0K_jR689RiEGGJ40sVASK8E6S02cUY344qMXdtwLo9g@mail.gmail.com>
References: <1440749769-10135-1-git-send-email-javier@osg.samsung.com>
 <55E174F3.1030202@samsung.com> <55E17C56.4080200@osg.samsung.com>
 <CAJKOXPerJFZqeqNrVrdQnP7YB23LiWf+ZWYHBsWGRvqDQ-PJGA@mail.gmail.com>
 <CABxcv=nwXc-_Y7qdZ56EGxM266Yifm56m6+Pb8iTHSWLHHSkfA@mail.gmail.com>
 <CAJKOXPdVDSPgFPkdnLBezimSHs+N0=5KCyXB=CQqMQy3LAcFVw@mail.gmail.com>
 <CABxcv=m0K_jR689RiEGGJ40sVASK8E6S02cUY344qMXdtwLo9g@mail.gmail.com>
Message-ID: <CAJKOXPeHPstPXxzyw1yBFKY-XR44j8vOfEPm4vq-_Fi6k09EGg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-08-29 19:31 GMT+09:00 Javier Martinez Canillas <javier@dowhile0.org>:
> Hello Krzysztof,
>
> On Sat, Aug 29, 2015 at 12:22 PM, Krzysztof Kozlowski
> <k.kozlowski@samsung.com> wrote:
>> 2015-08-29 19:07 GMT+09:00 Javier Martinez Canillas <javier@dowhile0.org>:
>>> Hello Krzysztof,
>>>
>>> On Sat, Aug 29, 2015 at 11:55 AM, Krzysztof Kozlowski
>>> <k.kozlowski@samsung.com> wrote:
>>>> 2015-08-29 18:33 GMT+09:00 Javier Martinez Canillas <javier@osg.samsung.com>:
>>>>> Hello Krzysztof,
>>>>>
>>>>> On 08/29/2015 11:01 AM, Krzysztof Kozlowski wrote:
>>>>>> W dniu 28.08.2015 o 17:16, Javier Martinez Canillas pisze:
>>>>>>> Some Exynos big.LITTLE boards (i.e: Exynos5420 and Exynos5800 based
>>>>>>> Chromebooks) have proper firmware that allow the big.LITTLE CPUidle
>>>>>>> driver to work correctly, so enable support for this.
>>>>>>>
>>>>>>> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
>>>>>>>
>>>>>>> ---
>>>>>>> Kukjin and Krzysztof,
>>>>>>>
>>>>>>> As you know there are other boards like the Exynos5422 based Odroid XU{3,4}
>>>>>>> whose firmware is broken due leaving CCI in secure mode which means that the
>>>>>>> kernel MCPM support can't properly manage CCI.
>>>>>>>
>>>>>>> So if you pick this patch, it should be tested in kernelci before appearing
>>>>>>> in linux-next to prevent any boot issues.
>>>>>>>
>>>>>>> But if that happens, I believe that is better to do a fix / workaround in
>>>>>>> those broken platforms since nothing prevents users to enable this option
>>>>>>> anyways. For example the CCI device node could be disabled in the DTS.
>>>>>>>
>>>>>>>  arch/arm/configs/exynos_defconfig | 1 +
>>>>>>>  1 file changed, 1 insertion(+)
>>>>>>
>>>>>> On Odroid XU3L (next-20150828, Hardkernel u-boot) boot hangs just after:
>>>>>>
>>>>>
>>>>> Thanks for testing, I was expecting that is just that I don't have a
>>>>> Odroid XU{3,4} board for test here, I guess I should get one.
>>>>>
>>>>>> [    2.568650] dwmmc_exynos 12200000.mmc: num-slots property not found,
>>>>>> assuming 1 slot is available
>>>>>>
>>>>>> ... so no. NACK :). First the boards, firmware, bootloader or kernel
>>>>>
>>>>> Agreed with the nack :)
>>>>>
>>>>>> code have to be fixed.
>>>>>>
>>>>>
>>>>> Or disable CCI, could you please test the following patch [0] so I
>>>>> can post it properly?
>>>>
>>>> It fixes the boot hang but causes other issues. Not all CPUs boot (I
>>>
>>> Thanks for testing.
>>>
>>>> tested it on Chanho Park's patch for fixing CPU boot with SWRESET):
>>>> [    0.010781] CPU0: update cpu_capacity 448
>>>> [    0.010839] CPU0: thread -1, cpu 0, socket 1, mpidr 80000100
>>>> [    0.011098] Setting up static identity map for 0x40008280 - 0x400082d8
>>>> [    0.056329] CPU1: update cpu_capacity 448
>>>> [    0.056337] CPU1: thread -1, cpu 1, socket 0, mpidr 80000001
>>>> [    0.071100] CPU2: update cpu_capacity 448
>>>> [    0.071107] CPU2: thread -1, cpu 2, socket 0, mpidr 80000002
>>>> [    0.086103] CPU3: update cpu_capacity 448
>>>> [    0.086111] CPU3: thread -1, cpu 3, socket 0, mpidr 80000003
>>>> [    0.101100] CPU4: update cpu_capacity 1535
>>>> [    0.101108] CPU4: thread -1, cpu 0, socket 0, mpidr 80000000
>>>> [    1.115009] CPU5: failed to boot: -110
>>>> [    2.130019] CPU6: failed to boot: -110
>>>> [    3.145049] CPU7: failed to boot: -110
>>>> [    3.145151] Brought up 5 CPUs
>>>> [    3.145196] SMP: Total of 5 processors activated (240.00 BogoMIPS).
>>>> [    3.145251] CPU: WARNING: CPU(s) started in wrong/inconsistent
>>>> modes (primary CPU mode 0x13)
>>>> [    3.145327] CPU: This may indicate a broken bootloader or firmware.
>>>> [    3.149347] devtmpfs: initialized
>>>>
>>>
>>> Sigh, such an inconsistent behavior between Exynos5420/5422/5800 boards :-/
>>
>> I put all my hope into Przemyslaw's work :)
>>
>
> Me too :)
>
>>>
>>> Any ideas? I agree that the b.L CPUidle support shouldn't be enabled
>>> by default in exynos_defconfig but as I said nothing prevents the user
>>> to enable that option and make the board to hang on boot.
>>
>> I think these are actually two different issues:
>> 1. If user enables b.L cpuidle manually, some of the Exynos542x boards
>> would work (Peach Pi, AFAIU?) and some would not (Odroid XU3, probably
>
> Yes, Exynos5800 Peach Pi and Exynos5420 Peach Pit IIRC.
>
>> also Arndale Octa). If we cannot fix firmware then we could implement
>> a workaround in Exynos code. However it shouldn't be DTS but rather
>> the mach code.
>
> Agreed about adding a workaround in mach code.
>
>> 2. The default config should be a reference config so it should work
>> on all boards and should offer all necessary features on them (or even
>> all features). Enabling the b.L in it makes sense only if it does not
>> introduce regressions to other boards. If we cannot achieve that
>> (Odroid XU3 will be affected negatively) then still we could fix issue
>> #1 so user's manual setting would work.
>>
>
> Yes but if we achieve #1, then I think that b.L CPUidle support should
> be enabled by default in exynos_defconfig even when it does not work
> on some boards (as long as don't affect negatively) so users of boards
> that do work can have that feature out of the box without figuring out
> what additional config options needs to be enabled.
>
> Or that's what you meant and I misunderstood?

If there won't be negative impact then sure, it could be enabled.
However as we saw above, disabling CCI (which is a fix for cpuidle b.L
on XU3) has negative impact. Of course there could be other
workarounds...

Best regards,
Krzysztof
