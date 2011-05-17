From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 17 May 2011 14:11:10 +0100
Subject: [PATCH v6 1/8] MTD: Add integrator-flash feature to physmap
In-Reply-To: <1305637877-24436-1-git-send-email-marc.zyngier@arm.com>
References: <1305637877-24436-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1305637877-24436-2-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In the process of moving platforms away from integrator-flash
(aka armflash), add to physmap the few features that make
armflash unique:

- optionnal probing for the AFS partition type
- init() and exit() methods, used by Integrator to control
  write access to the various onboard programmable components

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: David Woodhouse <dwmw2@infradead.org>
---
 drivers/mtd/maps/physmap.c  |   16 +++++++++++++++-
 include/linux/mtd/physmap.h |    2 ++
 2 files changed, 17 insertions(+), 1 deletions(-)

diff --git a/drivers/mtd/maps/physmap.c b/drivers/mtd/maps/physmap.c
index 7522df4..49676b7 100644
--- a/drivers/mtd/maps/physmap.c
+++ b/drivers/mtd/maps/physmap.c
@@ -67,6 +67,10 @@ static int physmap_flash_remove(struct platform_device *dev)
 		if (info->mtd[i] != NULL)
 			map_destroy(info->mtd[i]);
 	}
+
+	if (physmap_data->exit)
+		physmap_data->exit(dev);
+
 	return 0;
 }
 
@@ -77,7 +81,11 @@ static const char *rom_probe_types[] = {
 					"map_rom",
 					NULL };
 #ifdef CONFIG_MTD_PARTITIONS
-static const char *part_probe_types[] = { "cmdlinepart", "RedBoot", NULL };
+static const char *part_probe_types[] = { "cmdlinepart", "RedBoot",
+#ifdef CONFIG_MTD_AFS_PARTS
+					  "afs",
+#endif
+					  NULL };
 #endif
 
 static int physmap_flash_probe(struct platform_device *dev)
@@ -100,6 +108,12 @@ static int physmap_flash_probe(struct platform_device *dev)
 		goto err_out;
 	}
 
+	if (physmap_data->init) {
+		err = physmap_data->init(dev);
+		if (err)
+			goto err_out;
+	}
+
 	platform_set_drvdata(dev, info);
 
 	for (i = 0; i < dev->num_resources; i++) {
diff --git a/include/linux/mtd/physmap.h b/include/linux/mtd/physmap.h
index bcfd9f7..d37cca0 100644
--- a/include/linux/mtd/physmap.h
+++ b/include/linux/mtd/physmap.h
@@ -22,6 +22,8 @@ struct map_info;
 
 struct physmap_flash_data {
 	unsigned int		width;
+	int			(*init)(struct platform_device *);
+	void			(*exit)(struct platform_device *);
 	void			(*set_vpp)(struct map_info *, int);
 	unsigned int		nr_parts;
 	unsigned int		pfow_base;
-- 
1.7.0.4
