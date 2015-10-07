From: yang.shi@linaro.org (Shi, Yang)
Date: Wed, 07 Oct 2015 15:46:57 -0700
Subject: Run armv7 32 bit userspace on aarch64
Message-ID: <5615A0E1.1050402@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi folks,

I'm trying to run armv7 little endian userspace on qemu aarch64 with 
4.1.x kernel. I was told by someone such usecase is valid and I have 
CONFIG_COMPAT enabled in my kernel.

But, I ran into the below error. It looks the userspace application is 
trying to write a readonly page. I got the similar failure on arm vfp 
with Linaro images (4.1 kernel) too.

Did anyone have tried it recently?

Any suggestion is appreciated.

Thanks,
Yang


init[1]: unhandled level 3 permission fault (11) at 0x4cb2fad3, esr 
0x9200004f
pgd = ffffffc0040c6000
[4cb2fad3] *pgd=00000000440d1003, *pud=00000000440d1003, 
*pmd=00000000440d2003, *pte=0020000045974fd3

CPU: 0 PID: 1 Comm: init Not tainted 4.1.9-WR8.0.0.0_standard #3
Hardware name: linux,dummy-virt (DT)
task: ffffffc006900000 ti: ffffffc006908000 task.ti: ffffffc006908000
PC is at 0x4cb7747c
LR is at 0x4cb29c5c
pc : [<000000004cb7747c>] lr : [<000000004cb29c5c>] pstate: 40060010
sp : 00000000ffc5a358
x12: 000000004cbe8474
x11: 0000000000000000 x10: 000000004caa0000
x9 : 0000000000000000 x8 : 0000000000000000
x7 : 0000000000000036 x6 : 0000000000000500
x5 : 0000000000000005 x4 : 0000000000000000
x3 : 000000004cb2fad3 x2 : 0000000000000013
x1 : 000000000000596c x0 : 000000004cb2fad3

CPU: 0 PID: 1 Comm: init Not tainted 4.1.9-WR8.0.0.0_standard #3
Hardware name: linux,dummy-virt (DT)
Call trace:
[<ffffffc00008a4b0>] dump_backtrace+0x0/0x128
[<ffffffc00008a5f8>] show_stack+0x20/0x30
[<ffffffc000688448>] dump_stack+0x80/0xc4
[<ffffffc00068667c>] panic+0xd8/0x210
[<ffffffc000686514>] __do_user_fault.isra.1+0xf0/0xf4
[<ffffffc000690870>] do_page_fault+0x378/0x380
[<ffffffc00008237c>] do_mem_abort+0x54/0xb0
Exception stack(0xffffffc00690be30 to 0xffffffc00690bf50)
be20:                                     00400000 00000000 00000000 
00000000
be40: ffffffff ffffffff 4cb7747c 00000000 60060010 00000000 00000011 
00000000
be60: 00000184 00000000 00000036 00000000 00698000 ffffffc0 06908000 
ffffffc0
be80: ffffffff ffffffff 00020802 00000000 00000026 00000100 00000001 
00000000
bea0: 00000000 00000000 00083c70 ffffffc0 00400000 00000000 00000000 
00000000
bec0: ffffffff ffffffff 4ca7ffa4 00000000 4cb2fad3 00000000 0000596c 
00000000
bee0: 00000013 00000000 4cb2fad3 00000000 00000000 00000000 00000005 
00000000
bf00: 00000500 00000000 00000036 00000000 00000000 00000000 00000000 
00000000
bf20: 4caa0000 00000000 00000000 00000000 4cbe8474 00000000 ffc5a358 
00000000
bf40: 4cb29c5c 00000000 00000000 00000000
---[ end Kernel panic - not syncing: BUG!
