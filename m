From: julien.grall@citrix.com (Julien Grall)
Date: Fri, 11 Sep 2015 17:25:59 +0100
Subject: [PATCH v2] arm/xen: Enable user access to the kernel before issuing a
 privcmd call
Message-ID: <1441988759-4572-1-git-send-email-julien.grall@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When Xen is copying data to/from the guest it will check if the kernel
has the right to do the access. If not, the hypercall will return an
error.

After the commit a5e090acbf545c0a3b04080f8a488b17ec41fe02 "ARM:
software-based privileged-no-access support", the kernel can't access
any longer the user space by default. This will result to fail on every
hypercall made by the userspace (i.e via privcmd).

We have to enable the userspace access and then restore the correct
permission every time the privcmd is used to made an hypercall.

I didn't find generic helpers to do a these operations, so the change
is only arm32 specific.

Reported-by: Riku Voipio <riku.voipio@linaro.org>
Signed-off-by: Julien Grall <julien.grall@citrix.com>

---
Cc: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
Cc: Russell King <linux@arm.linux.org.uk>

    Changes in v2:
        - Directly enable/disable the user space access in assembly
        - Typoes

    ARM64 doesn't seem to have priviledge no-access support yet so there
    is nothing to do for now.

    I haven't look x86 at all.
---
 arch/arm/xen/hypercall.S | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/xen/hypercall.S b/arch/arm/xen/hypercall.S
index f00e080..10fd99c 100644
--- a/arch/arm/xen/hypercall.S
+++ b/arch/arm/xen/hypercall.S
@@ -98,8 +98,23 @@ ENTRY(privcmd_call)
 	mov r1, r2
 	mov r2, r3
 	ldr r3, [sp, #8]
+	/*
+	 * Privcmd calls are issued by the userspace. We need to allow the
+	 * kernel to access the userspace memory before issuing the hypercall.
+	 */
+	uaccess_enable r4
+
+	/* r4 is loaded now as we use it as scratch register before */
 	ldr r4, [sp, #4]
 	__HVC(XEN_IMM)
+
+	/*
+	 * Disable userspace access from kernel. This is fine to do it
+	 * unconditionally as no set_fs(KERNEL_DS)/set_fs(get_ds()) is
+	 * called before.
+	 */
+	uaccess_disable r4
+
 	ldm sp!, {r4}
 	ret lr
 ENDPROC(privcmd_call);
-- 
2.1.4
