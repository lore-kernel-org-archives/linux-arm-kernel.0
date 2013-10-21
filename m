From: matthew_minter@xyratex.com (Matthew Minter)
Date: Mon, 21 Oct 2013 15:47:43 +0100
Subject: Armada XP Internal registers
Message-ID: <CAFJTrDtznkpwi76yyEKYvjuo+XV34ky9AOe8Qfa5wm-uHDJT6A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I recently had to upgrade the boot loader on my Armada XP GP board (as
I could not get the sources for the old version, only the binaries for
the SPI flash version and needed to build a bootloader to boot from
NAND flash).

After upgrading I experienced a number of problems on both the mvebu tree and
Ezequiel Garcia's v2 NAND develoment tree (here
https://github.com/MISL-EBU-System-SW/mainline-public/tree/l2-mtd/upstream-nand-v2)
(which otherwise runs really well, so thanks)

However I do not think it is the fault of either kernel. Specifically
it seems the new bootloader is sticking the internal registers at
0xf1000000 instead of 0xd0000000. Specifically this was causing the
kernel to oops and then panic when trying to init the IRQ or serial
uart.

It seems that changing the armada-xp-gp device tree to read:
        soc {
                ranges = <MBUS_ID(0xf0, 0x01) 0 0 0xf1000000 0x100000
                          MBUS_ID(0x01, 0x1d) 0 0 0xfff00000 0x100000
                          MBUS_ID(0x01, 0x2f) 0 0 0xf0000000 0x1000000>;


instead of:
        soc {
                ranges = <MBUS_ID(0xf0, 0x01) 0 0 0xd0000000 0x100000
                          MBUS_ID(0x01, 0x1d) 0 0 0xfff00000 0x100000
                          MBUS_ID(0x01, 0x2f) 0 0 0xf0000000 0x1000000>;

causes the chip to get further in boot, however at this point I found
another issue. The kernel was experiencing another oops (which was
killing either init or the idle process) due to an error "Unhandled
fault: external abort on non-linefetch (0x808) at 0xf0144010"

I again managed to get past this by not configuring the serial port on
the kernel command line however this has the significant drawback that
I do not get any messages from the kernel or my init system over
serial and the terminal remains blank until a getty eventually spawns.
This makes other boot issues hard to debug.

I am not completely sure if this is a boot-loader issue, a kernel
issue or my own misconfiguration. However I can make the chip boot so
it is not too urgent, just introduces annoying limitations.

If anyone has any ideas on this I would be very grateful, best regards,
Matthew

-- 


------------------------------
For additional information including the registered office and the treatment of Xyratex confidential information please visit www.xyratex.com

------------------------------
