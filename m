From: lizf@cn.fujitsu.com (Li Zefan)
Date: Thu, 03 Jun 2010 15:24:39 +0800
Subject: [PATCH 1/2] menuconfig: fix to center checklist correctly in a corner
	case
Message-ID: <4C0758B7.5070907@cn.fujitsu.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Run:
	make ARCH=arm menuconfig

And then select "System Type" -> "ARM system type". The kconfig
"choice" menu at this point looks empty.

It's because config ARCH_S3C2410 has a long prompt:

config ARCH_S3C2410
        bool "Samsung S3C2410, S3C2412, S3C2413, S3C2416, S3C2440, S3C2442, S3C2443, S3C2450"
	...

menuconfig centers the checklist according to this prompt without
considering the width of the list, and then things get wrong.

Reported-by: Nobin Mathew <nobin.mathew@gmail.com>
Signed-off-by: Li Zefan <lizf@cn.fujitsu.com>
---

Please queue these 2 patches for 2.6.35.

---
 scripts/kconfig/lxdialog/checklist.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/scripts/kconfig/lxdialog/checklist.c b/scripts/kconfig/lxdialog/checklist.c
index bcc6f19..c92a05a 100644
--- a/scripts/kconfig/lxdialog/checklist.c
+++ b/scripts/kconfig/lxdialog/checklist.c
@@ -175,6 +175,7 @@ do_resize:
 	check_x = 0;
 	item_foreach()
 		check_x = MAX(check_x, strlen(item_str()) + 4);
+	check_x = MIN(check_x, list_width);
 
 	check_x = (list_width - check_x) / 2;
 	item_x = check_x + 4;
-- 
1.6.3
