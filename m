From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 11 Sep 2014 12:08:26 +0200
Subject: [PATCH 1/2] ARM: cache-l2x0: clean up aurora cache handling
In-Reply-To: <3459745.mC0zoLRDxy@wuerfel>
References: <2852268.nkG1OoBDfE@wuerfel>
 <20140908153946.GB12361@n2100.arm.linux.org.uk>
 <2958731.nsOomQFma0@wuerfel> <3459745.mC0zoLRDxy@wuerfel>
Message-ID: <20140911120826.0ea45cf6@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Arnd Bergmann,

On Mon, 08 Sep 2014 22:42:23 +0200, Arnd Bergmann wrote:
> The aurora cache controller is the only remaining user of a couple
> of functions in this file and are completely unused when that is
> disabled, leading to build warnings:
> 
> arch/arm/mm/cache-l2x0.c:167:13: warning: 'l2x0_cache_sync' defined but not used [-Wunused-function]
> arch/arm/mm/cache-l2x0.c:184:13: warning: 'l2x0_flush_all' defined but not used [-Wunused-function]
> arch/arm/mm/cache-l2x0.c:194:13: warning: 'l2x0_disable' defined but not used [-Wunused-function]
> 
> With the knowledge that the code is now aurora-specific, we can
> simplify it noticeably:
> 
> - The pl310 errata workarounds are not needed on aurora and can be removed
> - The cache_wait() macro is never needed since this is not an l210/l220
> - aurora_pa_range can keep the spinlock while syncing the cache
> - We can load the l2x0_base into a local variable across operations
> 
> There should be no functional change in this patch, but readability
> and the generated object code improves, along with avoiding the
> warnings.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ----
>  arch/arm/mm/cache-l2x0.c | 115 ++++++++++++++++++++++++++-----------------------------------------------
>  1 file changed, 41 insertions(+), 74 deletions(-)

Acked-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Tested-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
 (on Armada 370 RD and Armada XP GP, boot tested, plus a little bit of
 DMA traffic by reading data from a SD card)

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
