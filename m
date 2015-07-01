From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 01 Jul 2015 16:38:34 -0700
Subject: [PATCH 1/4] hvc_dcc: bind driver to core0 for reads and writes
In-Reply-To: <55934919.8070703@codeaurora.org>
References: <1435699387-32591-1-git-send-email-timur@codeaurora.org>
 <5593443C.5070800@codeaurora.org> <55934919.8070703@codeaurora.org>
Message-ID: <559479FA.5080300@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/30/2015 06:57 PM, Timur Tabi wrote:
> Stephen Boyd wrote:
>> Maybe we should look into making the console number (i.e. ttyHVC0,
>> ttyHVC1, etc.) correspond to the logical CPU number 0, 1, etc? We would
>> need some hotplug notifier to tear down and restore the console when the
>> CPU comes online and goes offline, but it may work out nicer than taking
>> the approach this patch does.
>
> My understanding is that Trace32 only responds to core 0 in SMP mode.
> So if CPU0 goes offline, there's no point in migrating the thread to
> another CPU, because Trace32 won't listen for it anyway.  Without this
> patch, console output is randomly scattered across CPUs because the
> put_chars call run on any CPU.  Without consolidating all console
> output to one CPU, DCC is effectively useless.
>
> So I can make the changes you suggested, but I don't think that
> actually fixes anything.

It would at least fix the AMP case where you have one tty per CPU. If a
CPU goes offline, the tty would be removed at the same time. The user
could put the console on another CPU, or all of them, if they want to
offline CPUs.

It sounds like in the SMP case the tool is broken and it should do
better about consolidating output from different CPUs into one place. If
it really only listens to the boot CPU then making a tty per-CPU would
work just the same as this patch even when the CPU goes offline.

> When CPU0 goes offline, what does schedule_work_on(0, actually do?  If
> it does nothing, then the output FIFO will fill up, and put_chars will
> return 0, and that's it.

schedule_work_on() shouldn't be used when a CPU can go offline (see the
comment above queue_work_on). I think it has to break affinity to run
the work item on some other CPU.

>
> Does CPU hotplug automatically take CPUs offline when the load is low?
> If so, then then thread could randomly bounce from CPU to CPU.

Sorry, I should have been clearer. The thread would be bound to the CPU
the tty corresponds to. No thread migration or bouncing. We would have
to tear down and restore the tty on hotplug as well. I guess one problem
here is that it doesn't do anything about the console. The console
doesn't go through the khvcd thread like the tty does so we would still
need some sort of dcc specific code to move the console writes to a
particular CPU. And the downside there is that consoles are supposed to
support atomic operations so that debugging information can always get
out to the user. When we need to migrate the write to a particular CPU
we might lose information if scheduling is broken or something.

So can we fix the tool instead and keep writing out data on random CPUs?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
