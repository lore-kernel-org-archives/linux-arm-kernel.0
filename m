From: myungjoo.ham@gmail.com (MyungJoo Ham)
Date: Fri, 18 Nov 2011 13:07:22 +0900
Subject: [PATCH 1/4] ARM: exynos4: Add support for AFTR mode cpuidle state
In-Reply-To: <CAK44p20KprcRRhGg_-9zftsiFDNZEP11u4qYujOHcZwPcMH=HQ@mail.gmail.com>
References: <1320426228-21746-1-git-send-email-amit.kachhap@linaro.org>
 <1320426228-21746-2-git-send-email-amit.kachhap@linaro.org>
 <CAJ0PZbTzFDvom3PoPXEvhC8JE_mV3wfYMspnQdRLO=-oz5wGkw@mail.gmail.com>
 <CAK44p20KprcRRhGg_-9zftsiFDNZEP11u4qYujOHcZwPcMH=HQ@mail.gmail.com>
Message-ID: <CAJ0PZbS+qyGsgPbUeupvZrYcjWQ6psVq1euOuB4j1TJoGsPqOw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 17, 2011 at 8:22 PM, Amit Kachhap <amit.kachhap@linaro.org> wrote:
> On 11 November 2011 13:03, MyungJoo Ham <myungjoo.ham@gmail.com> wrote:
>> On Sat, Nov 5, 2011 at 2:03 AM, ?<amit.kachhap@linaro.org> wrote:
>>> From: Amit Daniel Kachhap <amit.kachhap@linaro.org>
>>>
>>> This patch adds support for AFTR(ARM OFF TOP RUNNING) mode in
>>> cpuidle driver for EXYNOS4210. L2 cache keeps their data in this mode.
>>> This patch ports the code to the latest interfaces to
>>> save/restore CPU state inclusive of CPU PM notifiers, l2
>>> resume and cpu_suspend/resume.
>>>
>>> Signed-off-by: Jaecheol Lee <jc.lee@samsung.com>
>>> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>>> Signed-off-by: Amit Daniel Kachhap <amit.kachhap@linaro.org>
>>> ---
>> []
>>> +#define REG_DIRECTGO_ADDR ? ? ?(samsung_rev() == EXYNOS4210_REV_1_1 ? \
>>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? S5P_INFORM7 : (S5P_VA_SYSRAM + 0x24))
>>> +#define REG_DIRECTGO_FLAG ? ? ?(samsung_rev() == EXYNOS4210_REV_1_1 ? \
>>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? S5P_INFORM6 : (S5P_VA_SYSRAM + 0x20))
>>>
>> []
>>> +
>>> + ? ? ? __raw_writel(BSYM(virt_to_phys(s3c_cpu_resume)),
>>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?REG_DIRECTGO_ADDR);
>>> + ? ? ? __raw_writel(0xfcba0d10, REG_DIRECTGO_FLAG);
>>> +
>>> ? ? ? ?return 0;
>>
>> Hello,
>>
>>
>> Why are you using INFORM6 and 7 registers in order to save resume
>> address and power-mode flags?
>>
>> INFORM0 and 1 have been used in pm.c for the exactly same purpose.
>> Please use the same registers in cpuidle.c as well.
>>
>> The same part in bootloader (IPL) can handle whether it's
>> suspend-to-RAM or AFTR and the both modes are mutually exclusive and
>> you only need one value for resume PC.
>>
>> Therefore, you can keep the value at the same location, which is the
>> method we have been using.
> Hi,
>
> I tried using INFORM0 and INFORM1 in cpuidle and make it same as pm.c.
> But this doesnt work. Looks like my irom fused code checks for the
> wakeup source and needs INFORM7 and INFORM6 for non sleep wakeups. My
> cpu version is S5PV310AH--0AH1113(Origen board).
> I suggest adding support for both type of wakeups(directly from irom
> and through bootloader).
>
Hello Amit,

Have you checked the part that checks flags for AFTR mode and
Suspend-to-RAM in IPL?

If your code is checking AFTR flags with INFORM6/7 and PM flags with
INFORM0/1, that is terribly wrong as those two modes are mutually
exclusive and are very similar in terms of IPL codes.

Also, the IPL-bootloader code runs in IRAM where CPU determines
whether to continue to boot or jump to resume address of
suspend-to-RAM or deepidle (AFTR/LPA/...).

If yours works with INFORM0/1 for PM, it should work with INFORM0/1 in
AFTR as well if your (S/W loadable) IPL code is correct and INFORM6/7
is not touched regardless of how your IROM code is written. Please
check your IPL code and try to let AFTR use the same address with PM.
There is no reason to use another INFORM registers for AFTR only.
Please note that pm-related IPL code is not in ROM, but loaded by ROM
part of IPL to RAM from a storage.



To jc.lee,

Could you please check whether your IPL code checks for INFORM0/1 for
both PM and AFTR or INFORM0/1 for PM and INFORM6/7 for AFTR?
If the latter is what your IPL does, then, how does it react when both
INFORM0/1 and INFORM6/7 are set for both PM and AFTR?
The IPL code we have uses INFORM0/1 for both PM and AFTR/LPA.


Cheers!
MyungJoo

> Thanks,
> Amit D
>>
>> Besides, the Exynos4210 chipmaker (S.LSI) has told that INFORM6 and 7
>> registers are used by in-chip code (iROM or iRAM).
>>
>>
>> Cheers!
>> MyungJoo
>>
>>
>>
>> --
>> MyungJoo Ham, Ph.D.
>> Mobile Software Platform Lab, DMC Business, Samsung Electronics
>>
>



-- 
MyungJoo Ham, Ph.D.
Mobile Software Platform Lab, DMC Business, Samsung Electronics
