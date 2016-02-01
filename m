From: fu.wei@linaro.org (fu.wei at linaro.org)
Date: Tue,  2 Feb 2016 04:26:58 +0800
Subject: [PATCH v3 6/6] kvm: arm64: Add ACPI support for virt arch timer
In-Reply-To: <1454358418-5157-1-git-send-email-fu.wei@linaro.org>
References: <1454358418-5157-1-git-send-email-fu.wei@linaro.org>
Message-ID: <1454358418-5157-7-git-send-email-fu.wei@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fu Wei <fu.wei@linaro.org>

This patch adds ACPI/GTDT support for virt arch timer
using the API in GTDT driver.

Signed-off-by: Fu Wei <fu.wei@linaro.org>
---
 virt/kvm/arm/arch_timer.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/virt/kvm/arm/arch_timer.c b/virt/kvm/arm/arch_timer.c
index 0a279d3..4077347 100644
--- a/virt/kvm/arm/arch_timer.c
+++ b/virt/kvm/arm/arch_timer.c
@@ -385,6 +385,9 @@ static int kvm_timer_get_ppi(unsigned int *ppi)
 {
 	struct device_node *np;
 	int ret = -EINVAL;
+#ifdef CONFIG_ACPI_GTDT
+	struct arch_timer_data data;
+#endif
 
 	np = of_find_matching_node(NULL, arch_timer_of_match);
 	if (!np) {
@@ -397,6 +400,11 @@ static int kvm_timer_get_ppi(unsigned int *ppi)
 	of_node_put(np);
 
 skip_of:
+#ifdef CONFIG_ACPI_GTDT
+	if (!*ppi && !gtdt_arch_timer_data_init(NULL, &data))
+		*ppi = data.virt_ppi;
+#endif
+
 	if (*ppi)
 		return 0;
 
-- 
2.5.0
