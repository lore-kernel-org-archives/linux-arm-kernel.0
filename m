From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 21 Feb 2017 15:22:16 +0000
Subject: [PATCH 2/2] arch_timer: acpi: add hisi timer erratum data
In-Reply-To: <58AC2AEF.1030803@huawei.com> (Hanjun Guo's message of "Tue, 21
 Feb 2017 19:56:31 +0800")
References: <1485254391-51551-1-git-send-email-guohanjun@huawei.com>
 <1485254391-51551-3-git-send-email-guohanjun@huawei.com>
 <20170124105717.GB6277@leverpostej>
 <a2ac2a70-09fb-5cec-c090-b8ebde90e24f@arm.com>
 <589D6776.2010400@huawei.com>
 <6c3a2952-731b-dfae-ba22-f9d7df25d691@arm.com>
 <58AC2AEF.1030803@huawei.com>
Message-ID: <874lzn602f.fsf@on-the-bus.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 21 2017 at 11:56:31 am GMT, Hanjun Guo <guohanjun@huawei.com> wrote:
> Hi Marc,

[...]

> Thank you very much! I prepared an ACPI patch based on your branch, I was
> trying to reuse the "const void *id" for ACPI as well but we need to match the
> oem_id, oem_table_id and oem_revision in GTDT table, so I introduced new
> matching information for ACPI, please take a look if it's OK.
>
> commit 02d531ae4a88c483db849a611bd9bf7c39d2e1bf
> Author: Hanjun Guo <hanjun.guo@linaro.org>
> Date:   Tue Feb 21 15:17:14 2017 +0800
>
>     arm64: arch_timer: enable the erratums in ACPI way
>    
>     Match OEM information which are oem_id, oem_table_id and oem_revision
>     to enable the erratum for specific platforms.
>    
>     Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> ---
>  arch/arm64/include/asm/arch_timer.h  |  7 +++++++
>  drivers/clocksource/arm_arch_timer.c | 31 +++++++++++++++++++++++++++++++
>  2 files changed, 38 insertions(+)
>
> diff --git a/arch/arm64/include/asm/arch_timer.h b/arch/arm64/include/asm/arch_timer.h
> index 1595134..79d033c 100644
> --- a/arch/arm64/include/asm/arch_timer.h
> +++ b/arch/arm64/include/asm/arch_timer.h
> @@ -22,6 +22,7 @@
>  #include <asm/barrier.h>
>  #include <asm/sysreg.h>
>  
> +#include <linux/acpi.h>
>  #include <linux/bug.h>
>  #include <linux/init.h>
>  #include <linux/jump_label.h>
> @@ -42,6 +43,7 @@ enum arch_timer_erratum_match_type {
>         ate_match_dt,
>         ate_match_global_cap_id,
>         ate_match_local_cap_id,
> + ate_match_acpi,
>  };
>  
>  struct clock_event_device;
> @@ -49,6 +51,11 @@ enum arch_timer_erratum_match_type {
>  struct arch_timer_erratum_workaround {
>         enum arch_timer_erratum_match_type match_type;
>         const void *id;         /* Indicate the Erratum ID */
> +#ifdef CONFIG_ACPI
> + char oem_id[ACPI_OEM_ID_SIZE + 1];
> + char oem_table_id[ACPI_OEM_TABLE_ID_SIZE + 1];
> + u32 oem_revision;
> +#endif
>         const char *desc_str;
>         u32 (*read_cntp_tval_el0)(void);
>         u32 (*read_cntv_tval_el0)(void);
> diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
> index bbd9361..82ff6e4 100644
> --- a/drivers/clocksource/arm_arch_timer.c
> +++ b/drivers/clocksource/arm_arch_timer.c
> @@ -363,6 +363,32 @@ bool arch_timer_check_dt_erratum(const struct arch_timer_erratum_workaround
> *wa,
>         return of_property_read_bool(np, wa->id);
>  }
>  
> +#ifdef CONFIG_ACPI
> +static bool
> +arch_timer_check_acpi_erratum(const struct arch_timer_erratum_workaround *wa,
> +                       const void *arg)
> +{
> + const struct acpi_table_header *table = arg;
> +
> + if (!wa->oem_id || !wa->oem_table_id)
> +         return false;
> +
> + if (!memcmp(wa->oem_id, table->oem_id, ACPI_OEM_ID_SIZE) &&
> +     !memcmp(wa->oem_table_id, table->oem_table_id,
> +             ACPI_OEM_TABLE_ID_SIZE) &&
> +     wa->oem_revision == table->oem_revision) {
> +         return true;
> + }
> +
> + return false;
> +}
> +#else
> +static inline bool
> +arch_timer_check_acpi_erratum(const struct arch_timer_erratum_workaround *wa,
> +                       const void *arg)
> +{ return false; }
> +#endif
> +
>  static
>  bool arch_timer_check_global_cap_erratum(const struct arch_timer_erratum_workaround *wa,
>                                          const void *arg)
> @@ -440,6 +466,9 @@ static void arch_timer_check_ool_workaround(enum arch_timer_erratum_match_typ
> e t
>                 match_fn = arch_timer_check_local_cap_erratum;
>                 local = true;
>                 break;
> + case ate_match_acpi:
> +         match_fn = arch_timer_check_acpi_erratum;
> +         break;
>         }
>
>         wa = arch_timer_iterate_errata(type, match_fn, arg);
> @@ -1284,6 +1313,8 @@ static int __init arch_timer_acpi_init(struct acpi_table_header *table)
>         /* Check for globally applicable workarounds */
>         arch_timer_check_ool_workaround(ate_match_global_cap_id, NULL);
>  
> + arch_timer_check_ool_workaround(ate_match_acpi, table);
> +
>         arch_timer_init();
>         return 0;
>  }
>
> And I got compile errors for this patch [1], seems "#include <linux/acpi.h>" in
> arch/arm64/include/asm/arch_timer.h triggers the problem of head
> file inclusions (too early to include <linux/sched.h>?), I'm looking into it,
> if you can help to take a look too, that will be great :)

This is really much more complicated (and uglier) than what I had in
mind, and I don't want to add more cruft to the erratum description
structure. So instead of trying to explain what I wanted to see, here's
the patches I whipped together.

Please let me know if they work for you (as I have no way of testing
them).

Thanks,

	M.

>From 50eb735436f9f6482285939b39b52d858d848537 Mon Sep 17 00:00:00 2001
From: Marc Zyngier <marc.zyngier@arm.com>
Date: Tue, 21 Feb 2017 14:37:30 +0000
Subject: [PATCH 1/2] arm64: arch_timer: Allow erratum matching with ACPI OEM
 information

Just as we're able to identify a broken platform using some DT
information, let's enable a way to spot the offenders with ACPI.

The difference is that we can only match on some OEM info instead
of implementation-specific properties. So in order to avoid the
insane multiplication of errata structures, we allow an array
of OEM descriptions to be attached to an erratum structure.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/include/asm/arch_timer.h  |  1 +
 drivers/clocksource/arm_arch_timer.c | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/arch/arm64/include/asm/arch_timer.h b/arch/arm64/include/asm/arch_timer.h
index 159513479f6e..2e635deba776 100644
--- a/arch/arm64/include/asm/arch_timer.h
+++ b/arch/arm64/include/asm/arch_timer.h
@@ -42,6 +42,7 @@ enum arch_timer_erratum_match_type {
 	ate_match_dt,
 	ate_match_global_cap_id,
 	ate_match_local_cap_id,
+	ate_match_acpi_oem_info,
 };
 
 struct clock_event_device;
diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index bbd9361c7d66..1de18113e5ae 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -189,6 +189,12 @@ static struct cyclecounter cyclecounter = {
 	.mask	= CLOCKSOURCE_MASK(56),
 };
 
+struct ate_acpi_oem_info {
+	char oem_id[ACPI_OEM_ID_SIZE + 1];
+	char oem_table_id[ACPI_OEM_TABLE_ID_SIZE + 1];
+	u32 oem_revision;
+};
+
 #ifdef CONFIG_FSL_ERRATUM_A008585
 /*
  * The number of retries is an arbitrary value well beyond the highest number
@@ -377,6 +383,29 @@ bool arch_timer_check_local_cap_erratum(const struct arch_timer_erratum_workarou
 	return this_cpu_has_cap((uintptr_t)wa->id);
 }
 
+
+static
+bool arch_timer_check_acpi_oem_erratum(const struct arch_timer_erratum_workaround *wa,
+				       const void *arg)
+{
+	static const struct ate_acpi_oem_info empty_oem_info = {};
+	const struct ate_acpi_oem_info *info = wa->id;
+	const struct acpi_table_header *table = arg;
+
+	/* Iterate over the ACPI EOM info array, looking for a match */
+	while (memcmp(info, &empty_oem_info, sizeof(*info))) {
+		if (!memcmp(info->oem_id, table->oem_id, ACPI_OEM_ID_SIZE) &&
+		    !memcmp(info->oem_table_id, table->oem_table_id, ACPI_OEM_TABLE_ID_SIZE) &&
+		    info->oem_revision == table->oem_revision)
+
+			return true;
+
+		info++;
+	}
+
+	return false;
+}
+
 static const struct arch_timer_erratum_workaround *
 arch_timer_iterate_errata(enum arch_timer_erratum_match_type type,
 			  ate_match_fn_t match_fn,
@@ -440,6 +469,9 @@ static void arch_timer_check_ool_workaround(enum arch_timer_erratum_match_type t
 		match_fn = arch_timer_check_local_cap_erratum;
 		local = true;
 		break;
+	case ate_match_acpi_oem_info:
+		match_fn = arch_timer_check_acpi_oem_erratum;
+		break;
 	}
 
 	wa = arch_timer_iterate_errata(type, match_fn, arg);
@@ -1283,6 +1315,7 @@ static int __init arch_timer_acpi_init(struct acpi_table_header *table)
 
 	/* Check for globally applicable workarounds */
 	arch_timer_check_ool_workaround(ate_match_global_cap_id, NULL);
+	arch_timer_check_ool_workaround(ate_match_acpi_oem_info, table);
 
 	arch_timer_init();
 	return 0;
-- 
2.11.0


>From 857eae645c7dd0cf6c7cd652dd87bbe8041a5d70 Mon Sep 17 00:00:00 2001
From: Marc Zyngier <marc.zyngier@arm.com>
Date: Tue, 21 Feb 2017 15:04:27 +0000
Subject: [PATCH 2/2] arm64: arch_timer: Add HISILICON_ERRATUM_161010101 ACPI
 matching data

In order to deal with ACPI enabled platforms suffering from the
HISILICON_ERRATUM_161010101, let's add the required OEM data that
allow the workaround to be enabled.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/clocksource/arm_arch_timer.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 1de18113e5ae..062046bca9eb 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -269,6 +269,25 @@ static u64 notrace hisi_161010101_read_cntvct_el0(void)
 {
 	return __hisi_161010101_read_reg(cntvct_el0);
 }
+
+static struct ate_acpi_oem_info hisi_161010101_oem_info[] = {
+	{
+		.oem_id		= "HISI  ",
+		.oem_table_id	= "HIP05   ",
+		.oem_revision	= 0,
+	},
+	{
+		.oem_id		= "HISI  ",
+		.oem_table_id	= "HIP06   ",
+		.oem_revision	= 0,
+	},
+	{
+		.oem_id		= "HISI  ",
+		.oem_table_id	= "HIP07   ",
+		.oem_revision	= 0,
+	},
+	{ },
+};
 #endif
 
 #ifdef CONFIG_ARM64_ERRATUM_858921
@@ -346,6 +365,16 @@ static const struct arch_timer_erratum_workaround ool_workarounds[] = {
 		.set_next_event_phys = erratum_set_next_event_tval_phys,
 		.set_next_event_virt = erratum_set_next_event_tval_virt,
 	},
+	{
+		.match_type = ate_match_acpi_oem_info,
+		.id = hisi_161010101_oem_info,
+		.desc_str = "HiSilicon erratum 161010101",
+		.read_cntp_tval_el0 = hisi_161010101_read_cntp_tval_el0,
+		.read_cntv_tval_el0 = hisi_161010101_read_cntv_tval_el0,
+		.read_cntvct_el0 = hisi_161010101_read_cntvct_el0,
+		.set_next_event_phys = erratum_set_next_event_tval_phys,
+		.set_next_event_virt = erratum_set_next_event_tval_virt,
+	},
 #endif
 #ifdef CONFIG_ARM64_ERRATUM_858921
 	{
-- 
2.11.0


-- 
Jazz is not dead, it just smell funny.
