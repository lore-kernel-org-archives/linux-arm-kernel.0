From: matthew_minter@xyratex.com (Matthew Minter)
Date: Mon, 21 Oct 2013 15:59:16 +0100
Subject: Armada XP Internal registers
In-Reply-To: <CAFJTrDtznkpwi76yyEKYvjuo+XV34ky9AOe8Qfa5wm-uHDJT6A@mail.gmail.com>
References: <CAFJTrDtznkpwi76yyEKYvjuo+XV34ky9AOe8Qfa5wm-uHDJT6A@mail.gmail.com>
Message-ID: <CAFJTrDuc_dmfzK+4vw2k0PawUM1=iSZVotG1P3CAQi=u25=LLQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In amendment to before, I missed a small factual detail, to cause a
successful boot I do have to specify a boot console (ttys0) just not
specify a baud rate. for example "console=ttyS0" as opposed to
"console=ttyS0,115200" to cause it to boot, but even then no boot
command line works.

On 21 October 2013 15:47, Matthew Minter <matthew_minter@xyratex.com> wrote:
> I recently had to upgrade the boot loader on my Armada XP GP board (as
> I could not get the sources for the old version, only the binaries for
> the SPI flash version and needed to build a bootloader to boot from
> NAND flash).
>
> After upgrading I experienced a number of problems on both the mvebu tree and
> Ezequiel Garcia's v2 NAND develoment tree (here
> https://github.com/MISL-EBU-System-SW/mainline-public/tree/l2-mtd/upstream-nand-v2)
> (which otherwise runs really well, so thanks)
>
> However I do not think it is the fault of either kernel. Specifically
> it seems the new bootloader is sticking the internal registers at
> 0xf1000000 instead of 0xd0000000. Specifically this was causing the
> kernel to oops and then panic when trying to init the IRQ or serial
> uart.
>
> It seems that changing the armada-xp-gp device tree to read:
>         soc {
>                 ranges = <MBUS_ID(0xf0, 0x01) 0 0 0xf1000000 0x100000
>                           MBUS_ID(0x01, 0x1d) 0 0 0xfff00000 0x100000
>                           MBUS_ID(0x01, 0x2f) 0 0 0xf0000000 0x1000000>;
>
>
> instead of:
>         soc {
>                 ranges = <MBUS_ID(0xf0, 0x01) 0 0 0xd0000000 0x100000
>                           MBUS_ID(0x01, 0x1d) 0 0 0xfff00000 0x100000
>                           MBUS_ID(0x01, 0x2f) 0 0 0xf0000000 0x1000000>;
>
> causes the chip to get further in boot, however at this point I found
> another issue. The kernel was experiencing another oops (which was
> killing either init or the idle process) due to an error "Unhandled
> fault: external abort on non-linefetch (0x808) at 0xf0144010"
>
> I again managed to get past this by not configuring the serial port on
> the kernel command line however this has the significant drawback that
> I do not get any messages from the kernel or my init system over
> serial and the terminal remains blank until a getty eventually spawns.
> This makes other boot issues hard to debug.
>
> I am not completely sure if this is a boot-loader issue, a kernel
> issue or my own misconfiguration. However I can make the chip boot so
> it is not too urgent, just introduces annoying limitations.
>
> If anyone has any ideas on this I would be very grateful, best regards,
> Matthew

-- 


------------------------------
For additional information including the registered office and the treatment of Xyratex confidential information please visit www.xyratex.com

------------------------------
