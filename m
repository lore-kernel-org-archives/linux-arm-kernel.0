From: dave.martin@linaro.org (Dave Martin)
Date: Fri, 30 Sep 2011 17:56:40 +0100
Subject: [RFC PATCH 1/3] ARM: amba: pass a suitable modalias to udev
In-Reply-To: <1317401802-24362-1-git-send-email-dave.martin@linaro.org>
References: <1317401802-24362-1-git-send-email-dave.martin@linaro.org>
Message-ID: <1317401802-24362-2-git-send-email-dave.martin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch defines and imlpements a new modalias for AMBA devices:

        MODALIAS=amba:xxxxxxxx

where 'x' is a hex digit in lower case.

This enables udev to auto-load modules transparently for AMBA
devices, provided that each driver makes suitable MODULE_ALIAS()
declarations based on the supported AMBA device IDs.

Without this, drivers built as modules never get loaded, unless
they are loaded manually.

Signed-off-by: Dave Martin <dave.martin@linaro.org>
---
 drivers/amba/bus.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
index d74926e..7d2ba0b 100644
--- a/drivers/amba/bus.c
+++ b/drivers/amba/bus.c
@@ -52,7 +52,14 @@ static int amba_uevent(struct device *dev, struct kobj_uevent_env *env)
 	int retval = 0;
 
 	retval = add_uevent_var(env, "AMBA_ID=%08x", pcdev->periphid);
-	return retval;
+	if (retval)
+		return retval;
+
+	retval = add_uevent_var(env, "MODALIAS=amba:%08x", pcdev->periphid);
+	if (retval)
+		return retval;
+
+	return 0;
 }
 #else
 #define amba_uevent NULL
-- 
1.7.4.1
