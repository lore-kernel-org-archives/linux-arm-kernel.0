From: will.deacon@arm.com (Will Deacon)
Date: Fri, 17 Nov 2017 18:22:00 +0000
Subject: [PATCH 17/18] arm64: makefile: Ensure TEXT_OFFSET doesn't overlap
 with trampoline
In-Reply-To: <1510942921-12564-1-git-send-email-will.deacon@arm.com>
References: <1510942921-12564-1-git-send-email-will.deacon@arm.com>
Message-ID: <1510942921-12564-18-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When CONFIG_ARM64_RANDOMIZE_TEXT_OFFSET=y, we could end up with a
TEXT_OFFSET of less than 2 * PAGE_SIZE, which would result in an
overlap with the trampoline and a panic on boot.

Fix this by restricting the minimum value of the random TEXT_OFFSET
value so that it is not less than 2 pages when CONFIG_UNMAP_KERNEL_AT_EL0
is enabled.

I do wonder whether we should just remove
CONFIG_ARM64_RANDOMIZE_TEXT_OFFSET completely, since we're realistically
never going to be able to change our offset from 0x80000, but this keeps
the dream alive for now.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/Makefile | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index 939b310913cf..b60ac6c43ccd 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -87,9 +87,21 @@ head-y		:= arch/arm64/kernel/head.o
 
 # The byte offset of the kernel image in RAM from the start of RAM.
 ifeq ($(CONFIG_ARM64_RANDOMIZE_TEXT_OFFSET), y)
-TEXT_OFFSET := $(shell awk "BEGIN {srand(); printf \"0x%06x\n\", \
-		 int(2 * 1024 * 1024 / (2 ^ $(CONFIG_ARM64_PAGE_SHIFT)) * \
-		 rand()) * (2 ^ $(CONFIG_ARM64_PAGE_SHIFT))}")
+TEXT_OFFSET := $(shell awk							\
+		"BEGIN {							\
+			srand();						\
+			page_size = 2 ^ $(CONFIG_ARM64_PAGE_SHIFT);		\
+			tramp_size = 0;						\
+			if (\" $(CONFIG_UNMAP_KERNEL_AT_EL0)\" == \" y\") {	\
+				tramp_size = 2 * page_size;			\
+			}							\
+			offset = int(2 * 1024 * 1024 / page_size * rand());	\
+			offset *= page_size;					\
+			if (offset < tramp_size) {				\
+				offset = tramp_size;				\
+			}							\
+			printf \"0x%06x\n\", offset;				\
+		}")
 else
 TEXT_OFFSET := 0x00080000
 endif
-- 
2.1.4
