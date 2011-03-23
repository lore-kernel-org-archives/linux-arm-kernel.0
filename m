From: linus.walleij@stericsson.com (Linus Walleij)
Date: Wed, 23 Mar 2011 11:04:34 +0100
Subject: [PATCH 3/6] amba: make hardcoded periphid override hardware
Message-ID: <1300874674-14780-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

This makes a hardcoded periphid from the platform override any
magic number found in the hardware. This shall henceforth be used
when the information found in the hardware is either missing,
i.e. not encoding the CID with the magic cookie 0xb105f00d, or
incorrect such that the revision number should have been bumped in
hardware, but the silicon designer has failed to do so.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/amba/bus.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
index 6d2bb25..fcf355c 100644
--- a/drivers/amba/bus.c
+++ b/drivers/amba/bus.c
@@ -603,6 +603,10 @@ int amba_device_register(struct amba_device *dev, struct resource *parent)
 	if (ret)
 		goto err_out;
 
+	/* Hard-coded primecell ID instead of plug-n-play */
+	if (dev->periphid != 0)
+		goto skip_probe;
+
 	/*
 	 * Dynamically calculate the size of the resource
 	 * and use this for iomap
@@ -643,6 +647,7 @@ int amba_device_register(struct amba_device *dev, struct resource *parent)
 	if (ret)
 		goto err_release;
 
+ skip_probe:
 	ret = device_add(&dev->dev);
 	if (ret)
 		goto err_release;
-- 
1.7.3.2
