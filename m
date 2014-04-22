From: ashwin.chaugule@linaro.org (Ashwin Chaugule)
Date: Tue, 22 Apr 2014 13:32:45 -0400
Subject: [PATCH v6 1/3] PSCI: Add initial support for PSCIv0.2 functions
In-Reply-To: <CALrVBkuSsi=2J1YT7w2bGtcL7CL6_xheZceaRtqETyC9mUqhTw@mail.gmail.com>
References: <1397762146-8337-1-git-send-email-ashwin.chaugule@linaro.org>
 <1397762146-8337-2-git-send-email-ashwin.chaugule@linaro.org>
 <CALrVBkuSsi=2J1YT7w2bGtcL7CL6_xheZceaRtqETyC9mUqhTw@mail.gmail.com>
Message-ID: <CAJ5Y-eZ=ugeav++ysMCbAUFnPMr5=WaCdrEdYojwLi1HTYX6rw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21 April 2014 02:23, Anup Patel <anup.patel@linaro.org> wrote:
> Hi Ashwin,
>
> Please include system reboot & shutdown implementation
> in this patch using PSCI v0.2 SYSTEM_OFF and
> SYSTEM_RESET functions.

hm, I had thought these relied on having the (optional) MIGRATE
function. But thats not the case.

So, how about this..

---------------------8<---------------------

diff --git a/arch/arm/kernel/psci.c b/arch/arm/kernel/psci.c
index ead8cdb..5a54f2f 100644
--- a/arch/arm/kernel/psci.c
+++ b/arch/arm/kernel/psci.c
@@ -17,6 +17,8 @@

 #include <linux/init.h>
 #include <linux/of.h>
+#include <linux/reboot.h>
+#include <linux/pm.h>
 #include <uapi/linux/psci.h>

 #include <asm/compiler.h>
@@ -24,6 +26,7 @@
 #include <asm/opcodes-sec.h>
 #include <asm/opcodes-virt.h>
 #include <asm/psci.h>
+#include <asm/system_misc.h>

 struct psci_operations psci_ops;

@@ -196,6 +199,16 @@ static int get_set_conduit_method(struct device_node *np)
  return 0;
 }

+static void psci_sys_reset(enum reboot_mode reboot_mode, const char *cmd)
+{
+ invoke_psci_fn(PSCI_0_2_FN_SYSTEM_RESET, 0, 0, 0);
+}
+
+static void psci_sys_off(void)
+{
+ invoke_psci_fn(PSCI_0_2_FN_SYSTEM_OFF, 0, 0, 0);
+}
+
 /*
  * PSCI Function IDs for v0.2+ are well defined so use
  * standard values.
@@ -249,6 +262,10 @@ static int psci_0_2_init(struct device_node *np)
  PSCI_0_2_FN_MIGRATE_INFO_TYPE;
  psci_ops.migrate_info_type = psci_migrate_info_type;

+ arm_pm_restart = psci_sys_reset;
+
+ pm_power_off = psci_sys_off;
+
 out_put_node:
  of_node_put(np);
  return err;
diff --git a/arch/arm64/kernel/psci.c b/arch/arm64/kernel/psci.c
index 63a7685..583b7c3 100644
--- a/arch/arm64/kernel/psci.c
+++ b/arch/arm64/kernel/psci.c
@@ -18,6 +18,8 @@
 #include <linux/init.h>
 #include <linux/of.h>
 #include <linux/smp.h>
+#include <linux/reboot.h>
+#include <linux/pm.h>
 #include <uapi/linux/psci.h>

 #include <asm/compiler.h>
@@ -25,6 +27,7 @@
 #include <asm/errno.h>
 #include <asm/psci.h>
 #include <asm/smp_plat.h>
+#include <asm/system_misc.h>

 #define PSCI_POWER_STATE_TYPE_STANDBY 0
 #define PSCI_POWER_STATE_TYPE_POWER_DOWN 1
@@ -217,6 +220,16 @@ static int get_set_conduit_method(struct device_node *np)
  return 0;
 }

+static void psci_sys_reset(enum reboot_mode reboot_mode, const char *cmd)
+{
+ invoke_psci_fn(PSCI_0_2_FN_SYSTEM_RESET, 0, 0, 0);
+}
+
+static void psci_sys_off(void)
+{
+ invoke_psci_fn(PSCI_0_2_FN_SYSTEM_OFF, 0, 0, 0);
+}
+
 /*
  * PSCI Function IDs for v0.2+ are well defined so use
  * standard values.
@@ -270,6 +283,10 @@ static int psci_0_2_init(struct device_node *np)
  PSCI_0_2_FN_MIGRATE_INFO_TYPE;
  psci_ops.migrate_info_type = psci_migrate_info_type;

+ arm_pm_restart = psci_sys_reset;
+
+ pm_power_off = psci_sys_off;
+
 out_put_node:
  of_node_put(np);
  return err;
