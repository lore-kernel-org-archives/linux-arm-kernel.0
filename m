From: ipaton0@gmail.com (Iain Paton)
Date: Wed, 27 Aug 2014 11:43:21 +0100
Subject: Oops: 17 SMP ARM (v3.16-rc2)
In-Reply-To: <C4A61A5CA4AD2246942F4BA6F20ACB8043578CB2@ALVA-EXMB04.alv.autoliv.int>
References: <20140626151424.GT32514@n2100.arm.linux.org.uk>
 <20140806125550.GO30282@n2100.arm.linux.org.uk>
 <C4A61A5CA4AD2246942F4BA6F20ACB804357526C@ALVA-EXMB04.alv.autoliv.int>
 <20140807121248.GY30282@n2100.arm.linux.org.uk>
 <20140808180900.GG30282@n2100.arm.linux.org.uk>
 <C4A61A5CA4AD2246942F4BA6F20ACB8043576356@ALVA-EXMB04.alv.autoliv.int>
 <CAOMZO5B8GR+ABBoJ=dJcFqw3Wagfaip7HM+C1FTz+aE4CmqiPw@mail.gmail.com>
 <C4A61A5CA4AD2246942F4BA6F20ACB80435776D3@ALVA-EXMB04.alv.autoliv.int>
 <CAOMZO5B7FgzB7ThVyV2Vk7wTwYgjRWjEnkkAN5uwwKMaBKq1yg@mail.gmail.com>
 <C4A61A5CA4AD2246942F4BA6F20ACB8043577770@ALVA-EXMB04.alv.autoliv.int>
 <53F11FF6.8030303@gmail.com>
 <CAOMZO5CDvQDD7gVLFStwv4MPrUyqZE3sEDZwb0gukkXujYG-6Q@mail.gmail.com>
 <53F2E89B.80009@gmail.com> <53F5BE3D.5070209@gmail.com>
 <CAOMZO5A3CgaVCKxNDG-zEdwprYdRDXD_XZ2ikW+mns-iieYHsg@mail.gmail.com>
 <53F71D1B.8090004@gmail.com>
 <C4A61A5CA4AD2246942F4BA6F20ACB8043578CB2@ALVA-EXMB04.alv.autoliv.int>
Message-ID: <53FDB649.2070506@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27/08/14 07:32, Mattis Lorentzon wrote:
> Hi Iain, Russell and Fabio,
> 
>> The config is attached. Note that there's a lot of additional stuff enabled as
>> I'm aiming for a single general purpose kernel that covers i.MX6, AM3359,
>> Allwinner A10/A20 along with several versions of boards using those
>> particular SoCs.
>>
>> Same kernel binary on all the boards I've tried this on, only real differences
>> will be the devicetree and u-boot
> 
> Amazingly we have been able to run a complete nightly test on eight i.MX6
> boards without hickups using Iain's config! We had to modify it slightly to get
> it to boot, please find attached patch and Iain's patched config.

Interesting. We obviously have some differences in how we boot, my changes to 
your config to get it to boot basically amount to reverting the patch you attached 
and then enabling sata and mmc. So far I've been unable to get your config to fail.

I'm attaching the patch showing what I changed in case it sheds any light on 
what's going on, although I don't see why any of the changes make any difference.

My kernel command line is also fairly obvious with nothing I'd think is odd:
console=ttymxc1,115200n8 root=/dev/sda1 ro rootfstype=ext2 rootwait video= ahci-imx.hotplug=1

It would be good to know what makes my config work for you, I don't think I've 
done anything special with it.

Iain

-------------- next part --------------
3c3
< # Linux/arm 3.16.0 Kernel Configuration
---
> # Linux/arm 3.16.0-rc2 Kernel Configuration
38c38
< CONFIG_KERNEL_GZIP=y
---
> # CONFIG_KERNEL_GZIP is not set
41c41
< # CONFIG_KERNEL_LZO is not set
---
> CONFIG_KERNEL_LZO=y
233,239c233
< CONFIG_PARTITION_ADVANCED=y
< # CONFIG_ACORN_PARTITION is not set
< # CONFIG_AIX_PARTITION is not set
< # CONFIG_OSF_PARTITION is not set
< # CONFIG_AMIGA_PARTITION is not set
< # CONFIG_ATARI_PARTITION is not set
< # CONFIG_MAC_PARTITION is not set
---
> # CONFIG_PARTITION_ADVANCED is not set
241,249d234
< # CONFIG_BSD_DISKLABEL is not set
< # CONFIG_MINIX_SUBPARTITION is not set
< # CONFIG_SOLARIS_X86_PARTITION is not set
< # CONFIG_UNIXWARE_DISKLABEL is not set
< # CONFIG_LDM_PARTITION is not set
< # CONFIG_SGI_PARTITION is not set
< # CONFIG_ULTRIX_PARTITION is not set
< # CONFIG_SUN_PARTITION is not set
< # CONFIG_KARMA_PARTITION is not set
251,252d235
< # CONFIG_SYSV68_PARTITION is not set
< # CONFIG_CMDLINE_PARTITION is not set
265,266d247
< CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
< CONFIG_RWSEM_SPIN_ON_OWNER=y
533,534c514,521
< # CONFIG_ARM_APPENDED_DTB is not set
< CONFIG_CMDLINE=""
---
> CONFIG_ARM_APPENDED_DTB=y
> CONFIG_ARM_ATAG_DTB_COMPAT=y
> CONFIG_ARM_ATAG_DTB_COMPAT_CMDLINE_FROM_BOOTLOADER=y
> # CONFIG_ARM_ATAG_DTB_COMPAT_CMDLINE_EXTEND is not set
> CONFIG_CMDLINE="___console=ttymxc0,115200 ___debug ___LOGLEVEL=8 ___initrd=0x11800040,12383491 ___dyndbg=\"file * +p\""
> CONFIG_CMDLINE_FROM_BOOTLOADER=y
> # CONFIG_CMDLINE_EXTEND is not set
> # CONFIG_CMDLINE_FORCE is not set
591c578
< # CONFIG_PM_TEST_SUSPEND is not set
---
> CONFIG_PM_TEST_SUSPEND=y
919d905
< CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
920a907
> CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
1045,1059c1032
< CONFIG_ATA=y
< # CONFIG_ATA_NONSTANDARD is not set
< CONFIG_ATA_VERBOSE_ERROR=y
< CONFIG_SATA_PMP=y
< 
< #
< # Controllers with non-SFF native interface
< #
< CONFIG_SATA_AHCI=y
< CONFIG_SATA_AHCI_PLATFORM=y
< CONFIG_AHCI_IMX=y
< # CONFIG_SATA_INIC162X is not set
< # CONFIG_SATA_ACARD_AHCI is not set
< # CONFIG_SATA_SIL24 is not set
< # CONFIG_ATA_SFF is not set
---
> # CONFIG_ATA is not set
1786,1815c1759
< CONFIG_MMC=y
< # CONFIG_MMC_DEBUG is not set
< # CONFIG_MMC_CLKGATE is not set
< 
< #
< # MMC/SD/SDIO Card Drivers
< #
< CONFIG_MMC_BLOCK=y
< CONFIG_MMC_BLOCK_MINORS=8
< CONFIG_MMC_BLOCK_BOUNCE=y
< # CONFIG_SDIO_UART is not set
< # CONFIG_MMC_TEST is not set
< 
< #
< # MMC/SD/SDIO Host Controller Drivers
< #
< CONFIG_MMC_SDHCI=y
< CONFIG_MMC_SDHCI_IO_ACCESSORS=y
< # CONFIG_MMC_SDHCI_PCI is not set
< CONFIG_MMC_SDHCI_PLTFM=y
< # CONFIG_MMC_SDHCI_OF_ARASAN is not set
< CONFIG_MMC_SDHCI_ESDHC_IMX=y
< # CONFIG_MMC_SDHCI_PXAV3 is not set
< # CONFIG_MMC_SDHCI_PXAV2 is not set
< # CONFIG_MMC_MXC is not set
< # CONFIG_MMC_TIFM_SD is not set
< # CONFIG_MMC_CB710 is not set
< # CONFIG_MMC_VIA_SDMMC is not set
< # CONFIG_MMC_DW is not set
< # CONFIG_MMC_USDHI6ROL0 is not set
---
> # CONFIG_MMC is not set
1968d1911
< # CONFIG_WIMAX_GDM72XX is not set
