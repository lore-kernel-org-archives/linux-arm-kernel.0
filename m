From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 10 Dec 2015 16:06:10 +0100
Subject: [PATCH] i2c: allow building emev2 without slave mode again
In-Reply-To: <201512102224.cVm7Hcp0%fengguang.wu@intel.com>
References: <201512102224.cVm7Hcp0%fengguang.wu@intel.com>
Message-ID: <2592093.cGKEcKVqLU@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 10 December 2015 22:54:25 kbuild test robot wrote:
> 
>    In file included from arch/x86/include/asm/realmode.h:5:0,
>                     from arch/x86/include/asm/acpi.h:33,
>                     from arch/x86/include/asm/fixmap.h:19,
>                     from arch/x86/include/asm/apic.h:12,
>                     from arch/x86/include/asm/smp.h:12,
>                     from arch/x86/include/asm/mmzone_64.h:10,
>                     from arch/x86/include/asm/mmzone.h:4,
>                     from include/linux/mmzone.h:856,
>                     from include/linux/gfp.h:5,
>                     from include/linux/device.h:29,
>                     from drivers/i2c/busses/i2c-emev2.c:15:
>    drivers/i2c/busses/i2c-emev2.c: In function 'em_i2c_irq_handler':
> >> arch/x86/include/asm/io.h:53:3: warning: 'value' may be used uninitialized in this function [-Wmaybe-uninitialized]
>     { asm volatile("mov" size " %0,%1": :reg (val), \
>       ^
>    drivers/i2c/busses/i2c-emev2.c:232:13: note: 'value' was declared here
>      u8 status, value;
>                 ^

The warning was indeed introduced by my change, but I think there
was a preexisting issue:

The slave_cb callback function is supposed to set the 'value'
here, but it might return an error not assign the pointer, which
is something that both the rcar and the emev2 drivers do not handle
correctly.

It might be best to change the callback to return 'void' and not
allow it to fail. At least the eeprom slave cannot fail anyway,
and it is the only implementation we have at the moment.
The inline function would then have to be changed to initialize
the 'value'.

Alternatively, the  inline could return an error, and both bus
drivers check for the error before using 'value'.

	Arnd
