From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Wed, 21 Oct 2015 12:53:49 +0100
Subject: [PATCH v4 2/3] xen,
 cpu_hotplug: call device_offline instead of cpu_down
In-Reply-To: <alpine.DEB.2.02.1510211251370.27957@kaball.uk.xensource.com>
References: <alpine.DEB.2.02.1510211251370.27957@kaball.uk.xensource.com>
Message-ID: <1445428430-21567-2-git-send-email-stefano.stabellini@eu.citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When offlining a cpu, instead of cpu_down, call device_offline, which
also takes care of updating the cpu.dev.offline field. This keeps the
sysfs file /sys/devices/system/cpu/cpuN/online, up to date.  Also move
the call to disable_hotplug_cpu, because it makes more sense to have it
there.

We don't call device_online at cpu-hotplug time, because that would
immediately take the cpu online, while we want to retain the current
behaviour: the user needs to explicitly enable the cpu after it has
been hotplugged.

Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
CC: konrad.wilk at oracle.com
CC: boris.ostrovsky at oracle.com
CC: david.vrabel at citrix.com

---

Changes in v4:
- protect device_offline with lock/unlock_device_hotplug
- improve commit message
---
 drivers/xen/cpu_hotplug.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/xen/cpu_hotplug.c b/drivers/xen/cpu_hotplug.c
index 43de1f5..5676aef 100644
--- a/drivers/xen/cpu_hotplug.c
+++ b/drivers/xen/cpu_hotplug.c
@@ -18,6 +18,11 @@ static void enable_hotplug_cpu(int cpu)
 
 static void disable_hotplug_cpu(int cpu)
 {
+	if (cpu_online(cpu)) {
+		lock_device_hotplug();
+		device_offline(get_cpu_device(cpu));
+		unlock_device_hotplug();
+	}
 	if (cpu_present(cpu))
 		xen_arch_unregister_cpu(cpu);
 
@@ -55,7 +60,6 @@ static void vcpu_hotplug(unsigned int cpu)
 		enable_hotplug_cpu(cpu);
 		break;
 	case 0:
-		(void)cpu_down(cpu);
 		disable_hotplug_cpu(cpu);
 		break;
 	default:
-- 
1.7.10.4
