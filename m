From: p.pisati@gmail.com (Paolo Pisati)
Date: Mon, 19 Jan 2015 10:17:13 +0100
Subject: beaglebone black: is mem=... broken?
In-Reply-To: <CAMuHMdX07-5xUt8KpS_biZMhpeoZcQFHvZL9ZFQGvKm9-CEKng@mail.gmail.com>
References: <20150118143448.GA4023@luxor.wired.org>
 <CAMuHMdX07-5xUt8KpS_biZMhpeoZcQFHvZL9ZFQGvKm9-CEKng@mail.gmail.com>
Message-ID: <20150119091713.GA7829@luxor.wired.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 18, 2015 at 06:38:46PM +0100, Geert Uytterhoeven wrote:
> 
> The boot loader copied the DT to the end of real RAM, not to the end of
> the 256 MiB block? Hence the kernel accesses unmapped memory
> when checking the FDT header?

actually everything is below 256M since physical memory starts at
0x80000000:

U-Boot# printenv loadaddr
loadaddr=0x82000000
U-Boot# printenv fdtaddr
fdtaddr=0x88000000
U-Boot# load mmc 0:1 ${loadaddr} zimage
reading zimage
5694816 bytes read in 318 ms (17.1 MiB/s)
U-Boot# load mmc 0:1 ${fdtaddr} am335x-boneblack.dtb
reading am335x-boneblack.dtb
29985 bytes read in 10 ms (2.9 MiB/s)
U-Boot# setenv bootargs console=ttyO0,115200n8 root=/dev/mmcblk0p2 ro
rootfstype=ext4 rootwait debug earlyprintk mem=256M
U-Boot# bootz ${loadaddr} - ${fdtaddr}
Kernel image @ 0x82000000 [ 0x000000 - 0x56e560 ]
## Flattened Device Tree blob at 88000000
   Booting using the fdt blob at 0x88000000
   Loading Device Tree to 8fff5000, end 8ffff520 ... OK

Starting kernel ...

hangs there, and after i reset i found the aforementioned oops in __log_buf.

Here is without the mem= argument:

U-Boot SPL 2015.01 (Jan 16 2015 - 10:20:36)
MMC: block number 0x100 exceeds max(0x0)
MMC: block number 0x200 exceeds max(0x0)
*** Error - No Valid Environment Area found
Using default environment



U-Boot 2015.01 (Jan 16 2015 - 10:20:36)

       Watchdog enabled
I2C:   ready
DRAM:  512 MiB
MMC:   OMAP SD/MMC: 0, OMAP SD/MMC: 1
Net:   <ethaddr> not set. Validating first E-fuse MAC
cpsw, usb_ether
Hit any key to stop autoboot:  0 
U-Boot# load mmc 0:1 ${loadaddr} zimage
reading zimage
5694816 bytes read in 318 ms (17.1 MiB/s)
U-Boot# load mmc 0:1 ${fdtaddr} am335x-boneblack.dtb
reading am335x-boneblack.dtb
29985 bytes read in 11 ms (2.6 MiB/s)
U-Boot# setenv bootargs console=ttyO0,115200n8 root=/dev/mmcblk0p2 ro
rootfstype=ext4 rootwait debug earlyprintk       
U-Boot# bootz ${loadaddr} - ${fdtaddr}
Kernel image @ 0x82000000 [ 0x000000 - 0x56e560 ]
## Flattened Device Tree blob at 88000000
   Booting using the fdt blob at 0x88000000
   Loading Device Tree to 8fff5000, end 8ffff520 ... OK

Starting kernel ...

[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 3.19.0-rc4-00001-g45aa0b7 (flag at luxor) (gcc version 4.8.2 (Ubuntu/Linaro 4.8.2-16ubuntu4) ) #1 SMP Fri Jan 16 10:33:22 CET5
...
-- 
bye,
p.
