From: bp@alien8.de (Borislav Petkov)
Date: Wed, 27 Apr 2011 09:38:39 +0200
Subject: console_cpu_notify can cause scheduling BUG during CPU hotplug
In-Reply-To: <4DB733D4.3000002@codeaurora.org>
References: <4DB604C7.8090305@codeaurora.org>
	<BANLkTimPHaiiiVC_A6jtUtaa_pYJuhepYg@mail.gmail.com>
	<4DB65EEC.7060604@ti.com> <4DB733D4.3000002@codeaurora.org>
Message-ID: <20110427073839.GA16718@liondog.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 26, 2011 at 02:06:28PM -0700, Michael Bohan wrote:
> On 4/25/2011 10:58 PM, Santosh Shilimkar wrote:
> >On 4/26/2011 5:48 AM, Kevin Cernekee wrote:
> >>On Mon, Apr 25, 2011 at 4:33 PM, Michael Bohan<mbohan@codeaurora.org>
> >>wrote:
> >>>I was curious if this scenario was accounted for in the design of the
> >>>console CPU notifier. One workaround for this problem is to remove
> >>>CPU_DEAD
> >>>from the possible actions in console_cpu_notify(). In fact, v1-v4 of the
> >>>patch above did not have CPU_DEAD, CPU_DYING or CPU_DOWN_FAILED in
> >>>the list
> >>>of actions. I wasn't able to track down why the other cases were
> >>>added in
> >>>the final patch.
> >>
> >>Here is the background information on the CPU_{DEAD,DYING,DOWN_FAILED}
> >>cases:
> >>
> >>http://lkml.org/lkml/2010/6/29/65
> >That's right.
> >May be the change log for commit '034260d67' would have been
> >bit more descriptive about the CPU hot-plug events.
> 
> Thanks for the clarification. Now regarding the problem, it seems
> like we can't be taking a semaphore in that path. That is to say, we
> can't be calling console_lock from within stop_machine. A few
> options that come to mind:
> 
> -Use console_trylock and accept the possibility that the output is
> not guaranteed to be synchronous with the hotplug operation.
> -Defer the console output emission (eg. workqueue) during hotplug.
> -Hybrid of the two: if the console_trylock fails, then we defer the
> console output emission.
> 
> Any opinions? I can submit a patch if one of these approaches is reasonable.

Great, whatever you guys come up with, we'd like to give it a run too.
We (AMD) hit the same issue in one of our tests but in our case we end
up in an endless loop of the state machine at stop_machine_cpu_stop()
since the core being offlined cannot ack the state transition to
STOPMACHINE_EXIT due to a similar reason.

One possible fix is dropping CPU_DYING from console_cpu_notify()
since it is called into by the offlining path in
kernel/cpu.c::take_cpu_down().

Thanks.

-- 
Regards/Gruss,
    Boris.
