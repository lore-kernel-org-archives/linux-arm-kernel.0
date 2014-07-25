From: riku.voipio@linaro.org (Riku Voipio)
Date: Fri, 25 Jul 2014 15:22:49 +0300
Subject: arm64 Kernel is overly verbose on user faults
Message-ID: <CAAqcGHkjgOfs1Yj3SNmjpzE2cdGTh4EQ0njyka6UaeVVnbvQGw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Arm64 kernel dmesg will print out a multiline message if any user
binary segfaults. We get "unhandled level X translation fault" with
pr_info, show_pte() with pr_alert and show_regs with default kernel
level:

https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/mm/fault.c#n111

Contrast to arm32 version, where it is only done if CONFIG_DEBUG_USER
is selected and user_debug=N is passed down from kernel command line:

https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/arch/arm/mm/fault.c#n161

The verboseness was useful in early platform bringup, but now it is
now a more source of confusion (people google for unhandled level
translation fault and find old linaro bugs..) . For end users pov, the
x86 version with single line on INFO level would probably be good:

https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/arch/x86/mm/fault.c#n729

example:

test[8901]: segfault at 0 ip 00007fe456a4621f sp 00007ffffd465a90
error 6 in libc-2.19.so[7fe4569db000+19f000]

Could the arm64 behavior be changed to match arm or x86 printouts?

Riku
