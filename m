From: brad@heeltoe.com (Brad Parker)
Date: Thu, 26 Nov 2015 18:26:38 -0500
Subject: armv7 + lpae broken in 4.1.12+ ?
Message-ID: <5657952E.906@heeltoe.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I was recently building a 4.1.12 kernel for a generic V7 platform with 
LPAE.   I could not get it to boot and then discovered two things:

- the early printk code in tty/serial call ioremap very early and it 
fails because there's no heap
- the code in proc-v7-3level.S/cpu_v7_set_pte_ext doesn't work

The printk issue is no big deal.  The pte issue is more important.

I found that the pte entries were garbage, which really confused me.  I 
finally discovered that the code in proc-v7-3level.S expects data in r0, 
r2 & r3, but in fact it comes in on r0, r1 & r2.

My guess is that this is some vestige of the change made to 
cpu_v7_switch_mm() some time ago to make the PA a 64 bit value (hence 
using r0,r1).  But this change was not made to cpu_v7_set_pte_ext, so it 
writes garbage.

lol.  I guess I'm the only one who turns on LPAE for v7 cpu's...

The simple fix is to add "mov r3, r2; mov r2,r1" at the begining of 
cpu_v7_set_pte_ext(), but that's a hack (but it does solve the problem 
and the kernel boots).

I suspect the "right thing" is to make the prototype for 
cpu_v7_set_pte_ext() in proc-fns.h use a phys_addr_t but I have not 
tried that yet.

Can someone confirm that what I am seeing is correct?

-brad
