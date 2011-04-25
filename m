From: mbohan@codeaurora.org (Michael Bohan)
Date: Mon, 25 Apr 2011 16:33:27 -0700
Subject: console_cpu_notify can cause scheduling BUG during CPU hotplug
Message-ID: <4DB604C7.8090305@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I've run into a crash scenario during CPU hotplug on ARM/MSM where we 
BUG() due to a schedule while atomic in v2.6.38-rc6. The issue appears 
to be that the console cpu notifier can block on a semaphore during 
cpu_stopper_thread's atomic code path. Preemption is explicitly disabled 
in cpu_stopper_thread.

The suspected path was added with this commit:

commit 034260d6779087431a8b2f67589c68b919299e5c
Author: Kevin Cernekee <cernekee@gmail.com>
Date:   Thu Jun 3 22:11:25 2010 -0700

     printk: fix delayed messages from CPU hotplug events

I was curious if this scenario was accounted for in the design of the 
console CPU notifier. One workaround for this problem is to remove 
CPU_DEAD from the possible actions in console_cpu_notify(). In fact, 
v1-v4 of the patch above did not have CPU_DEAD, CPU_DYING or 
CPU_DOWN_FAILED in the list of actions. I wasn't able to track down why 
the other cases were added in the final patch.

Crash log:

<3>[   21.408237] BUG: scheduling while atomic: migration/1/371/0x00000002
<4>[   21.408247] Modules linked in:
<4>[   21.408286] [<c0050e40>] (unwind_backtrace+0x0/0x128) from 
[<c056748c>] (schedule+0x9c/0x6c4)
<4>[   21.408303] [<c056748c>] (schedule+0x9c/0x6c4) from [<c0567d04>] 
(schedule_timeout+0x1c/0x208)
<4>[   21.408319] [<c0567d04>] (schedule_timeout+0x1c/0x208) from 
[<c0568fac>] (__down+0x68/0x98)
<4>[   21.408337] [<c0568fac>] (__down+0x68/0x98) from [<c00d844c>] 
(down+0x2c/0x3c)
<4>[   21.408354] [<c00d844c>] (down+0x2c/0x3c) from [<c00bb23c>] 
(console_lock+0x38/0x60)
<4>[   21.408377] [<c00bb23c>] (console_lock+0x38/0x60) from 
[<c0564c80>] (console_cpu_notify+0x20/0x2c)
<4>[   21.408394] [<c0564c80>] (console_cpu_notify+0x20/0x2c) from 
[<c00d8488>] (notifier_call_chain+0x2c/0x70)
<4>[   21.408410] [<c00d8488>] (notifier_call_chain+0x2c/0x70) from 
[<c00bc318>] (__cpu_notify+0x24/0x3c)
<4>[   21.408425] [<c00bc318>] (__cpu_notify+0x24/0x3c) from 
[<c0552e7c>] (take_cpu_down+0x2c/0x34)
<4>[   21.408444] [<c0552e7c>] (take_cpu_down+0x2c/0x34) from 
[<c00f34d4>] (stop_machine_cpu_stop+0xc0/0x11c)
<4>[   21.408462] [<c00f34d4>] (stop_machine_cpu_stop+0xc0/0x11c) from 
[<c00f337c>] (cpu_stopper_thread+0xc8/0x160)
<4>[   21.408482] [<c00f337c>] (cpu_stopper_thread+0xc8/0x160) from 
[<c00d30b0>] (kthread+0x80/0x88)
<4>[   21.408498] [<c00d30b0>] (kthread+0x80/0x88) from [<c004b6a0>] 
(kernel_thread_exit+0x0/0x8)

Thanks,
Mike

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
