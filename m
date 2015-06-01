From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 1 Jun 2015 16:58:25 +0200
Subject: Please revert 3eea8b5d68c801fec788b411582b803463834752 as it
 breaks touchscreen on n900.
In-Reply-To: <20150601140605.GA26908@amd>
References: <20150529192505.GA28987@amd> <20150529193211.GA7599@amd>
 <20150529194955.GV2026@saruman.tx.rr.com>
 <20150529195629.GA9811@amd> <20150529201745.GC17267@lukather>
 <20150529202123.GY2026@saruman.tx.rr.com>
 <20150529202954.GA26494@localhost> <20150529203456.GC22083@amd>
 <20150601095556.GH17267@lukather> <20150601140605.GA26908@amd>
Message-ID: <20150601145825.GA20557@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 01, 2015 at 04:06:06PM +0200, Pavel Machek wrote:
> Hi!
> 
> > > But that's not what I'm asking. See a changelog of
> > > 3eea8b5d68c801fec788b411582b803463834752 and compare it with what it
> > > actually does.
> > > 
> > > It is buggy. If fuzz is specified but maximum is not, it overwites
> > > maximum with zero.
> > 
> > If maximum is not set, you'll have other issues anyway. But it really
> > boils down on what the default behaviour should be.
> 
> It was not broken before commit
> 3eea8b5d68c801fec788b411582b803463834752. Maximum was set, but after
> your patch, it is overwritten with zero.
> 
> > > Plus it introduces new failure "if (!test_bit(axis, dev->absbit))".
> > 
> > It's not a new failure, it's testing against stupid code.
> 
> Yes. In a commit marked "cleanup". We call this "undocumented
> feature".

It has never been said that it was a "cleanup" (whatever the double
quotes mean) but a rework. And it's not a feature either.

> > If an axis is setup in the DT but not registered in the driver,
> > something is wrong, most probably the DT.
> 
> Yes, we have fixed the DT, so that bug you introduced will not happen
> on n900 with updated device tree.

s/updated/fixed/

> > > Plus it fails to distinguish between "value not specified in the dt"
> > > and "zero is specified in the dt".
> > 
> > Again, default behaviour.
> 
> Again, regression from 4.0 kernel, you are not willing to fix.
>
> > > The 3eea8b5d68c801fec788b411582b803463834752 is just bad.
> > 
> > You were very welcome to review this patch at the time and/or suggest
> > a fix that pleases everyone.
> 
> You should be the one that should suggest fixes, as you broke it in
> the first place. But clearly you don't understand that.

You actually never asked for a fix, and went head first calling this
patch "bad" and asking for nothing but reverting it.

It's not really a very good way to move forward and start a productive
discussion.

I'm sorry if this cause you any issues, but reverting this patch will
break users (and this time at the kernel level only, the DT has
nothing to do with that) just like you are right now.

What about:

-- >8 --
diff --git a/drivers/input/touchscreen/of_touchscreen.c b/drivers/input/touchscreen/of_touchscreen.c
index b82b5207c78b..7e98c2e443ab 100644
--- a/drivers/input/touchscreen/of_touchscreen.c
+++ b/drivers/input/touchscreen/of_touchscreen.c
@@ -14,10 +14,10 @@
 #include <linux/input/mt.h>
 #include <linux/input/touchscreen.h>
 
-static u32 of_get_optional_u32(struct device_node *np,
+static int of_get_optional_u32(struct device_node *np,
 			       const char *property)
 {
-	u32 val = 0;
+	int val = -1;
 
 	of_property_read_u32(np, property, &val);
 
@@ -42,8 +42,12 @@ static void touchscreen_set_params(struct input_dev *dev,
 	}
 
 	absinfo = &dev->absinfo[axis];
-	absinfo->maximum = max;
-	absinfo->fuzz = fuzz;
+
+	if (max >= 0)
+		absinfo->maximum = max;
+
+	if (fuzz >= 0)
+		absinfo->fuzz = fuzz;
 }
 
 /**
@@ -57,7 +61,7 @@ static void touchscreen_set_params(struct input_dev *dev,
 void touchscreen_parse_of_params(struct input_dev *dev)
 {
 	struct device_node *np = dev->dev.parent->of_node;
-	u32 maximum, fuzz;
+	int maximum, fuzz;
 
 	input_alloc_absinfo(dev);
 	if (!dev->absinfo)
-- >8 --

That reduces the max size of the screens, but I don't really expect the screen
size to reach that order of magnitude before a few years...

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150601/f3f3e427/attachment.sig>
