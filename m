From: mbohan@codeaurora.org (Michael Bohan)
Date: Mon, 09 May 2011 13:39:32 -0700
Subject: console_cpu_notify can cause scheduling BUG during CPU hotplug
In-Reply-To: <20110430083853.GB3705@liondog.tnic>
References: <4DB604C7.8090305@codeaurora.org>
	<BANLkTimPHaiiiVC_A6jtUtaa_pYJuhepYg@mail.gmail.com>
	<4DB65EEC.7060604@ti.com> <4DB733D4.3000002@codeaurora.org>
	<20110427073839.GA16718@liondog.tnic>
	<4DB894C3.2040300@codeaurora.org>
	<20110430083853.GB3705@liondog.tnic>
Message-ID: <4DC85104.4080001@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/30/2011 1:38 AM, Borislav Petkov wrote:
> On Wed, Apr 27, 2011 at 03:12:19PM -0700, Michael Bohan wrote:
>> On 4/27/2011 12:38 AM, Borislav Petkov wrote:
>>> Great, whatever you guys come up with, we'd like to give it a run too.
>>> We (AMD) hit the same issue in one of our tests but in our case we end
>>> up in an endless loop of the state machine at stop_machine_cpu_stop()
>>> since the core being offlined cannot ack the state transition to
>>> STOPMACHINE_EXIT due to a similar reason.
>>>
>>> One possible fix is dropping CPU_DYING from console_cpu_notify()
>>> since it is called into by the offlining path in
>>> kernel/cpu.c::take_cpu_down().
>>
>> This seems to be a different problem. Could you elaborate about why
>> removing CPU_DYING from console_cpu_notify resolves your problem?
>
> Ok, I have to admit, I haven't spent a whole lot of time debugging this
> but here's what I know:
>
> First of all, how we trigger this? Our crazy testers have a script that
> takes cores off- and online in a random manner repeatedly and, if you go
> to another tty and do 'dmesg' in the same time, you can be absolutely
> sure that after a few times, you end up in the endless loop scenario
> above.

Our test scenario is similar to this. In the crash I reported, there 
needs to be contention for the console semaphore to trigger the BUG().

I get the impression that this sort of scenario is not tested 
extensively in Linux. Otherwise I think others would have reported the 
BUG I hit.

> Wait... I'm looking at the code now and it looks like Tejun changed the
> state machine implementation (3fc1f1e27a5b807791d72e5d992aa33b668a6626)
> so we'll have to retest to see whether this still happens.

Tejen's change (3fc1f1e27a5b807791d72e5d992aa33b668a6626) was first in 
v2.6.35, so it looks like you're using a pretty old kernel. Kevin's 
change (034260d6779087431a8b2f67589c68b919299e5c) was not in until 
v2.6.36, so therefore I'm a bit confused what code base you're running.

You mentioned before that one possible fix is dropping CPU_DYING from 
console_cpu_notify, but based on what you said, it doesn't seem like 
your kernel should be new enough have this functionality. Did you 
cherry-pick Kevin's change on top of an older code base? If so, that is 
likely dangerous.

Please keep me in loop with your findings on a more recent kernel.

 > Can you trigger your crash with latest kernel too?

The latest I've tested is v2.6.38, but the code related to blocking on 
the console semaphore with preemption disabled does not appear changed 
on the most recent code base.

Thanks,
Mike

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
