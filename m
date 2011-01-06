From: tony@atomide.com (Tony Lindgren)
Date: Thu, 6 Jan 2011 09:49:51 -0800
Subject: Current OMAP build failures
In-Reply-To: <20110106171019.GF1198@n2100.arm.linux.org.uk>
References: <20110106110336.GC31708@n2100.arm.linux.org.uk>
	<878vyyx8s4.fsf@ti.com>
	<20110106171019.GF1198@n2100.arm.linux.org.uk>
Message-ID: <20110106174950.GU7771@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [110106 09:09]:
> On Thu, Jan 06, 2011 at 09:05:15AM -0800, Kevin Hilman wrote:
> > Hi Russell,
> > 
> > Russell King - ARM Linux <linux@arm.linux.org.uk> writes:
> > 
> > > I've observed the following issues while building 2.6.37 + my devel
> > > branch.  I don't believe any of them to be due to anything in my tree,
> > > so would be in 2.6.37 as well.
> > 
> > What defconfig are you using for these builds?
> 
> I couldn't say offhand because they're built from configs created a while
> back.  I tend to just re-run the build with appropriate O= arguments to
> test things.
> 
> I can send the defconfigs if it'd help.

I have the following patch queued up as commit be40f7a3d7b53c1a44e11b376b4a395d6b91f58d
which should fix the compile error you're seeing. This seems to be related
to some option in the .config that's not happening with any of the
defconfigs.

Regards,

Tony


commit be40f7a3d7b53c1a44e11b376b4a395d6b91f58d
Author: Tony Lindgren <tony@atomide.com>
Date:   Tue Dec 7 16:25:40 2010 -0800

    omap: Fix undefined reference to omap2_i2c_mux_pins
    
    In some cases we can get error function `omap2_i2c_add_bus':
    arch/arm/plat-omap/i2c.c:136: undefined reference to `omap2_i2c_mux_pins'
    arch/arm/plat-omap/i2c.c:141: undefined reference to `omap_hwmod_lookup'
    arch/arm/plat-omap/i2c.c:157: undefined reference to `omap_device_build'
    
    Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/plat-omap/i2c.c b/arch/arm/plat-omap/i2c.c
index a6cf4e9..db9c4ef 100644
--- a/arch/arm/plat-omap/i2c.c
+++ b/arch/arm/plat-omap/i2c.c
@@ -130,6 +130,7 @@ static struct omap_device_pm_latency omap_i2c_latency[] = {
 	},
 };
 
+#ifdef CONFIG_ARCH_OMAP2PLUS
 static inline int omap2_i2c_add_bus(int bus_id)
 {
 	int l;
@@ -166,6 +167,12 @@ static inline int omap2_i2c_add_bus(int bus_id)
 
 	return PTR_ERR(od);
 }
+#else
+static inline int omap2_i2c_add_bus(int bus_id)
+{
+	return 0;
+}
+#endif
 
 static int __init omap_i2c_add_bus(int bus_id)
 {
