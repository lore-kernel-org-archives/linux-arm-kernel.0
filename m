From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Mon, 30 Mar 2015 14:05:33 +0200
Subject: ARM, earlyconsole and io mapping
Message-ID: <87iodivgfm.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I was wondering how the earlyconsole was supposed to work in order to add
support to the pxa architecture. More specifically, I don't understand how the
memory mapping is supposed to be available at the early parameters parsing.

The thing I don't understand is that :
 - in kernel initialization, parse_early_param() is called before
   machine_desc->map_io()
 - as a consequence, the architecture didn't add the vm early mapping for serial
   peripheral (which is added in pxa_map_io())
 - as a consequence, earlycon_map() will fail to map the serial MMIO
   (as in stack showed in [1])

Therefore, are there non-DT earlycon users on the list, and could they tell me
what way they get earlycon support in their arm boards please ?

Cheers.

-- 
Robert

[1] Call stack
#0  __arm_ioremap_pfn_caller (pfn=262400, offset=0, size=64, mtype=0, caller=0xc041d66c) at arch/arm/mm/ioremap.c:260
#1  0xc0015d34 in __arm_ioremap_caller (phys_addr=<value optimized out>, size=<value optimized out>, mtype=0, caller=<value optimized out>) at arch/arm/mm/ioremap.c:354
#2  0xc0015868 in __arm_ioremap (phys_addr=<value optimized out>, size=<value optimized out>, mtype=<value optimized out>) at arch/arm/mm/ioremap.c:383
#3  0xc041d66c in earlycon_map (buf=0x0, match=0x0, setup=0x40) at drivers/tty/serial/earlycon.c:48
#4  setup_earlycon (buf=0x0, match=0x0, setup=0x40) at drivers/tty/serial/earlycon.c:138
#5  0xc040a52c in do_early_param (param=0xc0424bf6 "earlycon", val=0xc0424bff "pxa,mmio,0x40100000,115200n8", unused=<value optimized out>) at init/main.c:420
#6  0xc00306bc in parse_one (doing=0xc0393668 "early options", args=0xc0424c1b "", params=<value optimized out>, num=<value optimized out>, min_level=0, max_level=0, unknown=0) at kernel/params.c:131
#7  parse_args (doing=0xc0393668 "early options", args=0xc0424c1b "", params=<value optimized out>, num=<value optimized out>, min_level=0, max_level=0, unknown=0) at kernel/params.c:216
#8  0xc040a854 in parse_early_options (cmdline=<value optimized out>) at init/main.c:430
#9  0xc040a890 in parse_early_param () at init/main.c:444
#10 0xc040d950 in setup_arch (cmdline_p=0xc07f3fd4) at arch/arm/kernel/setup.c:922
#11 0xc040a918 in start_kernel () at init/main.c:520
  => Here get_vm_area_caller() will fail in __arm_ioremap_pfn_caller().
