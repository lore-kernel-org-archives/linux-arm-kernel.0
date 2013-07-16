From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 16 Jul 2013 12:07:21 +0100
Subject: [PATCH] arm: align shared memory unconditionally to the SHMLBA
 boundary
In-Reply-To: <51E524D1.2090504@parallels.com>
References: <1361254269-3444-1-git-send-email-alekskartashov@parallels.com>
 <20130715173238.GJ1730@moon> <20130715180846.GV24642@n2100.arm.linux.org.uk>
 <20130715185739.GK1730@moon> <51E4DC0B.8040908@parallels.com>
 <20130716095349.GB16370@moon> <51E51EF1.3010104@parallels.com>
 <20130716103649.GC24642@n2100.arm.linux.org.uk>
 <51E524D1.2090504@parallels.com>
Message-ID: <20130716110721.GD24642@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 16, 2013 at 02:47:45PM +0400, Alexander Kartashov wrote:
> On 07/16/2013 02:36 PM, Russell King - ARM Linux wrote:
>> shmget() doesn't allocate space in the process for the SHM region.  It
>> merely creates the shm memory and returns an identifier for it which can
>> later be used by shmat() to map it.
> Thank you for the correction, I meant shmat() in that comment indeed.
> I'm sorry for the inconvenience.

Right, so it appears that there's a difference between shmat() with an
address and with a NULL address, because the enforcement is done by two
completely different bits of code in unrelated parts of the kernel.

I notice Sparc32 seems to have a fix for this along the lines of the
(untested) patch below, so let's do the same on ARM.  Please test this
and let me know if this solves your problem.

Thanks.

 arch/arm/include/asm/shmparam.h |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/include/asm/shmparam.h b/arch/arm/include/asm/shmparam.h
index a5223b3..843db59 100644
--- a/arch/arm/include/asm/shmparam.h
+++ b/arch/arm/include/asm/shmparam.h
@@ -1,16 +1,16 @@
 #ifndef _ASMARM_SHMPARAM_H
 #define _ASMARM_SHMPARAM_H
 
+#include <asm/cachetype.h>
+
 /*
  * This should be the size of the virtually indexed cache/ways,
  * or page size, whichever is greater since the cache aliases
  * every size/ways bytes.
  */
-#define	SHMLBA	(4 * PAGE_SIZE)		 /* attach addr a multiple of this */
+#define	SHMLBA	(cache_is_vipt_aliasing() ? (4 * PAGE_SIZE) : PAGE_SIZE)
 
-/*
- * Enforce SHMLBA in shmat
- */
+/* Enforce SHMLBA in shmat */
 #define __ARCH_FORCE_SHMLBA
 
 #endif /* _ASMARM_SHMPARAM_H */
