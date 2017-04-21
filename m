From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 21 Apr 2017 16:27:14 +0200
Subject: stable/linux-3.18.y build: 204 builds: 5 failed, 199 passed, 35
 errors, 212 warnings (v3.18.49)
In-Reply-To: <58f8ea00.84621c0a.da7d6.1c19@mx.google.com>
References: <58f8ea00.84621c0a.da7d6.1c19@mx.google.com>
Message-ID: <CAK8P3a3QsSMtc7AWjVjtM+tW8ARt1Ygw53=CSjgbG6Pvpq0QvQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 20, 2017 at 7:04 PM, kernelci.org bot <bot@kernelci.org> wrote:
> stable/linux-3.18.y build: 204 builds: 5 failed, 199 passed, 35 errors, 212 warnings (v3.18.49)

I've gone through all these now and found a fix. In three cases, there is no
fix yet since the respective drivers got removed before the warning was
noticed. Do we have a policy for how to deal with those? Should I just
send patches to address the warnings for 3.18?

> Errors summary:
> 7 arch/mips/jz4740/irq.h:21:38: error: 'struct irq_data' declared inside
> parameter list will not be visible outside of this definition or declaration
> [-Werror]
> 7 arch/mips/jz4740/irq.h:20:39: error: 'struct irq_data' declared inside
> parameter list will not be visible outside of this definition or declaration
> [-Werror]


5b235dc2647e4 MIPS: Fix the build on jz4740 after removing the custom gpio.h

> 2 arch/mips/mm/fault.c:321:1: error: the frame size of 1104 bytes is larger
> than 1024 bytes [-Werror=frame-larger-than=]

This is a result of a newer compiler version, combined with the -Werror
flag that is applied to arch/mips/, and two of the mips defconfigs overriding
CONFIG_FRAME_WARN to 1024 on a 64-bit architecture (probably by
accident).

I saw this also when I looked at the 3.16 warnings, but only now actually
bisected it. The fix is

86038c5ea81b ("perf: Avoid horrible stack usage")

> Detailed per-defconfig build reports:
>
> allmodconfig+CONFIG_OF=n (x86) ? PASS, 0 errors, 8 warnings, 0 section
> mismatches
>
> Warnings:
> fs/nfs/nfs4proc.c:3062:10: warning: switch condition has boolean value
> [-Wswitch-bool]

c7757074839f ("fs/nfs: fix new compiler warning about boolean in switch")

> drivers/iommu/intel-iommu.c:1762:25: warning: unused variable 'drhd'
> [-Wunused-variable]

509fca899d56 ("iommu/vt-d: Remove unused variable")

> drivers/message/i2o/i2o_config.c:893:19: warning: cast to pointer from
> integer of different size [-Wint-to-pointer-cast]
> drivers/message/i2o/i2o_config.c:953:10: warning: cast to pointer from
> integer of different size [-Wint-to-pointer-cast]

The driver is obsolete and was removed in v4.2. It looks like the warning
should still be there in v4.1.y, but I don't remember having seen it. It
would be trivial to fix this with an obvious patch adding a cast.


> drivers/staging/bcm/CmHost.c:1503:3: warning: cast to pointer from integer
> of different size [-Wint-to-pointer-cast]
> drivers/staging/bcm/CmHost.c:1546:3: warning: cast to pointer from integer
> of different size [-Wint-to-pointer-cast]
> drivers/staging/bcm/CmHost.c:1564:3: warning: cast to pointer from integer
> of different size [-Wint-to-pointer-cast]

Similarly, the driver was removed in v3.19, but I could create a patch for
the warning.

> drivers/scsi/advansys.c:71:2: warning: #warning this driver is still not
> properly converted to the DMA API [-Wcpp]

The driver was properly converted in v4.2 and the warning removed, but the
conversion would be outside of stable-kernel-rules.

> Section mismatches:
> WARNING: arch/x86/kernel/built-in.o(.text.unlikely+0x157f): Section mismatch
> in reference from the function cpumask_empty.constprop.3() to the variable
> .init.data:nmi_ipi_mask
> WARNING: arch/x86/built-in.o(.text.unlikely+0x189b): Section mismatch in
> reference from the function cpumask_empty.constprop.3() to the variable
> .init.data:nmi_ipi_mask
> WARNING: vmlinux.o(.text.unlikely+0x1962): Section mismatch in reference
> from the function cpumask_empty.constprop.3() to the variable
> .init.data:nmi_ipi_mask

f0ba662a6e06f2 x86: Properly _init-annotate NMI selftest code

> allnoconfig (mips) ? PASS, 0 errors, 1 warning, 0 section mismatches
>
> Warnings:
> mm/page_alloc.c:5346:34: warning: array subscript is below array bounds
> [-Warray-bounds]

Also bisected this one now, this is also missing on 3.16:

90cae1fe1c35 ("mm/init: fix zone boundary creation")

> ar7_defconfig (mips) ? PASS, 0 errors, 2 warnings, 0 section mismatches
>
> Warnings:
> include/linux/kernel.h:713:17: warning: comparison of distinct pointer types
> lacks a cast

2f5281ba2a8f ("net: ti: cpmac: Fix compiler warning due to type confusion")

> at91_dt_defconfig (arm) ? PASS, 0 errors, 2 warnings, 0 section mismatches
>
> Warnings:
> drivers/clk/at91/clk-usb.c:155:20: warning: initialization from incompatible
> pointer type [-Wincompatible-pointer-types]
> drivers/clk/at91/clk-usb.c:193:20: warning: initialization from incompatible
> pointer type [-Wincompatible-pointer-types]

I've send this fix:

8<------
clk: at91: usb: fix determine_rate prototype again

We had an incorrect backport of
4591243102fa ("clk: at91: usb: propagate rate modification to the parent clk")
that was fixed incorrectly in linux-3.18.y by
76723e7ed589 ("clk: at91: usb: fix determine_rate prototype")

This should fix it properly.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/drivers/clk/at91/clk-usb.c b/drivers/clk/at91/clk-usb.c
index 0283a5713d6c..930a424cc4a0 100644
--- a/drivers/clk/at91/clk-usb.c
+++ b/drivers/clk/at91/clk-usb.c
@@ -59,7 +59,7 @@ static unsigned long
at91sam9x5_clk_usb_recalc_rate(struct clk_hw *hw,
 static long at91sam9x5_clk_usb_determine_rate(struct clk_hw *hw,
       unsigned long rate,
       unsigned long *best_parent_rate,
-      struct clk_hw **best_parent_hw)
+      struct clk **best_parent_hw)
 {
  struct clk *parent = NULL;
  long best_rate = -EINVAL;
@@ -91,7 +91,7 @@ static long at91sam9x5_clk_usb_determine_rate(struct
clk_hw *hw,
  best_rate = tmp_rate;
  best_diff = tmp_diff;
  *best_parent_rate = tmp_parent_rate;
- *best_parent_hw = __clk_get_hw(parent);
+ *best_parent_hw = parent;
  }

  if (!best_diff || tmp_rate < rate)
---------->8

> ath79_defconfig (mips) ? PASS, 0 errors, 2 warnings, 0 section mismatches
>
> Warnings:
> arch/mips/kernel/entry.S:170: Warning: tried to set unrecognized symbol:
> MIPS_ISA_LEVEL_RAW

aebac99384f7 ("MIPS: kernel: entry.S: Set correct ISA level for mips_ihb")

> cerfcube_defconfig (arm) ? PASS, 0 errors, 2 warnings, 0 section mismatches
>
> Warnings:
> fs/nfsd/nfs4state.c:3781:3: warning: 'old_deny_bmap' may be used
> uninitialized in this function [-Wmaybe-uninitialized]

5368e1a6 ("nfsd: work around a gcc-5.1 warning")

> corgi_defconfig (arm) ? PASS, 0 errors, 2 warnings, 0 section mismatches
>
> Warnings:
> drivers/usb/gadget/legacy/inode.c:648:10: warning: 'value' may be used
> uninitialized in this function [-Wmaybe-uninitialized]

This is caused by the backport of f01d35a15fa0416 from 4.0 to 3.18:
c81fc59be42c6e0 gadgetfs: use-after-free in ->aio_read()

The backported patch was buggy, but the mainline code was
rewritten in a larger patch directly following this one in a way that
fixed the bug.

For stable, we should need only a one-line change, which I sent now:

diff --git a/drivers/usb/gadget/legacy/inode.c
b/drivers/usb/gadget/legacy/inode.c
index 54f964bbc79a..fe45311f243e 100644
--- a/drivers/usb/gadget/legacy/inode.c
+++ b/drivers/usb/gadget/legacy/inode.c
@@ -654,6 +654,7 @@ fail:
    GFP_KERNEL);
  if (!priv->iv) {
  kfree(priv);
+ value = -ENOMEM;
  goto fail;
  }
  }

> defconfig+CONFIG_LKDTM=y (mips) ? PASS, 0 errors, 3 warnings, 0 section
> mismatches
>
> Warnings:
> include/asm-generic/div64.h:43:28: warning: comparison of distinct pointer
> types lacks a cast
> include/asm-generic/div64.h:43:28: warning: comparison of distinct pointer
> types lacks a cast

2ae83bf93882 ("[CIFS] Fix setting time before epoch (negative time values)")

> efm32_defconfig (arm) ? PASS, 0 errors, 1 warning, 0 section mismatches
>
> Warnings:
> arch/arm/kernel/head-nommu.S:167: Warning: Use of r13 as a source register
> is deprecated when r15 is the destination register.

970d96f9a81b ("ARM: 8383/1: nommu: avoid deprecated source register on mov")

> imx_v6_v7_defconfig (arm) ? PASS, 0 errors, 2 warnings, 0 section mismatches
>
> Warnings:
> drivers/net/wireless/brcm80211/brcmfmac/fwsignal.c:1478:8: warning: 'skb'
> may be used uninitialized in this function [-Wmaybe-uninitialized]

22f44150aad7 ("brcmfmac: avoid gcc-5.1 warning")

> ip27_defconfig (mips) ? PASS, 0 errors, 6 warnings, 0 section mismatches
>
> Warnings:
> lib/cpumask.c:194:25: warning: the address of 'cpu_all_bits' will always
> evaluate as 'true' [-Waddress]

f36963c9d3f6f4 cpumask_set_cpu_local_first => cpumask_local_spread, lament

> include/linux/sched.h:1975:56: warning: 'noio_flag' may be used
> uninitialized in this function [-Wmaybe-uninitialized]

I've bisected this to
be0c37c985ed ("MIPS: Rearrange PTE bits into fixed positions.")
which accidentally shuts up the warning, but does not apply to
3.18, and is not appropriate for a stable backport.

The code is correct, so we can probably just add an initialization
for the variable. Patch sent.

> drivers/tty/nozomi.c:857:9: warning: 'size' may be used uninitialized in
> this function [-Wmaybe-uninitialized]

a4f642a8a3c2 ("tty: nozomi: avoid a harmless gcc warning")

> drivers/net/ethernet/neterion/vxge/vxge-main.c:2149:13: warning:
> 'adaptive_coalesce_rx_interrupts' defined but not used [-Wunused-function]
> drivers/net/ethernet/neterion/vxge/vxge-main.c:2121:13: warning:
> 'adaptive_coalesce_tx_interrupts' defined but not used [-Wunused-function]

57e7c8cef224 ("net: vxge: avoid unused function warnings")

> ip32_defconfig (mips) ? PASS, 0 errors, 2 warnings, 0 section mismatches
>
> Warnings:
> drivers/misc/ioc4.c:194:16: warning: 'start' may be used uninitialized in
> this function [-Wmaybe-uninitialized]

769105aa740d ("misc: ioc4: simplify wave period measurement in clock_calibrate")

> malta_defconfig (mips) ? PASS, 0 errors, 3 warnings, 0 section mismatches
>
> Warnings:
> drivers/net/wireless/hostap/hostap_hw.c:842:5: warning: 'rec' may be used
> uninitialized in this function [-Wmaybe-uninitialized]

48dc5fb3ba53b2 hostap: avoid uninitialized variable use in hfa384x_get_rid

> msp71xx_defconfig (mips) ? PASS, 0 errors, 3 warnings, 0 section mismatches
>
> Warnings:
> arch/mips/pci/ops-pmcmsp.c:196:24: warning: 'bpci_lock' defined but not used
> [-Wunused-variable]

c4a305374bbf ("MIPS: MSP71xx: remove odd locking in PCI config space
access code")
> mtx1_defconfig (mips) ? PASS, 0 errors, 4 warnings, 0 section mismatches
>
> Warnings:
> drivers/net/ethernet/dec/tulip/winbond-840.c:910:2: warning: #warning
> Processor architecture undefined [-Wcpp]

de92718883dd ("net: tulip: turn compile-time warning into dev_warn()")

> multi_v7_defconfig+CONFIG_ARM_LPAE=y (arm) ? PASS, 0 errors, 3 warnings, 0
> section mismatches
>
> Warnings:
> drivers/mmc/host/sunxi-mmc.c:297:35: warning: cast to pointer from integer
> of different size [-Wint-to-pointer-cast]

d34712d2e3db ("mmc: sunxi: avoid invalid pointer calculation")

> multi_v7_defconfig+CONFIG_SMP=n (arm) ? FAIL, 1 error, 2 warnings, 0 section
> mismatches
>
> Errors:
> arch/arm/kernel/psci.c:287:12: error: redefinition of 'psci_init'
> Warnings:

patch sent:

commit 37290221124afbaa9a11f17d2b1fc6bf2e829872
Author: Arnd Bergmann <arnd@arndb.de>
Date:   Fri Apr 21 15:54:10 2017 +0200

    [3.18-stable regression] ARM: psci: fix header file

    Commit be95485a0b828 was incorrectly backported to 3.18 and
    now causes a different build error when CONFIG_SMP is disabled:

     arch/arm/kernel/psci.c:287:12: error: redefinition of 'psci_init'

    This version is how it should be on 3.18, with the main psci
    code built for both SMP and UP, but the psci_smp_available()
    function only being available for SMP builds.

    Fixes: dbcfee724255 ("ARM: 8457/1: psci-smp is built only for SMP")
    Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/arch/arm/include/asm/psci.h b/arch/arm/include/asm/psci.h
index e3789fb02c9c..8ca5308a05d7 100644
--- a/arch/arm/include/asm/psci.h
+++ b/arch/arm/include/asm/psci.h
@@ -37,11 +37,15 @@ struct psci_operations {
 extern struct psci_operations psci_ops;
 extern struct smp_operations psci_smp_ops;

-#if defined(CONFIG_SMP) && defined(CONFIG_ARM_PSCI)
+#ifdef CONFIG_ARM_PSCI
 int psci_init(void);
-bool psci_smp_available(void);
 #else
 static inline int psci_init(void) { return 0; }
+#endif
+
+#if defined(CONFIG_SMP) && defined(CONFIG_ARM_PSCI)
+bool psci_smp_available(void);
+#else
 static inline bool psci_smp_available(void) { return false; }
 #endif

> nlm_xlp_defconfig (mips) ? FAIL, 1 error, 3 warnings, 0 section mismatches
>
> Errors:
> fs/gfs2/dir.c:768:9: warning: 'leaf_no' may be used uninitialized in this
> function [-Wmaybe-uninitialized]
> fs/gfs2/dir.c:987:8: warning: 'leaf_no' may be used uninitialized in this
> function [-Wmaybe-uninitialized]

67893f12e537 ("gfs2: avoid uninitialized variable warning")

(also needed on v4.4.y)

> fs/btrfs/extent_io.c:2166:13: warning: cast to pointer from integer of
> different size [-Wint-to-pointer-cast]

6e1103a6e9b1 ("btrfs: fix state->private cast on 32 bit machines")

> realview-smp_defconfig
>
> Warnings:
> arch/arm/mm/cache-l2x0.c:168:13: warning: 'l2x0_cache_sync' defined but not
> used [-Wunused-function]
> arch/arm/mm/cache-l2x0.c:185:13: warning: 'l2x0_flush_all' defined but not
> used [-Wunused-function]
> arch/arm/mm/cache-l2x0.c:195:13: warning: 'l2x0_disable' defined but not
> used [-Wunused-function]

20e783e39e55 ARM: 8296/1: cache-l2x0: clean up aurora cache handling

> rm200_defconfig (mips) ? FAIL, 0 errors, 5 warnings, 0 section mismatches
>
> Warnings:
> drivers/scsi/aic94xx/aic94xx_sds.c:597:2: warning: 'offs' may be used
> uninitialized in this function [-Wmaybe-uninitialized]

36dd5acd196574d4 aic94xx: Skip reading user settings if flash is not found

> arch/mips/boot/elf2ecoff.c:270:8: warning: variable 'shstrtab' set but not
> used [-Wunused-but-set-variable]

> Warnings:
> arch/mips/ralink/prom.c:64:2: warning: 'argc' is used uninitialized in this
> function [-Wuninitialized]
> arch/mips/ralink/prom.c:64:2: warning: 'argv' is used uninitialized in this
> function [-Wuninitialized]

9c48568b3692 ("MIPS: ralink: Cosmetic change to prom_init().")

> tinyconfig (arm) ? PASS, 0 errors, 3 warnings, 0 section mismatches
>
> Warnings:
> .config:807:warning: override: KERNEL_XZ changes choice state
> .config:809:warning: override: SLOB changes choice state

236dec051078 ("kconfig: tinyconfig: provide whole choice blocks to
avoid warnings")
