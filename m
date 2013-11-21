From: tony@atomide.com (Tony Lindgren)
Date: Wed, 20 Nov 2013 16:05:34 -0800
Subject: [PATCH] ARM: OMAP2+: Fix populating the hwmod data from device
 tree
In-Reply-To: <alpine.DEB.2.02.1311202148160.30143@utopia.booyaka.com>
References: <20131120025620.GF10317@atomide.com>
 <20131120181255.GG10317@atomide.com>
 <20131120192209.GI10317@atomide.com>
 <alpine.DEB.2.02.1311202148160.30143@utopia.booyaka.com>
Message-ID: <20131121000533.GJ10317@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Paul Walmsley <paul@pwsan.com> [131120 13:59]:
> On Wed, 20 Nov 2013, Tony Lindgren wrote:
> 
> > * Tony Lindgren <tony@atomide.com> [131120 10:13]:
> > > * Tony Lindgren <tony@atomide.com> [131119 18:57]:
> > > > We have some device tree properties where the ti,hwmod has multiple
> > > > values:
> > > > 
> > > > am33xx.dtsi:	ti,hwmods = "tpcc", "tptc0", "tptc1", "tptc2";
> > > > am4372.dtsi:	ti,hwmods = "tpcc", "tptc0", "tptc1", "tptc2";
> > 
> > I think these should be defined in the .dtsi files as separate devices
> > and removed from the related omap_hwmod_*_data.c files.
> > 
> > > > dra7.dtsi:	ti,hwmods = "l3_main_1", "l3_main_2";
> > 
> > These too should be defined in the .dtsi file. Looks like we're missing
> > the related data in the omap_hwmod_7xx_data.c file anyways?
> > 
> > > > omap3.dtsi:	ti,hwmods = "mcbsp2", "mcbsp2_sidetone";
> > > > omap3.dtsi:	ti,hwmods = "mcbsp3", "mcbsp3_sidetone";
> > 
> > OK the sidetone data we can probably parse using the ti,hwmods as
> > an index.
> > 
> > > > omap4.dtsi:	ti,hwmods = "l3_main_1", "l3_main_2", "l3_main_3";
> > > > omap5.dtsi:	ti,hwmods = "l3_main_1", "l3_main_2", "l3_main_3";
> > 
> > Benoit, I guess these mean that those devices should be created
> > dynamically, right?
> > 
> > Yet we've removed the related data in commit 3b9b10 and are not
> > passing it in the .dtsi file?
> > 
> > So these should be created as separate devices in the .dtsi file
> > instead AFAIK.
> > 
> > > Hmm I think this also needs part two to it to populate the right IO space
> > > based on the index, this probably now wrongly populates the first IO space
> > > for all the hwmod instances in the group.
> > 
> > Yeah this patch clearly is not the right fix to the problem of
> > missing data.
> 
> In most of the cases with multiple hwmods per DT device, there's probably 
> something wrong with the data.  So we should try to remove those when 
> possible.
> 
> For example if you look at the SIDETONE blocks, those should definitely be 
> separate DT devices - they have separate address spaces, SYSCONFIG 
> registers, etc. (section 21.6.2 "SIDETONE register mapping summary", 
> OMAP36xx TRM)

Agreed, those need to be fixed.
 
> Would strongly suspect that's the case also for the EDMA blocks you 
> mention.

Yes so it seems.
 
> Am not 100% sure about the L3 cases; would have to dig deeper.

They at least had interrupts listed looking at commit 3b9b10. Probably
the thing to do for now is to revert those changes, and see if we can
just remove the L3 entries from the .dtsi files.

In any case, to handle this better and to fix the overwriting issue,
here's a patch to deal with it and print out some warnings. Got any
better ideas?

Regards,

Tony


From: Tony Lindgren <tony@atomide.com>
Date: Wed, 20 Nov 2013 15:46:51 -0800
Subject: [PATCH] ARM: OMAP2+: Fix overwriting hwmod data with data from device
 tree
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

We have some device tree properties where the ti,hwmod have multiple
values:

am33xx.dtsi:	ti,hwmods = "tpcc", "tptc0", "tptc1", "tptc2";
am4372.dtsi:	ti,hwmods = "tpcc", "tptc0", "tptc1", "tptc2";
dra7.dtsi:	ti,hwmods = "l3_main_1", "l3_main_2";
omap3.dtsi:	ti,hwmods = "mcbsp2", "mcbsp2_sidetone";
omap3.dtsi:	ti,hwmods = "mcbsp3", "mcbsp3_sidetone";
omap4.dtsi:	ti,hwmods = "l3_main_1", "l3_main_2", "l3_main_3";
omap5.dtsi:	ti,hwmods = "l3_main_1", "l3_main_2", "l3_main_3";

That's not correct way of doing things because they are separate
devices with their own address space, interrupts, SYSCONFIG registers
and can set their PM states independently.

So they should all be fixed to be separate devices in the .dts files.

Until that happens, let's fix up the issue of overwriting the hwmod
data with the first ioreg from device tree by using and index
to keep track of the ioreg passed. That can then be used to handle
the ti,hwmods string array instead of just the first string to
find the related hwmod entrye.

Let's also add some warnings for bad data so it's easier to fix.

Cc: "Beno?t Cousson" <bcousson@baylibre.com>
Cc: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index e3f0eca..399c2a7 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -2330,34 +2330,62 @@ static int _shutdown(struct omap_hwmod *oh)
  * of_dev_hwmod_lookup - look up needed hwmod from dt blob
  * @np: struct device_node *
  * @oh: struct omap_hwmod *
+ * @index: index of the entry found
+ * @found: struct device_node * found or NULL
  *
  * Parse the dt blob and find out needed hwmod. Recursive function is
  * implemented to take care hierarchical dt blob parsing.
- * Return: The device node on success or NULL on failure.
+ * Return: Returns 0 on success, -ENODEV when not found.
  */
-static struct device_node *of_dev_hwmod_lookup(struct device_node *np,
-						struct omap_hwmod *oh)
+static int of_dev_hwmod_lookup(struct device_node *np,
+			       struct omap_hwmod *oh,
+			       int *index,
+			       struct device_node **found)
 {
-	struct device_node *np0 = NULL, *np1 = NULL;
-	const char *p;
+	struct device_node *np0 = NULL;
 
 	for_each_child_of_node(np, np0) {
-		if (of_find_property(np0, "ti,hwmods", NULL)) {
-			p = of_get_property(np0, "ti,hwmods", NULL);
-			if (!strcmp(p, oh->name))
-				return np0;
-			np1 = of_dev_hwmod_lookup(np0, oh);
-			if (np1)
-				return np1;
+		int count, i;
+
+		count = of_property_count_strings(np0, "ti,hwmods");
+		if (count < 1)
+			continue;
+
+		for (i = 0; i < count; i++) {
+			struct device_node *np1;
+			const char *p;
+			int res, ci;
+
+			res = of_property_read_string_index(np0, "ti,hwmods",
+							    i, &p);
+			if (res)
+				continue;
+
+			if (!strcmp(p, oh->name)) {
+				*found = np0;
+				*index = i;
+				return 0;
+			}
+			res = of_dev_hwmod_lookup(np0, oh, &ci, &np1);
+			if (res == 0) {
+				*found = np1;
+				*index = ci;
+				return 0;
+			}
 		}
 	}
-	return NULL;
+
+	*found = NULL;
+	*index = 0;
+
+	return -ENODEV;
 }
 
 /**
  * _init_mpu_rt_base - populate the virtual address for a hwmod
  * @oh: struct omap_hwmod * to locate the virtual address
  * @data: (unused, caller should pass NULL)
+ * @index: index of the reg entry iospace in device tree
  * @np: struct device_node * of the IP block's device node in the DT data
  *
  * Cache the virtual address used by the MPU to access this IP block's
@@ -2368,7 +2396,7 @@ static struct device_node *of_dev_hwmod_lookup(struct device_node *np,
  * -ENXIO on absent or invalid register target address space.
  */
 static int __init _init_mpu_rt_base(struct omap_hwmod *oh, void *data,
-				    struct device_node *np)
+				    int index, struct device_node *np)
 {
 	struct omap_hwmod_addr_space *mem;
 	void __iomem *va_start = NULL;
@@ -2390,13 +2418,17 @@ static int __init _init_mpu_rt_base(struct omap_hwmod *oh, void *data,
 		if (!np)
 			return -ENXIO;
 
-		va_start = of_iomap(np, oh->mpu_rt_idx);
+		va_start = of_iomap(np, index + oh->mpu_rt_idx);
 	} else {
 		va_start = ioremap(mem->pa_start, mem->pa_end - mem->pa_start);
 	}
 
 	if (!va_start) {
-		pr_err("omap_hwmod: %s: Could not ioremap\n", oh->name);
+		if (mem)
+			pr_err("omap_hwmod: %s: Could not ioremap\n", oh->name);
+		else
+			pr_err("omap_hwmod: %s: Missing dt reg%i for %s\n",
+			       oh->name, index, np->full_name);
 		return -ENXIO;
 	}
 
@@ -2422,17 +2454,29 @@ static int __init _init_mpu_rt_base(struct omap_hwmod *oh, void *data,
  */
 static int __init _init(struct omap_hwmod *oh, void *data)
 {
-	int r;
+	int r, index;
 	struct device_node *np = NULL;
 
 	if (oh->_state != _HWMOD_STATE_REGISTERED)
 		return 0;
 
-	if (of_have_populated_dt())
-		np = of_dev_hwmod_lookup(of_find_node_by_name(NULL, "ocp"), oh);
+	if (of_have_populated_dt()) {
+		struct device_node *bus;
+
+		bus = of_find_node_by_name(NULL, "ocp");
+		if (!bus)
+			return -ENODEV;
+
+		r = of_dev_hwmod_lookup(bus, oh, &index, &np);
+		if (r)
+			pr_debug("omap_hwmod: %s missing dt data\n", oh->name);
+		else if (np && index)
+			pr_warn("omap_hwmod: %s using broken dt data from %s\n",
+				oh->name, np->name);
+	}
 
 	if (oh->class->sysc) {
-		r = _init_mpu_rt_base(oh, NULL, np);
+		r = _init_mpu_rt_base(oh, NULL, index, np);
 		if (r < 0) {
 			WARN(1, "omap_hwmod: %s: doesn't have mpu register target base\n",
 			     oh->name);
