From: victor.kamensky@linaro.org (Victor Kamensky)
Date: Tue,  8 Apr 2014 00:04:10 -0700
Subject: [PATCH] systemtap: need to use kallsyms_lookup_funcptr with arm
 thumb2 kernel
Message-ID: <1396940651-19013-1-git-send-email-victor.kamensky@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi SystemTap maintainers, and ARM kernel gurus,

When SystemTap is used with Dave Long's uprobes series and kernel
compiled with CONFIG_THUMB2_KERNEL when SystemTap module attaches to
user-land executable kernel crashes with very weird traceback. 

The root case is very similar to issue discussed at [1] with lltng
and CONFIG_THUMB2_KERNEL - basically in SystemTap kernel module
support code kallsyms_lookup_name function is used to lookup symbol
and returned pointer is 2 or 4 bytes aligned; then pointer is casted
to function pointer and it is called. Because function pointer
call address does not have bit 0 set, CPU assumes that it jumps to
ARM code, but which is actually thumb2 opcodes, which in turns produces
very unexpected result, code jumps to some random place and crashes
there.

Proposed fix is very similar to one implemented at [1]. Basically
inside of SystemTap module support code it introduces
kallsyms_lookup_funcptr function which if called with 
CONFIG_THUMB2_KERNEL set bit 0 of returned function address or
returns result of kallsyms_lookup_name for all other case.

On [1] Dave Martin suggested to promote kallsyms_lookup_funcptr to
kernel headers, but it does not look it happened yet. Because it
affects many other than ARM architectures, personally, I am not sure
how to go about it. Never done it before ... I can try to do it 
with some guidance. If someone else can take it up, it will be
fine with me. It would be great to have solution in kernel headers.
Besides lttng and SystemTap, I guess, there could be other similar
cases.

In mean time please find patch for SystemTap that follows this 
cover letter. The patch implements kallsyms_lookup_funcptr wrapper
inside of SystemTap runtime sources. Change similar to [1] done
for lttng.

[1] http://lists.lttng.org/pipermail/lttng-dev/2011-September/016469.html

Thanks,
Victor

Appendix Kernel crash example
-----------------------------

Last login: Sun Apr  6 13:11:06 UTC 2014 on tty1
root at genericarmv7a:~# [   66.974478] Internal error: Oops - undefined instruction: 0 [#1] SMP THUMB2
[   66.980052] Modules linked in: stap_bb2bc039e273bae6d1b63f6062b0d112_2107(O)
[   66.987056] CPU: 1 PID: 1577 Comm: sh Tainted: G           O 3.14.0 #1
[   66.993577] task: eca3c200 ti: ec0d0000 task.ti: ec0d0000
[   66.998971] PC is at msdos_create+0x6a/0x118
[   67.003214] LR is at task_work_add+0x8/0x68
[   67.007374] pc : [<8016f0ca>]    lr : [<80030f50>]    psr: 00000013
[   67.007374] sp : ec0d1f00  ip : 7f80663d  fp : 00000000
[   67.018854] r10: eca3c200  r9 : 00000000  r8 : ec12fdd8
[   67.024035] r7 : ee20ed80  r6 : 7f8077b1  r5 : 7f80cf48  r4 : 7f80cd08
[   67.030549] r3 : 80030f48  r2 : 00000001  r1 : ec06d590  r0 : ee20ed80
[   67.037060] Flags: nzcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
[   67.044133] Control: 70c5387d  Table: ac19ee80  DAC: 55555555
[   67.049860]
[   67.049860] PC: 0x8016f04a:
[   67.054113] f048  30700260 fe6cf2fc 46394628 f7fd4632 4604fb43 bf00e7df 41f0e92d b500b094
[   67.062268] f068  eb04f85d 460e4607 f8d569c5 30700260 ff34f2fc 3260f8d5 0225f10d 69f16a30
[   67.070428] f088  f7ff33a0 4604fb75 6a33b980 2b2e781b 4638d05d f10daa0c f7f90125 b970fc73
[   67.078586] f0a8  f06f9812 b1080415 fff4f773 0260f8d5 f2fc3070 4620fe35 e8bdb014 f6e981f0
[   67.086746] f0c8  f10dfa13 f04f081c ab0c0e00 93029007 0125f10d f8cd4623 4672e000 8004f8cd
[   67.094905] f0e8  f8cd4638 f7ffe020 4604fc7b d1dd2800 230ce9dd 99114628 fd10f7fd 98124602

Victor Kamensky (1):
  systemtap: need to use kallsyms_lookup_funcptr with arm thumb2 kernel

 runtime/linux/kallsyms_wrapper.h | 28 ++++++++++++++++++++++++++++
 runtime/linux/runtime.h          |  2 ++
 runtime/stp_task_work.c          |  4 ++--
 runtime/stp_utrace.c             |  6 +++---
 runtime/transport/transport.c    | 12 ++++++------
 5 files changed, 41 insertions(+), 11 deletions(-)
 create mode 100644 runtime/linux/kallsyms_wrapper.h

-- 
1.9.0
