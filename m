From: armlinux@emagii.com (ARM Linux)
Date: Sun, 26 Feb 2012 18:37:25 +0100
Subject: AT91: How copy kernel code to SRAM and execute?
Message-ID: <4F4A6DD5.5040606@emagii.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I am looking for some examples on how to copy a small piece of kernel code
to internal SRAM and then execute it.

Why?
If you want to restart, you execute the "/sbin/reboot" command
which will eventually call the "arch_reset" function, which in the AT91
case will write to a "user reset" register.

The problem is that the chip may reset in the middle of an SDRAM read 
transfer.
The SDRAM will see it's clock stopped and will continue to drive the bus.

When the ROM bootloader tries to access any boot memory (Parallel flash 
or NAND flash)
on the parallel bus, there will be a bus conflict between the boot 
memory and the SDRAM,
and the bootROM will not properly detect the boot program, and will enter
an In System Programming mode.

This is described in the SAM9G20 datasheet, but is probably valid
for all older generation AT91 devices as well.

The workaround seems to be to turn off the SDRAM and then do the reset.
Obviously you cannot read instructions from SDRAM after it has been 
turned off.

One possible workaround is to copy the code to SRAM and then execute.


Looking for some hints on how first copy the code to the internal SRAM 
located at 0x300000,
and then jump and execute the code at this address.

Note that when arch_reset is called, the CPU is no longer executing
in its normal state.
It is called from arm_machine_restart in "arch/arm/kernel/process.c"
which has turned off the caches and setup some direct mapping at lower 
addresses

-- 

Best Regards
Ulf Samuelsson
ulf at emagii.com
+46 722 427437
