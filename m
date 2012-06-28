From: arve@android.com (=?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?=)
Date: Thu, 28 Jun 2012 13:38:50 -0700
Subject: How to use ARM ETM/ETB at linux?
In-Reply-To: <CACRpkdZv+Kp0apmLcZQgY07z1YQ3gC8r+d9Ed-c0OZLTo7DN6A@mail.gmail.com>
References: <CAHrpEqRk4SQ+8LHCOX0zwtZjnTe=k0c_GCJMqvYMZBUa-dJq=A@mail.gmail.com>
 <CACRpkdZv+Kp0apmLcZQgY07z1YQ3gC8r+d9Ed-c0OZLTo7DN6A@mail.gmail.com>
Message-ID: <CAMP5Xgf=bxYJNpOp7od2jrG-SEKiVo=hGjMCMn6KVjKyw2+uJw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 28, 2012 at 8:42 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Thu, Jun 21, 2012 at 7:38 AM, Frank Li <lznuaa@gmail.com> wrote:
>
>> Anyone use ARM ETM/ETB before?
>
> I know for sure that Arve has been making good use of the ETB+ETB,
> since there are some nice patches for it in the Android source tree,
> but I don't know how he's using it :-)
>

I have not used it a lot, but I made changes to make it work on
systems with Cortex A8, A9 and A15 cpus. I found it most useful to
debug watchdog resets, but I had to manually figure out where in the
buffer the data starts since the pointers were lost on a reset.

> John Stultz recently submitted some of Arves patches upstream so let's
> ask these gentlemen how they use it.
>
> Yours,
> Linus Walleij
>
>>
>> I run.
>> echo 1 > /sys/devices/etm/trace_running
>>
>> root at freescale /$ echo v >/proc/sysrq-trigger
>> SysRq : etm
>> Trace buffer contents length: 4
>> --- ETB buffer begin ---
>> 01000000000000000000000000000000
>>
>> --- ETB buffer end ---

Make sure you don't have trace-funnels between the trace cell and the
trace buffer that need to be configured. All the SOCs I used have at
least one trace funnel in the way that by default did not not pass any
data through. The driver has no code to configure these (the channels
used are SOC specific and usually not well documented).

Also, at least one SOC I used would not output any trace data with the
default configuration since it considered the kernel to be executing
in secure mode. One of the patches from the android tree fixes this.


>>
>>
>> best regards
>> Frank Li
>
> Yours,
> Linus Walleij



-- 
Arve Hj?nnev?g
