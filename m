From: gregkh@linuxfoundation.org (gregkh)
Date: Thu, 27 Apr 2017 16:28:22 +0200
Subject: stable/linux-3.18.y build: 204 builds: 5 failed, 199 passed, 35
 errors, 212 warnings (v3.18.49)
In-Reply-To: <CAK8P3a3QsSMtc7AWjVjtM+tW8ARt1Ygw53=CSjgbG6Pvpq0QvQ@mail.gmail.com>
References: <58f8ea00.84621c0a.da7d6.1c19@mx.google.com>
 <CAK8P3a3QsSMtc7AWjVjtM+tW8ARt1Ygw53=CSjgbG6Pvpq0QvQ@mail.gmail.com>
Message-ID: <20170427142822.GA19542@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 21, 2017 at 04:27:14PM +0200, Arnd Bergmann wrote:
> On Thu, Apr 20, 2017 at 7:04 PM, kernelci.org bot <bot@kernelci.org> wrote:
> > efm32_defconfig (arm) ? PASS, 0 errors, 1 warning, 0 section mismatches
> >
> > Warnings:
> > arch/arm/kernel/head-nommu.S:167: Warning: Use of r13 as a source register
> > is deprecated when r15 is the destination register.
> 
> 970d96f9a81b ("ARM: 8383/1: nommu: avoid deprecated source register on mov")

This doesn't apply to the 3.18-stable tree, and I don't know ARM
assembly good enough to backport it properly.  Any hints?

> > imx_v6_v7_defconfig (arm) ? PASS, 0 errors, 2 warnings, 0 section mismatches
> >
> > Warnings:
> > drivers/net/wireless/brcm80211/brcmfmac/fwsignal.c:1478:8: warning: 'skb'
> > may be used uninitialized in this function [-Wmaybe-uninitialized]
> 
> 22f44150aad7 ("brcmfmac: avoid gcc-5.1 warning")

Applied.

> > ip27_defconfig (mips) ? PASS, 0 errors, 6 warnings, 0 section mismatches
> >
> > Warnings:
> > lib/cpumask.c:194:25: warning: the address of 'cpu_all_bits' will always
> > evaluate as 'true' [-Waddress]
> 
> f36963c9d3f6f4 cpumask_set_cpu_local_first => cpumask_local_spread, lament

Doesn't apply, and I couldn't figure out the backport :(

> > drivers/tty/nozomi.c:857:9: warning: 'size' may be used uninitialized in
> > this function [-Wmaybe-uninitialized]
> 
> a4f642a8a3c2 ("tty: nozomi: avoid a harmless gcc warning")

Applied to 3.18 and 4.4-stable, as it was missing in 4.4

> > drivers/net/ethernet/neterion/vxge/vxge-main.c:2149:13: warning:
> > 'adaptive_coalesce_rx_interrupts' defined but not used [-Wunused-function]
> > drivers/net/ethernet/neterion/vxge/vxge-main.c:2121:13: warning:
> > 'adaptive_coalesce_tx_interrupts' defined but not used [-Wunused-function]
> 
> 57e7c8cef224 ("net: vxge: avoid unused function warnings")

Applied.

> > ip32_defconfig (mips) ? PASS, 0 errors, 2 warnings, 0 section mismatches
> >
> > Warnings:
> > drivers/misc/ioc4.c:194:16: warning: 'start' may be used uninitialized in
> > this function [-Wmaybe-uninitialized]
> 
> 769105aa740d ("misc: ioc4: simplify wave period measurement in clock_calibrate")

Applied.

> > malta_defconfig (mips) ? PASS, 0 errors, 3 warnings, 0 section mismatches
> >
> > Warnings:
> > drivers/net/wireless/hostap/hostap_hw.c:842:5: warning: 'rec' may be used
> > uninitialized in this function [-Wmaybe-uninitialized]
> 
> 48dc5fb3ba53b2 hostap: avoid uninitialized variable use in hfa384x_get_rid

Applied to 4.4 and 3.18 trees.

> > msp71xx_defconfig (mips) ? PASS, 0 errors, 3 warnings, 0 section mismatches
> >
> > Warnings:
> > arch/mips/pci/ops-pmcmsp.c:196:24: warning: 'bpci_lock' defined but not used
> > [-Wunused-variable]
> 
> c4a305374bbf ("MIPS: MSP71xx: remove odd locking in PCI config space
> access code")

Applied.

> > mtx1_defconfig (mips) ? PASS, 0 errors, 4 warnings, 0 section mismatches
> >
> > Warnings:
> > drivers/net/ethernet/dec/tulip/winbond-840.c:910:2: warning: #warning
> > Processor architecture undefined [-Wcpp]
> 
> de92718883dd ("net: tulip: turn compile-time warning into dev_warn()")

Applied.

> > multi_v7_defconfig+CONFIG_ARM_LPAE=y (arm) ? PASS, 0 errors, 3 warnings, 0
> > section mismatches
> >
> > Warnings:
> > drivers/mmc/host/sunxi-mmc.c:297:35: warning: cast to pointer from integer
> > of different size [-Wint-to-pointer-cast]
> 
> d34712d2e3db ("mmc: sunxi: avoid invalid pointer calculation")

Applied.

> > nlm_xlp_defconfig (mips) ? FAIL, 1 error, 3 warnings, 0 section mismatches
> >
> > Errors:
> > fs/gfs2/dir.c:768:9: warning: 'leaf_no' may be used uninitialized in this
> > function [-Wmaybe-uninitialized]
> > fs/gfs2/dir.c:987:8: warning: 'leaf_no' may be used uninitialized in this
> > function [-Wmaybe-uninitialized]
> 
> 67893f12e537 ("gfs2: avoid uninitialized variable warning")
> 
> (also needed on v4.4.y)

Applied to both.

> > fs/btrfs/extent_io.c:2166:13: warning: cast to pointer from integer of
> > different size [-Wint-to-pointer-cast]
> 
> 6e1103a6e9b1 ("btrfs: fix state->private cast on 32 bit machines")

Applied.

> > realview-smp_defconfig
> >
> > Warnings:
> > arch/arm/mm/cache-l2x0.c:168:13: warning: 'l2x0_cache_sync' defined but not
> > used [-Wunused-function]
> > arch/arm/mm/cache-l2x0.c:185:13: warning: 'l2x0_flush_all' defined but not
> > used [-Wunused-function]
> > arch/arm/mm/cache-l2x0.c:195:13: warning: 'l2x0_disable' defined but not
> > used [-Wunused-function]
> 
> 20e783e39e55 ARM: 8296/1: cache-l2x0: clean up aurora cache handling

Applied.

> > rm200_defconfig (mips) ? FAIL, 0 errors, 5 warnings, 0 section mismatches
> >
> > Warnings:
> > drivers/scsi/aic94xx/aic94xx_sds.c:597:2: warning: 'offs' may be used
> > uninitialized in this function [-Wmaybe-uninitialized]
> 
> 36dd5acd196574d4 aic94xx: Skip reading user settings if flash is not found

Applied.

> > arch/mips/boot/elf2ecoff.c:270:8: warning: variable 'shstrtab' set but not
> > used [-Wunused-but-set-variable]
> 
> > Warnings:
> > arch/mips/ralink/prom.c:64:2: warning: 'argc' is used uninitialized in this
> > function [-Wuninitialized]
> > arch/mips/ralink/prom.c:64:2: warning: 'argv' is used uninitialized in this
> > function [-Wuninitialized]
> 
> 9c48568b3692 ("MIPS: ralink: Cosmetic change to prom_init().")

Applied.

> > tinyconfig (arm) ? PASS, 0 errors, 3 warnings, 0 section mismatches
> >
> > Warnings:
> > .config:807:warning: override: KERNEL_XZ changes choice state
> > .config:809:warning: override: SLOB changes choice state
> 
> 236dec051078 ("kconfig: tinyconfig: provide whole choice blocks to
> avoid warnings")

Applied.

Thanks so much for the list, I think I'm all caught up now, hopefully
the next release will have almost no warnings.

greg k-h
