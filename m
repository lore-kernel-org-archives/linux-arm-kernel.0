From: timur@codeaurora.org (Timur Tabi)
Date: Fri, 3 Jul 2015 10:42:42 -0400
Subject: [PATCH 1/4] hvc_dcc: bind driver to core0 for reads and writes
In-Reply-To: <559479FA.5080300@codeaurora.org>
References: <1435699387-32591-1-git-send-email-timur@codeaurora.org>
 <5593443C.5070800@codeaurora.org> <55934919.8070703@codeaurora.org>
 <559479FA.5080300@codeaurora.org>
Message-ID: <58BCCF6C-6B42-4D4C-9D5B-EF5FFEC5DA3D@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Jul 1, 2015, at 7:38 PM, Stephen Boyd wrote:

> It would at least fix the AMP case where you have one tty per CPU. If a
> CPU goes offline, the tty would be removed at the same time. The user
> could put the console on another CPU, or all of them, if they want to
> offline CPUs.

How would the user put the TTY on another CPU?  The command-line parameter is a boot-time configuration.  I'm okay with adding that parameter, but we still have the problem of losing the TTY altogether if that CPU goes offline.  I would like to see the TTY migrated to another CPU, but if I don't know if that makes sense either.  Is it possible for CPUs to go randomly offline temporarily to manage load?

To be clear, I'm okay with adding a hotplug hook that shuts down the thread if the TTY CPU goes offline, so that we don't attempt to schedule a thread on a CPU that's offline.  I am concerned about whether hotplug can automatically offline the TTY CPU without warning, and suddenly we don't have TTY any more.

Is there a way to prevent the TTY CPU from going offline via hotplug?  A way of saying, "if you want to offline a CPU,  don't offline this one?"

> It sounds like in the SMP case the tool is broken and it should do
> better about consolidating output from different CPUs into one place. If
> it really only listens to the boot CPU then making a tty per-CPU would
> work just the same as this patch even when the CPU goes offline.

Yes, the tool is broken, but that's not the only problem.  Each CPU has its own DCC, and since the console driver can run on any thread, it will scatter console output across all the CPUs.  So any tool that listens on DCC is going to have this problem on an SMP system.  I'm pretty sure Trace32 isn't the only one.

>> When CPU0 goes offline, what does schedule_work_on(0, actually do?  If
>> it does nothing, then the output FIFO will fill up, and put_chars will
>> return 0, and that's it.
> 
> schedule_work_on() shouldn't be used when a CPU can go offline (see the
> comment above queue_work_on). I think it has to break affinity to run
> the work item on some other CPU.

So if I run schedule_work_on() on a CPU, and that CPU is offline, it will just schedule the workqueue on some other random CPU?

>> Does CPU hotplug automatically take CPUs offline when the load is low?
>> If so, then then thread could randomly bounce from CPU to CPU.
> 
> Sorry, I should have been clearer. The thread would be bound to the CPU
> the tty corresponds to. No thread migration or bouncing. We would have
> to tear down and restore the tty on hotplug as well. I guess one problem
> here is that it doesn't do anything about the console. The console
> doesn't go through the khvcd thread like the tty does so we would still
> need some sort of dcc specific code to move the console writes to a
> particular CPU. And the downside there is that consoles are supposed to
> support atomic operations so that debugging information can always get
> out to the user. When we need to migrate the write to a particular CPU
> we might lose information if scheduling is broken or something.

I'm not sure I understand all that.  What do you mean by the thread is bound to the CPU that the TTY correspond to?  When a kernel thread (running on some CPU) calls printk(), doesn't the call to the HVC driver occur also on that CPU? That's the whole reason behind this patch -- that each call to printk() results in a DCC write that occurs on a different CPU.

> So can we fix the tool instead and keep writing out data on random CPUs?

No, we can't.  The impression I got that Lauterbach is not responsive to feature requests like this one.  And again, this problem really occurs with any tool that listens to DCC on an SMP system.
