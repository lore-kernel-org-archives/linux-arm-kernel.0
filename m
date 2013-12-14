From: weiyj.lk@gmail.com (Wei Yongjun)
Date: Sat, 14 Dec 2013 12:43:11 +0800
Subject: [PATCH -next] ARM: pxa: fix return value check in
 em_x270_sensor_init()
Message-ID: <CAPgLHd_SQbatw9n57n-FPT1O3j4s_8YonjO8RwWCUscroh5jcw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

In case of error, the function regulator_get() returns ERR_PTR()
and never returns NULL. The NULL test in the return value check
should be replaced with IS_ERR().

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 arch/arm/mach-pxa/em-x270.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-pxa/em-x270.c b/arch/arm/mach-pxa/em-x270.c
index 6915a9f..339b422 100644
--- a/arch/arm/mach-pxa/em-x270.c
+++ b/arch/arm/mach-pxa/em-x270.c
@@ -971,9 +971,9 @@ static int em_x270_sensor_init(void)
 	gpio_direction_output(cam_reset, 0);
 
 	em_x270_camera_ldo = regulator_get(NULL, "vcc cam");
-	if (em_x270_camera_ldo == NULL) {
+	if (IS_ERR(em_x270_camera_ldo)) {
 		gpio_free(cam_reset);
-		return -ENODEV;
+		return PTR_ERR(em_x270_camera_ldo);
 	}
 
 	ret = regulator_enable(em_x270_camera_ldo);
