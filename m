From: james.morse@arm.com (James Morse)
Date: Thu, 28 Jun 2018 11:06:56 +0100
Subject: [RFC/RFT PATCH 2/2] ACPI / APEI: Add DMI matching quirks for
 platforms that require hest_disable
In-Reply-To: <20180628100656.10692-1-james.morse@arm.com>
References: <20180628100656.10692-1-james.morse@arm.com>
Message-ID: <20180628100656.10692-3-james.morse@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some RAS errors are related to an invalid hardware access that was
made by software. Sometimes this happens before the kernel runs.

For example, HPE's ProLiant m400 Server (aka moonshot) trips the
platforms RAS mechanism during UEFI's ExitBootServices. Once the
kernel probes the RAS error descriptor regions, it finds a stale
'fatal error', and hits the deck.

Add a table of DMI matches to allow platforms like this to be
quirked. For moonshot we also want to know the UEFI firmware
version, as this appears to be where the faulting access happens.

This quirk causes the following to be printed during boot:
| [    2.491990] HEST: disabled due to firmware quirk
| [    2.496659] HEST: Table parsing disabled.
[...]
| [    6.341314] GHES: HEST is not enabled!

Link: https://bugzilla.redhat.com/show_bug.cgi?id=1574718
Link: https://www.spinics.net/lists/arm-kernel/msg660956.html
Signed-off-by: James Morse <james.morse@arm.com>
CC: Mark Salter <msalter@redhat.com>
CC: Geoff Levand <geoff@infradead.org>
---
 drivers/acpi/apei/hest.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/acpi/apei/hest.c b/drivers/acpi/apei/hest.c
index b1e9f81ebeea..d0e49f0cd353 100644
--- a/drivers/acpi/apei/hest.c
+++ b/drivers/acpi/apei/hest.c
@@ -23,6 +23,8 @@
  * GNU General Public License for more details.
  */
 
+#include <linux/efi.h>
+#include <linux/dmi.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/init.h>
@@ -212,6 +214,40 @@ err:
 	goto out;
 }
 
+static int __init quirk_hpe_moonshot_m400(const struct dmi_system_id *d)
+{
+	/* Only 'EFI v2.60 by HPE' is known to be affected */
+	unsigned int affected_version = (2<<16) | 60;
+
+	if (!IS_ENABLED(CONFIG_EFI))
+		return 0;
+
+	if (efi_get_runtime_version() == affected_version) {
+		pr_info(HEST_PFX "disabled due to firmware quirk\n");
+		hest_disable = HEST_DISABLED;
+	}
+
+	return 0;
+}
+
+static const struct dmi_system_id hest_quirk_dmi_table[]  __initconst = {
+	{
+		.callback = quirk_hpe_moonshot_m400,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR,	"HPE"),
+			DMI_MATCH(DMI_PRODUCT_NAME,	"ProLiant m400 Server"),
+			DMI_MATCH(DMI_BOARD_NAME,	"ProLiant m400 Server"),
+			DMI_MATCH(DMI_BIOS_VERSION,	"U02"),
+		},
+	},
+	{},
+};
+
+static void __init acpi_hest_quirks(void)
+{
+	dmi_check_system(hest_quirk_dmi_table);
+}
+
 static int __init setup_hest_disable(char *str)
 {
 	hest_disable = HEST_DISABLED;
@@ -226,6 +262,8 @@ void __init acpi_hest_init(void)
 	int rc = -ENODEV;
 	unsigned int ghes_count = 0;
 
+	acpi_hest_quirks();
+
 	if (hest_disable) {
 		pr_info(HEST_PFX "Table parsing disabled.\n");
 		return;
-- 
2.17.1
