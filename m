From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 19 Aug 2016 19:32:33 +0200
Subject: [PATCH v3 12/12] reset: Add Tegra BPMP reset driver
In-Reply-To: <20160819173233.13260-1-thierry.reding@gmail.com>
References: <20160819173233.13260-1-thierry.reding@gmail.com>
Message-ID: <20160819173233.13260-13-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thierry Reding <treding@nvidia.com>

This driver uses the services provided by the BPMP firmware driver to
implement a reset driver based on the MRQ_RESET request.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/reset/Makefile           |  1 +
 drivers/reset/tegra/Makefile     |  1 +
 drivers/reset/tegra/reset-bpmp.c | 63 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 65 insertions(+)
 create mode 100644 drivers/reset/tegra/Makefile
 create mode 100644 drivers/reset/tegra/reset-bpmp.c

diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
index 5d65a93d3c43..523f2d705d24 100644
--- a/drivers/reset/Makefile
+++ b/drivers/reset/Makefile
@@ -6,6 +6,7 @@ obj-$(CONFIG_MACH_PISTACHIO) += reset-pistachio.o
 obj-$(CONFIG_ARCH_MESON) += reset-meson.o
 obj-$(CONFIG_ARCH_SUNXI) += reset-sunxi.o
 obj-$(CONFIG_ARCH_STI) += sti/
+obj-$(CONFIG_ARCH_TEGRA) += tegra/
 obj-$(CONFIG_ARCH_HISI) += hisilicon/
 obj-$(CONFIG_ARCH_ZYNQ) += reset-zynq.o
 obj-$(CONFIG_ATH79) += reset-ath79.o
diff --git a/drivers/reset/tegra/Makefile b/drivers/reset/tegra/Makefile
new file mode 100644
index 000000000000..fd943b1ae029
--- /dev/null
+++ b/drivers/reset/tegra/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_ARCH_TEGRA_186_SOC)	+= reset-bpmp.o
diff --git a/drivers/reset/tegra/reset-bpmp.c b/drivers/reset/tegra/reset-bpmp.c
new file mode 100644
index 000000000000..a06e45dc3f30
--- /dev/null
+++ b/drivers/reset/tegra/reset-bpmp.c
@@ -0,0 +1,63 @@
+#include <linux/reset-controller.h>
+
+#include <soc/tegra/bpmp.h>
+#include <soc/tegra/bpmp-abi.h>
+
+static struct tegra_bpmp *to_tegra_bpmp(struct reset_controller_dev *rstc)
+{
+	return container_of(rstc, struct tegra_bpmp, rstc);
+}
+
+static int tegra_bpmp_reset_common(struct reset_controller_dev *rstc,
+				   enum mrq_reset_commands command,
+				   unsigned int id)
+{
+	struct tegra_bpmp *bpmp = to_tegra_bpmp(rstc);
+	struct mrq_reset_request request;
+	struct tegra_bpmp_message msg;
+
+	memset(&request, 0, sizeof(request));
+	request.cmd = command;
+	request.reset_id = id;
+
+	memset(&msg, 0, sizeof(msg));
+	msg.mrq = MRQ_RESET;
+	msg.tx.data = &request;
+	msg.tx.size = sizeof(request);
+
+	return tegra_bpmp_transfer(bpmp, &msg);
+}
+
+static int tegra_bpmp_reset_module(struct reset_controller_dev *rstc,
+				   unsigned long id)
+{
+	return tegra_bpmp_reset_common(rstc, CMD_RESET_MODULE, id);
+}
+
+static int tegra_bpmp_reset_assert(struct reset_controller_dev *rstc,
+				   unsigned long id)
+{
+	return tegra_bpmp_reset_common(rstc, CMD_RESET_ASSERT, id);
+}
+
+static int tegra_bpmp_reset_deassert(struct reset_controller_dev *rstc,
+				     unsigned long id)
+{
+	return tegra_bpmp_reset_common(rstc, CMD_RESET_DEASSERT, id);
+}
+
+static const struct reset_control_ops tegra_bpmp_reset_ops = {
+	.reset = tegra_bpmp_reset_module,
+	.assert = tegra_bpmp_reset_assert,
+	.deassert = tegra_bpmp_reset_deassert,
+};
+
+int tegra_bpmp_init_resets(struct tegra_bpmp *bpmp)
+{
+	bpmp->rstc.ops = &tegra_bpmp_reset_ops;
+	bpmp->rstc.owner = THIS_MODULE;
+	bpmp->rstc.of_node = bpmp->dev->of_node;
+	bpmp->rstc.nr_resets = bpmp->soc->num_resets;
+
+	return devm_reset_controller_register(bpmp->dev, &bpmp->rstc);
+}
-- 
2.9.0
