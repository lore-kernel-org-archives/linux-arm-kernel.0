From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Wed,  7 Nov 2018 09:40:05 +0000
Subject: [RFC PATCH 1/4] kconfig: add as-instr macro to scripts/Kconfig.include
In-Reply-To: <1541583608-26375-1-git-send-email-vladimir.murzin@arm.com>
References: <1541583608-26375-1-git-send-email-vladimir.murzin@arm.com>
Message-ID: <1541583608-26375-2-git-send-email-vladimir.murzin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are cases where the whole feature, for instance arm64/lse or
arm/crypto, can depend on assembler. Current practice is to report
buildtime that selected feature is not supported, which can be quite
annoying...

It'd nicer if we can check assembler first and opt-in feature
visibility in Kconfig.

Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
---
 scripts/Kconfig.include | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/scripts/Kconfig.include b/scripts/Kconfig.include
index dad5583..07c145c 100644
--- a/scripts/Kconfig.include
+++ b/scripts/Kconfig.include
@@ -22,6 +22,10 @@ success = $(if-success,$(1),y,n)
 # Return y if the compiler supports <flag>, n otherwise
 cc-option = $(success,$(CC) -Werror $(1) -E -x c /dev/null -o /dev/null)
 
+# $(as-instr,<instr>)
+# Return y if the assembler supports <instr>, n otherwise
+as-instr = $(success,printf "%b\n" "$(1)" | $(CC) -Werror -c -x assembler -o /dev/null -)
+
 # $(ld-option,<flag>)
 # Return y if the linker supports <flag>, n otherwise
 ld-option = $(success,$(LD) -v $(1))
-- 
1.9.1
