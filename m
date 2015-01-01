From: dgilbert@interlog.com (Douglas Gilbert)
Date: Thu, 01 Jan 2015 13:02:13 -0500
Subject: [PATCH] at91: i2c-at91: improve time-out handling
Message-ID: <54A58BA5.3080003@interlog.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With lk 3.19.0-rc2 and a at91sam9g25 (9x5) based system I
connected a NXP SC16IS750 I2C to serial bridge. After
routing the 750's IRQ back to the sc16is7xx driver and some
simple successful test, it was time for some intense testing:
Tx looped back to Rx on the 750, open picocom on /dev/ttySC0
at 38400, and use hexdump to blast a binary file (in hex) at
ttySC0. The I2C SCL speed was 200,000 Hz.

It worked as expected for a few seconds then it wedged the
I2C bus. That was repeatable. In the cases that I checked SCL
was high, SDA was low (driven by _both_ the G25's macrocell
and the 750!!) and IRQ was active (low). This patch stopped
the G25 macrocell from driving SDA low in the above wedge
(and stopped copious error reports going to the log). I was
surprised that a NXP I2C chip got into this situation, IMO
SDA on a slave should have a driven low timeout. IMO all
I2C master drivers should have provision to drive a gpio
connected to a (or all the) slave's RESET line(s).


ChangeLog:
    when handling an I2C bus time-out, first clean-up the
    DMA transfer, then do an I2C macrocell software reset
    and restore some registers, including the interrupt
    mask

Signed-off-by: Douglas Gilbert <dgilbert@interlog.com>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: i2c-at91-timeout1.patch
Type: text/x-patch
Size: 972 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150101/fd42e097/attachment.bin>
