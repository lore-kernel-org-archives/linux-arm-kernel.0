From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed, 31 Oct 2018 12:28:40 -0700
Subject: [PATCH v3 3/6] of/fdt: Populate phys_initrd_start/phys_initrd_size
 from FDT
In-Reply-To: <20181031192843.13230-1-f.fainelli@gmail.com>
References: <20181031192843.13230-1-f.fainelli@gmail.com>
Message-ID: <20181031192843.13230-4-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we have central and global variables holding the physical
address and size of the initrd, we can have
early_init_dt_check_for_initrd() populate
phys_initrd_start/phys_initrd_size for us.

This allows us to remove a chunk of code from arch/arm/mm/init.c
introduced with commit 65939301acdb ("arm: set initrd_start/initrd_end
for fdt scan").

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm/mm/init.c | 6 ------
 drivers/of/fdt.c   | 2 ++
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index 87d59a53861d..4bfa08e27319 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -236,12 +236,6 @@ static void __init arm_initrd_init(void)
 	phys_addr_t start;
 	unsigned long size;
 
-	/* FDT scan will populate initrd_start */
-	if (initrd_start && !phys_initrd_size) {
-		phys_initrd_start = __virt_to_phys(initrd_start);
-		phys_initrd_size = initrd_end - initrd_start;
-	}
-
 	initrd_start = initrd_end = 0;
 
 	if (!phys_initrd_size)
diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 76c83c1ffeda..e34cb49231b5 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -925,6 +925,8 @@ static void __init early_init_dt_check_for_initrd(unsigned long node)
 	end = of_read_number(prop, len/4);
 
 	__early_init_dt_declare_initrd(start, end);
+	phys_initrd_start = start;
+	phys_initrd_size = end - start;
 
 	pr_debug("initrd_start=0x%llx  initrd_end=0x%llx\n",
 		 (unsigned long long)start, (unsigned long long)end);
-- 
2.17.1
