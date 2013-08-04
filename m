From: liwanp@linux.vnet.ibm.com (Wanpeng Li)
Date: Sun, 4 Aug 2013 15:54:34 +0800
Subject: [PATCH] MM: Make Contiguous Memory Allocator depends on MMU
In-Reply-To: <1375593061-11350-1-git-send-email-manjunath.goudar@linaro.org>
References: <1375593061-11350-1-git-send-email-manjunath.goudar@linaro.org>
Message-ID: <20130804075434.GA10603@hacker.(null)>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 04, 2013 at 10:41:01AM +0530, Manjunath Goudar wrote:
>s patch adds a Kconfig dependency on an MMU being available before
>CMA can be enabled.  Without this patch, CMA can be enabled on an
>MMU-less system which can lead to issues. This was discovered during
>randconfig testing, in which CMA was enabled w/o MMU being enabled,
>leading to the following error:
>
> CC      mm/migrate.o
>mm/migrate.c: In function ?remove_migration_pte?:
>mm/migrate.c:134:3: error: implicit declaration of function ?pmd_trans_huge?
>[-Werror=implicit-function-declaration]
>   if (pmd_trans_huge(*pmd))
>   ^
>mm/migrate.c:137:3: error: implicit declaration of function ?pte_offset_map?
>[-Werror=implicit-function-declaration]
>   ptep = pte_offset_map(pmd, addr);
>

Similar one.

http://marc.info/?l=linux-mm&m=137532486405085&w=2

>Signed-off-by: Manjunath Goudar <manjunath.goudar@linaro.org>
>Acked-by: Arnd Bergmann <arnd@linaro.org>
>Cc: Deepak Saxena <dsaxena@linaro.org>
>Cc: IWAMOTO Toshihiro <iwamoto@valinux.co.jp>
>Cc: Hirokazu Takahashi <taka@valinux.co.jp>
>Cc: Dave Hansen <haveblue@us.ibm.com>
>Cc: linux-mm at kvack.org
>Cc: Johannes Weiner <hannes@cmpxchg.org>
>Cc: Michal Hocko <mhocko@suse.cz>
>Cc: Balbir Singh <bsingharora@gmail.com>
>Cc: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
>---
> mm/Kconfig |    2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/mm/Kconfig b/mm/Kconfig
>index 256bfd0..ad6b98e 100644
>--- a/mm/Kconfig
>+++ b/mm/Kconfig
>@@ -522,7 +522,7 @@ config MEM_SOFT_DIRTY
>
> config CMA
> 	bool "Contiguous Memory Allocator"
>-	depends on HAVE_MEMBLOCK
>+	depends on MMU && HAVE_MEMBLOCK
> 	select MIGRATION
> 	select MEMORY_ISOLATION
> 	help
>-- 
>1.7.9.5
>
>--
>To unsubscribe, send a message with 'unsubscribe linux-mm' in
>the body to majordomo at kvack.org.  For more info on Linux MM,
>see: http://www.linux-mm.org/ .
>Don't email: <a href=mailto:"dont@kvack.org"> email at kvack.org </a>
