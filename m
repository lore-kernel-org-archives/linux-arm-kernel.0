From: liuj97@gmail.com (Jiang Liu)
Date: Tue,  7 Jan 2014 22:17:12 +0800
Subject: [PATCH v8 5/7] arm64, jump label: detect %c support for ARM64
In-Reply-To: <1389104234-15239-1-git-send-email-liuj97@gmail.com>
References: <1389104234-15239-1-git-send-email-liuj97@gmail.com>
Message-ID: <1389104234-15239-6-git-send-email-liuj97@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As commit a9468f30b5eac6 "ARM: 7333/2: jump label: detect %c
support for ARM", this patch detects the same thing for ARM64
because some ARM64 GCC versions have the same issue.

Some versions of ARM64 GCC which do support asm goto, do not
support the %c specifier. Since we need the %c to support jump
labels on ARM64, detect that too in the asm goto detection script
to avoid build errors with these versions.

Acked-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Jiang Liu <liuj97@gmail.com>
---
 scripts/gcc-goto.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/gcc-goto.sh b/scripts/gcc-goto.sh
index a2af2e8..c9469d3 100644
--- a/scripts/gcc-goto.sh
+++ b/scripts/gcc-goto.sh
@@ -5,7 +5,7 @@
 cat << "END" | $@ -x c - -c -o /dev/null >/dev/null 2>&1 && echo "y"
 int main(void)
 {
-#ifdef __arm__
+#if defined(__arm__) || defined(__aarch64__)
 	/*
 	 * Not related to asm goto, but used by jump label
 	 * and broken on some ARM GCC versions (see GCC Bug 48637).
-- 
1.8.1.2
