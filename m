From: mbohan@codeaurora.org (Michael Bohan)
Date: Thu,  1 Apr 2010 17:20:48 -0700
Subject: [PATCH 2/3] arm: Add config option for HOLES_IN_ZONE
In-Reply-To: <1270167649-17824-1-git-send-email-mbohan@codeaurora.org>
References: <>
 <1270167649-17824-1-git-send-email-mbohan@codeaurora.org>
Message-ID: <1270167649-17824-2-git-send-email-mbohan@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Michael Bohan <mbohan@quicinc.com>

This option is for FLATMEM configurations with multiple memory
banks that have end addresses not aligned to MAX_ORDER_NR_PAGES.

To save memory, ARM frees memmap regions for pfns associated with
gaps in the address map. When the VM code migrates pages, it will
assume that the memmap entries are valid.

This option adds extra checking with pfn_valid() to
ensure the memmap entries are valid. It may adversely impact
performance.

Change-Id: I48d8afb69db25b1f44d698f1a7da106911b4be1c
Signed-off-by: Michael Bohan <mbohan@quicinc.com>
Signed-off-by: Michael Bohan <mbohan@codeaurora.org>
---
 arch/arm/Kconfig |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index c5408bf..8dadce9 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1233,6 +1233,20 @@ config OABI_COMPAT
 config ARCH_HAS_HOLES_MEMORYMODEL
 	bool
 
+config HOLES_IN_ZONE
+	bool "Memory map has holes ending within MAX_ORDER_NR_PAGES"
+	default n
+	depends on FLATMEM
+	help
+	  Say 'y' here if you have multiple memory banks where the bank
+	  end addresses coresponding to the holes are not MAX_ORDER_NR_PAGES
+	  aligned. Failure to enable this in those circumstances will result
+	  in the VM code assuming ownership of pages with no memmap memory
+	  allocated for them. This option could impact performance as it
+	  performs extra checks in the VM code. As alternative, consider
+	  aligning end addresses to MAX_ORDER_NR_PAGES or changing MAX_ORDER
+	  to compensate for your alignment requirements.
+
 # Discontigmem is deprecated
 config ARCH_DISCONTIGMEM_ENABLE
 	bool
-- 
1.6.2.3
