From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Sat, 27 Oct 2012 14:47:51 +0530
Subject: [PATCH 6/9] pinctrl: SPEAr1310: Separate out pci pins from pcie_sata
 pin group
In-Reply-To: <cover.1351329224.git.viresh.kumar@linaro.org>
References: <cover.1351329224.git.viresh.kumar@linaro.org>
Message-ID: <a469af2b2cf96ecf3fb8df945b7a77b42be535d8.1351329224.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Vipul Kumar Samar <vipulkumar.samar@st.com>

SPEAr1310 has separate PCI and PCIe implementations which are not muxed with
each other. Presently they have been implemented as muxed together with SATA and
are represented wrongly in the software.

In reality only PCIe and SATA implementations are muxed with each other. This
patch separates out pci pins creating a new pingroup and function for pci.

Signed-off-by: Vipul Kumar Samar <vipulkumar.samar@st.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Reviewed-by: Shiraz Hashim <shiraz.hashim@st.com>
---
 drivers/pinctrl/spear/pinctrl-spear1310.c | 93 +++++++++++++++++--------------
 1 file changed, 51 insertions(+), 42 deletions(-)

diff --git a/drivers/pinctrl/spear/pinctrl-spear1310.c b/drivers/pinctrl/spear/pinctrl-spear1310.c
index baf98ae..a25ab73 100644
--- a/drivers/pinctrl/spear/pinctrl-spear1310.c
+++ b/drivers/pinctrl/spear/pinctrl-spear1310.c
@@ -1763,29 +1763,52 @@ static struct spear_function can1_function = {
 	.ngroups = ARRAY_SIZE(can1_grps),
 };
 
-/* Pad multiplexing for pci device */
-static const unsigned pci_sata_pins[] = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 18,
+/* Pad multiplexing for (ras-ip) pci device */
+static const unsigned pci_pins[] = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 18,
 	19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36,
 	37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54,
 	55, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99 };
-#define PCI_SATA_MUXREG				\
-	{					\
-		.reg = PAD_FUNCTION_EN_0,	\
-		.mask = PMX_MCI_DATA8_15_MASK,	\
-		.val = 0,			\
-	}, {					\
-		.reg = PAD_FUNCTION_EN_1,	\
-		.mask = PMX_PCI_REG1_MASK,	\
-		.val = 0,			\
-	}, {					\
-		.reg = PAD_FUNCTION_EN_2,	\
-		.mask = PMX_PCI_REG2_MASK,	\
-		.val = 0,			\
-	}
 
-/* pad multiplexing for pcie0 device */
+static struct spear_muxreg pci_muxreg[] = {
+	{
+		.reg = PAD_FUNCTION_EN_0,
+		.mask = PMX_MCI_DATA8_15_MASK,
+		.val = 0,
+	}, {
+		.reg = PAD_FUNCTION_EN_1,
+		.mask = PMX_PCI_REG1_MASK,
+		.val = 0,
+	}, {
+		.reg = PAD_FUNCTION_EN_2,
+		.mask = PMX_PCI_REG2_MASK,
+		.val = 0,
+	},
+};
+
+static struct spear_modemux pci_modemux[] = {
+	{
+		.muxregs = pci_muxreg,
+		.nmuxregs = ARRAY_SIZE(pci_muxreg),
+	},
+};
+
+static struct spear_pingroup pci_pingroup = {
+	.name = "pci_grp",
+	.pins = pci_pins,
+	.npins = ARRAY_SIZE(pci_pins),
+	.modemuxs = pci_modemux,
+	.nmodemuxs = ARRAY_SIZE(pci_modemux),
+};
+
+static const char *const pci_grps[] = { "pci_grp" };
+static struct spear_function pci_function = {
+	.name = "pci",
+	.groups = pci_grps,
+	.ngroups = ARRAY_SIZE(pci_grps),
+};
+
+/* pad multiplexing for (fix-part) pcie0 device */
 static struct spear_muxreg pcie0_muxreg[] = {
-	PCI_SATA_MUXREG,
 	{
 		.reg = PCIE_SATA_CFG,
 		.mask = PCIE_CFG_VAL(0),
@@ -1802,15 +1825,12 @@ static struct spear_modemux pcie0_modemux[] = {
 
 static struct spear_pingroup pcie0_pingroup = {
 	.name = "pcie0_grp",
-	.pins = pci_sata_pins,
-	.npins = ARRAY_SIZE(pci_sata_pins),
 	.modemuxs = pcie0_modemux,
 	.nmodemuxs = ARRAY_SIZE(pcie0_modemux),
 };
 
-/* pad multiplexing for pcie1 device */
+/* pad multiplexing for (fix-part) pcie1 device */
 static struct spear_muxreg pcie1_muxreg[] = {
-	PCI_SATA_MUXREG,
 	{
 		.reg = PCIE_SATA_CFG,
 		.mask = PCIE_CFG_VAL(1),
@@ -1827,15 +1847,12 @@ static struct spear_modemux pcie1_modemux[] = {
 
 static struct spear_pingroup pcie1_pingroup = {
 	.name = "pcie1_grp",
-	.pins = pci_sata_pins,
-	.npins = ARRAY_SIZE(pci_sata_pins),
 	.modemuxs = pcie1_modemux,
 	.nmodemuxs = ARRAY_SIZE(pcie1_modemux),
 };
 
-/* pad multiplexing for pcie2 device */
+/* pad multiplexing for (fix-part) pcie2 device */
 static struct spear_muxreg pcie2_muxreg[] = {
-	PCI_SATA_MUXREG,
 	{
 		.reg = PCIE_SATA_CFG,
 		.mask = PCIE_CFG_VAL(2),
@@ -1852,22 +1869,20 @@ static struct spear_modemux pcie2_modemux[] = {
 
 static struct spear_pingroup pcie2_pingroup = {
 	.name = "pcie2_grp",
-	.pins = pci_sata_pins,
-	.npins = ARRAY_SIZE(pci_sata_pins),
 	.modemuxs = pcie2_modemux,
 	.nmodemuxs = ARRAY_SIZE(pcie2_modemux),
 };
 
-static const char *const pci_grps[] = { "pcie0_grp", "pcie1_grp", "pcie2_grp" };
-static struct spear_function pci_function = {
-	.name = "pci",
-	.groups = pci_grps,
-	.ngroups = ARRAY_SIZE(pci_grps),
+static const char *const pcie_grps[] = { "pcie0_grp", "pcie1_grp", "pcie2_grp"
+};
+static struct spear_function pcie_function = {
+	.name = "pci_express",
+	.groups = pcie_grps,
+	.ngroups = ARRAY_SIZE(pcie_grps),
 };
 
 /* pad multiplexing for sata0 device */
 static struct spear_muxreg sata0_muxreg[] = {
-	PCI_SATA_MUXREG,
 	{
 		.reg = PCIE_SATA_CFG,
 		.mask = SATA_CFG_VAL(0),
@@ -1884,15 +1899,12 @@ static struct spear_modemux sata0_modemux[] = {
 
 static struct spear_pingroup sata0_pingroup = {
 	.name = "sata0_grp",
-	.pins = pci_sata_pins,
-	.npins = ARRAY_SIZE(pci_sata_pins),
 	.modemuxs = sata0_modemux,
 	.nmodemuxs = ARRAY_SIZE(sata0_modemux),
 };
 
 /* pad multiplexing for sata1 device */
 static struct spear_muxreg sata1_muxreg[] = {
-	PCI_SATA_MUXREG,
 	{
 		.reg = PCIE_SATA_CFG,
 		.mask = SATA_CFG_VAL(1),
@@ -1909,15 +1921,12 @@ static struct spear_modemux sata1_modemux[] = {
 
 static struct spear_pingroup sata1_pingroup = {
 	.name = "sata1_grp",
-	.pins = pci_sata_pins,
-	.npins = ARRAY_SIZE(pci_sata_pins),
 	.modemuxs = sata1_modemux,
 	.nmodemuxs = ARRAY_SIZE(sata1_modemux),
 };
 
 /* pad multiplexing for sata2 device */
 static struct spear_muxreg sata2_muxreg[] = {
-	PCI_SATA_MUXREG,
 	{
 		.reg = PCIE_SATA_CFG,
 		.mask = SATA_CFG_VAL(2),
@@ -1934,8 +1943,6 @@ static struct spear_modemux sata2_modemux[] = {
 
 static struct spear_pingroup sata2_pingroup = {
 	.name = "sata2_grp",
-	.pins = pci_sata_pins,
-	.npins = ARRAY_SIZE(pci_sata_pins),
 	.modemuxs = sata2_modemux,
 	.nmodemuxs = ARRAY_SIZE(sata2_modemux),
 };
@@ -2093,6 +2100,7 @@ static struct spear_pingroup *spear1310_pingroups[] = {
 	&can0_dis_sd_pingroup,
 	&can1_dis_sd_pingroup,
 	&can1_dis_kbd_pingroup,
+	&pci_pingroup,
 	&pcie0_pingroup,
 	&pcie1_pingroup,
 	&pcie2_pingroup,
@@ -2138,6 +2146,7 @@ static struct spear_function *spear1310_functions[] = {
 	&can0_function,
 	&can1_function,
 	&pci_function,
+	&pcie_function,
 	&sata_function,
 	&ssp1_function,
 	&gpt64_function,
-- 
1.7.12.rc2.18.g61b472e
