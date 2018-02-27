From: benjamin.gaignard@linaro.org (Benjamin Gaignard)
Date: Tue, 27 Feb 2018 15:09:24 +0100
Subject: [PATCH 1/3] driver core: check notifier_call_chain return value
In-Reply-To: <20180227140926.22996-1-benjamin.gaignard@st.com>
References: <20180227140926.22996-1-benjamin.gaignard@st.com>
Message-ID: <20180227140926.22996-2-benjamin.gaignard@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When being notified that a driver is about to be bind a listener
could return NOTIFY_BAD.
Check the return to be sure that the driver could be bind.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
 drivers/base/dd.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index de6fd092bf2f..9275f2c0fed2 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -304,9 +304,12 @@ static int driver_sysfs_add(struct device *dev)
 {
 	int ret;
 
-	if (dev->bus)
-		blocking_notifier_call_chain(&dev->bus->p->bus_notifier,
-					     BUS_NOTIFY_BIND_DRIVER, dev);
+	if (dev->bus) {
+		if (blocking_notifier_call_chain(&dev->bus->p->bus_notifier,
+						 BUS_NOTIFY_BIND_DRIVER, dev) ==
+						 NOTIFY_BAD)
+			return -EINVAL;
+	}
 
 	ret = sysfs_create_link(&dev->driver->p->kobj, &dev->kobj,
 				kobject_name(&dev->kobj));
-- 
2.15.0
