From: hunold@linuxtv.org (Michael Hunold)
Date: Mon, 05 Mar 2012 12:34:09 +0100
Subject: iMX53 quick start board and SATA
In-Reply-To: <20120304083258.GE10743@S2101-09.ap.freescale.net>
References: <4F50C734.90302@linuxtv.org>
 <20120304083258.GE10743@S2101-09.ap.freescale.net>
Message-ID: <4F54A4B1.5000807@linuxtv.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Shawn,

on 04.03.2012 09:33 Shawn Guo said the following:
> I think with the following patches in Linux 3.2, the i.MX53 SATA
> support should be there, though I never played with it.

> 904c04f [libata] ahci_platform: Add the board_ids and pi refer to different features
> d870ea1 MX53 Enable the AHCI SATA on MX53 SMD board
> 0661b82 MX53 Enable the AHCI SATA on MX53 LOCO board
> e97e303 MX53 Enable the AHCI SATA on MX53 ARD board
> 97915bd AHCI Add the AHCI SATA feature on the MX53 platforms

thank you very much for your answer.

I checked that the code is present in the kernel tree that I have used
and indeed it is.

After further investigation, I could see that imx53_add_ahci_imx() is
called correctly, but then imx_sata_init() was not called. This means
that the platform driver was not present.

I noticed that the AHCI platform driver in drivers/ata/ahci_platform.c
is only compiled when CONFIG_SATA_AHCI_PLATFORM=y is set and this was
not the case when the default config was used.

After enabling the necessary config option, the SATA port is now found
correctly:

ahci: SSS flag set, parallel bus scan disabled
ahci imx53-ahci.0: AHCI 0001.0100 32 slots 1 ports 3 Gbps 0x1 impl
platform mode
ahci imx53-ahci.0: flags: ncq sntf stag pm led clo only pmp pio slum
part ccc
scsi0 : ahci_platform
ata1: SATA max UDMA/133 mmio [mem 0x10000000-0x10000fff] port 0x100 irq 28

Probably it would be a good idea to unconditionally select
CONFIG_SATA_AHCI_PLATFORM when MACH_MX53_LOCO is selected.

Best regards
Michael.
