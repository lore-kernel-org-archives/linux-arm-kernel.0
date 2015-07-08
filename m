From: mperttunen@nvidia.com (Mikko Perttunen)
Date: Wed, 8 Jul 2015 14:27:45 +0300
Subject: [PATCH 2/5] host1x: Pass register value in firewall
In-Reply-To: <1436354868-24309-1-git-send-email-mperttunen@nvidia.com>
References: <1436354868-24309-1-git-send-email-mperttunen@nvidia.com>
Message-ID: <1436354868-24309-3-git-send-email-mperttunen@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Arto Merilainen <amerilainen@nvidia.com>

In gr2d and gr3d units the register offset was sufficient for determining
if the register in interest is used for storing a register value.

However, in VIC this is not the case. The operations are passed through
two registers, METHOD0 and METHOD1. Depending on content of METHOD0,
METHOD1 can be either address or data field.

This patch updates the firewall interface to deliver also the register
value to allow book-keeping inside the engine driver.

Signed-off-by: Arto Merilainen <amerilainen@nvidia.com>
Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 drivers/gpu/drm/tegra/drm.h  |  4 ++--
 drivers/gpu/drm/tegra/gr2d.c |  4 ++--
 drivers/gpu/drm/tegra/gr3d.c |  4 ++--
 drivers/gpu/host1x/job.c     | 35 +++++++++++++++++++++++------------
 include/linux/host1x.h       |  4 ++--
 5 files changed, 31 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/tegra/drm.h b/drivers/gpu/drm/tegra/drm.h
index 659b2fc..0e7756e 100644
--- a/drivers/gpu/drm/tegra/drm.h
+++ b/drivers/gpu/drm/tegra/drm.h
@@ -1,6 +1,6 @@
 /*
  * Copyright (C) 2012 Avionic Design GmbH
- * Copyright (C) 2012-2013 NVIDIA CORPORATION.  All rights reserved.
+ * Copyright (C) 2012-2015 NVIDIA CORPORATION.  All rights reserved.
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -70,7 +70,7 @@ struct tegra_drm_client_ops {
 	int (*open_channel)(struct tegra_drm_client *client,
 			    struct tegra_drm_context *context);
 	void (*close_channel)(struct tegra_drm_context *context);
-	int (*is_addr_reg)(struct device *dev, u32 class, u32 offset);
+	int (*is_addr_reg)(struct device *dev, u32 class, u32 offset, u32 val);
 	int (*submit)(struct tegra_drm_context *context,
 		      struct drm_tegra_submit *args, struct drm_device *drm,
 		      struct drm_file *file);
diff --git a/drivers/gpu/drm/tegra/gr2d.c b/drivers/gpu/drm/tegra/gr2d.c
index 02cd3e3..7e4424f 100644
--- a/drivers/gpu/drm/tegra/gr2d.c
+++ b/drivers/gpu/drm/tegra/gr2d.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (c) 2012-2013, NVIDIA Corporation.
+ * Copyright (c) 2012-2015, NVIDIA Corporation.
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -84,7 +84,7 @@ static void gr2d_close_channel(struct tegra_drm_context *context)
 	host1x_channel_put(context->channel);
 }
 
-static int gr2d_is_addr_reg(struct device *dev, u32 class, u32 offset)
+static int gr2d_is_addr_reg(struct device *dev, u32 class, u32 offset, u32 val)
 {
 	struct gr2d *gr2d = dev_get_drvdata(dev);
 
diff --git a/drivers/gpu/drm/tegra/gr3d.c b/drivers/gpu/drm/tegra/gr3d.c
index 0b3f2b9..9ceaf35 100644
--- a/drivers/gpu/drm/tegra/gr3d.c
+++ b/drivers/gpu/drm/tegra/gr3d.c
@@ -1,6 +1,6 @@
 /*
  * Copyright (C) 2013 Avionic Design GmbH
- * Copyright (C) 2013 NVIDIA Corporation
+ * Copyright (C) 2013-2015 NVIDIA Corporation
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -94,7 +94,7 @@ static void gr3d_close_channel(struct tegra_drm_context *context)
 	host1x_channel_put(context->channel);
 }
 
-static int gr3d_is_addr_reg(struct device *dev, u32 class, u32 offset)
+static int gr3d_is_addr_reg(struct device *dev, u32 class, u32 offset, u32 val)
 {
 	struct gr3d *gr3d = dev_get_drvdata(dev);
 
diff --git a/drivers/gpu/host1x/job.c b/drivers/gpu/host1x/job.c
index b72aa91..77d977b 100644
--- a/drivers/gpu/host1x/job.c
+++ b/drivers/gpu/host1x/job.c
@@ -295,9 +295,10 @@ struct host1x_firewall {
 	u32 count;
 };
 
-static int check_register(struct host1x_firewall *fw, unsigned long offset)
+static int check_register(struct host1x_firewall *fw,
+			  unsigned long offset, u32 val)
 {
-	if (fw->job->is_addr_reg(fw->dev, fw->class, offset)) {
+	if (fw->job->is_addr_reg(fw->dev, fw->class, offset, val)) {
 		if (!fw->num_relocs)
 			return -EINVAL;
 
@@ -311,18 +312,21 @@ static int check_register(struct host1x_firewall *fw, unsigned long offset)
 	return 0;
 }
 
-static int check_mask(struct host1x_firewall *fw)
+static int check_mask(struct host1x_firewall *fw, struct host1x_job_gather *g)
 {
+	u32 *cmdbuf_base = (u32 *)fw->job->gather_copy_mapped +
+		(g->offset / sizeof(u32));
 	u32 mask = fw->mask;
 	u32 reg = fw->reg;
 	int ret;
 
 	while (mask) {
+		u32 val = cmdbuf_base[fw->offset];
 		if (fw->words == 0)
 			return -EINVAL;
 
 		if (mask & 1) {
-			ret = check_register(fw, reg);
+			ret = check_register(fw, reg, val);
 			if (ret < 0)
 				return ret;
 
@@ -336,17 +340,20 @@ static int check_mask(struct host1x_firewall *fw)
 	return 0;
 }
 
-static int check_incr(struct host1x_firewall *fw)
+static int check_incr(struct host1x_firewall *fw, struct host1x_job_gather *g)
 {
+	u32 *cmdbuf_base = (u32 *)fw->job->gather_copy_mapped +
+		(g->offset / sizeof(u32));
 	u32 count = fw->count;
 	u32 reg = fw->reg;
 	int ret;
 
 	while (count) {
+		u32 val = cmdbuf_base[fw->offset];
 		if (fw->words == 0)
 			return -EINVAL;
 
-		ret = check_register(fw, reg);
+		ret = check_register(fw, reg, val);
 		if (ret < 0)
 			return ret;
 
@@ -359,16 +366,20 @@ static int check_incr(struct host1x_firewall *fw)
 	return 0;
 }
 
-static int check_nonincr(struct host1x_firewall *fw)
+static int check_nonincr(struct host1x_firewall *fw,
+			 struct host1x_job_gather *g)
 {
+	u32 *cmdbuf_base = (u32 *)fw->job->gather_copy_mapped +
+		(g->offset / sizeof(u32));
 	u32 count = fw->count;
 	int ret;
 
 	while (count) {
+		u32 val = cmdbuf_base[fw->offset];
 		if (fw->words == 0)
 			return -EINVAL;
 
-		ret = check_register(fw, fw->reg);
+		ret = check_register(fw, fw->reg, val);
 		if (ret < 0)
 			return ret;
 
@@ -408,14 +419,14 @@ static int validate(struct host1x_firewall *fw, struct host1x_job_gather *g)
 			fw->class = word >> 6 & 0x3ff;
 			fw->mask = word & 0x3f;
 			fw->reg = word >> 16 & 0xfff;
-			err = check_mask(fw);
+			err = check_mask(fw, g);
 			if (err)
 				goto out;
 			break;
 		case 1:
 			fw->reg = word >> 16 & 0xfff;
 			fw->count = word & 0xffff;
-			err = check_incr(fw);
+			err = check_incr(fw, g);
 			if (err)
 				goto out;
 			break;
@@ -423,7 +434,7 @@ static int validate(struct host1x_firewall *fw, struct host1x_job_gather *g)
 		case 2:
 			fw->reg = word >> 16 & 0xfff;
 			fw->count = word & 0xffff;
-			err = check_nonincr(fw);
+			err = check_nonincr(fw, g);
 			if (err)
 				goto out;
 			break;
@@ -431,7 +442,7 @@ static int validate(struct host1x_firewall *fw, struct host1x_job_gather *g)
 		case 3:
 			fw->mask = word & 0xffff;
 			fw->reg = word >> 16 & 0xfff;
-			err = check_mask(fw);
+			err = check_mask(fw, g);
 			if (err)
 				goto out;
 			break;
diff --git a/include/linux/host1x.h b/include/linux/host1x.h
index d2ba7d3..fc86ced 100644
--- a/include/linux/host1x.h
+++ b/include/linux/host1x.h
@@ -1,5 +1,5 @@
 /*
- * Copyright (c) 2009-2013, NVIDIA Corporation. All rights reserved.
+ * Copyright (c) 2009-2015, NVIDIA Corporation. All rights reserved.
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -225,7 +225,7 @@ struct host1x_job {
 	u8 *gather_copy_mapped;
 
 	/* Check if register is marked as an address reg */
-	int (*is_addr_reg)(struct device *dev, u32 reg, u32 class);
+	int (*is_addr_reg)(struct device *dev, u32 reg, u32 class, u32 val);
 
 	/* Request a SETCLASS to this class */
 	u32 class;
-- 
2.1.4
