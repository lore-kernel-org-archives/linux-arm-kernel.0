From: ioana.ciornei@nxp.com (Ioana Ciornei)
Date: Mon, 5 Nov 2018 09:30:33 +0000
Subject: [PATCH 2/2] soc: fsl: dpio: use a cpumask to identify which cpus are
 unused
In-Reply-To: <1541410219-9943-1-git-send-email-ioana.ciornei@nxp.com>
References: <1541410219-9943-1-git-send-email-ioana.ciornei@nxp.com>
Message-ID: <1541410219-9943-3-git-send-email-ioana.ciornei@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current implementation of the dpio driver uses a static next_cpu
variable to keep track of the index of the next cpu available. This
approach does not handle well unbinding and binding dpio devices in a
random order. For example, unbinding a dpio and then binding it again
with the driver, will generate the below error:

$ echo dpio.5 > /sys/bus/fsl-mc/drivers/fsl_mc_dpio/unbind
$ echo dpio.5 > /sys/bus/fsl-mc/drivers/fsl_mc_dpio/bind
[  103.946380] fsl_mc_dpio dpio.5: probe failed. Number of DPIOs exceeds
NR_CPUS.
[  103.955157] fsl_mc_dpio dpio.5: fsl_mc_driver_probe failed: -34
-bash: echo: write error: No such device

Fix this error by keeping a global cpumask of unused cpus that will be
updated at every dpaa2_dpio_[probe,remove].

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
 drivers/soc/fsl/dpio/dpio-driver.c  | 25 ++++++++++++++++---------
 drivers/soc/fsl/dpio/dpio-service.c |  6 ++++++
 include/soc/fsl/dpaa2-io.h          |  2 ++
 3 files changed, 24 insertions(+), 9 deletions(-)

diff --git a/drivers/soc/fsl/dpio/dpio-driver.c b/drivers/soc/fsl/dpio/dpio-driver.c
index e58fcc9..832175c 100644
--- a/drivers/soc/fsl/dpio/dpio-driver.c
+++ b/drivers/soc/fsl/dpio/dpio-driver.c
@@ -30,6 +30,8 @@ struct dpio_priv {
 	struct dpaa2_io *io;
 };
 
+static cpumask_var_t cpus_unused_mask;
+
 static irqreturn_t dpio_irq_handler(int irq_num, void *arg)
 {
 	struct device *dev = (struct device *)arg;
@@ -86,7 +88,7 @@ static int dpaa2_dpio_probe(struct fsl_mc_device *dpio_dev)
 	struct dpio_priv *priv;
 	int err = -ENOMEM;
 	struct device *dev = &dpio_dev->dev;
-	static int next_cpu = -1;
+	int possible_next_cpu;
 
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
@@ -128,17 +130,14 @@ static int dpaa2_dpio_probe(struct fsl_mc_device *dpio_dev)
 	desc.dpio_id = dpio_dev->obj_desc.id;
 
 	/* get the cpu to use for the affinity hint */
-	if (next_cpu == -1)
-		next_cpu = cpumask_first(cpu_online_mask);
-	else
-		next_cpu = cpumask_next(next_cpu, cpu_online_mask);
-
-	if (!cpu_possible(next_cpu)) {
+	possible_next_cpu = cpumask_first(cpus_unused_mask);
+	if (possible_next_cpu >= nr_cpu_ids) {
 		dev_err(dev, "probe failed. Number of DPIOs exceeds NR_CPUS.\n");
 		err = -ERANGE;
 		goto err_allocate_irqs;
 	}
-	desc.cpu = next_cpu;
+	desc.cpu = possible_next_cpu;
+	cpumask_clear_cpu(possible_next_cpu, cpus_unused_mask);
 
 	/*
 	 * Set the CENA regs to be the cache inhibited area of the portal to
@@ -211,7 +210,7 @@ static int dpaa2_dpio_remove(struct fsl_mc_device *dpio_dev)
 {
 	struct device *dev;
 	struct dpio_priv *priv;
-	int err;
+	int err = 0, cpu;
 
 	dev = &dpio_dev->dev;
 	priv = dev_get_drvdata(dev);
@@ -220,6 +219,9 @@ static int dpaa2_dpio_remove(struct fsl_mc_device *dpio_dev)
 
 	dpio_teardown_irqs(dpio_dev);
 
+	cpu = dpaa2_io_get_cpu(priv->io);
+	cpumask_set_cpu(cpu, cpus_unused_mask);
+
 	err = fsl_mc_portal_allocate(dpio_dev, 0, &dpio_dev->mc_io);
 	if (err) {
 		dev_err(dev, "MC portal allocation failed\n");
@@ -267,11 +269,16 @@ static int dpaa2_dpio_remove(struct fsl_mc_device *dpio_dev)
 
 static int dpio_driver_init(void)
 {
+	if (!zalloc_cpumask_var(&cpus_unused_mask, GFP_KERNEL))
+		return -ENOMEM;
+	cpumask_copy(cpus_unused_mask, cpu_online_mask);
+
 	return fsl_mc_driver_register(&dpaa2_dpio_driver);
 }
 
 static void dpio_driver_exit(void)
 {
+	free_cpumask_var(cpus_unused_mask);
 	fsl_mc_driver_unregister(&dpaa2_dpio_driver);
 }
 module_init(dpio_driver_init);
diff --git a/drivers/soc/fsl/dpio/dpio-service.c b/drivers/soc/fsl/dpio/dpio-service.c
index 21c3e32..3198265 100644
--- a/drivers/soc/fsl/dpio/dpio-service.c
+++ b/drivers/soc/fsl/dpio/dpio-service.c
@@ -214,6 +214,12 @@ irqreturn_t dpaa2_io_irq(struct dpaa2_io *obj)
 	return IRQ_HANDLED;
 }
 
+int dpaa2_io_get_cpu(struct dpaa2_io *d)
+{
+	return d->dpio_desc.cpu;
+}
+EXPORT_SYMBOL(dpaa2_io_get_cpu);
+
 /**
  * dpaa2_io_service_register() - Prepare for servicing of FQDAN or CDAN
  *                               notifications on the given DPIO service.
diff --git a/include/soc/fsl/dpaa2-io.h b/include/soc/fsl/dpaa2-io.h
index ab51e40..1c1764f 100644
--- a/include/soc/fsl/dpaa2-io.h
+++ b/include/soc/fsl/dpaa2-io.h
@@ -90,6 +90,8 @@ struct dpaa2_io_notification_ctx {
 	void *dpio_private;
 };
 
+int dpaa2_io_get_cpu(struct dpaa2_io *d);
+
 int dpaa2_io_service_register(struct dpaa2_io *service,
 			      struct dpaa2_io_notification_ctx *ctx);
 void dpaa2_io_service_deregister(struct dpaa2_io *service,
-- 
1.9.1
