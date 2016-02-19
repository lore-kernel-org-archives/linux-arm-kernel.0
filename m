From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 19 Feb 2016 09:39:59 +0000
Subject: [PATCH] clk: fix clk-gpio.c with optional clock= DT property
In-Reply-To: <20160219030731.GS4847@codeaurora.org>
References: <E1aFJ0A-00086Z-0I@rmk-PC.arm.linux.org.uk>
 <20160217230529.GM19428@n2100.arm.linux.org.uk>
 <20160218000747.2278.46405@quark.deferred.io>
 <20160218005503.GO19428@n2100.arm.linux.org.uk>
 <20160219030731.GS4847@codeaurora.org>
Message-ID: <20160219093959.GV19428@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 18, 2016 at 07:07:31PM -0800, Stephen Boyd wrote:
> On 02/18, Russell King - ARM Linux wrote:
> > This is even explained in the very first sentence of my commit
> > log:
> > 
> > | When the clock DT property is not given, of_clk_get_parent_count()
> >                                            ^^^^^^^^^^^^^^^^^^^^^^^^^
> > | returns -ENOENT, which then tries to allocate -2 x 4 bytes of memory,
> >   ^^^^^^^^^^^^^^^
> > 
> > -ENOENT is a negative number.  Now look at the patch which totally
> > rejects the clock if of_clk_get_parent_count() returns any negative
> > number...
> > 
> > I assume, therefore, that you did not *even* read my commit log...
> > 
> 
> Ok. So the simplest fix is to just do this? I'll write up some
> commit text and get this into the rc.

I'm sorry, I've had enough of this crappy maintainer behaviour over
this issue.  There's a simple solution:

(a) making a patch which undoes the broken commit and gives the result
    from my _tested_ patch which is _known_ to work, rather than coming
    up with yet another potentially broken solution.

(b) someone apologising for modifying a patch without mentioning in the
    commit log that it was modified, where the modification makes the
    patch no longer match the commit log, and effectively making the
    patch totally useless.

(a) is easy:

diff --git a/drivers/clk/clk-gpio.c b/drivers/clk/clk-gpio.c
index 19fed65587e8..05cca9298f44 100644
--- a/drivers/clk/clk-gpio.c
+++ b/drivers/clk/clk-gpio.c
@@ -287,15 +287,12 @@ static void __init of_gpio_clk_setup(struct device_node *node,
 	const char **parent_names;
 	int i, num_parents;
 
-	num_parents = of_clk_get_parent_count(node);
-	if (num_parents < 0)
-		return;
-
 	data = kzalloc(sizeof(*data), GFP_KERNEL);
 	if (!data)
 		return;
 
-	if (num_parents) {
+	num_parents = of_clk_get_parent_count(node);
+	if (num_parents > 0) {
 		parent_names = kcalloc(num_parents, sizeof(char *), GFP_KERNEL);
 		if (!parent_names) {
 			kfree(data);

Apply that with an apology and I'll be happy.  Do something else and
I'm not going to be happy, because it means more work for me.  And yes,
yet again, I've tested the above solution, and it works.  Of course it
works, it's my original solution, which was tested at the time.

The moral here is: do _not_ modify other peoples tested patches, or
if you do either _test_ them yourself or ask for them to be tested
before committing.  And if you modify a patch, _say so_ in the
commit text.

And yes, in this case, it's _easy_ for you to test.  You don't need
hardware other than a free gpio pin to come up with a DT fragment
to insert in a test platforms DT.

There is *no* excuse for this mess.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
