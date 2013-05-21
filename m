From: dgilbert@interlog.com (Douglas Gilbert)
Date: Tue, 21 May 2013 18:21:07 -0400
Subject: [PATCH] v2 rtc-at91rm9200: add support for at91sam9x5
Message-ID: <519BF353.2060800@interlog.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

An unspecified number of SoCs from the Atmel's
at91sam9x5 family including the at91sam9g25 have a
broken AT91_RTC_IMR (interrupt mask) register which
always returns zero.

If this bug can be neutralized, then the existing
rtc-at91rm9200 driver will work. On the other hand,
leaving this bug in place, and starting the RTC
causes unhandled interrupts which result in the
"SYS" interrupt being disabled. And that takes down
several other interrupts wired or-ed through the
SYS interrupt including the DBG port.

This is the second version of this patch, and is
against lk 3.10.0-rc2 .

ChangeLog:
    - checks in probe() function if AT91_RTC_IMR is broken.
      If so, uses a shadow imr
    - apart from that check, SoCs with a good IMR register
      take the same paths through rtc-at91rm9200.c as before
    - SoCs with a broken IMR take a spinlock while changing
      the state of IER or IDR (and the shadow), mainly to
      disable interrupts **.

** similar technique used in arch/arm/mach-at91/clock.c

Tested on an Aria G25 (at91sam9g25 based).

Signed-off-by: Douglas Gilbert <dgilbert@interlog.com>


-------------- next part --------------
A non-text attachment was scrubbed...
Name: rtc-sam9x5_3100rc1.patch
Type: text/x-patch
Size: 5787 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130521/44c67885/attachment.bin>
