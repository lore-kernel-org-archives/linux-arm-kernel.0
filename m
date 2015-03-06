From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Fri, 06 Mar 2015 21:18:34 +0900
Subject: [PATCH v5 1/9] arm64: dts: exynos: Add dts files for 64-bit
 Exynos5433 SoC
In-Reply-To: <20150306114021.GF8700@leverpostej>
References: <1425533911-14800-1-git-send-email-cw00.choi@samsung.com>
 <1425533911-14800-2-git-send-email-cw00.choi@samsung.com>
 <20150305122459.GC14093@leverpostej>
 <CAGTfZH3Bf1ueFO25NXFbN+Mvb9TcGbErbSp=a+vQ0=A+E07mQA@mail.gmail.com>
 <20150305170450.GG14093@leverpostej>
 <CAGTfZH3nkCvnuu+fC1Gv5DrRQXEg6Y19tQnh+phj6c_jAFpbvg@mail.gmail.com>
 <20150305185407.GK14093@leverpostej> <54F9140B.3060109@samsung.com>
 <20150306114021.GF8700@leverpostej>
Message-ID: <54F99B1A.3080600@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 03/06/2015 08:40 PM, Mark Rutland wrote:
>>>>>> CPU0 (boot CPU) is only well working for CPU_OFF.
>>>>>> But when I try to turn on the CPU0 after CPU_OFF, I failed it.
>>>>>
>>>>> That's rather worrying. Can you look into what's going on here? I'd
>>>>> rather not have dts describing things which are known to be broken.
>>>>
>>>> The board dts don't include any node for CPU_ON/OFF.
>>>
>>> I don't understand. The CPU_ON and CPU_OFF IDs are in the psci node
>>> quoted above, and all the CPUs had enable-method = "psci".
>>
>> I mean that there are not additional dt node except for 'cpu' and 'psci' node.
> 
> The psci node and cpu enable-method are sufficient. No other nodes
> should be relevant.

You're right.

> 
>>>
>>>> When I try to turn on the CPU0 (boot CPU), fail to turn on and lockup happen.
>>>> After lockup happen, I cannot use the console.
>>>
>>> That sounds like a pretty major bug.
>>>
>>> Are you able to investigate with a hardware debugger?
>>
>> I can't do because there are not any jtag connector.
> 
> That is very unfortunate. Which PSCI implementation are you using?
> Surely whoever developed it has access to debug. Surely they should have
> tested this?

I just used the lateset Linux 4.0-rc2 for PSCI (arch/arm64/kernel/psci.c)
without any modification. Unfortunately, I don't know who is the h/w developer of Exynos5433 SoC.

> 
>>> Do other CPUs eventually log errors regarding the lockup? Or is the
>>> machine completely dead from this point on?
>>
>> I tested CPU0 on/off. When I turn on the CPU0, I fail it. But, kernel just show the error log without lockup.
>> I gave you wrong infromation about CPU0 off.
> 
> Ok. However that's still a major bug.
> 
> [...]
> 
>>>>>>> I take it CPUs boot at EL2?
>>>>>
>>>>> Do the CPUs boot at EL1 or EL2?
>>>>
>>>> Unfortunately, I cannot check the secure firmware for Exynos5433 SoC.
>>>> I think that a few SoC provider probably would know it.
>>>
>>> I guess I asked the wrong question.
>>>
>>> Do CPUs enter the kernel at EL2 or at EL1?
>>
>> Could you give me a tip how to check the kernel at EL2 or EL1?
> 
> Hmm... I thought we logged this but it looks like we don't.
> 
> You could hack in a check of is_hyp_mode_available() and
> is_hyp_mode_mismatched(). That will tell you if EL2/hyp is available,
> and whether all CPUs enter at the same mode (mandatory per the boot
> protocol).

OK, I'll try it.

Thanks,
Chanwoo Choi
