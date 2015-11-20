From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Fri, 20 Nov 2015 11:58:18 +0000
Subject: [Xen-devel] [PATCH v4 2/7] xen/arm: introduce
 HYPERVISOR_platform_op on arm and arm64
In-Reply-To: <1447666977.15629.9.camel@citrix.com>
References: <alpine.DEB.2.02.1511121726370.526@kaball.uk.xensource.com>
 <1447349448-22610-2-git-send-email-stefano.stabellini@eu.citrix.com>
 <5645E868.30706@citrix.com>
 <alpine.DEB.2.02.1511131757360.2653@kaball.uk.xensource.com>
 <1447666977.15629.9.camel@citrix.com>
Message-ID: <alpine.DEB.2.02.1511201152030.1107@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 16 Nov 2015, Ian Campbell wrote:
> On Fri, 2015-11-13 at 18:10 +0000, Stefano Stabellini wrote:
> > 
> > I agree with your point (I thought about it myself) but the current
> > assembly scheme for hypercalls doesn't work well with that. I would have
> > to introduce, and maintain going forward, two special hypercall
> > implementations in assembly, one for arm and another for arm64, just to
> > set interface_version. I don't think it is worth it; I prefer to have to
> > maintain the explicit interface_version setting at the call sites (that
> > today is just one).
> 
> You could give the bare assembly stub a different name (append _core or
> _raw or something) and make HYPERVISOR_platform_op a C wrapper for it which
> DTRT.

I had an idea. I just need to 

#define HYPERVISOR_platform_op_raw HYPERVISOR_platform_op

then the small wrapper can work:


diff --git a/arch/arm/include/asm/xen/hypercall.h b/arch/arm/include/asm/xen/hypercall.h
index c3e00d0..d769972 100644
--- a/arch/arm/include/asm/xen/hypercall.h
+++ b/arch/arm/include/asm/xen/hypercall.h
@@ -50,7 +50,12 @@ int HYPERVISOR_memory_op(unsigned int cmd, void *arg);
 int HYPERVISOR_physdev_op(int cmd, void *arg);
 int HYPERVISOR_vcpu_op(int cmd, int vcpuid, void *extra_args);
 int HYPERVISOR_tmem_op(void *arg);
-int HYPERVISOR_platform_op(void *arg);
+int HYPERVISOR_platform_op_raw(void *arg);
+static inline int HYPERVISOR_platform_op(struct xen_platform_op *op)
+{
+	op->interface_version = XENPF_INTERFACE_VERSION;
+	return HYPERVISOR_platform_op_raw(op);
+}
 int HYPERVISOR_multicall(struct multicall_entry *calls, uint32_t nr);
 
 static inline int
diff --git a/arch/arm/include/asm/xen/interface.h b/arch/arm/include/asm/xen/interface.h
index 5b150d7..75d5968 100644
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
index f964238..0f7be84 100644
--- a/arch/arm/xen/enlighten.c
+++ b/arch/arm/xen/enlighten.c
@@ -141,7 +141,6 @@ static int xen_pvclock_gtod_notify(struct notifier_block *nb,
 	if (!was_set && timespec64_compare(&now, &next_sync) < 0)
 		return NOTIFY_OK;
 
-	op.interface_version = XENPF_INTERFACE_VERSION;
 	op.cmd = XENPF_settime64;
 	op.u.settime64.mbz = 0;
 	op.u.settime64.secs = now.tv_sec;
diff --git a/arch/arm/xen/hypercall.S b/arch/arm/xen/hypercall.S
index d4539f4..9a36f4f 100644
--- a/arch/arm/xen/hypercall.S
+++ b/arch/arm/xen/hypercall.S
@@ -89,7 +89,7 @@ HYPERCALL2(memory_op);
 HYPERCALL2(physdev_op);
 HYPERCALL3(vcpu_op);
 HYPERCALL1(tmem_op);
-HYPERCALL1(platform_op);
+HYPERCALL1(platform_op_raw);
 HYPERCALL2(multicall);
 
 ENTRY(privcmd_call)
diff --git a/arch/arm64/xen/hypercall.S b/arch/arm64/xen/hypercall.S
index f7d5724..70df80e 100644
--- a/arch/arm64/xen/hypercall.S
+++ b/arch/arm64/xen/hypercall.S
@@ -80,7 +80,7 @@ HYPERCALL2(memory_op);
 HYPERCALL2(physdev_op);
 HYPERCALL3(vcpu_op);
 HYPERCALL1(tmem_op);
-HYPERCALL1(platform_op);
+HYPERCALL1(platform_op_raw);
 HYPERCALL2(multicall);
 
 ENTRY(privcmd_call)
