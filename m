From: Chris.Brandt@renesas.com (Chris Brandt)
Date: Thu, 19 Mar 2015 20:57:21 +0000
Subject: XIP_KERNEL and !ARCH_MULTIPLATFORM
References: <HK2PR06MB0561CC16649A9C1F341CC6648A030@HK2PR06MB0561.apcprd06.prod.outlook.com>
 <CAMuHMdUR3oLp3RMcdEkMiqX92bosYE=f8tOKA1L_y59KMPuEJw@mail.gmail.com>
 <HK2PR06MB05613B2FBF8466204FA98A9D8A030@HK2PR06MB0561.apcprd06.prod.outlook.com>
 <CAMuHMdU3J1uzD5VAgHgF5NNzw_E7Njf7wU7kJ7oPuCKm7N_Arg@mail.gmail.com>
 <HK2PR06MB0561FE47407CA32AA8DDEFCF8A030@HK2PR06MB0561.apcprd06.prod.outlook.com>
 <CAMuHMdUS84s=uLYVk8BtRoKFmBzw7aT1eQCfGF1nx22hTqf15A@mail.gmail.com>
Message-ID: <HK2PR06MB05611C6D6CED1E32F4617D158A010@HK2PR06MB0561.apcprd06.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Eventually....I got it to boot.

I had to remove both CONFIG_HIGHMEM and CONFIG_SMP and then I could boot completely from ROM (which for me is external QSPI flash that is memory mapping into linear CPU space at address 0x18000000)

So, the total changes was:

1. start with shmobile_defconfig
2. remove all architectures but RZ/A1 (ARCH_R7S72100)
3. remove !ARCH_MULTIPLATFORM from XIP_KERNEL's dependencies
4. modify  'select ARM_PATCH_PHYS_VIRT if !XIP_KERNEL'  in PHYS_OFFSET (because I need to be able to set PHYS_OFFSET)
5. patch up mmu.c, proc-v7.S and link-vmlinux.sh
6. remove CONFIG_HIGHMEM and CONFIG_SMP

I also modified the DT to use internal RAM instead external SDRAM.

Of course to actually boot an XIP kernel, you have to make a custom command in u-boot (using bootm or go is not going to work).


Generally this exercise has taught me that  XIP and ARCH_MULTIPLATFORM do not play well together.

So while I think linux-4.0 will have the ability to run XIP with and ARMv7 (with a handful of patches), you'll definitely need to start with an out of tree config.

Chris
