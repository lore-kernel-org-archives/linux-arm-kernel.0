From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Thu, 23 Mar 2017 17:03:01 -0400
Subject: [PATCH 0/3] minitty: a minimal TTY layer alternative for embedded
 systems
Message-ID: <20170323210304.2181-1-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Many embedded systems don't need the full TTY layer support. Most of the
time, the TTY layer is only a conduit for outputting debugging messages
over a serial port. The TTY layer also implements many features that are
very unlikely to ever be used in such a setup. There is great potential
for both code and dynamic memory size reduction on small systems. This is
what this patch series is achieving.

The existing TTY code is quite large and complex. Trying to shrink it is
rather risky as the potential for breakage is non negligeable. Therefore,
the approach used here consists in the creation of the minimal code that
interface with the existing UART drivers and provide TTY-like character
devices to user space. When the regular TTY layer is disabled, then the
minitty layer replacement is proposed by Kconfig.

Of course, making it "mini" means there are limitations to what it does:

- This supports serial ports only. No VT's, no PTY's.

- The default n_tty line discipline is hardcoded and no other line
  discipline are supported.

- The line discipline features are not all implemented. Notably, XON/XOFF
  is currently not implemented (although this might not require a lot of
  code to do it).

- Hung-up state is not implemented.

- No error handling on RX bytes other than counting them.

- Behavior in the presence of overflows is most likely different from the
  full TTY code.

- Job control is currently not supported (this may change in the future and 
  be configurable).

But again, most small embedded systems simply don't need those things.

Here's some numbers using a minimal ARM config.

When CONFIG_TTY=y, the following files are linked into the kernel:

   text    data     bss     dec     hex filename
   8796     128       0    8924    22dc drivers/tty/n_tty.o
  12846     276      44   13166    336e drivers/tty/serial/serial_core.o
   4852     489      49    5390    150e drivers/tty/sysrq.o
   1376       0       0    1376     560 drivers/tty/tty_buffer.o
  13571     172     132   13875    3633 drivers/tty/tty_io.o
   3072       0       0    3072     c00 drivers/tty/tty_ioctl.o
   2457       2     120    2579     a13 drivers/tty/tty_ldisc.o
   1328       0       0    1328     530 drivers/tty/tty_ldsem.o
    316       0       0     316     13c drivers/tty/tty_mutex.o
   2516       0       0    2516     9d4 drivers/tty/tty_port.o
  51130    1067     345   52542    cd3e (TOTALS)

With CONFIG_TTY=n and CONFIG_MINITTY_SERIAL=y, the above is replaced by:

   text    data     bss     dec     hex filename
   8776       8     108    8892    22bc drivers/tty/serial/minitty_serial.o

That's it!  And the runtime buffer usage is much less as well.

Overall diffstat:

 drivers/tty/Kconfig                             |   10 +-
 drivers/tty/Makefile                            |    3 +-
 drivers/tty/serial/Kconfig                      |   12 +-
 drivers/tty/serial/Makefile                     |    3 +
 .../serial/{serial_core.c => fulltty_serial.c}  |    0
 drivers/tty/serial/minitty_serial.c             | 2091 +++++++++++++++++
 drivers/tty/tty_baudrate.c                      |  232 ++
 drivers/tty/tty_io.c                            |   24 -
 drivers/tty/tty_ioctl.c                         |  222 --
 include/linux/console.h                         |    2 +
 include/linux/tty.h                             |    7 +-
 include/linux/tty_flip.h                        |    4 +
 init/main.c                                     |    2 +-
 kernel/printk/printk.c                          |   24 +
 14 files changed, 2380 insertions(+), 256 deletions(-)
