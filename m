From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Mon, 27 Jun 2011 16:53:06 +0400
Subject: Problem with GDB when debugging IRQ handlers
Message-ID: <20110627125306.GA30646@doriath.ww600.siemens.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello, colleagues,

I've got into a problem when trying to debug irq handlers on PXA (in
qemu). backtrace is really strange from my POV (a target is just a qemu
running a bit modified 3.0-rc2 kernel):

arm-linux-gnueabi-gdb vmlinux
GNU gdb (GDB) 7.2-debian
Copyright (C) 2010 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.  Type "show copying"
and "show warranty" for details.
This GDB was configured as "--host=i486-linux-gnu --target=arm-linux-gnueabi".
For bug reporting instructions, please see:
<http://www.gnu.org/software/gdb/bugs/>...
Reading symbols from vmlinux...done.
(gdb) target localhost:1234
Undefined target command: "localhost:1234".  Try "help target".
(gdb) target remote:1234
break handle_Remote debugging using :1234
0xa0000000 in ?? ()
(gdb) break handle_level_irq
Breakpoint 1 at 0xc008811c: file kernel/irq/chip.c, line 329.
(gdb) cont
Continuing.

Breakpoint 1, handle_level_irq (irq=42, desc=0xc3e06000) at kernel/irq/chip.c:329
329		mask_ack_irq(desc);
(gdb) bt
#0  handle_level_irq (irq=42, desc=0xc3e06000) at kernel/irq/chip.c:329
#1  0xc0085f64 in generic_handle_irq_desc (irq=42) at include/linux/irqdesc.h:111
#2  generic_handle_irq (irq=42) at kernel/irq/irqdesc.c:304
#3  0xc0033060 in asm_do_IRQ (irq=42, regs=<value optimized out>) at arch/arm/kernel/irq.c:90
#4  0xc0033b50 in __irq_svc () at arch/arm/kernel/entry-armv.S:202
#5  0xc0033b50 in __irq_svc () at arch/arm/kernel/entry-armv.S:202
#6  0xc0033b50 in __irq_svc () at arch/arm/kernel/entry-armv.S:202
#7  0xc0033b50 in __irq_svc () at arch/arm/kernel/entry-armv.S:202
#8  0xc0033b50 in __irq_svc () at arch/arm/kernel/entry-armv.S:202
#9  0xc0033b50 in __irq_svc () at arch/arm/kernel/entry-armv.S:202
#10 0xc0033b50 in __irq_svc () at arch/arm/kernel/entry-armv.S:202
#11 0xc0033b50 in __irq_svc () at arch/arm/kernel/entry-armv.S:202
#12 0xc0033b50 in __irq_svc () at arch/arm/kernel/entry-armv.S:202

... and so on it continues ad infinitum. Is it the expected behaviour?
Because I'm pretty much sure that this isn't a desired behaviour.

-- 
With best wishes
Dmitry
