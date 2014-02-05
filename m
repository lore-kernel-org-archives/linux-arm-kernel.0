From: leif.lindholm@linaro.org (Leif Lindholm)
Date: Wed,  5 Feb 2014 17:03:59 +0000
Subject: [PATCH 08/22] Add strstr to compressed string.c for ARM.
In-Reply-To: <1391619853-10601-1-git-send-email-leif.lindholm@linaro.org>
References: <1391619853-10601-1-git-send-email-leif.lindholm@linaro.org>
Message-ID: <1391619853-10601-9-git-send-email-leif.lindholm@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Roy Franz <roy.franz@linaro.org>

The shared efi-stub-helper.c functions require a strstr implementation.
The EFI stub is part of the decompressor, so it does not use the kernel
strstr() implementation.  This patch adds a strstr() implementation to
the string.c file for the decompressor, with the implementation copied
from the arch/x86/boot/string.c file used by the x86 decompressor.

Signed-off-by: Roy Franz <roy.franz@linaro.org>
Signed-off-by: Leif Lindholm <leif.lindholm@linaro.org>
Reviewed-by: Grant Likely <grant.likely@linaro.org>
---
 arch/arm/boot/compressed/string.c |   21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm/boot/compressed/string.c b/arch/arm/boot/compressed/string.c
index 36e53ef..5397792 100644
--- a/arch/arm/boot/compressed/string.c
+++ b/arch/arm/boot/compressed/string.c
@@ -111,6 +111,27 @@ char *strchr(const char *s, int c)
 	return (char *)s;
 }
 
+/**
+ * strstr - Find the first substring in a %NUL terminated string
+ * @s1: The string to be searched
+ * @s2: The string to search for
+ */
+char *strstr(const char *s1, const char *s2)
+{
+	size_t l1, l2;
+
+	l2 = strlen(s2);
+	if (!l2)
+		return (char *)s1;
+	l1 = strlen(s1);
+	while (l1 >= l2) {
+		l1--;
+		if (!memcmp(s1, s2, l2))
+			return (char *)s1;
+		s1++;
+	}
+	return NULL;
+}
 #undef memset
 
 void *memset(void *s, int c, size_t count)
-- 
1.7.10.4
