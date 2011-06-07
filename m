From: frank.hofmann@tomtom.com (Frank Hofmann)
Date: Tue, 7 Jun 2011 17:48:17 +0100 (BST)
Subject: [RFC PATCH v4] ARM hibernation/suspend-to-disk support
Message-ID: <alpine.DEB.2.00.1106071722040.2236@localhost6.localdomain6>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

time for another round on this one...

This got quite a bit cleaned up now.

There's now no more need for a "swsusp context" at all. The code uses 
cpu_suspend/resume and keeps the snapshot state on the stack while 
writing it out.

There are a few dependencies this patch brings in:

* due to the use of cpu_suspend / cpu_resume, it'll only apply as-is
   to kernels no older than f6b0fa02e8b0708d17d631afce456524eadf87ff,
   where Russell King introduced the generic interface.
   Patching these into older kernels is a little work.

* it temporarily uses swapper_pg_dir and establishes 1:1 mappings there
   for a MMU-off transition, which is necessary before resume.
   In order to tear these down afterwards, identity_mapping_del() needs
   to be called; for some reason that's #ifdef CONFIG_SMP ...

* it needs to "catch" sleep_save_sp after cpu_suspend() so that resume
   can be provided with the proper starting point.
   This requires an ENTRY(sleep_save_sp) in arch/arm/kernel/sleep.S so
   that the symbol becomes public.

* it assumes cpu_reset will disable the MMU. cpu_v6_reset/cpu_v7_reset
   are currently not doing so (amongst some other minor chip types).

* there's kind of a circular dependency between CONFIG_HIBERNATION and
   CONFIG_PM_SLEEP, on ARM. The latter is necessary so that cpu_suspend
   and cpu_resume are compiled in, but it cannot be selected via
   ARCH_HIBERNATION_POSSIBLE because CONFIG_PM_SLEEP depends on
   CONFIG_HIBERNATION_INTERFACE - selected by CONFIG_HIBERNATION.

   Consequence is that right now, both CONFIG_PM_SLEEP and ...HIBERNATION
   must be set in your defconfig file to be able to compile.

   (my head swirls from writing this ...)

Otherwise, this is by far the cleanest in the series yet.


I've tested this on ARM1176; still need to do OMAP3 (Cortex-A8), will 
report on that.


Please let me know what you think,
FrankH.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: hibernation-07Jun2011.patch
Type: text/x-diff
Size: 7450 bytes
Desc: 
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110607/3a42d570/attachment.bin>
