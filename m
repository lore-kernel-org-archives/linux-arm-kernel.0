From: Yalin.Wang@sonymobile.com (Wang, Yalin)
Date: Mon, 15 Sep 2014 10:29:48 +0800
Subject: [PATCH] arm:extend __init_end to a page align address
In-Reply-To: <35FD53F367049845BC99AC72306C23D103CDBFBFB028@CNBJMBX05.corpusers.net>
References: <35FD53F367049845BC99AC72306C23D103CDBFBFB028@CNBJMBX05.corpusers.net>
Message-ID: <35FD53F367049845BC99AC72306C23D103D6DB4915FB@CNBJMBX05.corpusers.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

this patch change the __init_end address to a
page align address, so that free_initmem() can
free the whole .init section, because if the end
address is not page aligned, it will round down to
a page align address, then the tail unligned page
will not be freed.

Signed-off-by: wang <yalin.wang2010@gmail.com>
---
 arch/arm/kernel/vmlinux.lds.S   | 2 +-
 arch/arm64/kernel/vmlinux.lds.S | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
index 6f57cb9..8e95aa4 100644
--- a/arch/arm/kernel/vmlinux.lds.S
+++ b/arch/arm/kernel/vmlinux.lds.S
@@ -219,8 +219,8 @@ SECTIONS
 	__data_loc = ALIGN(4);		/* location in binary */
 	. = PAGE_OFFSET + TEXT_OFFSET;
 #else
-	__init_end = .;
 	. = ALIGN(THREAD_SIZE);
+	__init_end = .;
 	__data_loc = .;
 #endif
 
diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index 97f0c04..edf8715 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -97,9 +97,9 @@ SECTIONS
 
 	PERCPU_SECTION(64)
 
+	. = ALIGN(PAGE_SIZE);
 	__init_end = .;
 
-	. = ALIGN(PAGE_SIZE);
 	_data = .;
 	_sdata = .;
 	RW_DATA_SECTION(64, PAGE_SIZE, THREAD_SIZE)
-- 
1.9.2.msysgit.0
