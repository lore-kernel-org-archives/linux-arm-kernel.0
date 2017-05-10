From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 10 May 2017 19:10:52 +0100
Subject: [PATCHv3 0/2] arm64: fix hotplug rwsem boot fallout
In-Reply-To: <1493377266-2205-1-git-send-email-mark.rutland@arm.com>
References: <1493377266-2205-1-git-send-email-mark.rutland@arm.com>
Message-ID: <20170510180928.GA7102@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 28, 2017 at 12:01:04PM +0100, Mark Rutland wrote:
> Hi,
> 
> These patches fix a boot issue seen on some arm64 platforms as a result of the
> hotplug rwsem rework.
> 
> Thomas, would you be able to take these into the tip smp/hotplug branch?
> 
> Will has acked the arm64 part, and is happy for this to go via tip [1].
> 
> I've tested this atop of the tip smp/hotplug branch, and with the arm64
> for-next/core branch merged in, which git handles automatically. In both cases,
> it builds cleanly and boots fine on Juno R1.

As a heads-up, with next-20170510 I'm seeing a warning here that I don't
recall seeing when I tested the above, and I'm not sure how to fix it:

[    0.180998] CPU features: enabling workaround for ARM erratum 832075
[    0.181032] ------------[ cut here ]------------
[    0.181074] WARNING: CPU: 1 PID: 0 at kernel/cpu.c:234 lockdep_assert_hotplug_held+0x78/0x98
[    0.181084] Modules linked in:
[    0.181118] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 4.11.0-next-20170510 #1
[    0.181132] Hardware name: ARM Juno development board (r1) (DT)
[    0.181149] task: ffff80093590af00 task.stack: ffff800935938000
[    0.181172] PC is at lockdep_assert_hotplug_held+0x78/0x98
[    0.181194] LR is at lockdep_assert_hotplug_held+0x78/0x98
[    0.181213] pc : [<ffff200008155218>] lr : [<ffff200008155218>] pstate: 800001c5
[    0.181225] sp : ffff80093593bd80
[    0.181239] x29: ffff80093593bd80 x28: 0000000000000006 
[    0.181274] x27: 0000000000000000 x26: 0000000000000008 
[    0.181309] x25: 1fffe40001aa0d96 x24: 0000000000000000 
[    0.181344] x23: ffff20000abf74a0 x22: 0000000000000000 
[    0.181379] x21: 1ffff00126b277be x20: ffff20000b054000 
[    0.181414] x19: ffff20000ba69000 x18: 0000000000000000 
[    0.181448] x17: 0000000000000000 x16: 0000000000000002 
[    0.181482] x15: 0000000000000000 x14: ffff20000d71af80 
[    0.181517] x13: 1ffff00126b216dd x12: ffff80093590b6c0 
[    0.181552] x11: 1ffff00126b216d8 x10: ffff80093590b6c8 
[    0.181587] x9 : ffff20000ae3b000 x8 : ffff20000d71a000 
[    0.181622] x7 : 1ffff00126b216dc x6 : 0000000041b58ab3 
[    0.181656] x5 : 0000000041b58ab3 x4 : 0000000000000000 
[    0.181690] x3 : 1ffff00126b216d8 x2 : 0000000000000000 
[    0.181724] x1 : 0000000000000001 x0 : 0000000000000000 
[    0.181801] ---[ end trace eee4d9a3d314f895 ]---
[    0.181812] Call trace:
[    0.182133] [<ffff200008155218>] lockdep_assert_hotplug_held+0x78/0x98
[    0.182161] [<ffff20000840a36c>] __static_key_slow_inc+0x174/0x2e0
[    0.182188] [<ffff20000840a654>] static_key_enable_cpuslocked+0x64/0xb0
[    0.182215] [<ffff2000080a1120>] update_cpu_capabilities+0x178/0x2d8
[    0.182243] [<ffff20000809e72c>] update_cpu_errata_workarounds_cpuslocked+0x1c/0x28
[    0.182270] [<ffff2000080a1420>] check_local_cpu_capabilities+0x1a0/0x248
[    0.182295] [<ffff2000080a2d18>] secondary_start_kernel+0x1e8/0x478
[    0.182317] [<000000008219a1b4>] 0x8219a1b4
[    0.182337] CPU features: enabling workaround for ARM erratum 834220
[    0.182362] ------------[ cut here ]------------

The problem is that the secondary CPU doesn't hold the rwsem when it
calls __static_key_slow_inc() in its boot path. It cannot take the
rwsem, since the primaary CPU holds this for the duration of onlining
the secondary CPU.

So far, I haven't figured out how we can avoid this. Any ideas?

Thanks,
Mark.
