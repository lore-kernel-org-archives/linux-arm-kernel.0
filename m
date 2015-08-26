From: ryabinin.a.a@gmail.com (Andrey Ryabinin)
Date: Wed, 26 Aug 2015 19:15:06 +0300
Subject: [PATCH 3/4] arm64/efi-stub, kasan: don't instrument efi-stub.
In-Reply-To: <1440605707-8325-1-git-send-email-ryabinin.a.a@gmail.com>
References: <1440605707-8325-1-git-send-email-ryabinin.a.a@gmail.com>
Message-ID: <1440605707-8325-4-git-send-email-ryabinin.a.a@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

efi-stub.c code runs before we setup early shadow.
Intrumentation of it will cause boot crash.

Signed-off-by: Andrey Ryabinin <ryabinin.a.a@gmail.com>
---
 arch/arm64/kernel/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index 426d076..086b122 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -7,6 +7,8 @@ AFLAGS_head.o		:= -DTEXT_OFFSET=$(TEXT_OFFSET)
 CFLAGS_efi-stub.o 	:= -DTEXT_OFFSET=$(TEXT_OFFSET)
 CFLAGS_armv8_deprecated.o := -I$(src)
 
+KASAN_SANITIZE_efi-stub.o	:= n
+
 CFLAGS_REMOVE_ftrace.o = -pg
 CFLAGS_REMOVE_insn.o = -pg
 CFLAGS_REMOVE_return_address.o = -pg
-- 
2.4.6
