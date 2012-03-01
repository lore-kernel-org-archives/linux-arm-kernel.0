From: rob.lee@linaro.org (Rob Lee)
Date: Thu, 1 Mar 2012 14:57:54 -0600
Subject: [PATCH v7 0/9] Consolidate cpuidle functionality
In-Reply-To: <1330562578-3410-1-git-send-email-rob.lee@linaro.org>
References: <1330562578-3410-1-git-send-email-rob.lee@linaro.org>
Message-ID: <CAMXH7KGJtSyeGwEN4jz9TRPxHUjtreMHRG-4WDChB0BC88P=OA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 29, 2012 at 6:42 PM, Robert Lee <rob.lee@linaro.org> wrote:
> This patch series moves various functionality duplicated in platform
> cpuidle drivers to the core cpuidle driver. Also, the platform irq
> disabling was removed as it appears that all calls into
> cpuidle_call_idle will have already called local_irq_disable().
>

I'm told that I forgot to add the Acks from the previous v6 to this version:

Acked-by: Jean Pihet <j-pihet@ti.com> (v6)
Tested-by: Jean Pihet <j-pihet@ti.com> (v6, omap3)
Tested-by: Amit Daniel <amit.kachhap@linaro.org> (v6, Exynos4)
For the generic cpuidle changes:
Reviewed-by: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>

If anyone sees other omissions or has any suggested changes or
improvements in my patch submissions semantics, please let me know.

Thanks,
Rob

> Rafael,
>
> Could you review this patchset and merge patch 1/9 once its ready? ?It
> seems pretty close to being acceptable. ?The get_maintainer script shows
> Len Brown as the cpuidle maintainer but I've been unable to get a response
> from him so far. ?If you are not the right person, could you suggest
> who I can make this request to? ?Thanks.
>
> Note to platform maintainers:
>
> Platform patches (2/9 to 9/9) in this patchset are not required to work
> with patch 1/9 but please review and push these platform changes as possible
> to allow this consolidation to occur.
>
> Based on 3.3-rc5 plus recent exynos cpuidle patch (affects exynos cpuidle only):
> http://www.spinics.net/lists/linux-samsung-soc/msg09467.html
>
> v6 submission tested successfully on Exynos (thanks Amit Kacchap) and OMAP3
> (thanks Jean Pihet) platforms.
>
> v6 submission can be found here:
> http://www.spinics.net/lists/arm-kernel/msg162018.html
> Changes since v6:
> * Made some ?struct whitespace alignment changes.
> * Fixed a coding style violation (thanks Jean Pihet)
> * Fixed a bug in davinci cpuidle (thanks Jean Pihet)
> * Corrected the common ARM cpuidle WFI state description to be ARM platform
> ?agnostic (thanks Kevin Hilman)
> * Fixed the problem causing x86 and PPC builds to fail (thanks Deepthi)
> * Re-added a line of code that was mistakenly removed (thanks Deepthi)
>
> Robert Lee (9):
> ?cpuidle: Add common time keeping and irq enabling
> ?ARM: at91: Consolidate time keeping and irq enable
> ?ARM: exynos: Consolidate time keeping and irq enable
> ?ARM: kirkwood: Consolidate time keeping and irq enable
> ?ARM: davinci: Consolidate time keeping and irq enable
> ?ARM: omap: Consolidate OMAP3 time keeping and irq enable
> ?ARM: omap: Consolidate OMAP4 time keeping and irq enable
> ?ARM: shmobile: Consolidate time keeping and irq enable
> ?SH: shmobile: Consolidate time keeping and irq enable
>
> ?arch/arm/include/asm/cpuidle.h ? ? ? ?| ? 22 +++++++++
> ?arch/arm/kernel/Makefile ? ? ? ? ? ? ?| ? ?2 +-
> ?arch/arm/kernel/cpuidle.c ? ? ? ? ? ? | ? 21 ++++++++
> ?arch/arm/mach-at91/cpuidle.c ? ? ? ? ?| ? 67 ++++++++++-----------------
> ?arch/arm/mach-davinci/cpuidle.c ? ? ? | ? 82 +++++++++++++-------------------
> ?arch/arm/mach-exynos/cpuidle.c ? ? ? ?| ? 53 ++-------------------
> ?arch/arm/mach-kirkwood/cpuidle.c ? ? ?| ? 72 ++++++++--------------------
> ?arch/arm/mach-omap2/cpuidle34xx.c ? ? | ? 42 +++++++----------
> ?arch/arm/mach-omap2/cpuidle44xx.c ? ? | ? 21 +-------
> ?arch/arm/mach-shmobile/cpuidle.c ? ? ?| ? 31 +++----------
> ?arch/sh/kernel/cpu/shmobile/cpuidle.c | ? 10 +---
> ?drivers/cpuidle/cpuidle.c ? ? ? ? ? ? | ? 79 +++++++++++++++++++++++++------
> ?include/linux/cpuidle.h ? ? ? ? ? ? ? | ? 13 +++++-
> ?13 files changed, 233 insertions(+), 282 deletions(-)
> ?create mode 100644 arch/arm/include/asm/cpuidle.h
> ?create mode 100644 arch/arm/kernel/cpuidle.c
>
