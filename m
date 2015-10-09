From: dan.j.williams@intel.com (Dan Williams)
Date: Fri, 09 Oct 2015 18:16:41 -0400
Subject: [PATCH 12/20] memconsole: fix __iomem mishandling, switch to memremap
In-Reply-To: <20151009221537.32203.5867.stgit@dwillia2-desk3.jf.intel.com>
References: <20151009221537.32203.5867.stgit@dwillia2-desk3.jf.intel.com>
Message-ID: <20151009221641.32203.201.stgit@dwillia2-desk3.jf.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The memconsole driver is not using proper accessors for __iomem.  Switch
to memremap to fix this issue, and this also prepares the driver for the
removal of ioremap_cache.

Cc: Mike Waychison <mikew@google.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/firmware/google/memconsole.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/google/memconsole.c b/drivers/firmware/google/memconsole.c
index 2f569aaed4c7..fd5041716860 100644
--- a/drivers/firmware/google/memconsole.c
+++ b/drivers/firmware/google/memconsole.c
@@ -52,14 +52,15 @@ static ssize_t memconsole_read(struct file *filp, struct kobject *kobp,
 	char *memconsole;
 	ssize_t ret;
 
-	memconsole = ioremap_cache(memconsole_baseaddr, memconsole_length);
+	memconsole = memremap(memconsole_baseaddr, memconsole_length,
+			MEMREMAP_WB);
 	if (!memconsole) {
-		pr_err("memconsole: ioremap_cache failed\n");
+		pr_err("memconsole: memremap failed\n");
 		return -ENOMEM;
 	}
 	ret = memory_read_from_buffer(buf, count, &pos, memconsole,
 				      memconsole_length);
-	iounmap(memconsole);
+	memunmap(memconsole);
 	return ret;
 }
 
