From: marc.ceeeee@gmail.com (Marc C)
Date: Wed, 20 Nov 2013 23:58:04 -0800
Subject: [RFC] ARM Generic Timer + Interaction with WFI on Cortex-A15
Message-ID: <528DBD0C.6040203@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

I have a question regarding the interaction with the ARM Generic (or
architected) timer, high-resolution timer support, and the WFI instruction.

This commit [1] sets up the "C3STOP" flag on the arch_timer. According
to the commit log, an ARM core which implements the ARM Generic Timer
may power-down and thus invalidate some registers within the timer.
Therefore, flagging the timer with C3STOP will ensure that an
appropriate broadcast timer will be used whenever the CPU goes into idle.

However, according to this article [2], there is a difference in
implementation between the Cortex-A7 and Cortex-A15, wherein the A7 will
power-down on idle, and the A15 will not.

Now, given the 2 citations, can someone explain why the C3STOP flag is
used for _all_ implementations? Is it not the case that the A15-based
arch_timer can be used as a broadcast timer, even if the kernel is
configured to call WFI and put the CPU into low-power mode?

There have been some recent commits which conditionally setup the C3STOP
flag, depending on the CONFIG_CPU_IDLE flag. However, my concern is that
there are some ARM implementations that can actually go into low-power
mode and still use the arch_timer reliably.

Thank you,
Marc C

[1] -
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=27a5569dc66ecce06cb532542ddcd0b6da8783f6
[2] -
http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.faqs/ka16107.html
