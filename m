From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Fri, 16 Jan 2015 09:03:05 +0900
Subject: [RESEND PATCH v3] clocksource: exynos_mct: Add the support for
 Exynos 64bit SoC
In-Reply-To: <20150115133404.GF16217@leverpostej>
References: <1421213603-5020-1-git-send-email-cw00.choi@samsung.com>
 <54B69072.4080607@kernel.org> <54B692FB.7030703@linaro.org>
 <54B7024C.4020407@samsung.com> <20150115112938.GB16217@leverpostej>
 <CAGTfZH0Ve+icxc6FpMJhfNMRMqQASrcUmnrZw-6sYQz8rabC_A@mail.gmail.com>
 <CAGTfZH0SQRyTMTmge6x2fXFBdVwtgJ_wcxK36mFrf6ZNPBn85w@mail.gmail.com>
 <20150115133404.GF16217@leverpostej>
Message-ID: <54B85539.7090908@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/15/2015 10:34 PM, Mark Rutland wrote:
> On Thu, Jan 15, 2015 at 12:52:38PM +0000, Chanwoo Choi wrote:
>> On Thu, Jan 15, 2015 at 9:46 PM, Chanwoo Choi <cwchoi00@gmail.com> wrote:
>>> Hi Mark,
>>>
>>> On Thu, Jan 15, 2015 at 8:29 PM, Mark Rutland <mark.rutland@arm.com> wrote:
>>>> On Wed, Jan 14, 2015 at 11:57:00PM +0000, Chanwoo Choi wrote:
>>>>> Hi Kukjin,
>>>>>
>>>>> On 01/15/2015 01:02 AM, Daniel Lezcano wrote:
>>>>>> On 01/14/2015 04:51 PM, Kukjin Kim wrote:
>>>>>>> On 01/14/15 14:33, Chanwoo Choi wrote:
>>>>>>>
>>>>>>> Hi,
>>>>>>>
>>>>>>> + Doug, Olof
>>>>>>>
>>>>>>>> This patch adds the support for Exynos 64bit SoC. The delay_timer is only used
>>>>>>>> for Exynos 32bit SoC.
>>>>>>>>
>>>>>>> Yes, the Exynos MCT(Multi-Core Timer) is 64bit timer and it is available
>>>>>>> on 64bit exynos SoC such as exynos7. But basically ARMv8 architecture is
>>>>>>> including ARM ARCH timer (ARM Generic Timer) and exynos7 also has
>>>>>>> implemented it and additionally its access is faster than using memory
>>>>>>> mapped register called SFR for MCT...so Doug submitted patch to use MCT
>>>>>>> on 32bit exynos SoCs before.
>>>>>
>>>>> I know arch_timer. As you comment, ARCH timer would be used for system timer for ARMv8.
>>>>> But, Exynos5433/Exynos7 (ARMv8) include MCT (Multi-Core Timer) IP. I checked it on
>>>>> Exynos5433/EXynos7 User-manaual and tested it.
>>>>>
>>>>> I think that exynos_mct.c should support the Exynos 64-bit SoC
>>>>> because Exynos5433/Exynos7 include already MCT (Multi-Core Timer) IP.
>>>>>
>>>>> Also, I have a problem to verify ARCH timer on Exynos SoC. Exynos User-manual never includes
>>>>> the detailed information about for ARCH timer(e.g, clock for ARCH timer). I knew that
>>>>> I can get the document of ARCH timer for ARM official site but I think it is insufficient
>>>>> to implement ARCH timer on Exynos SoC.
>>>>
>>>> What do you mean by "insufficient to implement ARCH timer"?
>>>
>>> As I knew, timer must need the source clock. The clock for ARCH timer
>>> has dependency on Exynos SoC, But I cannot find
>>
>> I'm so sorry about this mistake. I pressed the send button before
>> completing reply.
>>
>> As I knew, timer must need the source clock. The clock for ARCH timer
>> has dependency on Exynos SoC, But I cannot find the clock information
>> for ARCH timer on Exynos SoC user-manual.
>>
>> When I tried to use ARCH timer on Exynos3250, It is not working. We
>> can check this ARCH timer issue of Exynos3250
>> on following patch[1]:
>> [1] http://www.spinics.net/lists/arm-kernel/msg322943.html
> 
> Hmm. That is annoying. Your boot code should have been initialising this
> already.

Right, 
I want to resolve the issue for Exynos3250 but I don't have any information.
Maybe this issue should be fixed by the architector of Exynos SoC or any samsung
developer who can contact the information of ARCH timer.

> 
>>>> The architected timer is mandatory in ARMv8, and required by the arm64
>>>> kernel.
>>>>
>>>> Additional timers may be requried if you want to put all CPUs into low
>>>> power states where the timer logic may be disabled and/or lose state,
>>>> but regardless the architected timers are necessary.
>>
>> I agree that ARCH timer is mandatory.
>>
>> I just think that existing exynos-mct.c driver should support the Exynos5/7 SoC
>> because released Exynos5/7 SoC includes already MCT IP for system timer.
> 
> I'm not opposed to the MCT. My only concern is that a configured and
> enabled architected timer is mandated by the boot protocol, and is a
> prerequisite for a functioning kernel. 

Thanks for your opinion.
As I replyed on previous mail, I agree that ARCH timer is necessary.

Your initial response made it
> sound like you expected the MCT alone to be sufficient.

I didn't mean it.

Best Regards,
Chanwoo Choi
