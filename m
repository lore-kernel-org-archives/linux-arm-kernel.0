From: fengguang.wu@intel.com (kbuild test robot)
Date: Tue, 7 Feb 2017 04:07:07 +0800
Subject: [hisi:topic-lpc-4.10-libio 138/148]
 drivers/tty/serial/8250/8250_port.c:420: undefined reference to `libio_outb'
Message-ID: <201702070457.wkXw3Exc%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://github.com/hisilicon/linux-hisi topic-lpc-4.10-libio
head:   06443d85dc35b64a704f7be84cc538281a1598f4
commit: c3fb8a18b9d66d740ac05a181c83d12f67f39f24 [138/148] asm-generic: use libio accessors as default
config: nios2-10m50_defconfig (attached as .config)
compiler: nios2-linux-gcc (GCC) 6.2.0
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout c3fb8a18b9d66d740ac05a181c83d12f67f39f24
        # save the attached .config to linux build tree
        make.cross ARCH=nios2 

All errors (new ones prefixed by >>):

   drivers/built-in.o: In function `io_serial_out':
>> drivers/tty/serial/8250/8250_port.c:420: undefined reference to `libio_outb'
   drivers/tty/serial/8250/8250_port.c:420:(.text+0x1bbb0): relocation truncated to fit: R_NIOS2_CALL26 against `libio_outb'
   drivers/built-in.o: In function `hub6_serial_out':
   drivers/tty/serial/8250/8250_port.c:359: undefined reference to `libio_outb'
   drivers/tty/serial/8250/8250_port.c:359:(.text+0x1bbf4): relocation truncated to fit: R_NIOS2_CALL26 against `libio_outb'
   drivers/tty/serial/8250/8250_port.c:360: undefined reference to `libio_outb'
   drivers/tty/serial/8250/8250_port.c:360:(.text+0x1bc04): relocation truncated to fit: R_NIOS2_CALL26 against `libio_outb'
   drivers/built-in.o: In function `io_serial_in':
>> drivers/tty/serial/8250/8250_port.c:414: undefined reference to `libio_inb'
   drivers/tty/serial/8250/8250_port.c:414:(.text+0x1bc34): relocation truncated to fit: R_NIOS2_CALL26 against `libio_inb'
   drivers/built-in.o: In function `hub6_serial_in':
   drivers/tty/serial/8250/8250_port.c:352: undefined reference to `libio_outb'
   drivers/tty/serial/8250/8250_port.c:352:(.text+0x1bc74): relocation truncated to fit: R_NIOS2_CALL26 against `libio_outb'
   drivers/tty/serial/8250/8250_port.c:353: undefined reference to `libio_inb'
   drivers/tty/serial/8250/8250_port.c:353:(.text+0x1bc80): relocation truncated to fit: R_NIOS2_CALL26 against `libio_inb'
   drivers/built-in.o: In function `serial8250_do_shutdown':
   drivers/tty/serial/8250/8250_port.c:2381: undefined reference to `libio_inb'
   drivers/tty/serial/8250/8250_port.c:2381:(.text+0x1c22c): relocation truncated to fit: R_NIOS2_CALL26 against `libio_inb'
   drivers/built-in.o: In function `outb_p':
>> include/asm-generic/io.h:414: undefined reference to `libio_outb'
   include/asm-generic/io.h:414:(.text+0x1d744): relocation truncated to fit: R_NIOS2_CALL26 against `libio_outb'
   drivers/built-in.o: In function `inb_p':
>> include/asm-generic/io.h:390: undefined reference to `libio_inb'
   include/asm-generic/io.h:390:(.text+0x1d74c): relocation truncated to fit: R_NIOS2_CALL26 against `libio_inb'
   drivers/built-in.o: In function `outb_p':
>> include/asm-generic/io.h:414: undefined reference to `libio_outb'
   include/asm-generic/io.h:414:(.text+0x1e348): relocation truncated to fit: R_NIOS2_CALL26 against `libio_outb'
   drivers/built-in.o: In function `inb_p':
>> include/asm-generic/io.h:390: undefined reference to `libio_inb'
   include/asm-generic/io.h:390:(.text+0x1e360): additional relocation overflows omitted from the output
   drivers/built-in.o: In function `outb_p':
>> include/asm-generic/io.h:414: undefined reference to `libio_outb'
   drivers/built-in.o: In function `inb_p':
>> include/asm-generic/io.h:390: undefined reference to `libio_inb'
   drivers/built-in.o: In function `serial8250_early_in':
>> drivers/tty/serial/8250/8250_early.c:54: undefined reference to `libio_inb'
   drivers/built-in.o: In function `serial8250_early_out':
>> drivers/tty/serial/8250/8250_early.c:78: undefined reference to `libio_outb'

vim +420 drivers/tty/serial/8250/8250_port.c

b6830f6d Peter Hurley 2015-06-27  408  	return ioread32be(p->membase + offset);
b6830f6d Peter Hurley 2015-06-27  409  }
b6830f6d Peter Hurley 2015-06-27  410  
b6830f6d Peter Hurley 2015-06-27  411  static unsigned int io_serial_in(struct uart_port *p, int offset)
b6830f6d Peter Hurley 2015-06-27  412  {
b6830f6d Peter Hurley 2015-06-27  413  	offset = offset << p->regshift;
b6830f6d Peter Hurley 2015-06-27 @414  	return inb(p->iobase + offset);
b6830f6d Peter Hurley 2015-06-27  415  }
b6830f6d Peter Hurley 2015-06-27  416  
b6830f6d Peter Hurley 2015-06-27  417  static void io_serial_out(struct uart_port *p, int offset, int value)
b6830f6d Peter Hurley 2015-06-27  418  {
b6830f6d Peter Hurley 2015-06-27  419  	offset = offset << p->regshift;
b6830f6d Peter Hurley 2015-06-27 @420  	outb(value, p->iobase + offset);
b6830f6d Peter Hurley 2015-06-27  421  }
b6830f6d Peter Hurley 2015-06-27  422  
b6830f6d Peter Hurley 2015-06-27  423  static int serial8250_default_handle_irq(struct uart_port *port);

:::::: The code at line 420 was first introduced by commit
:::::: b6830f6df8914faae9561bb245860c21af9b9e9b serial: 8250: Split base port operations from universal driver

:::::: TO: Peter Hurley <peter@hurleysoftware.com>
:::::: CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 9380 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170207/f333a73d/attachment.gz>
