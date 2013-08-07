From: dgilbert@interlog.com (Douglas Gilbert)
Date: Tue, 06 Aug 2013 20:32:17 -0400
Subject: at91sam9x5: uart (not usart) broken
Message-ID: <52019591.2010408@interlog.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Between lk 3.10.0 and lk 3.11.0-rc4 the uarts (not usarts)
have been broken in the at91sam9x5 family. The DT files have
been re-factored for uarts but look correct.

So suspicion moves to the atmel_serial driver which enjoyed
a lot of changes in June.

Tested on a at91sam9g25 (Aria G25) which is a member of the
at91sam9x5 family with two uarts (four usarts and a debug
serial port). The failure looks like this in dmesg:

  console [ttyS0] enabled
  f801c000.serial: ttyS1 at MMIO 0xf801c000 (irq = 23) is a ATMEL_SERIAL
  f8020000.serial: ttyS2 at MMIO 0xf8020000 (irq = 24) is a ATMEL_SERIAL
  f8024000.serial: ttyS3 at MMIO 0xf8024000 (irq = 25) is a ATMEL_SERIAL
  atmel_usart: probe of f8040000.serial failed with error -2
  f8028000.serial: ttyS4 at MMIO 0xf8028000 (irq = 32) is a ATMEL_SERIAL

The device at 0xf8040000 is uart0 . My DT file was trying
to bring up uart0 but not uart1.

Doug Gilbert
