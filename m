From: xiexiuqi@huawei.com (Xie XiuQi)
Date: Thu, 30 Mar 2017 18:31:03 +0800
Subject: [PATCH v3 3/8] arm64: apei: add a per-cpu variable to indecate sei is
 processing
In-Reply-To: <1490869877-118713-1-git-send-email-xiexiuqi@huawei.com>
References: <1490869877-118713-1-git-send-email-xiexiuqi@huawei.com>
Message-ID: <1490869877-118713-4-git-send-email-xiexiuqi@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a per-cpu variable to indicate sei is processing, with which we could use to
reserve a separate virtual space address page for sei in next patch

Signed-off-by: Xie XiuQi <xiexiuqi@huawei.com>
---
 arch/arm64/kernel/traps.c | 4 ++++
 include/acpi/ghes.h       | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index 53710a2..955dc8c 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -615,6 +615,8 @@ const char *esr_get_class_string(u32 esr)
 	return esr_class_str[ESR_ELx_EC(esr)];
 }
 
+DEFINE_PER_CPU(int, sei_in_process);
+
 /*
  * bad_mode handles the impossible case in the exception vector. This is always
  * fatal.
@@ -632,7 +634,9 @@ asmlinkage void bad_mode(struct pt_regs *regs, int reason, unsigned int esr)
 	 * of cper records at a time. There is no risk for one cpu to parse ghes table.
 	 */
 	if (IS_ENABLED(CONFIG_ACPI_APEI_SEI) && ESR_ELx_EC(esr) == ESR_ELx_EC_SERROR) {
+		this_cpu_inc(sei_in_process);
 		ghes_notify_sei();
+		this_cpu_dec(sei_in_process);
 	}
 
 	die("Oops - bad mode", regs, 0);
diff --git a/include/acpi/ghes.h b/include/acpi/ghes.h
index 10d752e..eed79ea 100644
--- a/include/acpi/ghes.h
+++ b/include/acpi/ghes.h
@@ -102,4 +102,6 @@ static inline void *acpi_hest_generic_data_payload(struct acpi_hest_generic_data
 int ghes_notify_sea(void);
 int ghes_notify_sei(void);
 
+DECLARE_PER_CPU(int, sei_in_process);
+
 #endif /* GHES_H */
-- 
1.8.3.1
