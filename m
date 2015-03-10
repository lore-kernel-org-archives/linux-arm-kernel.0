From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 10 Mar 2015 19:52:55 +0100
Subject: [PATCH v4 2/4] ARM: KVM: avoid "HYP init code too big" error
In-Reply-To: <1426013577-32081-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1426013577-32081-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1426013577-32081-3-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Arnd Bergmann <arnd@arndb.de>

When building large kernels, the linker will emit lots of veneers
into the .hyp.idmap.text section, which causes it to grow beyond
one page, and that triggers the build error.

This moves the section into .rodata instead, which avoids the
veneers and is safe because the code is not executed directly
but remapped by the hypervisor into its own executable address
space.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
[ardb: use __hyp_idmap_rodata section instead adding a duplicate .rodata,
       move the ALIGN() to __hyp_idmap_rodata as well,
       update log s/copied/remapped/]
Tested-by: Marc Zyngier <marc.zyngier@arm.com>
Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm/kernel/vmlinux.lds.S | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
index b31aa73e8076..7029c8e5b1b5 100644
--- a/arch/arm/kernel/vmlinux.lds.S
+++ b/arch/arm/kernel/vmlinux.lds.S
@@ -22,11 +22,15 @@
 	ALIGN_FUNCTION();						\
 	VMLINUX_SYMBOL(__idmap_text_start) = .;				\
 	*(.idmap.text)							\
-	VMLINUX_SYMBOL(__idmap_text_end) = .;				\
+	VMLINUX_SYMBOL(__idmap_text_end) = .;
+
+#define HYP_IDMAP_RODATA						\
+	__hyp_idmap_rodata : {						\
 	. = ALIGN(32);							\
 	VMLINUX_SYMBOL(__hyp_idmap_text_start) = .;			\
 	*(.hyp.idmap.text)						\
-	VMLINUX_SYMBOL(__hyp_idmap_text_end) = .;
+	VMLINUX_SYMBOL(__hyp_idmap_text_end) = .;			\
+	}
 
 #ifdef CONFIG_HOTPLUG_CPU
 #define ARM_CPU_DISCARD(x)
@@ -151,6 +155,7 @@ SECTIONS
 	}
 #endif
 
+	HYP_IDMAP_RODATA
 	NOTES
 
 	_etext = .;			/* End of text and rodata section */
-- 
1.8.3.2
