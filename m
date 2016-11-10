From: pankaj.dubey@samsung.com (pankaj.dubey)
Date: Thu, 10 Nov 2016 18:07:54 +0530
Subject: [PATCH v3 1/2] ARM: EXYNOS: Remove static mapping of SCU SFR
In-Reply-To: <5066943.nydi3GQ3KP@wuerfel>
References: <1478693755-11953-1-git-send-email-pankaj.dubey@samsung.com>
 <1478693755-11953-2-git-send-email-pankaj.dubey@samsung.com>
 <CGME20161110115456epcas2p4524185a083cd7173e354f46b94be9183@epcas2p4.samsung.com>
 <5066943.nydi3GQ3KP@wuerfel>
Message-ID: <a43af947-6002-bc65-f73b-02d57a78d6cb@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Thursday 10 November 2016 05:24 PM, Arnd Bergmann wrote:
> On Wednesday, November 9, 2016 5:45:54 PM CET Pankaj Dubey wrote:
>> Lets remove static mapping of SCU SFR mainly used in CORTEX-A9 SoC based
>> boards. Instead use mapping from device tree node of SCU.
>>
>> NOTE: This patch has dependency on DT file of any such CORTEX-A9 SoC
>> based boards, in the absence of SCU device node in DTS file, only single
>> CPU will boot. So if you are using OUT-OF-TREE DTS file of CORTEX-A9 based
>> Exynos SoC make sure to add SCU device node to DTS file for SMP boot.
>>
>> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
>> Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>
> 
> With CONFIG_SMP disabled, I now get this build failure:
> 

Sorry, I missed this part and did not check with CONFIG_SMP disabled.

> arch/arm/mach-exynos/pm.o: In function `exynos_enter_aftr':
> pm.c:(.text.exynos_enter_aftr+0xec): undefined reference to `exynos_scu_enable'
> arch/arm/mach-exynos/suspend.o: In function `exynos_pm_resume':
> suspend.c:(.text.exynos_pm_resume+0x78): undefined reference to `exynos_scu_enable'
> 
> Please fix. I have applied a patch locally (see below), but don't know
> if that is the best solution. As we seem to duplicate that code across
> several platforms, I wonder why we don't just put it into the core scu
> implementation.
> 

When I checked scu_enable declaration it is defined in
arch/arm/include/asm/smp_scu.h as:

#if defined(CONFIG_SMP) && defined(CONFIG_HAVE_ARM_SCU)
void scu_enable(void __iomem *scu_base);
#else
static inline void scu_enable(void __iomem *scu_base) {}
#endif

So if CONFIG_SMP is disable then there is no sense of exynos_scu_enable
as well. So wow about using below patch?

--------------------------------------------------------

Subject: [PATCH] ARM: exynos: fix build fail due to exynos_scu_enable

Build failed if we disable CONFIG_SMP as shown below:

arch/arm/mach-exynos/pm.o: In function `exynos_enter_aftr':
pm.c:(.text.exynos_enter_aftr+0xec): undefined reference to
`exynos_scu_enable'
arch/arm/mach-exynos/suspend.o: In function `exynos_pm_resume':
suspend.c:(.text.exynos_pm_resume+0x78): undefined reference to
`exynos_scu_enable'

Since scu_enable is defined only in case CONFIG_SMP and CONFIG_HAVE_ARM_SCU
lets move exynos_scu_enable also under these two macros.

Reported-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
---
 arch/arm/mach-exynos/common.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/mach-exynos/common.h b/arch/arm/mach-exynos/common.h
index fb12d11..03fdb79 100644
--- a/arch/arm/mach-exynos/common.h
+++ b/arch/arm/mach-exynos/common.h
@@ -156,7 +156,12 @@ extern void exynos_cpu_restore_register(void);
 extern void exynos_pm_central_suspend(void);
 extern int exynos_pm_central_resume(void);
 extern void exynos_enter_aftr(void);
+#if defined(CONFIG_SMP) && defined(CONFIG_HAVE_ARM_SCU)
 extern int exynos_scu_enable(void);
+#else
+static inline void exynos_scu_enable(void) {}
+#endif
+

------------------------------------------------------

Of-course your idea to move it in core SCU file is also good that we
lots of duplication in different architecture can be avoided.

In that case I can think of following patch:

[PATCH] ARM: scu: use SCU device node to enable SCU

Many platforms are duplicating code for enabling SCU, lets add
common code to enable SCU using SCU device node so the duplication in
each platform can be avoided.

Suggested-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
---
 arch/arm/include/asm/smp_scu.h |  2 ++
 arch/arm/kernel/smp_scu.c      | 17 +++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/arch/arm/include/asm/smp_scu.h b/arch/arm/include/asm/smp_scu.h
index bfe163c..e5e2492 100644
--- a/arch/arm/include/asm/smp_scu.h
+++ b/arch/arm/include/asm/smp_scu.h
@@ -38,8 +38,10 @@ static inline int scu_power_mode(void __iomem
*scu_base, unsigned int mode)
 #endif

 #if defined(CONFIG_SMP) && defined(CONFIG_HAVE_ARM_SCU)
+int of_scu_enable(void);
 void scu_enable(void __iomem *scu_base);
 #else
+static inline int of_scu_enable(void) {return 0;}
 static inline void scu_enable(void __iomem *scu_base) {}
 #endif

diff --git a/arch/arm/kernel/smp_scu.c b/arch/arm/kernel/smp_scu.c
index 72f9241..7c16d16 100644
--- a/arch/arm/kernel/smp_scu.c
+++ b/arch/arm/kernel/smp_scu.c
@@ -34,6 +34,23 @@ unsigned int __init scu_get_core_count(void __iomem
*scu_base)
 	return (ncores & 0x03) + 1;
 }

+int of_scu_enable(void)
+{
+	struct device_node *np;
+	void __iomem *scu_base;
+
+	np = of_find_compatible_node(NULL, NULL, "arm,cortex-a9-scu");
+	scu_base = of_iomap(np, 0);
+	of_node_put(np);
+	if (!scu_base) {
+		pr_err("%s failed to map scu_base\n", __func__);
+		return -ENOMEM;
+	}
+	scu_enable(scu_base);
+	iounmap(scu_base);
+	return 0;
+}
+
 /*
  * Enable the SCU
  */
-- 


Followed by cleanup in various architecture where this piece of code is
duplicated and all of them can call directly of_scu_enable()


Please let me know which one you will prefer for fixing build issue.

@Krzysztof, please let me know if I need to resubmit SCU series again
with fix or you will accept build fix patch on top of already taken patch.

Thanks,
Pankaj Dubey
