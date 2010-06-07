From: marek.vasut@gmail.com (Marek Vasut)
Date: Mon, 7 Jun 2010 17:12:20 +0200
Subject: [PATCH 4/5] [ARM] Auto calculate ZRELADDR and provide option for
	exceptions
In-Reply-To: <1275550613-9553-5-git-send-email-eric.miao@canonical.com>
References: <1275550613-9553-1-git-send-email-eric.miao@canonical.com>
	<1275550613-9553-5-git-send-email-eric.miao@canonical.com>
Message-ID: <201006071712.20888.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne ?t 3. ?ervna 2010 09:36:52 Eric Miao napsal(a):
> From: Eric Miao <eric.y.miao@gmail.com>
> 
> Original idea and prototype came from Nicolas Pitre.
> 
> As long as the zImage is placed within the 256MB range from the
> start of the memory, ZRELADDR (Address where the decompressed
> kernel will be placed, usually  == PHYS_OFFSET + TEXT_OFFSET)
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
>    address.
> 
>  - or the assumption of the zImage being loaded by the boot
>    loader within 256MB from the start address is simply
>    incorrect
> 
>  - or when ZBOOT_ROM is used, where the above assumption is
>    normally wrong
> 
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
> arch/arm/mach-bcmring/Makefile.boot:	   zreladdr-y   :=
> $(CONFIG_BCM_ZRELADDR) * refer to
> arch/arm/configs/bcmring_defconfig:CONFIG_BCM_ZRELADDR=0x8000
> arch/arm/mach-h720x/Makefile.boot:	   zreladdr-$(CONFIG_ARCH_H720X) :=
> 0x40008000 arch/arm/mach-shmobile/Makefile.boot:	   zreladdr-y   :=
> $(__ZRELADDR) * __ZRELADDR depends on CONFIG_MEMORY_START
> arch/arm/configs/ap4evb_defconfig:	CONFIG_MEMORY_START=0x40000000 (SH7372)
> arch/arm/configs/g3evm_defconfig:	CONFIG_MEMORY_START=0x50000000 (SH7367)
> arch/arm/configs/g4evm_defconfig:	CONFIG_MEMORY_START=0x40000000 (SH7377)
> 
> arch/arm/mach-at91/Makefile.boot:	   zreladdr-y	:= 0x70008000
> (CONFIG_ARCH_AT91CAP9) arch/arm/mach-at91/Makefile.boot:	   zreladdr-y	
:=
> 0x70008000 (CONFIG_ARCH_AT91SAM9G45) arch/arm/mach-at91/Makefile.boot:	  
> zreladdr-y	:= 0x20008000 (CONFIG_ARCH_AT91)
> arch/arm/mach-davinci/Makefile.boot:	   zreladdr-y	:= 0xc0008000
> (CONFIG_ARCH_DAVINCI_DA8XX) arch/arm/mach-davinci/Makefile.boot:	  
> zreladdr-y	:= 0x80008000 (!CONFIG_ARCH_DAVINCI_DA8XX)
> arch/arm/mach-ep93xx/Makefile.boot:	  
> zreladdr-$(CONFIG_EP93XX_SDCE3_SYNC_PHYS_OFFSET)	:= 0x00008000
> arch/arm/mach-ep93xx/Makefile.boot:	  
> zreladdr-$(CONFIG_EP93XX_SDCE0_PHYS_OFFSET)		:= 0xc0008000
> arch/arm/mach-ep93xx/Makefile.boot:	  
> zreladdr-$(CONFIG_EP93XX_SDCE1_PHYS_OFFSET)		:= 0xd0008000
> arch/arm/mach-ep93xx/Makefile.boot:	  
> zreladdr-$(CONFIG_EP93XX_SDCE2_PHYS_OFFSET)		:= 0xe0008000
> arch/arm/mach-ep93xx/Makefile.boot:	  
> zreladdr-$(CONFIG_EP93XX_SDCE3_ASYNC_PHYS_OFFSET)	:= 0xf0008000
> arch/arm/mach-gemini/Makefile.boot:	   zreladdr-y	:= 0x00008000
> (CONFIG_GEMINI_MEM_SWAP) arch/arm/mach-gemini/Makefile.boot:	  
> zreladdr-y	:= 0x10008000 (!CONFIG_GEMINI_MEM_SWAP)
> arch/arm/mach-mx2/Makefile.boot:	   zreladdr-$(CONFIG_MACH_MX21) :=
> 0xC0008000 arch/arm/mach-mx2/Makefile.boot:	  
> zreladdr-$(CONFIG_MACH_MX27) := 0xA0008000
> arch/arm/mach-realview/Makefile.boot:	   zreladdr-y	:= 0x70008000
> (CONFIG_REALVIEW_HIGH_PHYS_OFFSET) arch/arm/mach-realview/Makefile.boot:	 
>  zreladdr-y	:= 0x00008000 (CONFIG_REALVIEW_HIGH_PHYS_OFFSET)
> arch/arm/mach-sa1100/Makefile.boot:	   zreladdr-y	:= 0xc0008000
> arch/arm/mach-sa1100/Makefile.boot:	   zreladdr-$(CONFIG_SA1111) :=
> 0xc0208000
> 
> Machines where ZRELADDR cannot be auto calcuated:
> 
> arch/arm/mach-mx1/Makefile.boot:	   zreladdr-y	:= 0x08008000
> arch/arm/mach-shark/Makefile.boot:	   zreladdr-y	:= 0x08008000
> arch/arm/mach-u300/Makefile.boot:	   zreladdr-y	:= 0x28E08000
> arch/arm/mach-u300/Makefile.boot:	   zreladdr-y	:= 0x48008000
> 
> Signed-off-by: Eric Miao <eric.miao@canonical.com>
> ---
>  arch/arm/Kconfig                  |   63
> +++++++++++++++++++++++++++++++++++++ arch/arm/boot/Makefile            | 
>  10 +++---
>  arch/arm/boot/compressed/Makefile |    4 +-
>  arch/arm/boot/compressed/head.S   |   12 +++++--
>  4 files changed, 79 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index e340193..818f731 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1497,6 +1497,69 @@ config TEXT_OFFSET
>  	  TEXT_OFFSET is the offset of the decompressed kernel image from
>  	  memory start. Currently, it is expected the least significant 16
>  	  bits to be 0x8000, so to leave space for the initial page table.
> +
> +config AUTO_ZRELADDR
> +	bool "Auto calculation of the decompressed kernel image address"
> +	depends on !ZBOOT_ROM && !(ARCH_MX1 || ARCH_SHARK || ARCH_U300)
> +	help
> +	  ZRELADDR is the physical address where the decompressed kernel
> +	  image will be placed. If AUTO_ZRELADDR is selected, the address
> +	  will be determined at run-time by masking the current IP with
> +	  0xf000_0000. This assumes the zImage being placed in the 256MB
> +	  range from the start of memory.
> +
> +config ZRELADDR
> +	hex "Physical address of the decompressed kernel image"
> +	depends on !AUTO_ZRELADDR
> +	default 0x00008000 if ARCH_BCMRING || ARCH_CNS3XXX || ARCH_DOVE ||\
> +			      ARCH_EBSA110 || ARCH_FOOTBRIDGE || ARCH_INTEGRATOR 
||\
> +			      ARCH_IOP13XX || ARCH_IOP33X || ARCH_IXP2000 ||\
> +			      ARCH_IXP23XX || ARCH_IXP4XX || ARCH_KIRKWOOD ||\
> +			      ARCH_KS8695  || ARCH_LOKI || ARCH_MMP || 
ARCH_MV78XX0 ||\
> +			      ARCH_NOMADIK || ARCH_NUC93X || ARCH_NS9XXX ||\
> +			      ARCH_ORION5X || ARCH_SPEAR3XX || ARCH_SPEAR6XX ||\
> +			      ARCH_UX5XX || ARCH_VERSATILE || ARCH_W90X900
> +	default 0x08008000 if ARCH_MX1 || ARCH_SHARK
> +	default 0x10008000 if ARCH_MSM || ARCH_OMAP1 || ARCH_RPC
> +	default 0x20008000 if ARCH_S5P6440 || ARCH_S5P6442 ||\
> +			      ARCH_S5PC100 || ARCH_S5PV210
> +	default 0x30008000 if ARCH_S3C2410 || ARCH_S3C2400 || ARCH_S3C2412 ||\
> +			      ARCH_S3C2416 || ARCH_S3C2440 || ARCH_S3C2443
> +	default 0x40008000 if ARCH_STMP378X || ARCH_STMP37XX || ARCH_SH7372 ||\
> +			      ARCH_SH7377
> +	default 0x50008000 if ARCH_S3C64XX || ARCH_SH7367
> +	default 0x60008000 if ARCH_VEXPRESS
> +	default 0x80008000 if ARCH_MX25 || ARCH_MX3 || ARCH_NETX ||\
> +			      ARCH_OMAP2 || ARCH_PNX4008
> +	default 0x90008000 if ARCH_MX5 || ARCH_MX91231
> +	default 0xa0008000 if ARCH_IOP32X || ARCH_PXA || MACH_MX27
> +	default 0xc0008000 if ARCH_LH7A40X || MACH_MX21
> +	default 0xf0008000 if ARCH_AAEC2000 || ARCH_L7200
> +	default 0xc0028000 if ARCH_CLPS711X
> +	default 0x70008000 if ARCH_AT91 && (ARCH_AT91CAP9 || ARCH_AT91SAM9G45)
> +	default 0x20008000 if ARCH_AT91 && !(ARCH_AT91CAP9 || ARCH_AT91SAM9G45)
> +	default 0xc0008000 if ARCH_DAVINCI && ARCH_DAVINCI_DA8XX
> +	default 0x80008000 if ARCH_DAVINCI && !ARCH_DAVINCI_DA8XX
> +	default 0x00008000 if ARCH_EP93XX && EP93XX_SDCE3_SYNC_PHYS_OFFSET
> +	default 0xc0008000 if ARCH_EP93XX && EP93XX_SDCE0_PHYS_OFFSET
> +	default 0xd0008000 if ARCH_EP93XX && EP93XX_SDCE1_PHYS_OFFSET
> +	default 0xe0008000 if ARCH_EP93XX && EP93XX_SDCE2_PHYS_OFFSET
> +	default 0xf0008000 if ARCH_EP93XX && EP93XX_SDCE3_ASYNC_PHYS_OFFSET
> +	default 0x00008000 if ARCH_GEMINI && GEMINI_MEM_SWAP
> +	default 0x10008000 if ARCH_GEMINI && !GEMINI_MEM_SWAP
> +	default 0x70008000 if ARCH_REALVIEW && REALVIEW_HIGH_PHYS_OFFSET
> +	default 0x00008000 if ARCH_REALVIEW && !REALVIEW_HIGH_PHYS_OFFSET
> +	default 0xc0208000 if ARCH_SA1100 && SA1111
> +	default 0xc0008000 if ARCH_SA1100 && !SA1111
> +	default 0x30108000 if ARCH_S3C2410 && PM_H1940
> +	default 0x28E08000 if ARCH_U300 && MACH_U300_SINGLE_RAM
> +	default 0x48008000 if ARCH_U300 && !MACH_U300_SINGLE_RAM
> +	help
> +	  ZRELADDR is the physical address where the decompressed kernel
> +	  image will be placed. ZRELADDR has to be specified when the
> +	  assumption of AUTO_ZRELADDR is not valid, or when ZBOOT_ROM is
> +	  selected.
> +
>  endmenu
> 

Hi,
what about the PXA based devices, where RAM begins at 0x80000000 ?

Cheers

>  menu "CPU Power Management"
> diff --git a/arch/arm/boot/Makefile b/arch/arm/boot/Makefile
> index 4a590f4..8cc4669 100644
> --- a/arch/arm/boot/Makefile
> +++ b/arch/arm/boot/Makefile
> @@ -14,18 +14,16 @@
>  MKIMAGE         := $(srctree)/scripts/mkuboot.sh
> 
>  ifneq ($(MACHINE),)
> -include $(srctree)/$(MACHINE)/Makefile.boot
> +-include $(srctree)/$(MACHINE)/Makefile.boot
>  endif
> 
>  # Note: the following conditions must always be true:
> -#   ZRELADDR == virt_to_phys(PAGE_OFFSET + TEXT_OFFSET)
>  #   PARAMS_PHYS must be within 4MB of ZRELADDR
>  #   INITRD_PHYS must be in RAM
> -ZRELADDR    := $(zreladdr-y)
>  PARAMS_PHYS := $(params_phys-y)
>  INITRD_PHYS := $(initrd_phys-y)
> 
> -export ZRELADDR INITRD_PHYS PARAMS_PHYS
> +export INITRD_PHYS PARAMS_PHYS
> 
>  targets := Image zImage xipImage bootpImage uImage
> 
> @@ -67,7 +65,7 @@ quiet_cmd_uimage = UIMAGE  $@
>  ifeq ($(CONFIG_ZBOOT_ROM),y)
>  $(obj)/uImage: LOADADDR=$(CONFIG_ZBOOT_ROM_TEXT)
>  else
> -$(obj)/uImage: LOADADDR=$(ZRELADDR)
> +$(obj)/uImage: LOADADDR=$(CONFIG_ZRELADDR)
>  endif
> 
>  ifeq ($(CONFIG_THUMB2_KERNEL),y)
> @@ -78,6 +76,8 @@ $(obj)/uImage: STARTADDR=$(LOADADDR)
>  endif
> 
>  $(obj)/uImage:	$(obj)/zImage FORCE
> +	@test "$(CONFIG_AUTO_ZRELADDR)" == "y" ||\
> +	(echo CONFIG_ZRELADDR must be specified for uImage; exit -1)
>  	$(call if_changed,uimage)
>  	@echo '  Image $@ is ready'
> 
> diff --git a/arch/arm/boot/compressed/Makefile
> b/arch/arm/boot/compressed/Makefile index dbd3fe8..45b0f48 100644
> --- a/arch/arm/boot/compressed/Makefile
> +++ b/arch/arm/boot/compressed/Makefile
> @@ -4,6 +4,8 @@
>  # create a compressed vmlinuz image from the original vmlinux
>  #
> 
> +AFLAGS_head.o        := -DTEXT_OFFSET=$(CONFIG_TEXT_OFFSET)
> +
>  HEAD	= head.o
>  OBJS	= misc.o decompress.o
>  FONTC	= $(srctree)/drivers/video/console/font_acorn_8x8.c
> @@ -79,8 +81,6 @@ endif
>  EXTRA_CFLAGS  := -fpic -fno-builtin
>  EXTRA_AFLAGS  := -Wa,-march=all
> 
> -# Supply ZRELADDR to the decompressor via linker symbols.
> -LDFLAGS_vmlinux := --defsym zreladdr=$(ZRELADDR)
>  ifeq ($(CONFIG_CPU_ENDIAN_BE8),y)
>  LDFLAGS_vmlinux += --be8
>  endif
> diff --git a/arch/arm/boot/compressed/head.S
> b/arch/arm/boot/compressed/head.S index 0765990..17d19dc 100644
> --- a/arch/arm/boot/compressed/head.S
> +++ b/arch/arm/boot/compressed/head.S
> @@ -170,9 +170,16 @@ not_angel:
> 
>  		.text
>  		adr	r0, LC0
> - ARM(		ldmia	r0, {r1, r2, r3, r4, r5, r6, r11, ip, sp})
> - THUMB(		ldmia	r0, {r1, r2, r3, r4, r5, r6, r11, ip}	)
> + ARM(		ldmia	r0, {r1, r2, r3, r5, r6, r11, ip, sp})
> + THUMB(		ldmia	r0, {r1, r2, r3, r5, r6, r11, ip}	)
>   THUMB(		ldr	sp, [r0, #32]				)
> +#ifdef CONFIG_AUTO_ZRELADDR
> +		@ determine final kernel image address
> +		and	r4, pc, #0xf0000000
> +		add	r4, r4, #TEXT_OFFSET
> +#else
> +		ldr	r4, =CONFIG_ZRELADDR
> +#endif
>  		subs	r0, r0, r1		@ calculate the delta offset
> 
>  						@ if delta is zero, we are
> @@ -310,7 +317,6 @@ wont_overwrite:	mov	r0, r4
>  LC0:		.word	LC0			@ r1
>  		.word	__bss_start		@ r2
>  		.word	_end			@ r3
> -		.word	zreladdr		@ r4
>  		.word	_start			@ r5
>  		.word	_image_size		@ r6
>  		.word	_got_start		@ r11
