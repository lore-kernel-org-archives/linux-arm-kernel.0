From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 20 Jun 2012 17:39:41 +0200
Subject: AT91: RTC interrupt raised early at boot time
Message-ID: <20120620173941.2bf4138d@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear AT91 maintainers,

We're running into a problem using the RTC part of the AT91SAM9M10G45,
that we think we understand but we don't know how to fix nicely.

Basically, the problem is that the RTC registers are battery-backed, so
things like interrupt masks for the RTC device are preserved across
reboots. This has lead us to a situation where the system sets the time
in the RTC, which calls into the ->set_time() method of the driver.
This function does:

        /* Stop Time/Calendar from counting */
        cr = at91_rtc_read(AT91_RTC_CR);
        at91_rtc_write(AT91_RTC_CR, cr | AT91_RTC_UPDCAL | AT91_RTC_UPDTIM);

        at91_rtc_write(AT91_RTC_IER, AT91_RTC_ACKUPD);
        wait_for_completion(&at91_rtc_updated); /* wait for ACKUPD interrupt */
        at91_rtc_write(AT91_RTC_IDR, AT91_RTC_ACKUPD);

If for some reason the board gets rebooted during the
wait_for_completion(), then the board would no longer boot. The only
way to bring the board back to life is to remove the battery, to ensure
that all the state of those RTC registers are reset.

Gabe Siftar (in Cc) did some investigation, and found out that the
simple fact of enable UPDCAL|UPDTIM in the CR register + having the
ACKUPD interrupt enabled was sufficient to prevent the kernel from
booting. Our minimal sequence to reproduce this is therefore:

U-Boot> mw.l 0xFFFFFDB0 3
U-Boot> mw.l 0xFFFFFDD0 1
U-Boot> boot

And then the kernel would hang after uncompression. After adding
earlyprintk, we figured out that the problem is that IRQ1 was raised
without nobody caring (the RTC driver hasn't yet initialized, so it
hasn't registered its own interrupt handler). The problem is that this
IRQ line is shared between multiple peripherals, and is enabled to
allow the timer and DBGU to operate. But at this time, the RTC driver
has not yet had the opportunity to reset the RTC registers to a proper
state.

So our question is: where is the correct location to ensure that those
RTC registers are reset to sane values (i.e, interrupts disabled)?
Should this be done in the bootloader? In the kernel? If in the kernel,
in which place?

Of course, to solve our problem, we can do a oneline hack in our
bootloader, but we were interested in knowing what would be a more
correct solution that could potentially be upstreamed, so that others
don't fall into the same problem.

Thanks for your suggestions,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
