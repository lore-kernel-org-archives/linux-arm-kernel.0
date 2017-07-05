From: gabriel.fernandez@st.com (Gabriel FERNANDEZ)
Date: Wed, 5 Jul 2017 09:27:14 +0000
Subject: [RESEND PATCH v4] clk: stm32h7: Add stm32h743 clock driver
In-Reply-To: <20170630185403.GN22780@codeaurora.org>
References: <1496818794-14771-1-git-send-email-gabriel.fernandez@st.com>
 <20170621220703.GI4493@codeaurora.org>
 <110cf67f-e1d6-1f99-953c-6b9639bb4910@st.com>
 <20170628155956.GA5316@codeaurora.org>
 <7c0c3861-cf61-a9e2-cd5d-2ae30b8f32fa@st.com>
 <20170630002008.GD22780@codeaurora.org>
 <d325071a-5da5-4ff1-89b9-fc1bbe10e223@st.com>
 <20170630185403.GN22780@codeaurora.org>
Message-ID: <67be49fc-ca1b-338c-913e-a0cd19c55697@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 06/30/2017 08:54 PM, Stephen Boyd wrote:
> On 06/30, Gabriel FERNANDEZ wrote:
>>
>> On 06/30/2017 02:20 AM, Stephen Boyd wrote:
>>> On 06/29, Gabriel FERNANDEZ wrote:
>>>> On 06/28/2017 05:59 PM, Stephen Boyd wrote:
>>>>> On 06/27, Gabriel FERNANDEZ wrote:
>>>>>> On 06/22/2017 12:07 AM, Stephen Boyd wrote:
>>>>>>> readl_poll_timeout?
>>>>>>>
>>>>>> if i use readl_poll_timeout (wich use 'ktime_get()') it can be
>>>>>> operational only after the selection of clocksource ? (device_initcall).
>>>>>> And then if a driver turn on a clock before, it could blocked the linux
>>>>>> console ?
>>>>>>
>>>>> Ok. I wonder if we could add some sort of starting check to
>>>>> readl_poll_timeout() that tests system_state for booting vs.
>>>>> scheduling? That should be sufficient to handle this case?
>>>>>
>>>> Oops i think i understood my problem...
>>>> i used readl_poll_timeout in atomic context.
>>>> I have to move my code in the .prepare ops.
>>>>
>>>> If you are ok with that i will send a v5
>>>>
>>> There's readl_poll_timeout_atomic() for those modes.
>>>
>> yes it's exactly the test i made (use 'readl_poll_timeout()_atomic' in
>> .enable ops) but i'm blocked.
>>
>> if i do the same in .prepare ops with 'readl_poll_timeout()' it's ok.
> I'm still confused. readl_poll_timeout_atomic() uses ktime_get(),
> and so does readl_poll_timeout(), so how does moving to the
> prepare op fix the problem? What's the actual problem?
>
Yes both use ktime_get().

The issue concerns internal/external oscillator clocks (time 
stabilization could be long) and
if a driver wants to enable one these clocks before device_initcall().

By default the clocksource is the jiffies until the end of the boot 
(fs_initcall)
Then after, the best clocksource is selected (arm_system_timer or stm32 
timer, etc...)
There is no problem after because the counter is a hardware register.

But the jiffies counter is incremented by interruption and enable op
does not allow to be interrupted. (we can with prepare op).
