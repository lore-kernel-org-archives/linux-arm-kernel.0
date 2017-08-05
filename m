From: Julia.Lawall@lip6.fr (Julia Lawall)
Date: Sat,  5 Aug 2017 22:37:17 +0200
Subject: [PATCH 4/4] thermal: bcm2835: constify thermal_zone_of_device_ops
 structures
In-Reply-To: <1501965437-30730-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1501965437-30730-1-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <1501965437-30730-5-git-send-email-Julia.Lawall@lip6.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The thermal_zone_of_device_ops structure is only passed as the fourth
argument to thermal_zone_of_sensor_register, which is declared as const.
Thus the thermal_zone_of_device_ops structure itself can be const.

Done with the help of Coccinelle.

// <smpl>
@r disable optional_qualifier@
identifier i;
position p;
@@
static struct thermal_zone_of_device_ops i at p = { ... };

@ok1@
identifier r.i;
expression e1,e2,e3;
position p;
@@
thermal_zone_of_sensor_register(e1,e2,e3,&i at p)

@bad@
position p != {r.p,ok1.p};
identifier r.i;
struct thermal_zone_of_device_ops e;
@@
e at i@p

@depends on !bad disable optional_qualifier@
identifier r.i;
@@
static
+const
 struct thermal_zone_of_device_ops i = { ... };
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 drivers/thermal/broadcom/bcm2835_thermal.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/broadcom/bcm2835_thermal.c b/drivers/thermal/broadcom/bcm2835_thermal.c
index e6863c8..a4d6a0e 100644
--- a/drivers/thermal/broadcom/bcm2835_thermal.c
+++ b/drivers/thermal/broadcom/bcm2835_thermal.c
@@ -145,7 +145,7 @@ static void bcm2835_thermal_debugfs(struct platform_device *pdev)
 	debugfs_create_regset32("regset", 0444, data->debugfsdir, regset);
 }
 
-static struct thermal_zone_of_device_ops bcm2835_thermal_ops = {
+static const struct thermal_zone_of_device_ops bcm2835_thermal_ops = {
 	.get_temp = bcm2835_thermal_get_temp,
 };
 
