From: Sudeep.KarkadaNagesha@arm.com (Sudeep KarkadaNagesha)
Date: Mon, 22 Jul 2013 12:32:14 +0100
Subject: [PATCH v3 03/16] driver/core: cpu: initialize of_node in cpu's device
 struture
In-Reply-To: <1374492747-13879-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
References: <1374069984-20567-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <1374492747-13879-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
Message-ID: <1374492747-13879-4-git-send-email-Sudeep.KarkadaNagesha@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>

CPUs are also registered as devices but the of_node in these cpu
devices are not initialized. Currently different drivers requiring
to access cpu device node are parsing the nodes themselves and
initialising the of_node in cpu device.

The of_node in all the cpu devices needs to be initialized properly
and at one place. The best place to update this is CPU subsystem
driver when registering the cpu devices.

The OF/DT core library now provides of_get_cpu_node to retrieve a cpu
device node for a given logical index by abstracting the architecture
specific details.

This patch uses of_get_cpu_node to assign of_node when registering the
cpu devices.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Acked-by: Rob Herring <rob.herring@calxeda.com>
Signed-off-by: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
---
 drivers/base/cpu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
index 4c358bc..ea51c6d 100644
--- a/drivers/base/cpu.c
+++ b/drivers/base/cpu.c
@@ -14,6 +14,7 @@
 #include <linux/slab.h>
 #include <linux/percpu.h>
 #include <linux/acpi.h>
+#include <linux/of.h>
 
 #include "base.h"
 
@@ -289,6 +290,7 @@ int register_cpu(struct cpu *cpu, int num)
 	cpu->dev.release = cpu_device_release;
 	cpu->dev.offline_disabled = !cpu->hotpluggable;
 	cpu->dev.offline = !cpu_online(num);
+	cpu->dev.of_node = of_get_cpu_node(num);
 #ifdef CONFIG_ARCH_HAS_CPU_AUTOPROBE
 	cpu->dev.bus->uevent = arch_cpu_uevent;
 #endif
-- 
1.8.1.2
