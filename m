From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Mon, 6 Sep 2010 16:46:24 +0300
Subject: [PATCH v5 3/7] wireless: wl12xx: add platform data passing support
In-Reply-To: <20100906120716.GE20903@n2100.arm.linux.org.uk>
References: <1283376410-9999-1-git-send-email-ohad@wizery.com>
	<1283376410-9999-4-git-send-email-ohad@wizery.com>
	<AANLkTi=goLEUqM1XQ__PrGu4=Erw2utaNP4qFmSgRta2@mail.gmail.com>
	<20100906120716.GE20903@n2100.arm.linux.org.uk>
Message-ID: <AANLkTi=z-cqdwrbXo9pv9WhZkrnb7X+zpVNbJ_-VTJ16@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/9/6 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> We could instead make wl12xx_get_platform_data() return a const pointer
> to its own internal storage instead, or ERR pointers for the various
> failure cases.

Sounds good:

diff --git a/drivers/net/wireless/wl12xx/wl12xx_platform_data.c
b/drivers/net/wireless/wl12xx/wl12xx_platform_data.c
new file mode 100644
index 0000000..973b110
--- /dev/null
+++ b/drivers/net/wireless/wl12xx/wl12xx_platform_data.c
@@ -0,0 +1,28 @@
+#include <linux/module.h>
+#include <linux/err.h>
+#include <linux/wl12xx.h>
+
+static const struct wl12xx_platform_data *platform_data;
+
+int __init wl12xx_set_platform_data(const struct wl12xx_platform_data *data)
+{
+	if (platform_data)
+		return -EBUSY;
+	if (!data)
+		return -EINVAL;
+
+	platform_data = kmemdup(data, sizeof(*data), GFP_KERNEL);
+	if (!platform_data)
+		return -ENOMEM;
+
+	return 0;
+}
+
+const struct wl12xx_platform_data *wl12xx_get_platform_data(void)
+{
+	if (!platform_data)
+		return ERR_PTR(-ENODEV);
+
+	return platform_data;
+}
+EXPORT_SYMBOL(wl12xx_get_platform_data);


I'll wait a few days to see if there's any other comment, and then
post v6 with this change.

>
