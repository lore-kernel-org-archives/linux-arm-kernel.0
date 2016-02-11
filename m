From: robh@kernel.org (Rob Herring)
Date: Thu, 11 Feb 2016 17:06:34 -0600
Subject: [PATCH] ARM: boot: Add an implementation of strnlen for libfdt
Message-ID: <1455231994-12048-1-git-send-email-robh@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Recent versions of libfdt add a dependency on strnlen. Copy the
implementation in lib/string.c here, so we can update libfdt.

Signed-off-by: Rob Herring <robh@kernel.org>
---
Russell,

I have a pending libfdt update, so I'd like to take this thru the DT 
tree with your ack.

Rob

 arch/arm/boot/compressed/string.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/compressed/string.c b/arch/arm/boot/compressed/string.c
index 36e53ef..6894674 100644
--- a/arch/arm/boot/compressed/string.c
+++ b/arch/arm/boot/compressed/string.c
@@ -65,6 +65,15 @@ size_t strlen(const char *s)
 	return sc - s;
 }
 
+size_t strnlen(const char *s, size_t count)
+{
+	const char *sc;
+
+	for (sc = s; count-- && *sc != '\0'; ++sc)
+		/* nothing */;
+	return sc - s;
+}
+
 int memcmp(const void *cs, const void *ct, size_t count)
 {
 	const unsigned char *su1 = cs, *su2 = ct, *end = su1 + count;
-- 
2.5.0
