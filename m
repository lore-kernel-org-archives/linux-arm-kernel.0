From: arnd@arndb.de (Arnd Bergmann)
Date: Wed,  8 Aug 2012 16:47:19 +0200
Subject: [PATCH 02/11] mfd/asic3: fix asic3_mfd_probe return value
In-Reply-To: <1344437248-20560-1-git-send-email-arnd@arndb.de>
References: <1344437248-20560-1-git-send-email-arnd@arndb.de>
Message-ID: <1344437248-20560-3-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In commit 4f304245b "mfd: Set asic3 DS1WM clock_rate", a possible
path through asic3_mfd_probe was introduced that would lead to
an unpredictable return value, if everything succeeds but there
are pdata->leds is NULL. This was reported correctly by gcc.

Without this patch, building magician_defconfig results in:

drivers/mfd/asic3.c: In function 'asic3_mfd_probe':
drivers/mfd/asic3.c:940:2: warning: 'ret' may be used uninitialized in this function [-Wuninitialized]

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Paul Parsons <lost.distance@yahoo.com>
Cc: Philipp Zabel <philipp.zabel@gmail.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>
---
 drivers/mfd/asic3.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/asic3.c b/drivers/mfd/asic3.c
index 383421b..683e18a 100644
--- a/drivers/mfd/asic3.c
+++ b/drivers/mfd/asic3.c
@@ -925,6 +925,7 @@ static int __init asic3_mfd_probe(struct platform_device *pdev,
 			goto out;
 	}
 
+	ret = 0;
 	if (pdata->leds) {
 		int i;
 
-- 
1.7.10
