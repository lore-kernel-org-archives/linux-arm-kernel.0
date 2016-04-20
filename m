From: yang.shi@linaro.org (Shi, Yang)
Date: Wed, 20 Apr 2016 16:01:39 -0700
Subject: [BUG] set_pte_at: racy dirty state clearing warning
Message-ID: <57180A53.3000207@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will and Catalin,

When I enable memory comact via

# echo 1 > /proc/sys/vm/compact_memory

I got the below WARNING:

set_pte_at: racy dirty state clearing: 0x0068000099371bd3 -> 
0x0068000099371fd3
------------[ cut here ]------------
WARNING: CPU: 5 PID: 294 at ./arch/arm64/include/asm/pgtable.h:227 
ptep_set_access_flags+0x138/0x1b8
Modules linked in:

CPU: 5 PID: 294 Comm: systemd-journal Not tainted 
4.6.0-rc3-next-20160414 #13
Hardware name: Freescale Layerscape 2085a RDB Board (DT)
task: ffff80001e4f8080 ti: ffff80001e8b4000 task.ti: ffff80001e8b4000
PC is at ptep_set_access_flags+0x138/0x1b8
LR is at ptep_set_access_flags+0x138/0x1b8
pc : [<ffff200008497b70>] lr : [<ffff200008497b70>] pstate: 20000145
sp : ffff80001e8b7bc0
x29: ffff80001e8b7bc0 x28: ffff80001e843ac8
x27: 0000000000000040 x26: ffff80001e9ae0d8
x25: ffff200009901000 x24: ffff80001f32a938
x23: 0000000000000001 x22: ffff80001e9ae088
x21: 0000ffff7eb59000 x20: ffff80001e843ac8
x19: 0068000099371fd3 x18: fffffffffffffe09
x17: 0000ffff7ea48c88 x16: 0000aaaacb5afb20
x15: 003b9aca00000000 x14: 307830203e2d2033
x13: 6462313733393930 x12: 3030303836303078
x11: 30203a676e697261 x10: 656c632065746174
x9 : 7320797472696420 x8 : 79636172203a7461
x7 : 5f6574705f746573 x6 : ffff200008300ab8
x5 : 0000000000000003 x4 : 0000000000000000
x3 : 0000000000000003 x2 : ffff100003d16f64
x1 : dfff200000000000 x0 : 000000000000004f

---[ end trace d75cd9bb88364c80 ]---
Call trace:
Exception stack(0xffff80001e8b79a0 to 0xffff80001e8b7ac0)
79a0: 0068000099371fd3 ffff80001e843ac8 ffff80001e8b7bc0 ffff200008497b70
79c0: 0000000020000145 000000000000003d ffff200009901000 ffff200008301558
79e0: 0000000041b58ab3 ffff2000096870d0 ffff200008200668 ffff2000092b0e40
7a00: 0000000000000001 ffff80001f32a938 ffff200009901000 ffff80001e9ae0d8
7a20: 0000000000000040 ffff80001e843ac8 ffff200009901000 ffff80001e9ae0d8
7a40: ffff20000a9dcf60 0000000000000000 000000000a6d9320 ffff200000000000
7a60: ffff80001e8b7bc0 ffff80001e8b7bc0 ffff80001e8b7b80 00000000ffffffc8
7a80: ffff80001e8b7ad0 ffff200008415418 ffff80001e8b4000 1ffff00003d16f64
7aa0: 000000000000004f dfff200000000000 ffff100003d16f64 0000000000000003
[<ffff200008497b70>] ptep_set_access_flags+0x138/0x1b8
[<ffff20000847f564>] handle_mm_fault+0xa24/0xfa0
[<ffff20000821e7dc>] do_page_fault+0x3d4/0x4c0
[<ffff20000820045c>] do_mem_abort+0xac/0x140


My kernel has ARM64_HW_AFDBM enabled, but LS2085 is not ARMv8.1.

The code shows it just check if ARM64_HW_AFDBM is enabled or not, but 
doesn't check if the CPU really has such capability.

So, it might be better to have the capability checked runtime?

Thanks,
Yang
