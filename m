From: julien.grall@citrix.com (Julien Grall)
Date: Fri, 11 Sep 2015 15:16:03 +0100
Subject: [PATCH] arm/xen: Enable user access to the kernel before issuing a
 privcmd call
Message-ID: <1441980963-9002-1-git-send-email-julien.grall@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When Xen is copyin data to/from the guest it will check if the kernel
has the right to do the access. If not, the hypercall will return an
error.

After the commit a5e090acbf545c0a3b04080f8a488b17ec41fe02 "ARM:
software-based priviledged-no-access support", the kernel can't access
anymore the user space by default. This will result to fail on every
hypercall made by the userspace (i.e via privcmd).

We have to enable the userspace access and then restore the correct
permission everytime the privmcd is used to made an hypercall.

I didn't find generic helpers to do a these operations, so the change
is only arm32 specific.

Reported-by: Riku Voipio <riku.voipio@linaro.org>
Signed-off-by: Julien Grall <julien.grall@citrix.com>

---
Cc: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
Cc: Russell King <linux@arm.linux.org.uk>

    ARM64 doesn't seem to have priviledge no-access support yet so there
    is nothing to do for now.

    I haven't look x86 at all.
---
 arch/arm/xen/Makefile    |  1 +
 arch/arm/xen/hypercall.S |  4 ++--
 arch/arm/xen/privcmd.c   | 25 +++++++++++++++++++++++++
 3 files changed, 28 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/xen/privcmd.c

diff --git a/arch/arm/xen/Makefile b/arch/arm/xen/Makefile
index 1296952..d8d088a 100644
--- a/arch/arm/xen/Makefile
+++ b/arch/arm/xen/Makefile
@@ -1 +1,2 @@
 obj-y		:= enlighten.o hypercall.o grant-table.o p2m.o mm.o
+obj-y		+= privcmd.o
diff --git a/arch/arm/xen/hypercall.S b/arch/arm/xen/hypercall.S
index f00e080..56e7181 100644
--- a/arch/arm/xen/hypercall.S
+++ b/arch/arm/xen/hypercall.S
@@ -91,7 +91,7 @@ HYPERCALL3(vcpu_op);
 HYPERCALL1(tmem_op);
 HYPERCALL2(multicall);
 
-ENTRY(privcmd_call)
+ENTRY(__privcmd_call)
 	stmdb sp!, {r4}
 	mov r12, r0
 	mov r0, r1
@@ -102,4 +102,4 @@ ENTRY(privcmd_call)
 	__HVC(XEN_IMM)
 	ldm sp!, {r4}
 	ret lr
-ENDPROC(privcmd_call);
+ENDPROC(__privcmd_call);
diff --git a/arch/arm/xen/privcmd.c b/arch/arm/xen/privcmd.c
new file mode 100644
index 0000000..97f502a
--- /dev/null
+++ b/arch/arm/xen/privcmd.c
@@ -0,0 +1,25 @@
+#include <linux/uaccess.h>
+#include <asm/xen/hypervisor.h>
+
+/* Forward declaration for the assembly function living in hypercall.S */
+long __privcmd_call(unsigned call, unsigned int long a1,
+		    unsigned long a2, unsigned long a3,
+		    unsigned long a4, unsigned long a5);
+
+long privcmd_call(unsigned call, unsigned int long a1,
+		  unsigned long a2, unsigned long a3,
+		  unsigned long a4, unsigned long a5)
+{
+	long ret;
+	/*
+	 * Privcmd calls are issued by the userspace. We need to allow the
+	 * kernel to access the userspace memory before issuing the hypercall.
+	 */
+	unsigned int ua_flags = uaccess_save_and_enable();
+
+	ret = __privcmd_call(call, a1, a2, a3, a4, a5);
+
+	uaccess_restore(ua_flags);
+
+	return ret;
+}
-- 
2.1.4
