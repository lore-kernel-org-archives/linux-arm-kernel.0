From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 20 Mar 2018 12:43:48 +0000
Subject: Failed to boot ARM64 boards for recent linux-next
In-Reply-To: <1d4d0797-1630-b09d-943d-1a1cac178700@rock-chips.com>
References: <dae4b3b8-3da4-4a86-ac4a-0631802fa546@rock-chips.com>
 <077cecdd-7982-dd33-454f-e38cc571366c@arm.com>
 <9cff515e-fcb9-a1c0-329b-a18c3bed0071@rock-chips.com>
 <2dfe4f47-8163-d7a4-c9cc-d60b9f0e71a8@arm.com>
 <1d4d0797-1630-b09d-943d-1a1cac178700@rock-chips.com>
Message-ID: <46f5f8b2-44bb-d1ab-4949-9cc4a96a7e1b@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/03/18 10:06, Shawn Lin wrote:
> Hi Marc,
> 
> ? 2018/3/20 17:56, Marc Zyngier ??:
>> On 20/03/18 09:32, Shawn Lin wrote:
>>> Hi Marc,
>>>
>>> On 2018/3/20 17:01, Marc Zyngier wrote:
>>>> Hi Shawn,
>>>>
>>>> On 20/03/18 08:48, Shawn Lin wrote:
>>>>> Hi Marc,
>>>>>
>>>>>        I was able to boot my RK3399 board with in linux-next-20180314,
>>>>> but not today. My bisect robot shows me it was introduced by
>>>>>
>>>>> commit d6062a6d62c643a06c393745d032da3e6441d4bd
>>>>> Author: Marc Zyngier <marc.zyngier@arm.com>
>>>>> Date:   Fri Mar 9 14:53:19 2018 +0000
>>>>>
>>>>>        irqchip/gic-v3: Reset APgRn registers at boot time
>>>>>
>>>>>        Booting a crash kernel while in an interrupt handler is likely
>>>>>        to leave the Active Priority Registers with some state that
>>>>>        is not relevant to the new kernel, and is likely to lead
>>>>>        to erratic behaviours such as interrupts not firing as their
>>>>>        priority is already active.
>>>>>
>>>>>        As a sanity measure, wipe the APRs clean on startup. We make
>>>>>        sure to wipe both group 0 and 1 registers in order to avoid
>>>>>        any surprise.
>>>>>
>>>>>
>>>>> The panic log is here:
>>>>> https://paste.ubuntu.com/p/7WrJJDG6JQ/
>>>>>
>>>>> Is it a known issue or is there a coming patch for that?
>>>>
>>>>    Interesting. No, that wasn't the intention, but I may have missed a key
>>>> detail (group 0 access traps to EL3 if SCR_EL3.FIQ==1). Can you have a
>>>> go at the following hack, just to narrow it down:
>>>>
>>>> diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
>>>> index 5bb7bb22f1c1..f8ff43b1d4f8 100644
>>>> --- a/drivers/irqchip/irq-gic-v3.c
>>>> +++ b/drivers/irqchip/irq-gic-v3.c
>>>> @@ -570,16 +570,12 @@ static void gic_cpu_sys_reg_init(void)
>>>>    	switch(val + 1) {
>>>>    	case 8:
>>>>    	case 7:
>>>> -		write_gicreg(0, ICC_AP0R3_EL1);
>>>>    		write_gicreg(0, ICC_AP1R3_EL1);
>>>> -		write_gicreg(0, ICC_AP0R2_EL1);
>>>>    		write_gicreg(0, ICC_AP1R2_EL1);
>>>>    	case 6:
>>>> -		write_gicreg(0, ICC_AP0R1_EL1);
>>>>    		write_gicreg(0, ICC_AP1R1_EL1);
>>>>    	case 5:
>>>>    	case 4:
>>>> -		write_gicreg(0, ICC_AP0R0_EL1);
>>>>    		write_gicreg(0, ICC_AP1R0_EL1);
>>>>    	}
>>>>
>>>> Let me know if that helps.
>>>>
>>>
>>> It works for me. Thanks!
>> OK. Would you mind testing a much more complete patch?
> 
> Hmm.. the more complete patch doesn't work for me.

Right. Slightly more complicated than I though. This new one should be 
much better (or at least I hope...).

Please let me know if that helps.

	M.

>From f5cca850375f22d850816d86747a5e89e67344b0 Mon Sep 17 00:00:00 2001
From: Marc Zyngier <marc.zyngier@arm.com>
Date: Tue, 20 Mar 2018 09:46:42 +0000
Subject: [PATCH] irqchip/gic-v3: Check availability of Group0 before resetting
 AP0Rn

We now try to reset the Active Priority Registers at boot time,
without checking  if we actually have access to them. Bad move.
If the secure side has set SCR_EL3.FIQ=1, we'll trap to EL3, and
the firmware may not be please to get such an exception.

Instead, let's use PMR to find out if its value gets affected by
SCR_EL3.FIQ being set. We use the fact that when SCR_EL3.FIQ is
set, the LSB of the priority is lost due to the shifting back and
forth of the actual priority. If we read back a 0, we know that
Group0 is unavailable.

Fixes: d6062a6d62c6 ("irqchip/gic-v3: Reset APgRn registers at boot time")
Reported-by: Shawn Lin <shawn.lin@rock-chips.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/include/asm/arch_gicv3.h   |  6 +----
 arch/arm64/include/asm/arch_gicv3.h |  5 ----
 drivers/irqchip/irq-gic-v3.c        | 48 +++++++++++++++++++++++++++++--------
 3 files changed, 39 insertions(+), 20 deletions(-)

diff --git a/arch/arm/include/asm/arch_gicv3.h b/arch/arm/include/asm/arch_gicv3.h
index 27288bdbd840..0bd530702118 100644
--- a/arch/arm/include/asm/arch_gicv3.h
+++ b/arch/arm/include/asm/arch_gicv3.h
@@ -137,6 +137,7 @@ static inline u64 read_ ## a64(void)		\
 	return val; 				\
 }
 
+CPUIF_MAP(ICC_PMR, ICC_PMR_EL1)
 CPUIF_MAP(ICC_AP0R0, ICC_AP0R0_EL1)
 CPUIF_MAP(ICC_AP0R1, ICC_AP0R1_EL1)
 CPUIF_MAP(ICC_AP0R2, ICC_AP0R2_EL1)
@@ -206,11 +207,6 @@ static inline u32 gic_read_iar(void)
 	return irqstat;
 }
 
-static inline void gic_write_pmr(u32 val)
-{
-	write_sysreg(val, ICC_PMR);
-}
-
 static inline void gic_write_ctlr(u32 val)
 {
 	write_sysreg(val, ICC_CTLR);
diff --git a/arch/arm64/include/asm/arch_gicv3.h b/arch/arm64/include/asm/arch_gicv3.h
index 9becba9ab392..e278f94df0c9 100644
--- a/arch/arm64/include/asm/arch_gicv3.h
+++ b/arch/arm64/include/asm/arch_gicv3.h
@@ -76,11 +76,6 @@ static inline u64 gic_read_iar_cavium_thunderx(void)
 	return irqstat;
 }
 
-static inline void gic_write_pmr(u32 val)
-{
-	write_sysreg_s(val, SYS_ICC_PMR_EL1);
-}
-
 static inline void gic_write_ctlr(u32 val)
 {
 	write_sysreg_s(val, SYS_ICC_CTLR_EL1);
diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 5bb7bb22f1c1..62c6ea4523b8 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -532,7 +532,8 @@ static void gic_cpu_sys_reg_init(void)
 	int i, cpu = smp_processor_id();
 	u64 mpidr = cpu_logical_map(cpu);
 	u64 need_rss = MPIDR_RS(mpidr);
-	u32 val;
+	bool group0;
+	u32 val, pribits;
 
 	/*
 	 * Need to check that the SRE bit has actually been set. If
@@ -544,8 +545,28 @@ static void gic_cpu_sys_reg_init(void)
 	if (!gic_enable_sre())
 		pr_err("GIC: unable to set SRE (disabled at EL2), panic ahead\n");
 
+	pribits = gic_read_ctlr();
+	pribits &= ICC_CTLR_EL1_PRI_BITS_MASK;
+	pribits >>= ICC_CTLR_EL1_PRI_BITS_SHIFT;
+	pribits++;
+
+	/*
+	 * Let's find out if Group0 is under control of EL3 or not by
+	 * setting the highest possible, non-zero priority in PMR.
+	 *
+	 * If SCR_EL3.FIQ is set, the priority gets shifted down in
+	 * order for the CPU interface to set bit 7, and keep the
+	 * actual priority in the non-secure range. In the process, it
+	 * looses the least significant bit and the actual priority
+	 * becomes 0x80. Reading it back returns 0, indicating that
+	 * we're don't have access to Group0.
+	 */
+	write_gicreg(BIT(8 - pribits), ICC_PMR_EL1);
+	val = read_gicreg(ICC_PMR_EL1);
+	group0 = val != 0;
+
 	/* Set priority mask register */
-	gic_write_pmr(DEFAULT_PMR_VALUE);
+	write_gicreg(DEFAULT_PMR_VALUE, ICC_PMR_EL1);
 
 	/*
 	 * Some firmwares hand over to the kernel with the BPR changed from
@@ -563,23 +584,30 @@ static void gic_cpu_sys_reg_init(void)
 		gic_write_ctlr(ICC_CTLR_EL1_EOImode_drop_dir);
 	}
 
-	val = gic_read_ctlr();
-	val &= ICC_CTLR_EL1_PRI_BITS_MASK;
-	val >>= ICC_CTLR_EL1_PRI_BITS_SHIFT;
+	/* Always wack Group0 before Group1 */
+	if (group0) {
+		switch(pribits) {
+		case 8:
+		case 7:
+			write_gicreg(0, ICC_AP0R3_EL1);
+			write_gicreg(0, ICC_AP0R2_EL1);
+		case 6:
+			write_gicreg(0, ICC_AP0R1_EL1);
+		case 5:
+		case 4:
+			write_gicreg(0, ICC_AP0R0_EL1);
+		}
+	}
 
-	switch(val + 1) {
+	switch(pribits) {
 	case 8:
 	case 7:
-		write_gicreg(0, ICC_AP0R3_EL1);
 		write_gicreg(0, ICC_AP1R3_EL1);
-		write_gicreg(0, ICC_AP0R2_EL1);
 		write_gicreg(0, ICC_AP1R2_EL1);
 	case 6:
-		write_gicreg(0, ICC_AP0R1_EL1);
 		write_gicreg(0, ICC_AP1R1_EL1);
 	case 5:
 	case 4:
-		write_gicreg(0, ICC_AP0R0_EL1);
 		write_gicreg(0, ICC_AP1R0_EL1);
 	}
 
-- 
2.14.2


-- 
Jazz is not dead. It just smells funny...
