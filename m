From: wangnan0@huawei.com (Wangnan (F))
Date: Thu, 7 Apr 2016 21:00:23 +0800
Subject: [BUG] arm64 kprobe: Allow probing at rodata
Message-ID: <570659E7.3040408@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

When testing kprobe v12 we find a bug

# echo 'p:kprobes/mykprobe1 ftrace_enable_fops' > 
/sys/kernel/debug/tracing/kprobe_events
# echo 1 > /sys/kernel/debug/tracing/events/kprobes/mykprobe1/enable

Unable to handle kernel paging request at virtual address d42003f0
pgd = ffffffc009f64000
[d42003f0] *pgd=0000000000000000, *pud=0000000000000000
Internal error: Oops: 94000005 [#1] SMP
Modules linked in:
...

ftrace_enable_fops resides in rodata section, kprobe should not
allow user to put probe point on it.

It seems arm64 intentionally puts rodata between _stext and _etext in
arch/arm64/kernel/vmlinux.lds.S, so I think we should introduce a symbol
before rodata and extra verification in kprobe on arm64.

Thank you.

Full output:

# echo 'p:kprobes/mykprobe1 ftrace_enable_fops' > 
/sys/kernel/debug/tracing/kprobe_events
# echo 1 > /sys/kernel/debug/tracing/events/kprobes/mykprobe1/enable

Unable to handle kernel paging request at virtual address d42003f0
pgd = ffffffc009f64000
[d42003f0] *pgd=0000000000000000, *pud=0000000000000000
Internal error: Oops: 94000005 [#1] SMP
Modules linked in:
CPU: 0 PID: 99 Comm: sh Not tainted 4.5.0+ #105
Hardware name: linux,dummy-virt (DT)
task: ffffffc009fdc800 ti: ffffffc009ff4000 task.ti: ffffffc009ff4000
PC is at module_put+0x38/0x218
LR is at __fput+0xd4/0x1f4
pc : [<ffffffc000121760>] lr : [<ffffffc0001d4c14>] pstate: 20000145
sp : ffffffc009ff7db0
x29: ffffffc009ff7db0 x28: ffffffc009ff4000
x27: ffffffc00053c000 x26: 0000000000000018
x25: ffffffc00a01c610 x24: ffffffc0755a4f60
x23: ffffffc075569500 x22: ffffffc0001d4c14
x21: ffffffc0755a4f60 x20: 0000000000000008
x19: 00000000d4200080 x18: 0000007ffdfbc7f0
x17: 0000007fa78e3340 x16: ffffffc0001f4b84
x15: 0000007fa796b598 x14: 000000000000024e
x13: 000000001b670000 x12: 0000000000000008
x11: 0101010101010101 x10: ffffffc000fbdc88
x9 : 0000000000000001 x8 : 0000000000001ffe
x7 : ffffffc009fdcfc8 x6 : 0000000000000015
x5 : 0000000000000000 x4 : 0000000000000000
x3 : 0000000000000001 x2 : 0000000000000000
x1 : ffffffc009ff4000 x0 : 0000000000000001

Process sh (pid: 99, stack limit = 0xffffffc009ff4020)
Stack: (0xffffffc009ff7db0 to 0xffffffc009ff8000)
7da0:                                   ffffffc009ff7df0 ffffffc0001d4c14
7dc0: ffffffc00a01c600 0000000000000008 ffffffc0755a4f60 ffffffc0795f4c60
7de0: ffffffc075569500 ffffffc0755a4f60 ffffffc009ff7e50 ffffffc0001d4da8
7e00: ffffffc00a01c600 ffffffc009fdce68 ffffffc009fdc800 ffffffc0006614b0
7e20: ffffffc0009b3000 0000000000000015 000000000000011e 0000000000000000
7e40: 0000000000000058 0000000000000000 ffffffc009ff7e70 ffffffc0000ba5e0
7e60: 0000000000000000 ffffffc0001f4ca8 ffffffc009ff7eb0 ffffffc00008929c
7e80: 0000000000000004 ffffffc009ff4000 ffffffffffffffff 0000007fa78e336c
7ea0: 0000000020000000 0000000000000015 0000000000000000 ffffffc000085a9c
7ec0: 0000000000000000 000000001b679560 0000000000000001 0000000000000001
7ee0: 0000000000000000 0000000000000000 000000001b67c970 0000000000000000
7f00: 0000000000000010 fefefefefefefefe 0000000000000018 fefefeff1a65ff30
7f20: 7f7f7f7f7f7f7f7f 0101010101010101 0000000000000008 000000001b670000
7f40: 0000000000000000 0000007fa796b598 00000000004aeb48 0000007fa78e3340
7f60: 0000007ffdfbc7f0 000000000000000b 000000001b679560 000000001b67c890
7f80: 0000000000000000 0000000000000000 0000000000000000 0000000000000002
7fa0: 000000001b679468 000000001b679430 000000000047edf0 0000007ffdfbca10
7fc0: 000000000042f770 0000007ffdfbca10 0000007fa78e336c 0000000020000000
7fe0: 000000000000000b 0000000000000018 0000000000000000 0000000000000000
Call trace:
Exception stack(0xffffffc009ff7bf0 to 0xffffffc009ff7d10)
7be0:                                   0000000000000000 0000000000000008
7c00: ffffffc009ff7db0 ffffffc000121760 ffffffc00a01c600 0000000000000015
7c20: ffffffc009ff7c50 ffffffc0000e7540 ffffffc0005319a8 ffffffc009fdc800
7c40: 0000000000000001 ffffffc0016a8000 ffffffc009ff7c90 ffffffc0000e73a4
7c60: ffffffc009ff7ca0 ffffffc0000e9e38 ffffffc009ff7ca0 ffffffc0000e9f70
7c80: 000000000000024d ffffffc009fdcf90 0000000000000001 ffffffc009ff4000
7ca0: 0000000000000000 0000000000000001 0000000000000000 0000000000000000
7cc0: 0000000000000015 ffffffc009fdcfc8 0000000000001ffe 0000000000000001
7ce0: ffffffc000fbdc88 0101010101010101 0000000000000008 000000001b670000
7d00: 000000000000024e 0000007fa796b598
[<ffffffc000121760>] module_put+0x38/0x218
[<ffffffc0001d4c14>] __fput+0xd4/0x1f4
[<ffffffc0001d4da8>] ____fput+0x20/0x2c
[<ffffffc0000ba5e0>] task_work_run+0xb8/0xec
[<ffffffc00008929c>] do_notify_resume+0x5c/0x70
[<ffffffc000085a9c>] work_pending+0x10/0x14
Code: d5384101 b9401820 11000400 b9001820 (b9437263)
---[ end trace adc71e553dfc48ff ]---
note: sh[99] exited with preempt_count 1
