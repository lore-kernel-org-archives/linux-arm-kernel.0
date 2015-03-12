From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 11 Mar 2015 17:35:42 -0700
Subject: [PATCH] clk: provide clk_is_match() dummy for non-common clk
In-Reply-To: <20150311122905.GY8656@n2100.arm.linux.org.uk>
References: <1424876018-17852-1-git-send-email-shawn.guo@linaro.org>
 <1424876018-17852-2-git-send-email-shawn.guo@linaro.org>
 <20150225172757.421.43718@quantum> <8682755.oK0Ae34OOP@wuerfel>
 <20150311102208.GX8656@n2100.arm.linux.org.uk>
 <20150311111755.GI952@pengutronix.de>
 <20150311122905.GY8656@n2100.arm.linux.org.uk>
Message-ID: <5500DF5E.7010404@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/11/15 05:29, Russell King - ARM Linux wrote:
> On Wed, Mar 11, 2015 at 12:17:55PM +0100, Uwe Kleine-K?nig wrote:
>> Hey Russell,
>>
>> On Wed, Mar 11, 2015 at 10:22:09AM +0000, Russell King - ARM Linux wrote:
>>> On Sun, Mar 08, 2015 at 10:05:29PM +0100, Arnd Bergmann wrote:
>>>> ARM randconfig build tests found a new error for configurations
>>>> with COMMON_CLK disabled but HAS_CLK selected by the platform:
>>>>
>>>> ERROR: "clk_is_match" [sound/soc/fsl/snd-soc-fsl-spdif.ko] undefined!
>>>>
>>>> This moves the declaration around, so this case is covered
>>>> by the existing static inline helper function.
>>>>
>>>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>>>> Fixes: c69e182e51d89 ("clk: introduce clk_is_match")
>>>> ----
>>>> BTW, we have a preexisting problem in clk_get_parent,
>>>> clk_round_rate and clk_set_parent, which I've worked around in
>>>> my randconfig builds so far. Should we do that the same way?
>>> NAK, as Uwe points out, you didn't address my comment.
>> You commented on the patch that is c69e182e51d8 ("clk: introduce
>> clk_is_match") now in next. Arnd just moved this around.
> *Sigh*
>
> Mike - please remove this commit until proper kernel patch process is
> honoured.  We'll have some order here, and mutual respect of fellow
> kernel developers, rather than people selectively ignoring people.
> Yes, I realise that it fixes a bug, but it's utterly disgusting that
> comments on a patch are ignored and it's just picked up irrespective
> of comments being addressed.
>
> If you don't like that, bloody well do a better job.
>

The patch was *not* picked up after your mail was sent. The patch was
picked up the same day it was posted to the list (Feb 25). You sent
review comments a week later (March 4). I don't see any selective
ignoring here.

I'll fold the const comments from Geert, your comments, and Arnd's fix
into the patch. Here's the new patch:

----8<----

From: Michael Turquette <mturquette@linaro.org>
Subject: [PATCH] clk: introduce clk_is_match

Some drivers compare struct clk pointers as a means of knowing
if the two pointers reference the same clock hardware. This behavior is
dubious (drivers must not dereference struct clk), but did not cause any
regressions until the per-user struct clk patch was merged. Now the test
for matching clk's will always fail with per-user struct clk's.

clk_is_match is introduced to fix the regression and prevent drivers
from comparing the pointers manually.

Fixes: 035a61c314eb ("clk: Make clk API return per-user struct clk instances")
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Signed-off-by: Michael Turquette <mturquette@linaro.org>
[arnd at arndb.de: Fix COMMON_CLK=N && HAS_CLK=Y config]
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
[sboyd at codeaurora.org: const arguments to clk_is_match() and
remove unnecessary ternary operation]
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/clk/clk.c   | 26 ++++++++++++++++++++++++++
 include/linux/clk.h | 18 ++++++++++++++++++
 2 files changed, 44 insertions(+)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index b9f85fc2ce3f..237f23f68bfc 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -2170,6 +2170,32 @@ int clk_get_phase(struct clk *clk)
 }
 
 /**
+ * clk_is_match - check if two clk's point to the same hardware clock
+ * @p: clk compared against q
+ * @q: clk compared against p
+ *
+ * Returns true if the two struct clk pointers both point to the same hardware
+ * clock node. Put differently, returns true if struct clk *p and struct clk *q
+ * share the same struct clk_core object.
+ *
+ * Returns false otherwise. Note that two NULL clks are treated as matching.
+ */
+bool clk_is_match(const struct clk *p, const struct clk *q)
+{
+	/* trivial case: identical struct clk's or both NULL */
+	if (p == q)
+		return true;
+
+	/* true if clk->core pointers match. Avoid derefing garbage */
+	if (!IS_ERR_OR_NULL(p) && !IS_ERR_OR_NULL(q))
+		if (p->core == q->core)
+			return true;
+
+	return false;
+}
+EXPORT_SYMBOL_GPL(clk_is_match);
+
+/**
  * __clk_init - initialize the data structures in a struct clk
  * @dev:	device initializing this clk, placeholder for now
  * @clk:	clk being initialized
diff --git a/include/linux/clk.h b/include/linux/clk.h
index 8381bbfbc308..68c16a6bedb3 100644
--- a/include/linux/clk.h
+++ b/include/linux/clk.h
@@ -125,6 +125,19 @@ int clk_set_phase(struct clk *clk, int degrees);
  */
 int clk_get_phase(struct clk *clk);
 
+/**
+ * clk_is_match - check if two clk's point to the same hardware clock
+ * @p: clk compared against q
+ * @q: clk compared against p
+ *
+ * Returns true if the two struct clk pointers both point to the same hardware
+ * clock node. Put differently, returns true if struct clk *p and struct clk *q
+ * share the same struct clk_core object.
+ *
+ * Returns false otherwise. Note that two NULL clks are treated as matching.
+ */
+bool clk_is_match(const struct clk *p, const struct clk *q);
+
 #else
 
 static inline long clk_get_accuracy(struct clk *clk)
@@ -142,6 +155,11 @@ static inline long clk_get_phase(struct clk *clk)
 	return -ENOTSUPP;
 }
 
+static inline bool clk_is_match(const struct clk *p, const struct clk *q)
+{
+	return p == q;
+}
+
 #endif
 
 /**

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
