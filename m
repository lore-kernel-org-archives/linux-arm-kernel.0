From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 20 Mar 2015 09:19:10 +0100
Subject: XIP_KERNEL and !ARCH_MULTIPLATFORM
In-Reply-To: <HK2PR06MB05611C6D6CED1E32F4617D158A010@HK2PR06MB0561.apcprd06.prod.outlook.com>
References: <HK2PR06MB0561CC16649A9C1F341CC6648A030@HK2PR06MB0561.apcprd06.prod.outlook.com>
 <CAMuHMdUR3oLp3RMcdEkMiqX92bosYE=f8tOKA1L_y59KMPuEJw@mail.gmail.com>
 <HK2PR06MB05613B2FBF8466204FA98A9D8A030@HK2PR06MB0561.apcprd06.prod.outlook.com>
 <CAMuHMdU3J1uzD5VAgHgF5NNzw_E7Njf7wU7kJ7oPuCKm7N_Arg@mail.gmail.com>
 <HK2PR06MB0561FE47407CA32AA8DDEFCF8A030@HK2PR06MB0561.apcprd06.prod.outlook.com>
 <CAMuHMdUS84s=uLYVk8BtRoKFmBzw7aT1eQCfGF1nx22hTqf15A@mail.gmail.com>
 <HK2PR06MB05611C6D6CED1E32F4617D158A010@HK2PR06MB0561.apcprd06.prod.outlook.com>
Message-ID: <20150320081910.GF10068@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 19, 2015 at 08:57:21PM +0000, Chris Brandt wrote:
> Eventually....I got it to boot.
> 
> I had to remove both CONFIG_HIGHMEM and CONFIG_SMP and then I could boot completely from ROM (which for me is external QSPI flash that is memory mapping into linear CPU space at address 0x18000000)
> 
> So, the total changes was:
> 
> 1. start with shmobile_defconfig
> 2. remove all architectures but RZ/A1 (ARCH_R7S72100)
> 3. remove !ARCH_MULTIPLATFORM from XIP_KERNEL's dependencies
> 4. modify  'select ARM_PATCH_PHYS_VIRT if !XIP_KERNEL'  in PHYS_OFFSET (because I need to be able to set PHYS_OFFSET)
> 5. patch up mmu.c, proc-v7.S and link-vmlinux.sh
> 6. remove CONFIG_HIGHMEM and CONFIG_SMP
> 
> I also modified the DT to use internal RAM instead external SDRAM.
> 
> Of course to actually boot an XIP kernel, you have to make a custom command in u-boot (using bootm or go is not going to work).
It should. I remember that you need to pass something unintuitive to
mkimage (to not say buggy). See
http://lists.denx.de/pipermail/u-boot/2007-March/020171.html for my try
to fix that back when I still cared about U-Boot.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
