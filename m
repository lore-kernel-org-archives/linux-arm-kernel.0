From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 30 Jul 2011 14:05:37 +0100
Subject: [PATCH 07/18] dmaengine/amba-pl08x: Enable/Disable amba_pclk
	with channel requests
In-Reply-To: <20110730120740.GA15791@n2100.arm.linux.org.uk>
References: <cover.1311936523.git.viresh.kumar@st.com>
	<96781d46e41fa6ffc04b88527a25d73f5a59eda8.1311936524.git.viresh.kumar@st.com>
	<20110730120740.GA15791@n2100.arm.linux.org.uk>
Message-ID: <20110730130537.GB15791@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 30, 2011 at 01:07:40PM +0100, Russell King - ARM Linux wrote:
> On Fri, Jul 29, 2011 at 04:19:17PM +0530, Viresh Kumar wrote:
> > Amba devices have interface clocks attached as adev->pclk. This is the only
> > clock associated with DMAC and it can be disabled when DMAC is not in use. This
> > patch adds support to enable/disable this clk as and when channels are requested
> > and freed. Also it disables this clock at the end of probe.
> 
> It may make better sense to convert this to runtime PM.  I suspect
> that there's core support which the amba/bus.c can do to help in that
> respect (eg, managing the apb pclk itself) so that we don't have to
> add the same code to every primecell driver.

Something like this for the bus driver (untested):

 drivers/amba/bus.c |   38 ++++++++++++++++++++++++++++++++++++--
 1 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
index d74926e..9e93f34 100644
--- a/drivers/amba/bus.c
+++ b/drivers/amba/bus.c
@@ -365,6 +365,40 @@ static int amba_pm_restore_noirq(struct device *dev)
 
 #endif /* !CONFIG_HIBERNATE_CALLBACKS */
 
+#ifdef CONFIG_PM_RUNTIME
+/*
+ * Hooks to provide runtime PM of the pclk (bus clock).  It is safe to
+ * enable/disable the bus clock at runtime PM suspend/resume as this
+ * does not result in loss of context.  However, disabling vcore power
+ * would do, so we leave that to the driver.
+ */
+static int amba_pm_runtime_suspend(struct device *dev)
+{
+	struct amba_device *pcdev = to_amba_device(dev);
+	int ret = pm_generic_runtime_suspend(dev);
+
+	if (ret == 0 && dev->driver)
+		clk_disable(pcdev->pclk);
+
+	return ret;
+}
+
+static int amba_pm_runtime_resume(struct device *dev)
+{
+	struct amba_device *pcdev = to_amba_device(dev);
+	int ret;
+
+	if (dev->driver) {
+		ret = clk_enable(pcdev->pclk);
+		/* Failure is probably fatal to the system, but... */
+		if (ret)
+			return ret;
+	}
+
+	return pm_generic_runtime_resume(dev);
+}
+#endif
+
 #ifdef CONFIG_PM
 
 static const struct dev_pm_ops amba_pm = {
@@ -383,8 +417,8 @@ static const struct dev_pm_ops amba_pm = {
 	.poweroff_noirq	= amba_pm_poweroff_noirq,
 	.restore_noirq	= amba_pm_restore_noirq,
 	SET_RUNTIME_PM_OPS(
-		pm_generic_runtime_suspend,
-		pm_generic_runtime_resume,
+		amba_pm_runtime_suspend,
+		amba_pm_runtime_resume,
 		pm_generic_runtime_idle
 	)
 };
