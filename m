From: dsd@laptop.org (Daniel Drake)
Date: Sat, 14 Jul 2012 22:49:46 -0600
Subject: Losing VFP registers over suspend/resume
Message-ID: <CAMLZHHTvogPv06zukuUTuc6ezLuoMDwNSy6nPS_q=ambadi8VQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Testing XO-1.75 ARMv7 hardfp, the following simple test gives bad results:

In one terminal, run this python program:

import math
answer = math.cos(3.1415)
while True:
    x = math.cos(3.1415)
    if x != answer:
        print "Bad answer", x


In another terminal:
while sleep 3; do rtcwake -s 3 -m mem; done


This sets up a FP-heavy app running while the system is suspending and
resuming every few seconds.
The results are that every few minutes, one of the cosine calculations
produces the wrong result, and after a few hours the program can even
crash.

Applying the patch "ARM: vfp: Always save VFP state in vfp_pm_suspend"
solves the issue.
http://lists.infradead.org/pipermail/linux-arm-kernel/2011-February/042048.html
I tested with the above test case for several hours, and another OLPC
developer verified. No more bad calculations, no more crashes.

Any chance this effort could be revived? Looks like the patch was almost acked:
http://lists.infradead.org/pipermail/linux-arm-kernel/2011-February/042930.html

Thanks
Daniel
