From: sophian.yoma@gmail.com (yoma sophian)
Date: Thu, 30 Jul 2015 00:03:46 +0800
Subject: question about detect hard lockups without NMIs using secondary cpus
Message-ID: <CADUS3onib4DYYtPo7RfLAYiN4fpspzcFCx86-pJwuLc37hz3dQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi all:
below link introduced how to emulate NMIs on systems where they are
not available by using timer interrupts on other cpus.

http://article.gmane.org/gmane.linux.kernel/1419661

in kernel/watchdog.c
    --> watchdog_overflow_callback
          if (is_hardlockup()) {
           ...........................
                if (hardlockup_panic)
                        panic("Watchdog detected hard LOCKUP on cpu %d",
                              this_cpu); /*************/
                else
                        WARN(1, "Watchdog detected hard LOCKUP on cpu %d",
                             this_cpu);
             .......................
        }

I have some questions:
a.
in SMP system, suppose 4 cores, and hardlockup_panic is 1.
Core0 find Core1 hard lcokup in hardIRQ context
the panic function, above with '*' marked, will fail on
smp_send_stop(), and we will have no idea where core1 is trapped in,
right?

b.
things will get worse if we are running single core system if hard
lockup happen.
We even have no idea what happen.

If my conclusions above are correct, is there any way to debug  a) and
b) situation?

appreciate your kind help in advance,
