From: natechancellor@gmail.com (Nathan Chancellor)
Date: Wed, 17 Oct 2018 10:09:02 -0700
Subject: [PATCH] misc: atmel-ssc: Fix section annotation on
 atmel_ssc_get_driver_data
Message-ID: <20181017170901.13119-1-natechancellor@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After building the kernel with Clang, the following section mismatch
warning appears:

WARNING: vmlinux.o(.text+0x3bf19a6): Section mismatch in reference from
the function ssc_probe() to the function
.init.text:atmel_ssc_get_driver_data()
The function ssc_probe() references
the function __init atmel_ssc_get_driver_data().
This is often because ssc_probe lacks a __init
annotation or the annotation of atmel_ssc_get_driver_data is wrong.

Remove __init from atmel_ssc_get_driver_data to get rid of the mismatch.

Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---

Alternatively, ssc_probe could be marked as __init, I don't think there
is any way for the probe to defer. I decided to go with the more
conservative option first but I'm happy to respin if necessary.

Thanks!

 drivers/misc/atmel-ssc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/atmel-ssc.c b/drivers/misc/atmel-ssc.c
index b2a0340f277e..d8e3cc2dc747 100644
--- a/drivers/misc/atmel-ssc.c
+++ b/drivers/misc/atmel-ssc.c
@@ -132,7 +132,7 @@ static const struct of_device_id atmel_ssc_dt_ids[] = {
 MODULE_DEVICE_TABLE(of, atmel_ssc_dt_ids);
 #endif
 
-static inline const struct atmel_ssc_platform_data * __init
+static inline const struct atmel_ssc_platform_data *
 	atmel_ssc_get_driver_data(struct platform_device *pdev)
 {
 	if (pdev->dev.of_node) {
-- 
2.19.1
