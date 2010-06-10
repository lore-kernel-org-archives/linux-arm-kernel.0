From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 10 Jun 2010 11:00:15 +0200
Subject: [PATCH 4/5] [ARM] Auto calculate ZRELADDR and provide option
	for exceptions
In-Reply-To: <1275550613-9553-5-git-send-email-eric.miao@canonical.com>
References: <1275550613-9553-1-git-send-email-eric.miao@canonical.com>
	<1275550613-9553-5-git-send-email-eric.miao@canonical.com>
Message-ID: <20100610090015.GD3422@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 03, 2010 at 03:36:52PM +0800, Eric Miao wrote:
> From: Eric Miao <eric.y.miao@gmail.com>
> 
> Original idea and prototype came from Nicolas Pitre.
> 
> As long as the zImage is placed within the 256MB range from the
> start of the memory, ZRELADDR (Address where the decompressed
> kernel will be placed, usually  == PHYS_OFFSET + TEXT_OFFSET)
s/  / /

> can be determined at run-time by masking PC with 0xf000_0000.
> 
> Running through all the Makefile.boot, all those zreladdr-y
> address == 0x[0-f]000_0000 + TEXT_OFFSET can be determined at
> run-time.
> 
> Option CONFIG_AUTO_ZRELADDR and CONFIG_ZRELADDR are introduced,
> CONFIG_ZRELADDR _must_ be explicitly specified if:
> 
>  - ((zreladdr-y - TEXT_OFFSET) & ~0xf0000000) != 0, which means
>    a maksing of PC with 0xf000_0000 will result an incorrect
s/maksing of/masking/ (note: there are 2 changes)

>    address.
> 
>  - or the assumption of the zImage being loaded by the boot
>    loader within 256MB from the start address is simply
>    incorrect
Hmmm, this makes the image depending on the bootloader.  Not that nice.

>  - or when ZBOOT_ROM is used, where the above assumption is
>    normally wrong
So guess based on sp :-)

> List of all Makefile.boot:
> 
> Hardcoded, and can be auto calculated by masking PC with 0xf000_0000:
> 
> arch/arm/mach-cns3xxx/Makefile.boot:	   zreladdr-y	:= 0x00008000
> arch/arm/mach-dove/Makefile.boot:	   zreladdr-y	:= 0x00008000
> arch/arm/mach-ebsa110/Makefile.boot:	   zreladdr-y	:= 0x00008000
> arch/arm/mach-footbridge/Makefile.boot:	   zreladdr-y	:= 0x00008000
> arch/arm/mach-integrator/Makefile.boot:	   zreladdr-y	:= 0x00008000
> arch/arm/mach-iop13xx/Makefile.boot:	   zreladdr-y   := 0x00008000
> arch/arm/mach-iop33x/Makefile.boot:	   zreladdr-y	:= 0x00008000
> arch/arm/mach-ixp2000/Makefile.boot:	   zreladdr-y	:= 0x00008000
> arch/arm/mach-ixp23xx/Makefile.boot:	   zreladdr-y	:= 0x00008000
> arch/arm/mach-ixp4xx/Makefile.boot:	   zreladdr-y	:= 0x00008000
> arch/arm/mach-kirkwood/Makefile.boot:	   zreladdr-y	:= 0x00008000
> arch/arm/mach-ks8695/Makefile.boot:	   zreladdr-y	:= 0x00008000
> arch/arm/mach-loki/Makefile.boot:	   zreladdr-y	:= 0x00008000
> arch/arm/mach-mmp/Makefile.boot:	   zreladdr-y	:= 0x00008000
> arch/arm/mach-mv78xx0/Makefile.boot:	   zreladdr-y	:= 0x00008000
> arch/arm/mach-nomadik/Makefile.boot:	   zreladdr-y	:= 0x00008000
> arch/arm/mach-nuc93x/Makefile.boot:	   zreladdr-y	:= 0x00008000
> arch/arm/mach-ns9xxx/Makefile.boot:	   zreladdr-y	:= 0x8000
> arch/arm/mach-orion5x/Makefile.boot:	   zreladdr-y	:= 0x00008000
> arch/arm/mach-spear3xx/Makefile.boot:      zreladdr-y	:= 0x00008000
> arch/arm/mach-spear6xx/Makefile.boot:      zreladdr-y	:= 0x00008000
> arch/arm/mach-ux500/Makefile.boot:	   zreladdr-y	:= 0x00008000
> arch/arm/mach-versatile/Makefile.boot:	   zreladdr-y	:= 0x00008000
> arch/arm/mach-w90x900/Makefile.boot:	   zreladdr-y	:= 0x00008000
> arch/arm/mach-msm/Makefile.boot:	   zreladdr-y	:= 0x10008000
> arch/arm/mach-omap1/Makefile.boot:	   zreladdr-y	:= 0x10008000
> arch/arm/mach-rpc/Makefile.boot:	   zreladdr-y	:= 0x10008000
> arch/arm/mach-s5p6440/Makefile.boot:	   zreladdr-y	:= 0x20008000
> arch/arm/mach-s5p6442/Makefile.boot:	   zreladdr-y	:= 0x20008000
> arch/arm/mach-s5pc100/Makefile.boot:	   zreladdr-y	:= 0x20008000
> arch/arm/mach-s5pv210/Makefile.boot:	   zreladdr-y	:= 0x20008000
> arch/arm/mach-s3c2410/Makefile.boot:	   zreladdr-y	:= 0x30008000
> arch/arm/mach-s3c2410/Makefile.boot:	   zreladdr-y	:= 0x30108000
> arch/arm/mach-stmp378x/Makefile.boot:	   zreladdr-y	:= 0x40008000
> arch/arm/mach-stmp37xx/Makefile.boot:	   zreladdr-y	:= 0x40008000
> arch/arm/mach-s3c64xx/Makefile.boot:	   zreladdr-y	:= 0x50008000
> arch/arm/mach-vexpress/Makefile.boot:	   zreladdr-y	:= 0x60008000
> arch/arm/mach-mx25/Makefile.boot:	   zreladdr-y	:= 0x80008000
> arch/arm/mach-mx3/Makefile.boot:	   zreladdr-y	:= 0x80008000
> arch/arm/mach-netx/Makefile.boot:	   zreladdr-y	:= 0x80008000
> arch/arm/mach-omap2/Makefile.boot:	   zreladdr-y	:= 0x80008000
> arch/arm/mach-pnx4008/Makefile.boot:	   zreladdr-y	:= 0x80008000
> arch/arm/mach-mx5/Makefile.boot:	   zreladdr-y	:= 0x90008000
> arch/arm/mach-mxc91231/Makefile.boot:	   zreladdr-y	:= 0x90008000
> arch/arm/mach-iop32x/Makefile.boot:	   zreladdr-y	:= 0xa0008000
> arch/arm/mach-pxa/Makefile.boot:	   zreladdr-y	:= 0xa0008000
> arch/arm/mach-lh7a40x/Makefile.boot:	   zreladdr-y	:= 0xc0008000
> arch/arm/mach-clps711x/Makefile.boot:	   zreladdr-y	:= 0xc0028000
> arch/arm/mach-aaec2000/Makefile.boot:	   zreladdr-y	:= 0xf0008000
> arch/arm/mach-l7200/Makefile.boot:	   zreladdr-y	:= 0xf0008000
> 
> Depends on other options/macros, but still can be auto calculated by
> masking PC with 0xf000_0000:
> 
> arch/arm/mach-bcmring/Makefile.boot:	   zreladdr-y   := $(CONFIG_BCM_ZRELADDR)
> * refer to arch/arm/configs/bcmring_defconfig:CONFIG_BCM_ZRELADDR=0x8000
> arch/arm/mach-h720x/Makefile.boot:	   zreladdr-$(CONFIG_ARCH_H720X) := 0x40008000
> arch/arm/mach-shmobile/Makefile.boot:	   zreladdr-y   := $(__ZRELADDR)
> * __ZRELADDR depends on CONFIG_MEMORY_START
> arch/arm/configs/ap4evb_defconfig:	CONFIG_MEMORY_START=0x40000000 (SH7372)
> arch/arm/configs/g3evm_defconfig:	CONFIG_MEMORY_START=0x50000000 (SH7367)
> arch/arm/configs/g4evm_defconfig:	CONFIG_MEMORY_START=0x40000000 (SH7377)
> 
> arch/arm/mach-at91/Makefile.boot:	   zreladdr-y	:= 0x70008000 (CONFIG_ARCH_AT91CAP9)
> arch/arm/mach-at91/Makefile.boot:	   zreladdr-y	:= 0x70008000 (CONFIG_ARCH_AT91SAM9G45)
> arch/arm/mach-at91/Makefile.boot:	   zreladdr-y	:= 0x20008000 (CONFIG_ARCH_AT91)
> arch/arm/mach-davinci/Makefile.boot:	   zreladdr-y	:= 0xc0008000 (CONFIG_ARCH_DAVINCI_DA8XX)
> arch/arm/mach-davinci/Makefile.boot:	   zreladdr-y	:= 0x80008000 (!CONFIG_ARCH_DAVINCI_DA8XX)
> arch/arm/mach-ep93xx/Makefile.boot:	   zreladdr-$(CONFIG_EP93XX_SDCE3_SYNC_PHYS_OFFSET)	:= 0x00008000
> arch/arm/mach-ep93xx/Makefile.boot:	   zreladdr-$(CONFIG_EP93XX_SDCE0_PHYS_OFFSET)		:= 0xc0008000
> arch/arm/mach-ep93xx/Makefile.boot:	   zreladdr-$(CONFIG_EP93XX_SDCE1_PHYS_OFFSET)		:= 0xd0008000
> arch/arm/mach-ep93xx/Makefile.boot:	   zreladdr-$(CONFIG_EP93XX_SDCE2_PHYS_OFFSET)		:= 0xe0008000
> arch/arm/mach-ep93xx/Makefile.boot:	   zreladdr-$(CONFIG_EP93XX_SDCE3_ASYNC_PHYS_OFFSET)	:= 0xf0008000
> arch/arm/mach-gemini/Makefile.boot:	   zreladdr-y	:= 0x00008000 (CONFIG_GEMINI_MEM_SWAP)
> arch/arm/mach-gemini/Makefile.boot:	   zreladdr-y	:= 0x10008000 (!CONFIG_GEMINI_MEM_SWAP)
> arch/arm/mach-mx2/Makefile.boot:	   zreladdr-$(CONFIG_MACH_MX21) := 0xC0008000
> arch/arm/mach-mx2/Makefile.boot:	   zreladdr-$(CONFIG_MACH_MX27) := 0xA0008000
> arch/arm/mach-realview/Makefile.boot:	   zreladdr-y	:= 0x70008000 (CONFIG_REALVIEW_HIGH_PHYS_OFFSET)
> arch/arm/mach-realview/Makefile.boot:	   zreladdr-y	:= 0x00008000 (CONFIG_REALVIEW_HIGH_PHYS_OFFSET)
> arch/arm/mach-sa1100/Makefile.boot:	   zreladdr-y	:= 0xc0008000
> arch/arm/mach-sa1100/Makefile.boot:	   zreladdr-$(CONFIG_SA1111) := 0xc0208000
> 
> Machines where ZRELADDR cannot be auto calcuated:
> 
> arch/arm/mach-mx1/Makefile.boot:	   zreladdr-y	:= 0x08008000
> arch/arm/mach-shark/Makefile.boot:	   zreladdr-y	:= 0x08008000
> arch/arm/mach-u300/Makefile.boot:	   zreladdr-y	:= 0x28E08000
> arch/arm/mach-u300/Makefile.boot:	   zreladdr-y	:= 0x48008000
I care about mx1, so I would prefer using 0xf8000000.

What do you think about requiring r4 to be set to physoffset as I did in
my series?  This way zImage would already know PHYSOFFSET and so didn't
need to guess ZRELADDR.  OK, until most bootloaders are fixed we need
to guess, too.  But at least this would provide a way to stop guessing
wrong for the affected platforms.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
