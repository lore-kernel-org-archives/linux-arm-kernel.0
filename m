From: viresh.linux@gmail.com (viresh kumar)
Date: Thu, 29 Mar 2012 22:04:15 +0530
Subject: [RFC] pinctrl: Replace list_groups() with get_groups_count()
Message-ID: <CAOh2x==LTHPM+O9LXVFVdX2NfzKs2bttiYLm8VcL6qLXKrUMBg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Most of the SoC drivers implement list_*() routines for pinctrl, pinmux,
pinconf, etc, And these routines continue returning zero until the second
argument is greater than total count of available groups, function, etc.

I will take struct pinctrl_ops as an example to elaborate my concern/doubts.

There are few concerns here:
- list_groups() is called multiple times. If the purpose of this routine is to
  only check the number of groups available, then why not remove it and create
  another routine which returns number of total groups. Over which, we can run a
  simple loop.
- All client drivers have checks in their ops routines to check the range of
  groups, which is just not required if we pass the correct number to pinctrl
  framework. Because these ops are going to be called via pinctrl, and we can
  trust on it and place these range checkers there only to make SoC drivers
  simple.

I just wanted to have different views about my concerns/idea before i start
coding. If this idea looks fine, i would do this change across pinmux framework.

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 include/linux/pinctrl/pinctrl.h |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/include/linux/pinctrl/pinctrl.h b/include/linux/pinctrl/pinctrl.h
index 4e9f078..740fb99 100644
--- a/include/linux/pinctrl/pinctrl.h
+++ b/include/linux/pinctrl/pinctrl.h
@@ -64,9 +64,7 @@ struct pinctrl_gpio_range {
 /**
  * struct pinctrl_ops - global pin control operations, to be implemented by
  * pin controller drivers.
- * @list_groups: list the number of selectable named groups available
- *	in this pinmux driver, the core will begin on 0 and call this
- *	repeatedly as long as it returns >= 0 to enumerate the groups
+ * @get_group_count: Returns the count of total number of groups registered.
  * @get_group_name: return the group name of the pin group
  * @get_group_pins: return an array of pins corresponding to a certain
  *	group selector @pins, and the size of the array in @num_pins
@@ -74,7 +72,7 @@ struct pinctrl_gpio_range {
  *	info for a certain pin in debugfs
  */
 struct pinctrl_ops {
-	int (*list_groups) (struct pinctrl_dev *pctldev, unsigned selector);
+	int (*get_group_count) (struct pinctrl_dev *pctldev);
 	const char *(*get_group_name) (struct pinctrl_dev *pctldev,
 				       unsigned selector);
 	int (*get_group_pins) (struct pinctrl_dev *pctldev,
-- 
1.7.9
