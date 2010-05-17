From: hans.huebner@gmail.com (=?ISO-8859-1?Q?Hans_H=FCbner?=)
Date: Mon, 17 May 2010 11:04:09 +0200
Subject: Physical address access / Temporary MMU disable
Message-ID: <AANLkTinERP4BJFMXWtQqrwxPBtvb1lpJ73yQzO-Wb5zp@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I'm working with Linux 2.6.22 on an AT91SAM9260 based system.

I am implementing a device driver that has very strict timing and
jitter requirements.  It uses a FIQ handler, written in assembly, that
transfers data from the on-chip SRAM to GPIO ports.  In the default
configuration, it appears that the FIQ handler is invoked with the MMU
enabled, so the SRAM (and I/O) accesses are undergoing virtual address
translation.  If there is a TLB miss, this means that the MMU tables
in SDRAM are consulted, which violates the timing requirements of my
driver.

In order to reduce FIQ response time jitter, I would like to not use
virtual addresses in the FIQ handler.  Is disabling the MMU for the
duration of the FIQ handler through the CP15 coprocessor register the
right way to do this, or is there another way to make some section of
code use physical addresses?

Thanks,
Hans
