From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 23 Oct 2013 17:06:19 +0200
Subject: [RFC] of: Allow for experimental device tree bindings
Message-ID: <1382540779-6334-1-git-send-email-treding@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Past and recent discussions have shown that there's some concensus that
device tree bindings should be considered an ABI and therefore need to
remain backwards-compatible once code to implement them is included in
the final release of a Linux kernel.

At the same time there is a desire to keep some manoeuvre while we're
trying to figure things out. The fact is that many of us lack the
experience to design good bindings from the start. At the same time
there is a shortage of people that can review bindings and help design
better ones.

Progress and the addition of new features (and restoration of features
that used to work before the advent of DT for that matter) are blocked
to a large degree because of that.

This patch attempts to restore some degree of freedom by introducing an
easy way to mark device tree bindings as experimental as well as a way
for users to disable the use of experimental bindings if they choose
functionality at the cost of potential device tree incompatibilities.

Bindings are marked experimental by prefixing the compatible value with
an exclamation mark (!). In order to make it clear that experimental
bindings are undesirable in the long run, a warning will be output when
an experimental binding is encountered.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/of/Kconfig |  7 +++++++
 drivers/of/base.c  | 32 +++++++++++++++++++++++++++++++-
 2 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/drivers/of/Kconfig b/drivers/of/Kconfig
index 78cc760..dc482f8 100644
--- a/drivers/of/Kconfig
+++ b/drivers/of/Kconfig
@@ -24,6 +24,13 @@ config OF_SELFTEST
 
 	  If unsure, say N here, but this option is safe to enable.
 
+config OF_EXPERIMENTAL
+	bool "Support experimental device tree bindings"
+	help
+	  This option allows experimental device tree bindings to be used.
+	  Note that experimental bindings are subject to change, possibly
+	  requiring the DTB to be updated.
+
 config OF_FLATTREE
 	bool
 	select DTC
diff --git a/drivers/of/base.c b/drivers/of/base.c
index a96f850..b0b8371 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -342,6 +342,36 @@ struct device_node *of_get_cpu_node(int cpu, unsigned int *thread)
 }
 EXPORT_SYMBOL(of_get_cpu_node);
 
+static int of_compat_match(const char *device, const char *driver,
+			   const struct device_node *np)
+{
+	const char *dev = device;
+	const char *drv = driver;
+
+	if (device[0] == '!')
+		device++;
+
+	if (driver[0] == '!')
+		driver++;
+
+	if (of_compat_cmp(device, driver, strlen(driver)) != 0)
+		return 0;
+
+	/* check if binding is experimental */
+	if (dev != device || drv != driver) {
+		pr_warn("of: device %s (%s) uses an experimental binding\n",
+			np->name, np->full_name);
+
+		/* don't match if we don't want experimental bindings */
+		if (!IS_ENABLED(CONFIG_OF_EXPERIMENTAL)) {
+			pr_err("of: refusing to use binding \"%s\"\n", device);
+			return 0;
+		}
+	}
+
+	return 1;
+}
+
 /** Checks if the given "compat" string matches one of the strings in
  * the device's "compatible" property
  */
@@ -355,7 +385,7 @@ static int __of_device_is_compatible(const struct device_node *device,
 	if (cp == NULL)
 		return 0;
 	while (cplen > 0) {
-		if (of_compat_cmp(cp, compat, strlen(compat)) == 0)
+		if (of_compat_match(cp, compat, device))
 			return 1;
 		l = strlen(cp) + 1;
 		cp += l;
-- 
1.8.4
