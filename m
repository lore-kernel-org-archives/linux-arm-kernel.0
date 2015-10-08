From: dann.frazier@canonical.com (dann frazier)
Date: Thu,  8 Oct 2015 11:32:48 -0700
Subject: [PATCH] arm64: errata: Use KCONFIG variant of CFLAGS_MODULE to avoid
 user override
In-Reply-To: <CALdTtnvwwfT4xwTrAqqyn9MbbCYDi-vrHZBf18oOJjLhrdwM0A@mail.gmail.com>
References: <CALdTtnvwwfT4xwTrAqqyn9MbbCYDi-vrHZBf18oOJjLhrdwM0A@mail.gmail.com>
Message-ID: <1444329168-15685-1-git-send-email-dann.frazier@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Upstream commit df057cc7b4fa59e9b55f07ffdb6c62bf02e99a00 broke module
loading in Ubuntu kernel builds:

[ 2.192721] module gpio_xgene_sb: unsupported RELA relocation: 275
[ 2.193609] module xgene_enet: unsupported RELA relocation: 275
[ 2.249402] module libahci: unsupported RELA relocation: 275

That commit added a flag to CFLAGS_MODULE, which is vulnerable to
environment override. Ubuntu builds use this to pass in the ABI number,
so it was getting clobbered.

To avoid overriding, use KCONFIG_CFLAGS_MODULE instead.

Signed-off-by: dann frazier <dann.frazier@canonical.com>
CC: stable at vger.kernel.org
---
 arch/arm64/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index f9914d7..d10b5d4 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -42,7 +42,7 @@ endif
 CHECKFLAGS	+= -D__aarch64__
 
 ifeq ($(CONFIG_ARM64_ERRATUM_843419), y)
-CFLAGS_MODULE	+= -mcmodel=large
+KBUILD_CFLAGS_MODULE	+= -mcmodel=large
 endif
 
 # Default value
-- 
2.6.1
