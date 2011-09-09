From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Fri, 9 Sep 2011 19:41:08 +0530
Subject: [PATCH 14/25] OMAP4: PM: Add CPUX OFF mode support
In-Reply-To: <20110909141321.GC32138@S2100-06.ap.freescale.net>
References: <1315144466-9395-1-git-send-email-santosh.shilimkar@ti.com>
	<1315144466-9395-15-git-send-email-santosh.shilimkar@ti.com>
	<20110909080416.GF31581@S2100-06.ap.freescale.net>
	<4E69C9CF.6090709@ti.com>
	<20110909141321.GC32138@S2100-06.ap.freescale.net>
Message-ID: <CAMQu2gxeDzFGyhsXK-wDkyiJRoD6_GN58m=3_=NC8yKa_ThJnQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 9, 2011 at 7:43 PM, Shawn Guo <shawn.guo@freescale.com> wrote:
> On Fri, Sep 09, 2011 at 01:39:51PM +0530, Santosh wrote:
>> On Friday 09 September 2011 01:34 PM, Shawn Guo wrote:
>> >Hi Santosh,
>> >
>> >On Sun, Sep 04, 2011 at 07:24:15PM +0530, Santosh Shilimkar wrote:
>> >>This patch adds the CPU0 and CPU1 off mode support. CPUX close switch
>> >>retention (CSWR) is not supported by hardware design.
>> >>
>> >>The CPUx OFF mode isn't supported on OMAP4430 ES1.0
>> >>
>> >>CPUx sleep code is common for hotplug, suspend and CPUilde.
>> >>
>> >>Signed-off-by: Santosh Shilimkar<santosh.shilimkar@ti.com>
>> >>Cc: Kevin Hilman<khilman@ti.com>
>> >>---
>> >> ?arch/arm/mach-omap2/Makefile ? ? ? ? ? ? ? ? ? ?| ? ?3 +-
>> >> ?arch/arm/mach-omap2/include/mach/omap-secure.h ?| ? ?8 +
>> >> ?arch/arm/mach-omap2/include/mach/omap4-common.h | ? 25 +++
>> >> ?arch/arm/mach-omap2/omap-mpuss-lowpower.c ? ? ? | ?249 +++++++++++++++++++++++
>> >> ?arch/arm/mach-omap2/omap-smp.c ? ? ? ? ? ? ? ? ?| ? ?6 +
>> >> ?arch/arm/mach-omap2/omap4-sar-layout.h ? ? ? ? ?| ? ?9 +
>> >> ?arch/arm/mach-omap2/pm44xx.c ? ? ? ? ? ? ? ? ? ?| ? ?6 +
>> >> ?arch/arm/mach-omap2/sleep44xx.S ? ? ? ? ? ? ? ? | ?213 +++++++++++++++++++
>> >> ?8 files changed, 518 insertions(+), 1 deletions(-)
>> >> ?create mode 100644 arch/arm/mach-omap2/omap-mpuss-lowpower.c
>> >>
>> >
>> >[...]
>> >
>> >>diff --git a/arch/arm/mach-omap2/sleep44xx.S b/arch/arm/mach-omap2/sleep44xx.S
>> >>index 049f426..230ab8c 100644
>> >>--- a/arch/arm/mach-omap2/sleep44xx.S
>> >>+++ b/arch/arm/mach-omap2/sleep44xx.S
>> >>@@ -11,8 +11,221 @@
>> >>
>> >> ?#include<linux/linkage.h>
>> >> ?#include<asm/system.h>
>> >>+#include<asm/smp_scu.h>
>> >>+#include<asm/memory.h>
>> >>+#include<asm/hardware/cache-l2x0.h>
>> >>
>> >>+#include<plat/omap44xx.h>
>> >> ?#include<mach/omap4-common.h>
>> >>+#include<mach/omap-secure.h>
>> >>+
>> >>+#include "omap4-sar-layout.h"
>> >>+
>> >>+#ifdef CONFIG_SMP
>> >>+
>> >>+.macro ? ? DO_SMC
>> >>+ ? dsb
>> >>+ ? smc ? ? #0
>> >>+ ? dsb
>> >>+.endm
>> >>+
>> >>+ppa_zero_params:
>> >>+ ? .word ? ? ? ? ? 0x0
>> >>+
>> >>+/*
>> >>+ * =============================
>> >>+ * == CPU suspend finisher ==
>> >>+ * =============================
>> >>+ *
>> >>+ * void omap4_finish_suspend(unsigned long cpu_state)
>> >>+ *
>> >>+ * This function code saves the CPU context and performs the CPU
>> >>+ * power down sequence. Calling WFI effectively changes the CPU
>> >>+ * power domains states to the desired target power state.
>> >>+ *
>> >>+ * @cpu_state : contains context save state (r0)
>> >>+ * 0 - No context lost
>> >>+ * ? ? ? ? 1 - CPUx L1 and logic lost: MPUSS CSWR
>> >>+ * ? ? ? ? 2 - CPUx L1 and logic lost + GIC lost: MPUSS OSWR
>> >>+ * 3 - CPUx L1 and logic lost + GIC + L2 lost: MPUSS OFF
>> >
>> >I was told by rmk that same as imx6q, omap44xx will retain L2 content
>> >across suspen/resume cycle. ?Then what does "L2 lost" mean here? ?Or
>> >what rmk meant is the case cpu_state == 2?
>> >
>> Yes.
>>
>> The last case is entire SOC OFF. We call Device OFF in OMAP.
>> All voltages will scale to 0 V. This isn't supported by this
>> series.
>>
> Then the second question would be what the following patch in this
> series is for.
>
> ? ?[PATCH 20/25] OMAP4: PM: Add L2X0 cache lowpower support
>
> I could have read the patch incorrectly, but it seems l2x_clean_inv
> will also be called for "MPUSS OSWR" in which case L2 is retained?
> Shouldn't L2 for this case have been handled by rmk's patch (ARM: pm:
> add L2 cache cleaning for suspend)?
>
Yes you did read it wrongly :)
It won't be called for OSWR
