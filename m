From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Wed, 26 Mar 2014 19:22:07 +0100
Subject: [PATCH] clk: register fixed-clock only if #clock-cells property is
 present
Message-ID: <1395858127-18730-1-git-send-email-s.nawrocki@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After commit 1771b10d605d26ccee771a7fb4b08718c124097a
"clk: respect the clock dependencies in of_clk_init"
the order of registering clock providers and their corresponding
clocks may change. This commit currently causes a regression
on Exynos4 platforms, where fixed clocks are now being registered
through the standard "fixed-clock" compatible device driver, rather
than through a custom mechanism within the clk-exynos4 driver.
Then any attempts to register the fixed clocks in clk-exynos4
fail, since clocks named "xxti", "xusbxti" are already registered.
This means that some clock specifiers do not work any more, i.e.
those with phandle to the main clock controller node and fixed
indexes. This in turn causes wrong frequency of the root clocks
and various division by zero errors.

Hence for old dtbs, where #clock-cells property is missing in the
fixed-clock DT nodes for exynos4 this patch has a positive side
effect that the fixed clocks will not get registered through the
standard mechanism and the required clock names won't be taken
at the time the main clock controller driver's init callback is
called.

To make exynos use the standard fixed-clock registration mechanism,
related dts files could be updated, i.e. #clock-cells property
added together with required dependencies, that is a 'clocks'
property with phandles to the fixed clock nodes listed in it.
The dependencies specified in devicetree would then ensure proper
order of clocks registration.

Now the issue is that this patch affects not only exynos, but also
imx and at91 platforms. However, those use a custom compatible
string in addition to "fixed-clock" and I suspect registering
fixed clocks through the drivers/clk/clk-fixed-rate.c driver has
been  failing silently for them anyway. This patch could be
actually fixing similar issue as for exynos, seen after commit
"clk: respect the clock dependencies in of_clk_init".

There is one board that will likely break after this patch, i.e.
arch/arm/boot/dts/vf610-twr.dts. Nonetheless, it doesn't specify
the #clock-cells property, which is documented as mandatory in
Documentation/devicetree/bindings/clock/fixed-clock.txt.
So perhaps we could add the missing property to dts as a fix.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
 drivers/clk/clk-fixed-rate.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/clk/clk-fixed-rate.c b/drivers/clk/clk-fixed-rate.c
index 0fc56ab..cbbef2b 100644
--- a/drivers/clk/clk-fixed-rate.c
+++ b/drivers/clk/clk-fixed-rate.c
@@ -122,6 +122,11 @@ void of_fixed_clk_setup(struct device_node *node)
 	if (of_property_read_u32(node, "clock-frequency", &rate))
 		return;

+	if (!of_find_property(node, "#clock-cells", NULL)) {
+		pr_warn("clk: missing #clock-cells property at %s\n",
+			node->full_name);
+		return;
+	}
 	of_property_read_u32(node, "clock-accuracy", &accuracy);

 	of_property_read_string(node, "clock-output-names", &clk_name);
--
1.7.9.5
