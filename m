From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Mon, 19 Oct 2015 17:55:34 +0100
Subject: [PATCH v3 2/3] xen,
 cpu_hotplug: call device_offline instead of cpu_down
In-Reply-To: <alpine.DEB.2.02.1510191754000.27957@kaball.uk.xensource.com>
References: <alpine.DEB.2.02.1510191754000.27957@kaball.uk.xensource.com>
Message-ID: <1445273735-15758-2-git-send-email-stefano.stabellini@eu.citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When offlining a cpu, instead of cpu_down, call device_offline, which
also takes care of updating the cpu.dev.offline field. This keeps the
sysfs file /sys/devices/system/cpu/cpuN/online, up to date.  Also move
the call to disable_hotplug_cpu, because it makes more sense to have it
there.

Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
CC: konrad.wilk at oracle.com
CC: boris.ostrovsky at oracle.com
CC: david.vrabel at citrix.com
---
 drivers/xen/cpu_hotplug.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/xen/cpu_hotplug.c b/drivers/xen/cpu_hotplug.c
index 43de1f5..78804b5 100644
--- a/drivers/xen/cpu_hotplug.c
+++ b/drivers/xen/cpu_hotplug.c
@@ -18,6 +18,8 @@ static void enable_hotplug_cpu(int cpu)
 
 static void disable_hotplug_cpu(int cpu)
 {
+	if (cpu_online(cpu))
+		device_offline(get_cpu_device(cpu));
 	if (cpu_present(cpu))
 		xen_arch_unregister_cpu(cpu);
 
@@ -55,7 +57,6 @@ static void vcpu_hotplug(unsigned int cpu)
 		enable_hotplug_cpu(cpu);
 		break;
 	case 0:
-		(void)cpu_down(cpu);
 		disable_hotplug_cpu(cpu);
 		break;
 	default:
-- 
1.7.10.4
