From: linux@bohmer.net (Remy Bohmer)
Date: Sat, 6 Aug 2011 23:27:06 +0200
Subject: AT91SAM9261EK kit is broken, commit bd60299 has broken it
Message-ID: <CANqCtQKpAydgXEzs6OzsDDBM_9yVBaGjT++DBq-NKOUH+ssLGA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jean-Christophe,

Currently the Atmel AT91SAM9261-EK kit is broken within Linux 3.0,
3.01 and latest git.

These are the symptoms:
* Booting stops if LCD driver is enabled in the kernel. It stops
within the probe of the LCD driver. (at a msleep(10))
* schedule_timeout is broken.
* The jiffies based sched_clock does not run properly and stalls
during boot, before the LCD driver is being initialised. (You can see
this with printk-timestamps enabled)
* When LCD driver disabled, boards boots up to a prompt, but every
tool (e.g. 'top') that does a nanosleep syscall stays blocked in the
kernel.

After bisecting the tree searching for the offending commit, I came to
the following patch, after reverting it in mainline, everything works
again as normal. I do not see immediately what is wrong with this
commit, do you have an idea? Otherwise I will dig deeper in this
commit...

bd60299594fb1d28ae66563c9e76a0b89b0412cf is the first bad commit
commit bd60299594fb1d28ae66563c9e76a0b89b0412cf
Author: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Date:   Wed Feb 2 07:27:07 2011 +0100

    at91: switch to CLKDEV_LOOKUP

    we do not change the clock naming convention so does not need to switch
    the AVR32 yet

    Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
    Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
    Cc: Patrice Vilchez <patrice.vilchez@atmel.com>

Kind regards,

Remy
