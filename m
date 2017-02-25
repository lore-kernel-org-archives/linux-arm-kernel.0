From: xieyisheng1@huawei.com (Yisheng Xie)
Date: Sat, 25 Feb 2017 14:47:25 +0800
Subject: [PATCH RFC] arm64/mm: handle memmap kernel option
Message-ID: <1488005245-54811-1-git-send-email-xieyisheng1@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When use device tree mode, user can reserve memory by changes the dts,
however, when boot with ACPI, user cannot reserve memory except by
changing the ACPI table in BIOS, which is not so convenient.

To make user reserve memory for some specific use more convenient,
this patch implement the following memmap variants:
 - memmap=nn[KMG]$ss[KMG]: mark specified memory as reserved;
 - memmap=nn[KMG]@ss[KMG]: force usage of a specific region of memory;

Reported-by: Bob Dong <dongbo4@huawei.com>
Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
---
 arch/arm64/mm/init.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index e19e065..cf90c1d 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -188,6 +188,52 @@ static int __init early_mem(char *p)
 }
 early_param("mem", early_mem);
 
+static void __init parse_memmap_one(char *p)
+{
+	char *oldp;
+	unsigned long start_at, mem_size;
+
+	if (!p)
+		return;
+
+	oldp = p;
+	mem_size = memparse(p, &p);
+	if (p == oldp)
+		return;
+
+	switch (*p) {
+	case '@':
+		start_at = memparse(p + 1, &p);
+		memblock_add(start_at, mem_size);
+		break;
+
+	case '$':
+		start_at = memparse(p + 1, &p);
+		memblock_reserve(start_at, mem_size);
+		break;
+
+	default:
+		pr_warn("Unrecognized memmap syntax: %s\n", p);
+		break;
+	}
+}
+
+static int __init parse_memmap_opt(char *str)
+{
+	while (str) {
+		char *k = strchr(str, ',');
+
+		if (k)
+			*k++ = 0;
+
+		parse_memmap_one(str);
+		str = k;
+	}
+
+	return 0;
+}
+early_param("memmap", parse_memmap_opt);
+
 void __init arm64_memblock_init(void)
 {
 	const s64 linear_region_size = -(s64)PAGE_OFFSET;
-- 
1.7.12.4
