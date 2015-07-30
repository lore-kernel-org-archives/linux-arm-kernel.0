From: dan.j.williams@intel.com (Dan Williams)
Date: Thu, 30 Jul 2015 12:54:40 -0400
Subject: [PATCH v3 11/24] toshiba laptop: replace ioremap_cache with ioremap
In-Reply-To: <20150730165155.33962.64121.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <20150730165155.33962.64121.stgit@dwillia2-desk3.amr.corp.intel.com>
Message-ID: <20150730165440.33962.36249.stgit@dwillia2-desk3.amr.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With ioremap_cache being replaced with memremap there is no longer a
guarantee that a mapping will silently fall back to an uncached mapping.
Explicitly use a vanilla ioremap() for this short lived mapping.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jonathan Buzzard <jonathan@buzzard.org.uk>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/char/toshiba.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/toshiba.c b/drivers/char/toshiba.c
index 014c9d90d297..f5a45d887a37 100644
--- a/drivers/char/toshiba.c
+++ b/drivers/char/toshiba.c
@@ -430,7 +430,7 @@ static int tosh_probe(void)
 	int i,major,minor,day,year,month,flag;
 	unsigned char signature[7] = { 0x54,0x4f,0x53,0x48,0x49,0x42,0x41 };
 	SMMRegisters regs;
-	void __iomem *bios = ioremap_cache(0xf0000, 0x10000);
+	void __iomem *bios = ioremap(0xf0000, 0x10000);
 
 	if (!bios)
 		return -ENOMEM;
