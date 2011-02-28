From: bones@secretlab.ca (John Bonesio)
Date: Mon, 28 Feb 2011 15:33:47 -0800
Subject: [PATCH 3/4] ARM:boot:device tree: Add puthex routine for use in the
	boot wrapper
In-Reply-To: <20110228233153.24836.24176.stgit@riker>
References: <20110228233153.24836.24176.stgit@riker>
Message-ID: <20110228233346.24836.48614.stgit@riker>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds a routine named 'puthex'. This allows the boot wraper code to
display hex numbers.

Signed-off-by: John Bonesio <bones@secretlab.ca>
---

 arch/arm/boot/compressed/misc.c |   25 +++++++++++++++++++++++++
 1 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/compressed/misc.c b/arch/arm/boot/compressed/misc.c
index 2d4da4c..9af05ed 100644
--- a/arch/arm/boot/compressed/misc.c
+++ b/arch/arm/boot/compressed/misc.c
@@ -113,6 +113,31 @@ void putstr(const char *ptr)
 	flush();
 }
 
+void puthex(unsigned i)
+{
+	unsigned rem;
+	char str[32];
+	int str_idx = sizeof(str) - 1;;
+
+	str[str_idx--] = '\0';
+	putstr("0x");
+	if (!i) {
+		putstr("0");
+	} else {
+		while (i) {
+			rem = i % 16;
+
+			if (rem < 10) {
+				str[str_idx--] = rem + '0';
+			} else {
+				str[str_idx--] = (rem - 10) + 'a';
+			}
+			i = i / 16;
+		}
+
+		putstr(&str[str_idx + 1]);
+	}
+}
 
 #ifdef CONFIG_ARM_APPENDED_DTB
 /**
