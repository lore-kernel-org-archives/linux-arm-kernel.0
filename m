From: bp@alien8.de (Borislav Petkov)
Date: Sat, 30 Apr 2011 10:38:53 +0200
Subject: console_cpu_notify can cause scheduling BUG during CPU hotplug
In-Reply-To: <4DB894C3.2040300@codeaurora.org>
References: <4DB604C7.8090305@codeaurora.org>
	<BANLkTimPHaiiiVC_A6jtUtaa_pYJuhepYg@mail.gmail.com>
	<4DB65EEC.7060604@ti.com> <4DB733D4.3000002@codeaurora.org>
	<20110427073839.GA16718@liondog.tnic>
	<4DB894C3.2040300@codeaurora.org>
Message-ID: <20110430083853.GB3705@liondog.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 27, 2011 at 03:12:19PM -0700, Michael Bohan wrote:
> On 4/27/2011 12:38 AM, Borislav Petkov wrote:
> >Great, whatever you guys come up with, we'd like to give it a run too.
> >We (AMD) hit the same issue in one of our tests but in our case we end
> >up in an endless loop of the state machine at stop_machine_cpu_stop()
> >since the core being offlined cannot ack the state transition to
> >STOPMACHINE_EXIT due to a similar reason.
> >
> >One possible fix is dropping CPU_DYING from console_cpu_notify()
> >since it is called into by the offlining path in
> >kernel/cpu.c::take_cpu_down().
> 
> This seems to be a different problem. Could you elaborate about why
> removing CPU_DYING from console_cpu_notify resolves your problem?

Ok, I have to admit, I haven't spent a whole lot of time debugging this
but here's what I know:

First of all, how we trigger this? Our crazy testers have a script that
takes cores off- and online in a random manner repeatedly and, if you go
to another tty and do 'dmesg' in the same time, you can be absolutely
sure that after a few times, you end up in the endless loop scenario
above.

Don't ask me why they do that - they're just crazy! :) But yeah,
even with a the test sequence as far fetched as this one, the kernel
shouldn't "freeze".

Wait... I'm looking at the code now and it looks like Tejun changed the
state machine implementation (3fc1f1e27a5b807791d72e5d992aa33b668a6626)
so we'll have to retest to see whether this still happens.

Can you trigger your crash with latest kernel too?

Thanks.

-- 
Regards/Gruss,
    Boris.
