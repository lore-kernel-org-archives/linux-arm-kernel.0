From: Tero.Kristo@nokia.com (Tero.Kristo at nokia.com)
Date: Wed, 26 Jan 2011 09:27:03 +0000
Subject: [PATCH] OMAP3: PM: fix save secure RAM to restore MPU power state
In-Reply-To: <1296003011-26427-1-git-send-email-khilman@ti.com>
References: <1296003011-26427-1-git-send-email-khilman@ti.com>
Message-ID: <854C6400F5AA6644BA6FE7953F3E769B0376F954@008-AM1MPN1-012.mgdnok.nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



>-----Original Message-----
>From: ext Kevin Hilman [mailto:khilman at ti.com]
>Sent: 26 January, 2011 02:50
>To: linux-omap at vger.kernel.org
>Cc: linux-arm-kernel at lists.infradead.org; Kristo Tero (Nokia-MS/Tampere)
>Subject: [PATCH] OMAP3: PM: fix save secure RAM to restore MPU power
>state
>
>Currently, on HS/EMU devices, MPU power state forced to on during PM
>init by the save secure RAM code.  Rather than forcing the state of
>MPU powerdomain to on, simply read the current value and restore it
>after the ROM code has run.
>
>This only affects the !CPUidle case since when CPUidle is enabled, the
>MPU power state is dynamically changed by CPUidle.  In the !CPUidle
>case, MPU power state is initialized once at init and never touched.
>
>Cc: Tero Kristo <tero.kristo@nokia.com>
>Signed-off-by: Kevin Hilman <khilman@ti.com>
>---
>If no objectsions, will be queued in my pm-fixes branch for 2.6.38-rc.

Looks good to me. Ack, if you need one.
 
>
> arch/arm/mach-omap2/pm34xx.c |    7 ++++---
> 1 files changed, 4 insertions(+), 3 deletions(-)
>
>diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
>index 8cbbead..1916038 100644
>--- a/arch/arm/mach-omap2/pm34xx.c
>+++ b/arch/arm/mach-omap2/pm34xx.c
>@@ -168,9 +168,10 @@ static void omap3_core_restore_context(void)
>  * once during boot sequence, but this works as we are not using secure
>  * services.
>  */
>-static void omap3_save_secure_ram_context(u32 target_mpu_state)
>+static void omap3_save_secure_ram_context(void)
> {
> 	u32 ret;
>+	int mpu_next_state = pwrdm_read_next_pwrst(mpu_pwrdm);
>
> 	if (omap_type() != OMAP2_DEVICE_TYPE_GP) {
> 		/*
>@@ -181,7 +182,7 @@ static void omap3_save_secure_ram_context(u32
>target_mpu_state)
> 		pwrdm_set_next_pwrst(mpu_pwrdm, PWRDM_POWER_ON);
> 		ret = _omap_save_secure_sram((u32 *)
> 				__pa(omap3_secure_ram_storage));
>-		pwrdm_set_next_pwrst(mpu_pwrdm, target_mpu_state);
>+		pwrdm_set_next_pwrst(mpu_pwrdm, mpu_next_state);
> 		/* Following is for error tracking, it should not happen */
> 		if (ret) {
> 			printk(KERN_ERR "save_secure_sram() returns %08x\n",
>@@ -1094,7 +1095,7 @@ static int __init omap3_pm_init(void)
> 		local_fiq_disable();
>
> 		omap_dma_global_context_save();
>-		omap3_save_secure_ram_context(PWRDM_POWER_ON);
>+		omap3_save_secure_ram_context();
> 		omap_dma_global_context_restore();
>
> 		local_irq_enable();
>--
>1.7.3.5
