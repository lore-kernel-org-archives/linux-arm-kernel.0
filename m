From: maitysanchayan@gmail.com (Sanchayan Maity)
Date: Tue, 16 Feb 2016 10:30:53 +0530
Subject: [PATCH v3 1/3] hwmon: iio_hwmon: Allow the driver to accept hypen in
 device tree node names
In-Reply-To: <cover.1455597464.git.maitysanchayan@gmail.com>
References: <cover.1455597464.git.maitysanchayan@gmail.com>
Message-ID: <cca90e7d9b8fae5da5b186ae80b7081a8b6d3645.1455597464.git.maitysanchayan@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently the driver calls hwmon_device_register_with_groups which
does not accept hypen in node name and returns EINVAL. Use of hypen
in device tree node name results in probe failure., however use of
hypen in device tree node name is perfectly acceptable.

Change this by allocating a duplicate managed string, replacing
hypen with underscore and then calling hwmon_device_register_with_groups.
This allows the use of hypen in device tree node name while maintaining
backwards compatibility and preventing any possible regressions with
user space.

Signed-off-by: Sanchayan Maity <maitysanchayan@gmail.com>
---
 drivers/hwmon/iio_hwmon.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/iio_hwmon.c b/drivers/hwmon/iio_hwmon.c
index 17ae2eb..b550ba5 100644
--- a/drivers/hwmon/iio_hwmon.c
+++ b/drivers/hwmon/iio_hwmon.c
@@ -67,6 +67,7 @@ static int iio_hwmon_probe(struct platform_device *pdev)
 	enum iio_chan_type type;
 	struct iio_channel *channels;
 	const char *name = "iio_hwmon";
+	char *sname;
 
 	if (dev->of_node && dev->of_node->name)
 		name = dev->of_node->name;
@@ -144,7 +145,15 @@ static int iio_hwmon_probe(struct platform_device *pdev)
 
 	st->attr_group.attrs = st->attrs;
 	st->groups[0] = &st->attr_group;
-	st->hwmon_dev = hwmon_device_register_with_groups(dev, name, st,
+
+	sname = devm_kstrdup(dev, name, GFP_KERNEL);
+	if (!sname) {
+		ret = -ENOMEM;
+		goto error_release_channels;
+	}
+
+	strreplace(sname, '-', '_');
+	st->hwmon_dev = hwmon_device_register_with_groups(dev, sname, st,
 							  st->groups);
 	if (IS_ERR(st->hwmon_dev)) {
 		ret = PTR_ERR(st->hwmon_dev);
-- 
2.7.1
