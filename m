From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Fri, 20 Nov 2015 14:17:39 +0000
Subject: [PATCH v5 2/7] xen/arm: introduce HYPERVISOR_platform_op on arm and
 arm64
In-Reply-To: <alpine.DEB.2.02.1511201413050.1107@kaball.uk.xensource.com>
References: <alpine.DEB.2.02.1511201413050.1107@kaball.uk.xensource.com>
Message-ID: <1448029064-22285-2-git-send-email-stefano.stabellini@eu.citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>

---

Changes in v5:
- set interface_version to XENPF_INTERFACE_VERSION in an hypercall
  wrapper

Changes in v2:
- rename dom0_op to platform_op
---
 arch/arm/include/asm/xen/hypercall.h |    7 +++++++
 arch/arm/include/asm/xen/interface.h |    2 ++
 arch/arm/xen/enlighten.c             |    1 +
 arch/arm/xen/hypercall.S             |    1 +
 arch/arm64/xen/hypercall.S           |    1 +
 5 files changed, 12 insertions(+)

diff --git a/arch/arm/include/asm/xen/hypercall.h b/arch/arm/include/asm/xen/hypercall.h
index 712b50e..d769972 100644
--- a/arch/arm/include/asm/xen/hypercall.h
+++ b/arch/arm/include/asm/xen/hypercall.h
@@ -35,6 +35,7 @@
 
 #include <xen/interface/xen.h>
 #include <xen/interface/sched.h>
+#include <xen/interface/platform.h>
 
 long privcmd_call(unsigned call, unsigned long a1,
 		unsigned long a2, unsigned long a3,
@@ -49,6 +50,12 @@ int HYPERVISOR_memory_op(unsigned int cmd, void *arg);
 int HYPERVISOR_physdev_op(int cmd, void *arg);
 int HYPERVISOR_vcpu_op(int cmd, int vcpuid, void *extra_args);
 int HYPERVISOR_tmem_op(void *arg);
+int HYPERVISOR_platform_op_raw(void *arg);
+static inline int HYPERVISOR_platform_op(struct xen_platform_op *op)
+{
+	op->interface_version = XENPF_INTERFACE_VERSION;
+	return HYPERVISOR_platform_op_raw(op);
+}
 int HYPERVISOR_multicall(struct multicall_entry *calls, uint32_t nr);
 
 static inline int
diff --git a/arch/arm/include/asm/xen/interface.h b/arch/arm/include/asm/xen/interface.h
index 5006600..4dfd6d4 100644
--- a/arch/arm/include/asm/xen/interface.h
+++ b/arch/arm/include/asm/xen/interface.h
@@ -27,6 +27,8 @@
 		(hnd).p = val;				\
 	} while (0)
 
+#define __HYPERVISOR_platform_op_raw __HYPERVISOR_platform_op
+
 #ifndef __ASSEMBLY__
 /* Explicitly size integers that represent pfns in the interface with
  * Xen so that we can have one ABI that works for 32 and 64 bit guests.
diff --git a/arch/arm/xen/enlighten.c b/arch/arm/xen/enlighten.c
index 15621b1..2f57ba3 100644
--- a/arch/arm/xen/enlighten.c
+++ b/arch/arm/xen/enlighten.c
@@ -328,5 +328,6 @@ EXPORT_SYMBOL_GPL(HYPERVISOR_memory_op);
 EXPORT_SYMBOL_GPL(HYPERVISOR_physdev_op);
 EXPORT_SYMBOL_GPL(HYPERVISOR_vcpu_op);
 EXPORT_SYMBOL_GPL(HYPERVISOR_tmem_op);
+EXPORT_SYMBOL_GPL(HYPERVISOR_platform_op);
 EXPORT_SYMBOL_GPL(HYPERVISOR_multicall);
 EXPORT_SYMBOL_GPL(privcmd_call);
diff --git a/arch/arm/xen/hypercall.S b/arch/arm/xen/hypercall.S
index 10fd99c..9a36f4f 100644
--- a/arch/arm/xen/hypercall.S
+++ b/arch/arm/xen/hypercall.S
@@ -89,6 +89,7 @@ HYPERCALL2(memory_op);
 HYPERCALL2(physdev_op);
 HYPERCALL3(vcpu_op);
 HYPERCALL1(tmem_op);
+HYPERCALL1(platform_op_raw);
 HYPERCALL2(multicall);
 
 ENTRY(privcmd_call)
diff --git a/arch/arm64/xen/hypercall.S b/arch/arm64/xen/hypercall.S
index 8bbe940..70df80e 100644
--- a/arch/arm64/xen/hypercall.S
+++ b/arch/arm64/xen/hypercall.S
@@ -80,6 +80,7 @@ HYPERCALL2(memory_op);
 HYPERCALL2(physdev_op);
 HYPERCALL3(vcpu_op);
 HYPERCALL1(tmem_op);
+HYPERCALL1(platform_op_raw);
 HYPERCALL2(multicall);
 
 ENTRY(privcmd_call)
-- 
1.7.10.4
