From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Mon, 19 Oct 2015 17:55:35 +0100
Subject: [PATCH v3 3/3] xen/arm: don't try to re-register vcpu_info on
 cpu_hotplug.
In-Reply-To: <alpine.DEB.2.02.1510191754000.27957@kaball.uk.xensource.com>
References: <alpine.DEB.2.02.1510191754000.27957@kaball.uk.xensource.com>
Message-ID: <1445273735-15758-3-git-send-email-stefano.stabellini@eu.citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Call disable_percpu_irq on CPU_DYING and enable_percpu_irq when the cpu
is coming up.

Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>

---

Changes in v3:
- call disable_percpu_irq on CPU_DYING
- call enable_percpu_irq even when VCPUOP_register_vcpu_info has already
been called

Changes in v2:
- better comment
---
 arch/arm/xen/enlighten.c |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/xen/enlighten.c b/arch/arm/xen/enlighten.c
index 6c09cc4..074b1a2 100644
--- a/arch/arm/xen/enlighten.c
+++ b/arch/arm/xen/enlighten.c
@@ -93,6 +93,17 @@ static void xen_percpu_init(void)
 	int err;
 	int cpu = get_cpu();
 
+	/* 
+	 * VCPUOP_register_vcpu_info cannot be called twice for the same
+	 * vcpu, so if vcpu_info is already registered, just get out. This
+	 * can happen with cpu-hotplug.
+	 */
+	if (per_cpu(xen_vcpu, cpu) != NULL) {
+		enable_percpu_irq(xen_events_irq, 0);
+		put_cpu();
+		return;
+	}
+
 	pr_info("Xen: initializing cpu%d\n", cpu);
 	vcpup = per_cpu_ptr(xen_vcpu_info, cpu);
 
@@ -131,6 +142,9 @@ static int xen_cpu_notification(struct notifier_block *self,
 	case CPU_STARTING:
 		xen_percpu_init();
 		break;
+	case CPU_DYING:
+		disable_percpu_irq(xen_events_irq);
+		break;
 	default:
 		break;
 	}
-- 
1.7.10.4
