From: tony@atomide.com (Tony Lindgren)
Date: Tue, 5 Oct 2010 15:19:52 -0700
Subject: [PATCH] ARM: Check for is_smp for tlb_ops and cache_ops boardcast
In-Reply-To: <20100908031214.GI22507@atomide.com>
References: <20100817104414.19061.38999.stgit@baageli.muru.com>
	<20100906104413.GD20903@n2100.arm.linux.org.uk>
	<20100906180346.GC20849@atomide.com>
	<20100908030951.GH22507@atomide.com>
	<20100908031214.GI22507@atomide.com>
Message-ID: <20101005221952.GV3117@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren <tony@atomide.com> [100907 20:04]:
> This should not be needed when running on UP systems.
> 
> Additionally we will also get an undefined instruction on ARM cores
> without the extended CPUID registers with CONFIG_SMP_ON_UP.
> 
> Also, we can now remove the is_smp() test from mmu.c.

Just FYI, I've updated this one more time with to use cpus_empty
instead of !smp_on_up() here as well.

Regards,

Tony

From: Tony Lindgren <tony@atomide.com>
Date: Tue, 5 Oct 2010 08:28:32 -0700
Subject: [PATCH] ARM: Check for is_smp for tlb_ops and cache_ops broadcast

Broadcast should not be needed when running SMP kernel on UP systems.

Also, this fixes an undefined instruction for SMP_ON_UP on earlier ARM
cores without the extended CPUID_EXT_MMFR3 register.

Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/include/asm/smp_plat.h b/arch/arm/include/asm/smp_plat.h
index 7de5aa5..c8f7a08 100644
--- a/arch/arm/include/asm/smp_plat.h
+++ b/arch/arm/include/asm/smp_plat.h
@@ -10,11 +10,23 @@
 /* all SMP configurations have the extended CPUID registers */
 static inline int tlb_ops_need_broadcast(void)
 {
+	cpumask_t mask = cpu_online_map;
+
+	cpu_clear(smp_processor_id(), mask);
+	if (cpus_empty(mask))
+		return 0;
+
 	return ((read_cpuid_ext(CPUID_EXT_MMFR3) >> 12) & 0xf) < 2;
 }
 
 static inline int cache_ops_need_broadcast(void)
 {
+	cpumask_t mask = cpu_online_map;
+
+	cpu_clear(smp_processor_id(), mask);
+	if (cpus_empty(mask))
+		return 0;
+
 	return ((read_cpuid_ext(CPUID_EXT_MMFR3) >> 12) & 0xf) < 1;
 }
 
