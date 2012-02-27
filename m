From: amit.kucheria@linaro.org (Amit Kucheria)
Date: Mon, 27 Feb 2012 18:32:40 +0200
Subject: [PATCH v5 0/9] Consolidate cpuidle functionality
In-Reply-To: <1330318063-25460-1-git-send-email-rob.lee@linaro.org>
References: <1330318063-25460-1-git-send-email-rob.lee@linaro.org>
Message-ID: <CAHLCerOQPxTxbFRyRVW2DwThvOSBsr-R2VxfN=CCctTNkv3x=w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CC'ing Venki on this too.

The entire thread can be found at:
http://www.spinics.net/lists/arm-kernel/msg161596.html

On Mon, Feb 27, 2012 at 6:47 AM, Robert Lee <rob.lee@linaro.org> wrote:
> This patch series moves vaious functionality duplicated in platform
> cpuidle drivers to the core cpuidle driver. Also, the platform irq
> disabling was removed as it appears that all calls into
> cpuidle_call_idle will have already called local_irq_disable().
>
>
> Based on 3.3-rc5 plus recent exynos cpuidle patch:
> http://www.spinics.net/lists/linux-samsung-soc/msg09467.html
>
> v4 submission can be found here:
> http://lists.infradead.org/pipermail/linux-arm-kernel/2012-January/082742.html
>
> Changes since v4:
> * Added common cpu_do_idle function to core cpuidle
> * Added time keep irq en wrapper to core cpuidle
> * Removed pre/post enter
> * Re-added platforms that can use new common code.
>
> v3 submission can be found here:
> http://www.spinics.net/lists/arm-kernel/msg156751.html
> Changes since v3:
> * Removed drivers/cpuidle/common.c
> ** Removed the initialization helper functions
> ** Removed the wrapper used to consolidate time keeping and irq enable/disable
> * Add time keeping and local_irq_disable handling in cpuidle_call_idle().
> * Made necessary modifications to a few platforms that required the most changes
> ** Note on omap3: changed structure of omap3_idle_drvdata and added
> ?per_next_state and per_saved_state vars to accomodate new framework.
>
> v2 submission can be found here:
> http://comments.gmane.org/gmane.linux.ports.arm.kernel/144199
>
> Changes since v2:
> * Made various code organization and style changes as suggested in v1 review.
> * Removed at91 use of common code. ?A separate effort is underway to clean
> at91 code and the author has offered to convert to common interface as part
> of those changes (if this common interface is accepted in time).
> * Made platform cpuidle_driver objects __initdata and dynamically added one
> persistent instance of this object in common code.
> * Removed imx5 pm usage of gpc_dvfs clock as it is no longer needed after
> being enabled during clock initialization.
> * Re-organized patches.
>
> v1 submission can be found here:
> http://comments.gmane.org/gmane.linux.ports.arm.kernel/142791
>
> Changes since v1:
> * Common interface moved to drivers/cpuidle and made non arch-specific.
> * Made various fixes and suggested additions to the common cpuidle
> code from v1 review.
> * Added callback for filling in driver_data field as needed.
> * Modified the various platforms with these changes.
>
> Robert Lee (9):
> ?cpuidle: Add commonly used functionality for consolidation
> ?SH: shmobile: cpuidle consolidation
> ?ARM: omap: Consolidate OMAP3 cpuidle time keeping and irq enable
> ?ARM: omap: Consolidate OMAP4 cpuidle time keeping and irq enable
> ?ARM: shmobile: Consolidate cpuidle functionality
> ?ARM: davinci: Consolidate cpuidle functionality
> ?ARM: exynos: Consolidate cpuidle functionality
> ?ARM: kirkwood: Consolidate cpuidle functionality
> ?ARM: at91: Consolidate cpuidle functionality
>
> ?arch/arm/mach-at91/cpuidle.c ? ? ? ? ?| ? 64 +++++++++------------------
> ?arch/arm/mach-davinci/cpuidle.c ? ? ? | ? 77 +++++++++++++--------------------
> ?arch/arm/mach-exynos/cpuidle.c ? ? ? ?| ? 52 ++--------------------
> ?arch/arm/mach-kirkwood/cpuidle.c ? ? ?| ? 71 +++++++++----------------------
> ?arch/arm/mach-omap2/cpuidle34xx.c ? ? | ? 43 ++++++++-----------
> ?arch/arm/mach-omap2/cpuidle44xx.c ? ? | ? 21 +--------
> ?arch/arm/mach-shmobile/cpuidle.c ? ? ?| ? 22 +---------
> ?arch/sh/kernel/cpu/shmobile/cpuidle.c | ? 10 +---
> ?drivers/cpuidle/cpuidle.c ? ? ? ? ? ? | ? 37 +++++++++------
> ?include/linux/cpuidle.h ? ? ? ? ? ? ? | ? 55 +++++++++++++++++++++++
> ?10 files changed, 180 insertions(+), 272 deletions(-)
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
