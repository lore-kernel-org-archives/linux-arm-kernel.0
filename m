From: dagriego@gmail.com (dagriego)
Date: Mon, 23 Sep 2013 15:05:56 -0700
Subject: Corrupted registers in return from system call 2.6.31
Message-ID: <CAKgB9L_gMQCmNH-oLBCepB7JsEAcayf9nzar_qzDhx5MhvtYDw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
I'm troubleshooting an issue on a Marvell MV78XX0 processor board that
is running the 2.6.31 kernel (patches applied from MontaVista and
Marvell) and I wanted to know if anyone may have seen anything
similar?

What was first seen was random processes (sshd, rsync, snmpd)
segfaulting with a data abort.  This issue does not occur very
frequently (couple times a week).  After some investigation we've
instrumented the kernel to save the registers when entering and
exiting the kernel, and here are the results:

When Saved : Before Restoration
r4 = 0xba2c5680   0xb750d680
r5 = 0xb750d680   0xb76969a0
r6 = 0xb7479b40   0xb74796c0
r7 = 0xba237820   0xb7479b40
r8 = 0x00000000   0x00000000
r9 = 0xb7554000   0xb770c000
sl = 0xba3d8000   0xb7554000
fp = 0xba3d9a6c   0xb7555a6c
sp = 0xba3d99b0   0xb75559b0
pc = 0x803217fc   0x803217fc
e1 = 0x00000000   0x00000000
e2 = 0x00000000   0x00000000

Note that ftraces of the kernel showed the failing process going into
the kernel via the syscall interface, being interrupted by the timer
and other device's ISRs, and finally being scheduled to complete some
time later (usually after giving some other processes an opportunity
to run).

It would also be helpful to get suggestions on how to isolate or
reproduce this issues more frequently since it is still very rare.
Cheers,
-David
