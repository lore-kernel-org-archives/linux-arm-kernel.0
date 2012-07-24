From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Tue, 24 Jul 2012 11:13:20 +0200
Subject: [PATCH V2 6/7] ARM: EXYNOS5: Add the bus clock for FIMD
In-Reply-To: <000501cd6951$2aa24f00$7fe6ed00$%han@samsung.com>
References: <1342591053-7092-1-git-send-email-l.krishna@samsung.com>
 <1342591053-7092-7-git-send-email-l.krishna@samsung.com>
 <500D0C8B.3080007@samsung.com> <500D1F59.9030807@samsung.com>
 <000301cd6928$e5021660$af064320$%han@samsung.com>
 <500DE22F.5010006@samsung.com>
 <000601cd692e$b2ba7a70$182f6f50$%han@samsung.com>
 <500E00A3.8080203@samsung.com>
 <000101cd6942$2badc960$83095c20$%han@samsung.com>
 <500E112F.3090202@samsung.com>
 <000501cd6951$2aa24f00$7fe6ed00$%han@samsung.com>
Message-ID: <500E6730.1030805@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 07/24/2012 06:02 AM, Jingoo Han wrote:
>>>>>>>> I wonder fimd clock has any dependency with DP
>>>>>>> FIMD pixel clock is necessary to enable DP.
>>>>>> So then, i think DP driver also should control FIMD pixel clock.
>>>>>> Do you have any patch or plan for it?
>>>>> Um, I don't think so.
>>>>> Because, DP cannot work by itself.
>>>>> In order to use DP, FIMD should be enabled.
>>>>>
>>>>> If FIMD is enabled, FIMD pixel clock is enabled;
>>>>> therefore, DP driver does not need to control FIMD pixel clock.
>>>> Why does DP driver have FIMD driver dependency? Also for this, it needs
>>>> FIMD driver is probed earlier then DP driver.  We cannot decide driver
>>>> probe order if they are same level drivers and itself is weird
>>>> condition.  Although there is hardware dependency, DP and FIMD driver
>>>> don't have any code relations. They are each other drivers. But DP
>>>> needs FIMD pixel clock and because the clock can be control at the
>>>> several drivers and the clock framework exists for that, then i think
>>>> it's better DP driver also control FIMD pixel clock.
>>>>
>>>>> In my opinion, adding config dependency would be better, such as FB_S3C or DRM_EXYNOS_FIMD.
>>>> I think this is not solution. How do you ensure FIMD driver is probed
>>>> earlier than DP driver? Even if it's possible, when FIMD driver only
>>>> controls pixel clock, DP driver will execute any operations regardless
>>>> status of FIMD pixel clock, so if FIMD driver turns off pixel clock,
>>>> then DP will occur any error.
>>> late_initcall can ensure DP driver is probed later.
>>
>> I'm not sure late_initcall solution is good. It must choose at the last
>> if there isn't other way really.
> 
> 
> late_initcall is already used by many drivers.
> If you have any good idea, please, suggest it.

I agree with Mr. Shim here. using initcall doesn't look like a solution
to this issue. Neither compile time dependency is of much help.

The S3C framebuffer driver can be used as a loadable module, how
would initcalls be supposed to work then ?

Some notify mechanisms or deferred probing could be used, to make sure one
of drivers is initialized before the other.

--

Thanks,
Sylwester
