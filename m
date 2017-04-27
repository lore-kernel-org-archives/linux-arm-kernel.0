From: gregkh@linuxfoundation.org (gregkh)
Date: Thu, 27 Apr 2017 12:33:48 +0200
Subject: stable/linux-3.18.y build: 204 builds: 5 failed, 199 passed, 35
 errors, 212 warnings (v3.18.49)
In-Reply-To: <CAK8P3a3QsSMtc7AWjVjtM+tW8ARt1Ygw53=CSjgbG6Pvpq0QvQ@mail.gmail.com>
References: <58f8ea00.84621c0a.da7d6.1c19@mx.google.com>
 <CAK8P3a3QsSMtc7AWjVjtM+tW8ARt1Ygw53=CSjgbG6Pvpq0QvQ@mail.gmail.com>
Message-ID: <20170427103348.GA9881@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 21, 2017 at 04:27:14PM +0200, Arnd Bergmann wrote:
> On Thu, Apr 20, 2017 at 7:04 PM, kernelci.org bot <bot@kernelci.org> wrote:
> > stable/linux-3.18.y build: 204 builds: 5 failed, 199 passed, 35 errors, 212 warnings (v3.18.49)
> 
> I've gone through all these now and found a fix. In three cases, there is no
> fix yet since the respective drivers got removed before the warning was
> noticed. Do we have a policy for how to deal with those? Should I just
> send patches to address the warnings for 3.18?

I've wondered about this, and yeah, I would like to see the number drop
to 0 if at all possible (the scsi driver will not change), so i'll be
glad to take patches for the code that is no longer in upstream.

> > Errors summary:
> > 7 arch/mips/jz4740/irq.h:21:38: error: 'struct irq_data' declared inside
> > parameter list will not be visible outside of this definition or declaration
> > [-Werror]
> > 7 arch/mips/jz4740/irq.h:20:39: error: 'struct irq_data' declared inside
> > parameter list will not be visible outside of this definition or declaration
> > [-Werror]
> 
> 
> 5b235dc2647e4 MIPS: Fix the build on jz4740 after removing the custom gpio.h

now applied.

> > 2 arch/mips/mm/fault.c:321:1: error: the frame size of 1104 bytes is larger
> > than 1024 bytes [-Werror=frame-larger-than=]
> 
> This is a result of a newer compiler version, combined with the -Werror
> flag that is applied to arch/mips/, and two of the mips defconfigs overriding
> CONFIG_FRAME_WARN to 1024 on a 64-bit architecture (probably by
> accident).
> 
> I saw this also when I looked at the 3.16 warnings, but only now actually
> bisected it. The fix is
> 
> 86038c5ea81b ("perf: Avoid horrible stack usage")

Now applied.

> > Detailed per-defconfig build reports:
> >
> > allmodconfig+CONFIG_OF=n (x86) ? PASS, 0 errors, 8 warnings, 0 section
> > mismatches
> >
> > Warnings:
> > fs/nfs/nfs4proc.c:3062:10: warning: switch condition has boolean value
> > [-Wswitch-bool]
> 
> c7757074839f ("fs/nfs: fix new compiler warning about boolean in switch")

applied.

> > drivers/iommu/intel-iommu.c:1762:25: warning: unused variable 'drhd'
> > [-Wunused-variable]
> 
> 509fca899d56 ("iommu/vt-d: Remove unused variable")

Ugh, I thought I had found this one in the past, sorry about that, now
applied.

> > drivers/message/i2o/i2o_config.c:893:19: warning: cast to pointer from
> > integer of different size [-Wint-to-pointer-cast]
> > drivers/message/i2o/i2o_config.c:953:10: warning: cast to pointer from
> > integer of different size [-Wint-to-pointer-cast]
> 
> The driver is obsolete and was removed in v4.2. It looks like the warning
> should still be there in v4.1.y, but I don't remember having seen it. It
> would be trivial to fix this with an obvious patch adding a cast.

I'll take a fix :)

> > drivers/staging/bcm/CmHost.c:1503:3: warning: cast to pointer from integer
> > of different size [-Wint-to-pointer-cast]
> > drivers/staging/bcm/CmHost.c:1546:3: warning: cast to pointer from integer
> > of different size [-Wint-to-pointer-cast]
> > drivers/staging/bcm/CmHost.c:1564:3: warning: cast to pointer from integer
> > of different size [-Wint-to-pointer-cast]
> 
> Similarly, the driver was removed in v3.19, but I could create a patch for
> the warning.

I'll take it! :)

> > drivers/scsi/advansys.c:71:2: warning: #warning this driver is still not
> > properly converted to the DMA API [-Wcpp]
> 
> The driver was properly converted in v4.2 and the warning removed, but the
> conversion would be outside of stable-kernel-rules.

Yeah, this one is going to have to stay as-is :(

> > Section mismatches:
> > WARNING: arch/x86/kernel/built-in.o(.text.unlikely+0x157f): Section mismatch
> > in reference from the function cpumask_empty.constprop.3() to the variable
> > .init.data:nmi_ipi_mask
> > WARNING: arch/x86/built-in.o(.text.unlikely+0x189b): Section mismatch in
> > reference from the function cpumask_empty.constprop.3() to the variable
> > .init.data:nmi_ipi_mask
> > WARNING: vmlinux.o(.text.unlikely+0x1962): Section mismatch in reference
> > from the function cpumask_empty.constprop.3() to the variable
> > .init.data:nmi_ipi_mask
> 
> f0ba662a6e06f2 x86: Properly _init-annotate NMI selftest code

That commit is from 3.4, so how can I add it to 3.18? :)

> > allnoconfig (mips) ? PASS, 0 errors, 1 warning, 0 section mismatches
> >
> > Warnings:
> > mm/page_alloc.c:5346:34: warning: array subscript is below array bounds
> > [-Warray-bounds]
> 
> Also bisected this one now, this is also missing on 3.16:
> 
> 90cae1fe1c35 ("mm/init: fix zone boundary creation")

Now applied to 3.1_8_ :)

> > ar7_defconfig (mips) ? PASS, 0 errors, 2 warnings, 0 section mismatches
> >
> > Warnings:
> > include/linux/kernel.h:713:17: warning: comparison of distinct pointer types
> > lacks a cast
> 
> 2f5281ba2a8f ("net: ti: cpmac: Fix compiler warning due to type confusion")

Ugh, I don't know why this one wasn't in 3.18, that makes me wonder what
I missed that went into 4.4 that didn't make it to 3.18...

> > at91_dt_defconfig (arm) ? PASS, 0 errors, 2 warnings, 0 section mismatches
> >
> > Warnings:
> > drivers/clk/at91/clk-usb.c:155:20: warning: initialization from incompatible
> > pointer type [-Wincompatible-pointer-types]
> > drivers/clk/at91/clk-usb.c:193:20: warning: initialization from incompatible
> > pointer type [-Wincompatible-pointer-types]
> 
> I've send this fix:
> 
> 8<------
> clk: at91: usb: fix determine_rate prototype again
> 
> We had an incorrect backport of
> 4591243102fa ("clk: at91: usb: propagate rate modification to the parent clk")
> that was fixed incorrectly in linux-3.18.y by
> 76723e7ed589 ("clk: at91: usb: fix determine_rate prototype")
> 
> This should fix it properly.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> diff --git a/drivers/clk/at91/clk-usb.c b/drivers/clk/at91/clk-usb.c
> index 0283a5713d6c..930a424cc4a0 100644
> --- a/drivers/clk/at91/clk-usb.c
> +++ b/drivers/clk/at91/clk-usb.c
> @@ -59,7 +59,7 @@ static unsigned long
> at91sam9x5_clk_usb_recalc_rate(struct clk_hw *hw,
>  static long at91sam9x5_clk_usb_determine_rate(struct clk_hw *hw,
>        unsigned long rate,
>        unsigned long *best_parent_rate,
> -      struct clk_hw **best_parent_hw)
> +      struct clk **best_parent_hw)
>  {
>   struct clk *parent = NULL;
>   long best_rate = -EINVAL;
> @@ -91,7 +91,7 @@ static long at91sam9x5_clk_usb_determine_rate(struct
> clk_hw *hw,
>   best_rate = tmp_rate;
>   best_diff = tmp_diff;
>   *best_parent_rate = tmp_parent_rate;
> - *best_parent_hw = __clk_get_hw(parent);
> + *best_parent_hw = parent;
>   }
> 
>   if (!best_diff || tmp_rate < rate)
> ---------->8

Applied.

> > ath79_defconfig (mips) ? PASS, 0 errors, 2 warnings, 0 section mismatches
> >
> > Warnings:
> > arch/mips/kernel/entry.S:170: Warning: tried to set unrecognized symbol:
> > MIPS_ISA_LEVEL_RAW
> 
> aebac99384f7 ("MIPS: kernel: entry.S: Set correct ISA level for mips_ihb")

That was in 3.18.14, what kernel are you looking at here???

> > cerfcube_defconfig (arm) ? PASS, 0 errors, 2 warnings, 0 section mismatches
> >
> > Warnings:
> > fs/nfsd/nfs4state.c:3781:3: warning: 'old_deny_bmap' may be used
> > uninitialized in this function [-Wmaybe-uninitialized]
> 
> 5368e1a6 ("nfsd: work around a gcc-5.1 warning")

That commit id isn't in Linus's tree, where did you get it from?

> > corgi_defconfig (arm) ? PASS, 0 errors, 2 warnings, 0 section mismatches
> >
> > Warnings:
> > drivers/usb/gadget/legacy/inode.c:648:10: warning: 'value' may be used
> > uninitialized in this function [-Wmaybe-uninitialized]
> 
> This is caused by the backport of f01d35a15fa0416 from 4.0 to 3.18:
> c81fc59be42c6e0 gadgetfs: use-after-free in ->aio_read()
> 
> The backported patch was buggy, but the mainline code was
> rewritten in a larger patch directly following this one in a way that
> fixed the bug.
> 
> For stable, we should need only a one-line change, which I sent now:
> 
> diff --git a/drivers/usb/gadget/legacy/inode.c
> b/drivers/usb/gadget/legacy/inode.c
> index 54f964bbc79a..fe45311f243e 100644
> --- a/drivers/usb/gadget/legacy/inode.c
> +++ b/drivers/usb/gadget/legacy/inode.c
> @@ -654,6 +654,7 @@ fail:
>     GFP_KERNEL);
>   if (!priv->iv) {
>   kfree(priv);
> + value = -ENOMEM;
>   goto fail;
>   }
>   }

Now applied.

> > defconfig+CONFIG_LKDTM=y (mips) ? PASS, 0 errors, 3 warnings, 0 section
> > mismatches
> >
> > Warnings:
> > include/asm-generic/div64.h:43:28: warning: comparison of distinct pointer
> > types lacks a cast
> > include/asm-generic/div64.h:43:28: warning: comparison of distinct pointer
> > types lacks a cast
> 
> 2ae83bf93882 ("[CIFS] Fix setting time before epoch (negative time values)")

That was in 3.17, are you sure you are looking at 3.18 like the subject
says???

I'll do the rest after lunch...

thanks,

greg k-h
