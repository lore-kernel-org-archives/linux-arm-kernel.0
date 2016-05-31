From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 31 May 2016 15:30:29 +0100
Subject: [PATCHv2] arm64: enable CONFIG_SET_MODULE_RONX by default
Message-ID: <1464705029-23868-1-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The SET_MODULE_RONX protections are effectively the same as the
DEBUG_RODATA protections we enabled by default back in commit
57efac2f7108e325 ("arm64: enable CONFIG_DEBUG_RODATA by default"). It
seems unusual to have one but not the other.

As evidenced by the help text, the rationale appears to be that
SET_MODULE_RONX interacts poorly with tracing and patching, but both of
these make use of the insn framework, which takes SET_MODULE_RONX into
account. Any remaining issues are bugs which should be fixed regardless
of the default state of the option.

This patch enables DEBUG_SET_MODULE_RONX by default, and replaces the
help text with a new wording derived from the DEBUG_RODATA help text,
which better describes the functionality. Previously, the DEBUG_RODATA
entry was inconsistently indented with spaces, which are replaced with
tabs as with the other Kconfig entries.

Additionally, the wording of recommended defaults is made consistent for
all options. These are placed in a new paragraph, unquoted, as a full
sentence (with a period/full stop) as this appears to be the most common
form per $(git grep 'in doubt').

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Acked-by: Kees Cook <keescook@chromium.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Laura Abbott <labbott@fedoraproject.org>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/Kconfig.debug | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

I'm resending this with acks accumulated since we've hit v4.7-rc1. I've also
given this a spin loading and unloading modules, without incident.

Since v1 [1]:
* Accumulate acks
* Trivial v4.7-rc1 rebase

Mark.

[1] lkml.kernel.org/r/1463138436-5073-1-git-send-email-mark.rutland at arm.com

diff --git a/arch/arm64/Kconfig.debug b/arch/arm64/Kconfig.debug
index 710fde4..0cc758c 100644
--- a/arch/arm64/Kconfig.debug
+++ b/arch/arm64/Kconfig.debug
@@ -12,7 +12,8 @@ config ARM64_PTDUMP
 	  who are working in architecture specific areas of the kernel.
 	  It is probably not a good idea to enable this feature in a production
 	  kernel.
-	  If in doubt, say "N"
+
+	  If in doubt, say N.
 
 config PID_IN_CONTEXTIDR
 	bool "Write the current PID to the CONTEXTIDR register"
@@ -38,15 +39,15 @@ config ARM64_RANDOMIZE_TEXT_OFFSET
 	  value.
 
 config DEBUG_SET_MODULE_RONX
-        bool "Set loadable kernel module data as NX and text as RO"
-        depends on MODULES
-        help
-          This option helps catch unintended modifications to loadable
-          kernel module's text and read-only data. It also prevents execution
-          of module data. Such protection may interfere with run-time code
-          patching and dynamic kernel tracing - and they might also protect
-          against certain classes of kernel exploits.
-          If in doubt, say "N".
+	bool "Set loadable kernel module data as NX and text as RO"
+	depends on MODULES
+	default y
+	help
+	  Is this is set, kernel module text and rodata will be made read-only.
+	  This is to help catch accidental or malicious attempts to change the
+	  kernel's executable code.
+
+	  If in doubt, say Y.
 
 config DEBUG_RODATA
 	bool "Make kernel text and rodata read-only"
@@ -56,7 +57,7 @@ config DEBUG_RODATA
 	  is to help catch accidental or malicious attempts to change the
 	  kernel's executable code.
 
-	  If in doubt, say Y
+	  If in doubt, say Y.
 
 config DEBUG_ALIGN_RODATA
 	depends on DEBUG_RODATA
@@ -69,7 +70,7 @@ config DEBUG_ALIGN_RODATA
 	  alignment and potentially wasted space. Turn on this option if
 	  performance is more important than memory pressure.
 
-	  If in doubt, say N
+	  If in doubt, say N.
 
 source "drivers/hwtracing/coresight/Kconfig"
 
-- 
1.9.1
