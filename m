From: dave.martin@linaro.org (Dave Martin)
Date: Wed, 30 Nov 2011 15:37:49 +0000
Subject: [PATCH v3 4/5] ARM: vexpress: Initial RS1 memory map support
In-Reply-To: <1322579473-8804-5-git-send-email-pawel.moll@arm.com>
References: <1322579473-8804-1-git-send-email-pawel.moll@arm.com>
 <1322579473-8804-5-git-send-email-pawel.moll@arm.com>
Message-ID: <20111130153749.GE2045@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 29, 2011 at 03:11:12PM +0000, Pawel Moll wrote:
> This patch adds support for RS1 memory map based Versatile Express
> motherboard.

[...]

> +config ARCH_VEXPRESS_RS1
> +	bool
> +	select AUTO_ZRELADDR
> +	select ARM_PATCH_PHYS_VIRT
> +	help
> +	  RS1 VE memory map (i.a. motherboard peripherals at
> +	  0x1c000000, RAM at 0x80000000).
> +
>  endmenu
> diff --git a/arch/arm/mach-vexpress/Makefile.boot b/arch/arm/mach-vexpress/Makefile.boot
> index 8630b3d..05b77a5 100644
> --- a/arch/arm/mach-vexpress/Makefile.boot
> +++ b/arch/arm/mach-vexpress/Makefile.boot
> @@ -1,3 +1,9 @@
> +ifeq ($(CONFIG_ARCH_VEXPRESS_RS1),y)
> +   zreladdr-y	+= 0x80008000
> +params_phys-y	:= 0x80000100
> +initrd_phys-y	:= 0x80800000

This results in a uImage which is a bit broken if using a normal u-Boot
configured for vexpress-v2p-ca9, because the bootloader makes some
memory map assumptions, and anyway we don't expect the kernel to work
unless it's loaded at the start of RAM:


## Booting kernel from Legacy Image at 62000400 ...
   Image Name:   Linux-3.2.0-rc3+
   Image Type:   ARM Linux Kernel Image (uncompressed)
   Data Size:    2464984 Bytes = 2.4 MiB
   Load Address: 80008000
   Entry Point:  80008000
   Verifying Checksum ... OK
## Loading init Ramdisk from Legacy Image at 80ffffc0 ...
   Image Name:
   Image Type:   ARM Linux RAMDisk Image (uncompressed)
   Data Size:    2216523 Bytes = 2.1 MiB
   Load Address: 81000000
   Entry Point:  81000000
   Verifying Checksum ... OK
## Flattened Device Tree blob at 80ffc000
   Booting using the fdt blob at 0x80ffc000
   Loading Kernel Image ... OK
OK
   Loading Ramdisk to 7fcd3000, end 7fef024b ... OK
   Loading Device Tree to 7fcce000, end 7fcd2779 ... OK

Starting kernel ...

Uncompressing Linux... done, booting the kernel.
Booting Linux on physical CPU 0
Initializing cgroup subsys cpuset
Linux version 3.2.0-rc3+ (davem at e103592) (gcc version 4.5.2 (Ubuntu/Linaro 4.5.2-8ubuntu3) ) #12 SMP Wed Nov 30 15:10:19 GMT 2011
CPU: ARMv7 Processor [410fc091] revision 1 (ARMv7), cr=10c53c7d
CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
Machine: ARM Versatile Express, model: V2P-CA9
bootconsole [earlycon0] enabled
Ignoring RAM at 60000000-7fffffff (vmalloc region overlap).
Ignoring RAM at 60000000-9fffffff (vmalloc region overlap).
INITRD: 0x7fcd3000+0x0021d24b is not a memory region - disabling initrd
Memory policy: ECC disabled, Data cache writealloc

<HANG>


If I strip the uImage and rebuild it with -a 0x60008000 -e 0x60008000
and no other changes, that's sufficient to give me a fully booting
kernel.  I can also boot a single image on v2p-ca9 both with and without
a dtb in this configuration.

I'm using a Linaro u-Boot from a couple of releses ago; it's possible
things have changed since.


Do you know of any specific u-Boot version which shouldn't have these
problems?

Was the hard-coded uImage load address/entry point problem ever fixed?
(It totally defeats loading a single uImage on multiple board variants.)

Cheers
---Dave
