From: steve.capper@linaro.org (Steve Capper)
Date: Wed,  8 May 2013 10:52:42 +0100
Subject: [RFC PATCH v2 10/11] ARM64: mm: Raise MAX_ORDER for 64KB pages and
 THP.
In-Reply-To: <1368006763-30774-1-git-send-email-steve.capper@linaro.org>
References: <1368006763-30774-1-git-send-email-steve.capper@linaro.org>
Message-ID: <1368006763-30774-11-git-send-email-steve.capper@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The buddy allocator has a default MAX_ORDER of 11, which is too
low to allocate enough memory for 512MB Transparent HugePages if
our base page size is 64KB.

This patch introduces MAX_ZONE_ORDER and sets it to 14 when 64KB
pages are used in conjuction with THP, otherwise the default value
of 11 is used.

Signed-off-by: Steve Capper <steve.capper@linaro.org>
---
 arch/arm64/Kconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 053533b..a5f76cf 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -196,6 +196,11 @@ config ARCH_WANT_HUGE_PMD_SHARE
 
 source "mm/Kconfig"
 
+config FORCE_MAX_ZONEORDER
+	int
+	default "14" if (ARM64_64K_PAGES && TRANSPARENT_HUGEPAGE)
+	default "11"
+
 endmenu
 
 menu "Boot options"
-- 
1.8.1.4
