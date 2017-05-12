From: tony@atomide.com (Tony Lindgren)
Date: Fri, 12 May 2017 10:14:17 -0700
Subject: [PATCH] pinctrl: use non-devm kmalloc versions for free functions
In-Reply-To: <20170512153522.GG3489@atomide.com>
References: <1493855857-4453-1-git-send-email-andre.przywara@arm.com>
 <CACRpkdasvjBPcr5RrPwtTYaoGeTEJMWqXbSRaB5-cOEKXbpfRg@mail.gmail.com>
 <f529e2d1-68e0-2760-3fd0-c7b0e94dd003@arm.com>
 <CACRpkdZhUnu09CcRwkLS9Qf83OLiKkTVCQxZY0tsJmBHNAirVw@mail.gmail.com>
 <20170512153522.GG3489@atomide.com>
Message-ID: <20170512171417.GH3489@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren <tony@atomide.com> [170512 08:39]:
> * Linus Walleij <linus.walleij@linaro.org> [170512 02:28]:
> > On Thu, May 11, 2017 at 4:20 PM, Andre Przywara <andre.przywara@arm.com> wrote:
> > > Linus, can you shed some light if this array creation serves some purpose?
> > 
> > Tony [author of this function] can you look at this?
> > 
> > The code in pinctrl_generic_free_groups() does look a bit weird,
> > allocating these indices just to remove the radix tree.
> > Do you think we can clean it up?
> 
> Yup indeed it seems totally pointless. Also the same code can be
> removed from pinmux_generic_free_functions().
> 
> It must be left over code from my initial attempts to to add
> generic pinctrl groups and functions when I still though we need
> to keep a static array around for the indices to keep pinctrl
> happy. Then I probably did some robotic compile fixes after
> updating things to use just the radix tree and added indices
> locally to both functions..

Hmm no that, can't be, I think I figured it out.. See the patch
below.

Regards,

Tony

8< ---------------------------
>From tony Mon Sep 17 00:00:00 2001
From: Tony Lindgren <tony@atomide.com>
Date: Fri, 12 May 2017 08:47:57 -0700
Subject: [PATCH] pinctrl: core: Fix warning by removing bogus code

Andre Przywara <andre.przywara@arm.com> noticed that we can get the
following warning with -EPROBE_DEFER:

"WARNING: CPU: 1 PID: 89 at drivers/base/dd.c:349
driver_probe_device+0x2ac/0x2e8"

Let's fix the issue by removing the indices as suggested by
Tejun Heo <tj@kernel.org>. All we have to do here is kill the radix
tree.

I probably ended up with the indices after grepping for removal
of all entries using radix_tree_for_each_slot() and the first
match found was gmap_radix_tree_free(). Anyways, no need for
indices here, and we can just do remove all the entries using
radix_tree_for_each_slot() along how the item_kill_tree() test
case does.

Fixes: c7059c5ac70a ("pinctrl: core: Add generic pinctrl functions
for managing groups")
Fixes: a76edc89b100 ("pinctrl: core: Add generic pinctrl functions
for managing groups")
Reported-by: Andre Przywara <andre.przywara@arm.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/pinctrl/core.c   | 20 +++-----------------
 drivers/pinctrl/pinmux.c | 21 ++++-----------------
 2 files changed, 7 insertions(+), 34 deletions(-)

diff --git a/drivers/pinctrl/core.c b/drivers/pinctrl/core.c
--- a/drivers/pinctrl/core.c
+++ b/drivers/pinctrl/core.c
@@ -680,30 +680,16 @@ EXPORT_SYMBOL_GPL(pinctrl_generic_remove_group);
  * pinctrl_generic_free_groups() - removes all pin groups
  * @pctldev: pin controller device
  *
- * Note that the caller must take care of locking.
+ * Note that the caller must take care of locking. The pinctrl groups
+ * are allocated with devm_kzalloc() so no need to free them here.
  */
 static void pinctrl_generic_free_groups(struct pinctrl_dev *pctldev)
 {
 	struct radix_tree_iter iter;
-	struct group_desc *group;
-	unsigned long *indices;
 	void **slot;
-	int i = 0;
-
-	indices = devm_kzalloc(pctldev->dev, sizeof(*indices) *
-			       pctldev->num_groups, GFP_KERNEL);
-	if (!indices)
-		return;
 
 	radix_tree_for_each_slot(slot, &pctldev->pin_group_tree, &iter, 0)
-		indices[i++] = iter.index;
-
-	for (i = 0; i < pctldev->num_groups; i++) {
-		group = radix_tree_lookup(&pctldev->pin_group_tree,
-					  indices[i]);
-		radix_tree_delete(&pctldev->pin_group_tree, indices[i]);
-		devm_kfree(pctldev->dev, group);
-	}
+		radix_tree_delete(&pctldev->pin_group_tree, iter.index);
 
 	pctldev->num_groups = 0;
 }
diff --git a/drivers/pinctrl/pinmux.c b/drivers/pinctrl/pinmux.c
--- a/drivers/pinctrl/pinmux.c
+++ b/drivers/pinctrl/pinmux.c
@@ -826,30 +826,17 @@ EXPORT_SYMBOL_GPL(pinmux_generic_remove_function);
  * pinmux_generic_free_functions() - removes all functions
  * @pctldev: pin controller device
  *
- * Note that the caller must take care of locking.
+ * Note that the caller must take care of locking. The pinctrl
+ * functions are allocated with devm_kzalloc() so no need to free
+ * them here.
  */
 void pinmux_generic_free_functions(struct pinctrl_dev *pctldev)
 {
 	struct radix_tree_iter iter;
-	struct function_desc *function;
-	unsigned long *indices;
 	void **slot;
-	int i = 0;
-
-	indices = devm_kzalloc(pctldev->dev, sizeof(*indices) *
-			       pctldev->num_functions, GFP_KERNEL);
-	if (!indices)
-		return;
 
 	radix_tree_for_each_slot(slot, &pctldev->pin_function_tree, &iter, 0)
-		indices[i++] = iter.index;
-
-	for (i = 0; i < pctldev->num_functions; i++) {
-		function = radix_tree_lookup(&pctldev->pin_function_tree,
-					     indices[i]);
-		radix_tree_delete(&pctldev->pin_function_tree, indices[i]);
-		devm_kfree(pctldev->dev, function);
-	}
+		radix_tree_delete(&pctldev->pin_function_tree, iter.index);
 
 	pctldev->num_functions = 0;
 }
-- 
2.13.0
