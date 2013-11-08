From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Fri,  8 Nov 2013 18:37:09 +0000
Subject: [PATCH 6/9] ARM: kprobes-test: Workaround GAS .align bug
In-Reply-To: <1383935832-20865-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1383935832-20865-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <1383935832-20865-7-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Taras Kondratiuk <taras.kondratiuk@linaro.org>

By default if no fill symbol is given to .align directive in a code
section it fills gap with NOPs. If previous fragment is not
instruction-aligned, additional pre-alignment is done by zero bytes
before NOPs. These zero bytes are marked as data by special symbol $d in
symbol table. Unfortunately GAS assumes that there is only code in the
code section so it "puts back" code symbol $a at the end of this
pre-alignment. So if there is some data after alignment it will be
interpreted as code and will be swapped back to LE for BE8 system during
a final linking.

If explicit fill value is given to .align, the NOP-padding code is
skipped and symbol table does not get messed-up.

So the workaround for this issue:
Use explicit fill value if data should be aligned in the code section.

Signed-off-by: Taras Kondratiuk <taras.kondratiuk@linaro.org>
---
 arch/arm/kernel/kprobes-test.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/kernel/kprobes-test.h b/arch/arm/kernel/kprobes-test.h
index e28a869..eecc90a 100644
--- a/arch/arm/kernel/kprobes-test.h
+++ b/arch/arm/kernel/kprobes-test.h
@@ -115,7 +115,7 @@ struct test_arg_end {
 	/* multiple strings to be concatenated.  */		\
 	".ascii "#title"				\n\t"	\
 	".byte	0					\n\t"	\
-	".align	2					\n\t"
+	".align	2, 0					\n\t"
 
 #define	TEST_ARG_REG(reg, val)					\
 	".byte	"__stringify(ARG_TYPE_REG)"		\n\t"	\
-- 
1.8.4.rc3
