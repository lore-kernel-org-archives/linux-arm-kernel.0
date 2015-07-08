From: mperttunen@nvidia.com (Mikko Perttunen)
Date: Wed, 8 Jul 2015 14:27:44 +0300
Subject: [PATCH 1/5] host1x: Store device address to all bufs
In-Reply-To: <1436354868-24309-1-git-send-email-mperttunen@nvidia.com>
References: <1436354868-24309-1-git-send-email-mperttunen@nvidia.com>
Message-ID: <1436354868-24309-2-git-send-email-mperttunen@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Arto Merilainen <amerilainen@nvidia.com>

Currently job pinning is optimized to handle only the first buffer
using a certain host1x_bo object and all subsequent buffers using
the same host1x_bo are considered done.

In most cases this is correct, however, in case the same host1x_bo
is used in multiple gathers inside the same job, we skip also
storing the device address (physical or iova) to this buffer.

This patch reworks the host1x_job_pin() to store the device address
to all gathers.

Signed-off-by: Andrew Chew <achew@nvidia.com>
Signed-off-by: Arto Merilainen <amerilainen@nvidia.com>
Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 drivers/gpu/host1x/job.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/host1x/job.c b/drivers/gpu/host1x/job.c
index 63bd63f..b72aa91 100644
--- a/drivers/gpu/host1x/job.c
+++ b/drivers/gpu/host1x/job.c
@@ -1,7 +1,7 @@
 /*
  * Tegra host1x Job
  *
- * Copyright (c) 2010-2013, NVIDIA Corporation.
+ * Copyright (c) 2010-2015, NVIDIA Corporation.
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms and conditions of the GNU General Public License,
@@ -538,9 +538,12 @@ int host1x_job_pin(struct host1x_job *job, struct device *dev)
 
 		g->base = job->gather_addr_phys[i];
 
-		for (j = i + 1; j < job->num_gathers; j++)
-			if (job->gathers[j].bo == g->bo)
+		for (j = i + 1; j < job->num_gathers; j++) {
+			if (job->gathers[j].bo == g->bo) {
 				job->gathers[j].handled = true;
+				job->gathers[j].base = g->base;
+			}
+		}
 
 		err = do_relocs(job, g->bo);
 		if (err)
-- 
2.1.4
