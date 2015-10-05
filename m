From: slash.tmp@free.fr (Mason)
Date: Mon, 5 Oct 2015 09:38:46 +0200
Subject: Dropping "depends on SMP" for HAVE_ARM_TWD -- take 2
In-Reply-To: <20151005054652.GI26391@xsjsorenbubuntu>
References: <560E53E3.7070207@free.fr> <560E8584.8000207@free.fr>
 <20151002180255.GK12338@codeaurora.org> <560ED1FB.9010000@free.fr>
 <yw1xbncgluad.fsf@unicorn.mansr.com> <20151003103219.1e10bdeb@arm.com>
 <560FA4B5.1040709@free.fr> <20151003111231.544ae8e2@arm.com>
 <20151005054652.GI26391@xsjsorenbubuntu>
Message-ID: <56122906.9010102@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/10/2015 07:46, S?ren Brinkmann wrote:
> On Sat, 2015-10-03 at 11:12AM +0100, Marc Zyngier wrote:
>> On Sat, 3 Oct 2015 11:49:41 +0200
>> Mason <slash.tmp@free.fr> wrote:
>>
>>> On 03/10/2015 11:32, Marc Zyngier wrote:
>>>> On Sat, 3 Oct 2015 00:34:02 +0100
>>>> M?ns Rullg?rd wrote:
>>>>> Mason writes:
>>>>>
>>>>>> My port requires the TWD to function. So I'm using
>>>>>> select HAVE_ARM_TWD (no "if SMP") to have it work
>>>>>> even on MULTIPLATFORM UP configs.
>>>>>
>>>>> You could just let it use another timer in the non-smp case if you
>>>>> didn't have that weird aversion towards using my code.
>>>>
>>>> I have no idea what your code does, but using the timer that is
>>>> integrated into the core (just like on any other A9 implementation)
>>>> feels like the right thing to do, unless the HW is too broken to use
>>>> TWD.
>>>>
>>>> Another timer is a nice thing to have (it probably comes in handy for
>>>> suspend/resume, and it may have a much better resolution), but this
>>>> seems like icing on the cake at this point. Let's see the cake first.
>>>
>>> I have a quick question for you :-)
>>>
>>> As I stated several months ago, my goal is to produce the simplest
>>> port possible, which is why I chose the TWD instead of platform
>>> timers. At one point, I was also considering the global timer.
>>> (I have a Cortex A9 MPCore.) But as far as I could tell, the
>>> code for the global timer does not handle CPU frequency changes
>>> (while smp_twd.c does), is that correct?
>>
>> Indeed, I cannot see any code that does that in the GT driver. But if
>> you have an A9 MP, you probably want to stick to TWD, which gives you a
>> per-cpu timer instead of a global timer that will require IPIs to other
>> CPUs.
> 
> I think the TWD only provides a clock_event device. Clocksource and
> schedclock would have to be provided by something else.

That is correct AFAIU. But my platform provides a simple 32-bit 27 MHz
tick counter, which makes it trivial to implement clock source, sched
clock and delay timer.

http://article.gmane.org/gmane.linux.kernel/2049558

I have identified two problems with using the TWD in Linux:

1) the TWD is only available on SMP kernels
=> that issue seems close to being resolved

2) I was told that some platforms "turn off" the TWD block in
low-power modes (like during WFI), and therefore must be marked
as unreliable in "C3" (FEAT_C3STOP).

I have a patch to selectively not mark the TWD as unreliable.
(I will make a formal submission today.)

>>> AFAIU, TWD timers and global timer "tick" at the frequency of
>>> PERIPHCLK (which is CPUCLK/2 in my implementation). Therefore,
>>> code needs to be specifically written to handle cpufreq events.
>>> Is that a correct understanding?
>>
>> I don't have the A9 TRM handy (nor the desire to read it on a
>> sunny Saturday morning), so I can't really tell. But yes, this is
>> likely to require some clock change handling.
> 
> I looked at that once. IIRC, the problems are schedclock and clocksource.
> Other than a clockevent device which can be adjusted for frequency
> changes, there is (at least was) no such mechanism for clocksources and
> schedclock. Those are required to run at a stable frequency at all times
> (https://www.kernel.org/doc/Documentation/timers/timekeeping.txt).
> 
> On Zynq I had the same problem and created a construct of notifiers for
> our clocksource to deal with this problem
> (https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/drivers/clocksource/cadence_ttc_timer.c)
> I never really liked that "solution" much, though.
> 
> That approach would probably not work with the GT because, last time I
> checked, it runs at the maximum frequency possible, i.e. dividers at the
> minimum (as a timer should), which means, if cpufreq throttles your CPU
> speed down, you'd have to decrease the clock dividers which isn't
> possible anymore (I could do that on the TTC because we have to run it
> a at very low speeds with high dividers to avoid constantly overflowing
> the 16-bit counter).

Thanks for sharing your analysis.

Regards.
