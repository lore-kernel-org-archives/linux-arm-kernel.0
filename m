From: tixy@linaro.org (Jon Medhurst (Tixy))
Date: Thu, 07 Mar 2013 19:04:49 +0800
Subject: [BUG] ARM Architected timers appear broken in 3.9-rc1
Message-ID: <1362654289.3323.18.camel@linaro1.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark

When booting Versatile Express TC2 I am getting a null pointer
dereference which appears to be related to the recent changes in
architected timer support. 

The interesting part of the call stack is below (the full log is
attached). It shows that whilst entering CPU idle the code is calling
the NULL set_next_event function on the dummy timer setup by
broadcast_timer_setup.

I've also attached the kernel config I'm using and the code is at
git://git.linaro.org/people/tixy/kernel.git branch arch-timer-bug.

[    5.250325] PC is at 0x0
[    5.250336] LR is at clockevents_program_event+0x99/0xf4
[...]
[    5.250448] [<c004e1d5>] (clockevents_program_event+0x99/0xf4) from [<c004e8a9>] (tick_broadcast_set_event+0x35/0x3c)
[    5.250459] [<c004e8a9>] (tick_broadcast_set_event+0x35/0x3c) from [<c004ee25>] (tick_broadcast_oneshot_control+0x9d/0xd8)
[    5.250468] [<c004ee25>] (tick_broadcast_oneshot_control+0x9d/0xd8) from [<c004e72f>] (tick_notify+0x18b/0x2d0)
[    5.250477] [<c004e72f>] (tick_notify+0x18b/0x2d0) from [<c0036679>] (notifier_call_chain+0x45/0x54)
[    5.250485] [<c0036679>] (notifier_call_chain+0x45/0x54) from [<c0036713>] (raw_notifier_call_chain+0x17/0x1c)
[    5.250493] [<c0036713>] (raw_notifier_call_chain+0x17/0x1c) from [<c004de3d>] (clockevents_notify+0x25/0x10c)
[    5.250503] [<c004de3d>] (clockevents_notify+0x25/0x10c) from [<c02ef51b>] (bl_enter_powerdown+0x2b/0x9c)
[    5.250513] [<c02ef51b>] (bl_enter_powerdown+0x2b/0x9c) from [<c02edec5>] (cpuidle_enter+0xd/0x10)
[    5.250523] [<c02edec5>] (cpuidle_enter+0xd/0x10) from [<c02ee1e9>] (cpuidle_enter_state+0x11/0x50)
[    5.250532] [<c02ee1e9>] (cpuidle_enter_state+0x11/0x50) from [<c02ee293>] (cpuidle_idle_call+0x6b/0x10c)
[    5.250543] [<c02ee293>] (cpuidle_idle_call+0x6b/0x10c) from [<c000da41>] (cpu_idle+0x3d/0xd8)
[    5.250550] [<c000da41>] (cpu_idle+0x3d/0xd8) from [<803d90c9>] (0x803d90c9)

-- 
Tixy
-------------- next part --------------
A non-text attachment was scrubbed...
Name: config.tar.gz
Type: application/x-compressed-tar
Size: 13863 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130307/f967ba01/attachment-0002.bin>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: arch-timer-bug.log.tar.gz
Type: application/x-compressed-tar
Size: 7807 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130307/f967ba01/attachment-0003.bin>
