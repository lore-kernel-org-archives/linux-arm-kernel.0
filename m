From: lznuaa@gmail.com (Frank Li)
Date: Fri, 29 Jun 2012 11:31:10 +0800
Subject: How to use ARM ETM/ETB at linux?
In-Reply-To: <CAMP5Xgf=bxYJNpOp7od2jrG-SEKiVo=hGjMCMn6KVjKyw2+uJw@mail.gmail.com>
References: <CAHrpEqRk4SQ+8LHCOX0zwtZjnTe=k0c_GCJMqvYMZBUa-dJq=A@mail.gmail.com>
 <CACRpkdZv+Kp0apmLcZQgY07z1YQ3gC8r+d9Ed-c0OZLTo7DN6A@mail.gmail.com>
 <CAMP5Xgf=bxYJNpOp7od2jrG-SEKiVo=hGjMCMn6KVjKyw2+uJw@mail.gmail.com>
Message-ID: <CAHrpEqQ35ut30VGBjJY+AMRkf0ufssepEwFJk4ALARdLMhc4fA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2012/6/29 Arve Hj?nnev?g <arve@android.com>:
> On Thu, Jun 28, 2012 at 8:42 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
>> On Thu, Jun 21, 2012 at 7:38 AM, Frank Li <lznuaa@gmail.com> wrote:
>>
>>> Anyone use ARM ETM/ETB before?
>>
>> I know for sure that Arve has been making good use of the ETB+ETB,
>> since there are some nice patches for it in the Android source tree,
>> but I don't know how he's using it :-)
>>
>
> I have not used it a lot, but I made changes to make it work on
> systems with Cortex A8, A9 and A15 cpus. I found it most useful to
> debug watchdog resets, but I had to manually figure out where in the
> buffer the data starts since the pointers were lost on a reset.
>
>> John Stultz recently submitted some of Arves patches upstream so let's
>> ask these gentlemen how they use it.
>>
>> Yours,
>> Linus Walleij
>>
>>>
>>> I run.
>>> echo 1 > /sys/devices/etm/trace_running
>>>
>>> root at freescale /$ echo v >/proc/sysrq-trigger
>>> SysRq : etm
>>> Trace buffer contents length: 4
>>> --- ETB buffer begin ---
>>> 01000000000000000000000000000000
>>>
>>> --- ETB buffer end ---
>
> Make sure you don't have trace-funnels between the trace cell and the
> trace buffer that need to be configured. All the SOCs I used have at
> least one trace funnel in the way that by default did not not pass any
> data through. The driver has no code to configure these (the channels
> used are SOC specific and usually not well documented).
>
> Also, at least one SOC I used would not output any trace data with the
> default configuration since it considered the kernel to be executing
> in secure mode. One of the patches from the android tree fixes this.
>

Thank you for your reply. I will check trace-funnel with our IC team
owner and update you.
I have picked up below patch. Anything missed?

* | 2d4660b ARM: etm: Power down etm(s) when tracing is not enabled
* | 6e48ba5 ARM: etm: Support multiple ETMs/PTMs.
* | c1db5d4 ARM: etm: Return the entire trace buffer if it is empty after reset
* | 5b9dda1 ARM: etm: Add some missing locks and error checks
* | 1a6825a ARM: etm: Configure data tracing
* | 22a917b ARM: etm: Allow range selection
* | 684b02b ARM: etm: Don't try to clear the buffer full status after reading th
* | 86827c5 ARM: etm: Don't limit tracing to only non-secure code.
* | 936c25b ARM: etm: Don't require clock control


>
>>>
>>>
>>> best regards
>>> Frank Li
>>
>> Yours,
>> Linus Walleij
>
>
>
> --
> Arve Hj?nnev?g
