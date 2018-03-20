From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 20 Mar 2018 09:01:17 +0000
Subject: Failed to boot ARM64 boards for recent linux-next
In-Reply-To: <dae4b3b8-3da4-4a86-ac4a-0631802fa546@rock-chips.com>
References: <dae4b3b8-3da4-4a86-ac4a-0631802fa546@rock-chips.com>
Message-ID: <077cecdd-7982-dd33-454f-e38cc571366c@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

On 20/03/18 08:48, Shawn Lin wrote:
> Hi Marc,
> 
>      I was able to boot my RK3399 board with in linux-next-20180314,
> but not today. My bisect robot shows me it was introduced by
> 
> commit d6062a6d62c643a06c393745d032da3e6441d4bd
> Author: Marc Zyngier <marc.zyngier@arm.com>
> Date:   Fri Mar 9 14:53:19 2018 +0000
> 
>      irqchip/gic-v3: Reset APgRn registers at boot time
> 
>      Booting a crash kernel while in an interrupt handler is likely
>      to leave the Active Priority Registers with some state that
>      is not relevant to the new kernel, and is likely to lead
>      to erratic behaviours such as interrupts not firing as their
>      priority is already active.
> 
>      As a sanity measure, wipe the APRs clean on startup. We make
>      sure to wipe both group 0 and 1 registers in order to avoid
>      any surprise.
> 
> 
> The panic log is here:
> https://paste.ubuntu.com/p/7WrJJDG6JQ/
> 
> Is it a known issue or is there a coming patch for that?

 Interesting. No, that wasn't the intention, but I may have missed a key
detail (group 0 access traps to EL3 if SCR_EL3.FIQ==1). Can you have a
go at the following hack, just to narrow it down:

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 5bb7bb22f1c1..f8ff43b1d4f8 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -570,16 +570,12 @@ static void gic_cpu_sys_reg_init(void)
 	switch(val + 1) {
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

Let me know if that helps.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
