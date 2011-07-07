From: heechul@illinois.edu (Heechul Yun)
Date: Thu, 7 Jul 2011 09:30:19 -0500
Subject: [PATCHv2] remove unnecessary cache flush on v6 copypage
Message-ID: <20110707143019.GA16819@heechul-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


ARM: mm: remove unnecessary cache flush on v6 copypage

Originally introduced to maintain coherency between icache and dcache
in v6 nonaliasing mode. This is now handled by __sync_icache_dcache since
c0177800, therefore unneceary in this function.  

Signed-off-by: Heechul Yun <heechul@illinois.edu>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
--
arch/arm/mm/copypage-v6.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mm/copypage-v6.c b/arch/arm/mm/copypage-v6.c
index bdba6c6..63cca00 100644
--- a/arch/arm/mm/copypage-v6.c
+++ b/arch/arm/mm/copypage-v6.c
@@ -41,7 +41,6 @@ static void v6_copy_user_highpage_nonaliasing(struct page *to,
 	kfrom = kmap_atomic(from, KM_USER0);
 	kto = kmap_atomic(to, KM_USER1);
 	copy_page(kto, kfrom);
-	__cpuc_flush_dcache_area(kto, PAGE_SIZE);
 	kunmap_atomic(kto, KM_USER1);
 	kunmap_atomic(kfrom, KM_USER0);
 }
