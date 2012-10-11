From: ivan.shugov@gmail.com (Ivan Shugov)
Date: Thu, 11 Oct 2012 22:43:05 +0300
Subject: [PATCH] SoC: AT91: at91sam9g10ek: Impossible to detect the SOC type
Message-ID: <CAFNb0utyQO6yC-VMmeXA3mktU699Fu4sE8nFd6zJ+oz3e_qZYw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi! I'm working on a custom board based on at91sam9g10ek, so the same
port of linux kernel is used.

Linux kernel version: 3.6.1

Problem: SoC for at91sam9g10 device can't be detected, so the kernel can't
boot.

Reason: 'cidr' register in 'static void __init soc_detect(u32 dbgu_base)'
 from 'arch/arm/mach-at91/setup.c' at line '154' is checked for
ARCH_ID_AT91SAM9G10 coincidence, before masking AT91_CIDR_VERSION bit. So
the console output with earlyprintk enabled is:

//================================================

Linux version 3.6.1 (user-0 at debian-OS) (gcc version 4.5.2 (Sourcery
G++ Lite 2011.03-42) ) #10 Wed Oct 10 15:02:35 EDT 2012

CPU: ARM926EJ-S [41069265] revision 5 (ARMv5TEJ), cr=00053177

CPU: VIVT data cache, VIVT instruction cache

Machine: Atmel AT91SAM9G10-EK

Ignoring tag cmdline (using the default kernel command line)

bootconsole [earlycon0] enabled

Memory policy: ECC disabled, Data cache writeback

Kernel panic - not syncing: AT91: Impossible to detect the SOC type

[<c00133d4>] (unwind_backtrace+0x0/0xe0) from [<c02366dc>]
(panic+0x78/0x1cc)

[<c02366dc>] (panic+0x78/0x1cc) from [<c02fa35c>] (at91_map_io+0x90/0xc8)

[<c02fa35c>] (at91_map_io+0x90/0xc8) from [<c02f9860>]
(paging_init+0x564/0x6d0)

[<c02f9860>] (paging_init+0x564/0x6d0) from [<c02f7914>]
(setup_arch+0x464/0x704)

[<c02f7914>] (setup_arch+0x464/0x704) from [<c02f44f8>]
(start_kernel+0x6c/0x2d4)

[<c02f44f8>] (start_kernel+0x6c/0x2d4) from [<20008040>] (0x20008040)

//================================================

Solution: replace 'cidr' with 'socid'

//================================================

--- a/arch/arm/mach-at91/setup.c 2012-10-07 11:41:28.000000000 -0400
+++ b/arch/arm/mach-at91/setup.c 2012-10-11 15:41:48.000000000 -0400
@@ -151,7 +151,7 @@ static void __init soc_detect(u32 dbgu_b
  }

  /* at91sam9g10 */
- if ((cidr & ~AT91_CIDR_EXT) == ARCH_ID_AT91SAM9G10) {
+ if ((socid & ~AT91_CIDR_EXT) == ARCH_ID_AT91SAM9G10) {
  at91_soc_initdata.type = AT91_SOC_SAM9G10;
  at91_boot_soc = at91sam9261_soc;
  }

//================================================

Best regards, Ivan Shugov
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121011/e04e964b/attachment-0001.html>
