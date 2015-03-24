From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 24 Mar 2015 18:48:07 +0100
Subject: [PATCH] ARM: kvm: assert on HYP section boundaries not actual code
 size
Message-ID: <1427219287-21586-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Using ASSERT() with an expression that involves a symbol that
is only supplied through a PROVIDE() definition in the linker
script itself is apparently not supported by some older versions
of binutils.

So instead, rewrite the expression so that only the section
boundaries __hyp_idmap_text_start and __hyp_idmap_text_end
are used. Note that this reverts the fix in 06f75a1f6200
("ARM, arm64: kvm: get rid of the bounce page") for the ASSERT()
being triggered erroneously when unrelated linker emitted veneers
happen to end up in the HYP idmap region.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm/kernel/vmlinux.lds.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
index 2d760df0d57d..808398ec024e 100644
--- a/arch/arm/kernel/vmlinux.lds.S
+++ b/arch/arm/kernel/vmlinux.lds.S
@@ -381,5 +381,5 @@ ASSERT((__arch_info_end - __arch_info_begin), "no machine record defined")
  * and should not cross a page boundary.
  * The above comment applies as well.
  */
-ASSERT((__hyp_idmap_text_start & ~PAGE_MASK) + __hyp_idmap_size <= PAGE_SIZE,
+ASSERT(__hyp_idmap_text_end - (__hyp_idmap_text_start & PAGE_MASK) <= PAGE_SIZE,
 	"HYP init code too big or misaligned")
-- 
1.8.3.2
