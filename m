From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 29 May 2018 12:36:26 +0200
Subject: [PATCH] ARM: disable KCOV for trusted foundations code
Message-ID: <20180529103636.1535457-1-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ARM trusted foundations code is currently broken in linux-next
when CONFIG_KCOV_INSTRUMENT_ALL is set:

/tmp/ccHdQsCI.s: Assembler messages:
/tmp/ccHdQsCI.s:37: Error: .err encountered
/tmp/ccHdQsCI.s:38: Error: .err encountered
/tmp/ccHdQsCI.s:39: Error: .err encountered
scripts/Makefile.build:311: recipe for target 'arch/arm/firmware/trusted_foundations.o' failed

I could not find a function attribute that lets me disable
-fsanitize-coverage=trace-pc for just one function, so this
turns it off for the entire file instead.

Fixes: mmotm ("arm: port KCOV to arm")
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/firmware/Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/firmware/Makefile b/arch/arm/firmware/Makefile
index a71f16536b6c..6e41336b0bc4 100644
--- a/arch/arm/firmware/Makefile
+++ b/arch/arm/firmware/Makefile
@@ -1 +1,4 @@
 obj-$(CONFIG_TRUSTED_FOUNDATIONS)	+= trusted_foundations.o
+
+# tf_generic_smc() fails to build with -fsanitize-coverage=trace-pc
+KCOV_INSTRUMENT                := n
-- 
2.9.0
