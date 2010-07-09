From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 9 Jul 2010 13:40:50 +0100
Subject: [PATCH v4] GPIO PL061: Adding Clk framework support
In-Reply-To: <1277183247-4557-1-git-send-email-viresh.kumar@st.com>
References: <1277183247-4557-1-git-send-email-viresh.kumar@st.com>
Message-ID: <20100709124050.GF22845@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 22, 2010 at 10:37:27AM +0530, Viresh KUMAR wrote:
> -	spin_lock_init(&chip->lock);
> -	spin_lock_init(&chip->irq_lock);
> -	INIT_LIST_HEAD(&chip->list);
> +	chip->clk = clk_get(&dev->dev, NULL);
> +	if (IS_ERR(chip->clk)) {
> +		ret = PTR_ERR(chip->clk);
> +		/* clk Not present */
> +		if (ret == -ENOENT)
> +			chip->clk = NULL;

Please don't assume that NULL is not a valid value for a 'struct clk'.
Eg,

struct clk *clk_get(struct device *dev, const char *id)
{
        return dev && strcmp(dev_name(dev), "mb:16") == 0 ? NULL : ERR_PTR(-ENOENT);
}

However, this patch begs the question about what you're trying to do,
as the primecell doesn't take a clock for its operation other than the
AMBA bus clock.

As I've already pointed out, the current primecell implementations do
not assume that the bus clock is switched - and so they aren't written
such that the bus clock will be fiddled with when they do clk_enable
and clk_disable on their functional clocks.

As there do seem to be platforms which can switch the bus clock to
individual primecells, we need to add this support - and using the
existing clk API calls won't do, especially as we have primecell code
which accesses registers prior to doing anything with the clk API.

How about we have the core primecell code request the bus clock on
driver probe, enable it, and then call the drivers probe method.  On
driver remove, the bus clock is disabled and put after the drivers
remove method has been called.  We provide two new function calls,
amba_bus_clk_enable() and amba_bus_clk_disable() which primecell
drivers can use to control the bus clock to the peripheral - these
can be just macros to clk_enable and clk_disable respectively.

So something like the patch below (untested):

 drivers/amba/bus.c       |   35 +++++++++++++++++++++++++++++++----
 include/linux/amba/bus.h |   10 ++++++++++
 2 files changed, 41 insertions(+), 4 deletions(-)

diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
index f60b2b6..1b9f5f8 100644
--- a/drivers/amba/bus.c
+++ b/drivers/amba/bus.c
@@ -130,17 +130,44 @@ static int amba_probe(struct device *dev)
 {
 	struct amba_device *pcdev = to_amba_device(dev);
 	struct amba_driver *pcdrv = to_amba_driver(dev->driver);
-	struct amba_id *id;
+	struct amba_id *id = amba_lookup(pcdrv->id_table, pcdev);
+	struct clk *clk;
+	int ret;
+
+	do {
+		pcdev->busck = clk = clk_get(dev, "busck");
+		if (IS_ERR(clk) && PTR_ERR(clk) != -ENOENT) {
+			ret = PTR_ERR(clk);
+			break;
+		}
+
+		if (!IS_ERR(clk)) {
+			ret = clk_enable(clk);
+			if (ret)
+				break;
+		}
 
-	id = amba_lookup(pcdrv->id_table, pcdev);
+		ret = pcdrv->probe(pcdev, id);
+		if (ret == 0)
+			break;
 
-	return pcdrv->probe(pcdev, id);
+		clk_disable(clk);
+	} while (0);
+
+	return ret;
 }
 
 static int amba_remove(struct device *dev)
 {
+	struct amba_device *pcdev = to_amba_device(dev);
 	struct amba_driver *drv = to_amba_driver(dev->driver);
-	return drv->remove(to_amba_device(dev));
+	int ret = drv->remove(pcdev);
+
+	if (!IS_ERR(pcdev->busck)) {
+		clk_disable(pcdev->busck);
+		clk_put(pcdev->busck);
+	}
+	return ret;
 }
 
 static void amba_shutdown(struct device *dev)
diff --git a/include/linux/amba/bus.h b/include/linux/amba/bus.h
index 8b10386..f880c58 100644
--- a/include/linux/amba/bus.h
+++ b/include/linux/amba/bus.h
@@ -15,13 +15,17 @@
 #define ASMARM_AMBA_H
 
 #include <linux/device.h>
+#include <linux/err.h>
 #include <linux/resource.h>
 
 #define AMBA_NR_IRQS	2
 
+struct clk;
+
 struct amba_device {
 	struct device		dev;
 	struct resource		res;
+	struct clk		*busck;
 	u64			dma_mask;
 	unsigned int		periphid;
 	unsigned int		irq[AMBA_NR_IRQS];
@@ -59,6 +63,12 @@ struct amba_device *amba_find_device(const char *, struct device *, unsigned int
 int amba_request_regions(struct amba_device *, const char *);
 void amba_release_regions(struct amba_device *);
 
+#define amba_bus_clk_enable(d)	\
+	(IS_ERR((d)->busck) ? 0 : clk_enable((d)->busck))
+
+#define amba_bus_clk_disable(d)	\
+	do { if (!IS_ERR((d)->busck)) clk_disable((d)->busck); } while (0)
+
 #define amba_config(d)	(((d)->periphid >> 24) & 0xff)
 #define amba_rev(d)	(((d)->periphid >> 20) & 0x0f)
 #define amba_manf(d)	(((d)->periphid >> 12) & 0xff)
