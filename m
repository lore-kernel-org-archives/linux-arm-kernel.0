From: felipe.contreras@gmail.com (Felipe Contreras)
Date: Thu,  7 Oct 2010 15:29:09 +0300
Subject: [PATCH v2] ARM: allow, but warn, when issuing ioremap() on RAM
In-Reply-To: <20101007115156.GE27250@jasper.tkos.co.il>
References: <20101007115156.GE27250@jasper.tkos.co.il>
Message-ID: <1286454549-19690-1-git-send-email-felipe.contreras@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Many drivers are broken, and there's no alternative in sight. Such a big
change should stay as a warning for now, and only later should it
actually fail.

The drivers are not doing something correct, we get it, but for now it's
better to allow them to work (they do 99% of the time anyway) rather
than to force everyone to revert this patch in their internal trees
until there's a solution. A slightly broken functionality is better than
no functionality at all.

A warning lets people know that what they are doing is not right, and
they should fix it.

Cc: Han Jonghun <jonghun79.han@gmail.com>
Cc: Hemant Pedanekar <hemantp@ti.com>
Cc: Arnd Hannemann <arnd@arndnet.de>
Cc: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 arch/arm/mm/ioremap.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

For issues related to this:
http://article.gmane.org/gmane.linux.ports.arm.kernel/84454
http://article.gmane.org/gmane.linux.ports.sh.devel/8560
http://www.spinics.net/lists/linux-fbdev/msg01745.html
http://article.gmane.org/gmane.linux.drivers.video-input-infrastructure/22271

diff --git a/arch/arm/mm/ioremap.c b/arch/arm/mm/ioremap.c
index ab50627..a168673 100644
--- a/arch/arm/mm/ioremap.c
+++ b/arch/arm/mm/ioremap.c
@@ -202,10 +202,9 @@ void __iomem * __arm_ioremap_pfn_caller(unsigned long pfn,
 		return NULL;
 
 	/*
-	 * Don't allow RAM to be mapped - this causes problems with ARMv6+
+	 * This causes problems with ARMv6+. Will be disallowed soon.
 	 */
-	if (WARN_ON(pfn_valid(pfn)))
-		return NULL;
+	WARN_ON(pfn_valid(pfn));
 
 	type = get_mem_type(mtype);
 	if (!type)
-- 
1.7.3.1.2.g7fe2b
