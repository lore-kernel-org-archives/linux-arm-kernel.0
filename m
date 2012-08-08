From: arnd@arndb.de (Arnd Bergmann)
Date: Wed,  8 Aug 2012 23:27:53 +0200
Subject: [PATCH 05/10] asm-generic: xor: mark static functions as
 __maybe_unused
In-Reply-To: <1344461278-28245-1-git-send-email-arnd@arndb.de>
References: <1344461278-28245-1-git-send-email-arnd@arndb.de>
Message-ID: <1344461278-28245-6-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The asm-generic/xor.h header file is nasty and defines static functions
that are not inline. The header file is include by the ARM version of
asm/xor.h, which uses some but not all of the symbols defined there.

Marking the extraneous functions as __maybe_unused lets gcc drop them
without complaining.

Without this patch, building iop13xx_defconfig results in:

include/asm-generic/xor.h:696:34: warning: 'xor_block_8regs_p' defined but not used [-Wunused-variable]
include/asm-generic/xor.h:704:34: warning: 'xor_block_32regs_p' defined but not used [-Wunused-variable]

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Neil Brown <neilb@suse.de>
---
 include/asm-generic/xor.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/asm-generic/xor.h b/include/asm-generic/xor.h
index 6028fb8..b4d8432 100644
--- a/include/asm-generic/xor.h
+++ b/include/asm-generic/xor.h
@@ -693,7 +693,7 @@ static struct xor_block_template xor_block_32regs = {
 	.do_5 = xor_32regs_5,
 };
 
-static struct xor_block_template xor_block_8regs_p = {
+static struct xor_block_template xor_block_8regs_p __maybe_unused = {
 	.name = "8regs_prefetch",
 	.do_2 = xor_8regs_p_2,
 	.do_3 = xor_8regs_p_3,
@@ -701,7 +701,7 @@ static struct xor_block_template xor_block_8regs_p = {
 	.do_5 = xor_8regs_p_5,
 };
 
-static struct xor_block_template xor_block_32regs_p = {
+static struct xor_block_template xor_block_32regs_p __maybe_unused = {
 	.name = "32regs_prefetch",
 	.do_2 = xor_32regs_p_2,
 	.do_3 = xor_32regs_p_3,
-- 
1.7.10
