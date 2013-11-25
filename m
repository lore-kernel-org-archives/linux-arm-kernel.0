From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Mon, 25 Nov 2013 08:57:54 -0500
Subject: [PATCH] mm: nobootmem: avoid type warning about alignment value
In-Reply-To: <529217C7.6030304@cogentembedded.com>
References: <1385249326-9089-1-git-send-email-santosh.shilimkar@ti.com>
 <529217C7.6030304@cogentembedded.com>
Message-ID: <52935762.1080409@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 24 November 2013 10:14 AM, Sergei Shtylyov wrote:
> Hello.
> 
> On 24-11-2013 3:28, Santosh Shilimkar wrote:
> 
>> Building ARM with NO_BOOTMEM generates below warning. Using min_t
> 
>    Where is that below? :-)
> 
Damn.. Posted a wrong version of the patch ;-(
Here is the one with warning message included.

>From 571dfdf4cf8ac7dfd50bd9b7519717c42824f1c3 Mon Sep 17 00:00:00 2001
From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Date: Sat, 23 Nov 2013 18:16:50 -0500
Subject: [PATCH] mm: nobootmem: avoid type warning about alignment value

Building ARM with NO_BOOTMEM generates below warning.

mm/nobootmem.c: In function ?__free_pages_memory?:
mm/nobootmem.c:88:11: warning: comparison of distinct pointer types lacks a cast

Using min_t to find the correct alignment avoids the warning.

Cc: Tejun Heo <tj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 mm/nobootmem.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/nobootmem.c b/mm/nobootmem.c
index 2c254d3..8954e43 100644
--- a/mm/nobootmem.c
+++ b/mm/nobootmem.c
@@ -85,7 +85,7 @@ static void __init __free_pages_memory(unsigned long start, unsigned long end)
 	int order;
 
 	while (start < end) {
-		order = min(MAX_ORDER - 1UL, __ffs(start));
+		order = min_t(size_t, MAX_ORDER - 1UL, __ffs(start));
 
 		while (start + (1UL << order) > end)
 			order--;
-- 
1.7.9.5
