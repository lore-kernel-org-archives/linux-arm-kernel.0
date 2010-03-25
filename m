From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Fri, 26 Mar 2010 01:03:36 +0300
Subject: [PATCH 1/4] cns3xxx: Add basic support for Cavium Networks CNS3xxx
	processors
In-Reply-To: <20100325201040.GA8014@oksana.dev.rtsoft.ru>
References: <20100325200851.GA6470@oksana.dev.rtsoft.ru>
	<20100325201040.GA8014@oksana.dev.rtsoft.ru>
Message-ID: <4BABDDB8.9000505@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

Anton Vorontsov wrote:
> This patch adds a very basic support for ECONA CNS3xxx ARM11 MPcore
> (ARMv6) dual-core processors. Specifically, CNS3420VB rev 1.3 board
> is supported.
>
> With this patch CNS3420VP board is able to boot up to the userspace,
> with a console available on UART0.
>
> Note that SMP is not yet supported, as well as many peripheral
> devices. Support for these features will be added later.
>
> Signed-off-by: Anton Vorontsov <avorontsov@mvista.com>
>   

[...]

> diff --git a/arch/arm/mach-cns3xxx/Kconfig b/arch/arm/mach-cns3xxx/Kconfig
> new file mode 100644
> index 0000000..f730d8e
> --- /dev/null
> +++ b/arch/arm/mach-cns3xxx/Kconfig
> @@ -0,0 +1,13 @@
> +menu "CNS3XXX platform type"
> +	depends on ARCH_CNS3XXX
> +
> +config MACH_CNS3420VB
> +	bool "Support for CNS3420 Validation Board"
> +	select ARM_GIC
> +	help
> +	  Include support for the Cavium Networks CNS3420 MPCore Platform
> +	  Baseboard.
> +	  This is a platform with an on-board ARM11 MPCore and has support
> +	  for USB, USB-OTG, MMC/SD/SDIO, SATA, PCI-E, etc.
> +
> +endmenu
> diff --git a/arch/arm/mach-cns3xxx/Makefile b/arch/arm/mach-cns3xxx/Makefile
> new file mode 100644
> index 0000000..427507a
> --- /dev/null
> +++ b/arch/arm/mach-cns3xxx/Makefile
> @@ -0,0 +1,2 @@
> +obj-$(CONFIG_ARCH_CNS3XXX)		+= core.o pm.o
> +obj-$(CONFIG_MACH_CNS3420VB)		+= cns3420vb.o
> diff --git a/arch/arm/mach-cns3xxx/Makefile.boot b/arch/arm/mach-cns3xxx/Makefile.boot
> new file mode 100644
> index 0000000..7770128
> --- /dev/null
> +++ b/arch/arm/mach-cns3xxx/Makefile.boot
> @@ -0,0 +1,3 @@
> +   zreladdr-y	:= 0x00008000
> +params_phys-y	:= 0x00000100
> +initrd_phys-y	:= 0x00C00000
> diff --git a/arch/arm/mach-cns3xxx/cns3420vb.c b/arch/arm/mach-cns3xxx/cns3420vb.c
> new file mode 100644
> index 0000000..924e4da
> --- /dev/null
> +++ b/arch/arm/mach-cns3xxx/cns3420vb.c
> @@ -0,0 +1,160 @@
> +/*
> + * Cavium Networks CNS3420 Validation Board
>   

   I'd put the validation board support code into a patch of its own, 
separate from the SoC support...

WBR, Sergei
