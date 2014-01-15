From: kamal@canonical.com (Kamal Mostafa)
Date: Wed, 15 Jan 2014 09:45:25 -0800
Subject: [3.8.y.z extended stable] Patch "clk: clk-divider: fix divisor > 255
 bug" has been added to staging queue
Message-ID: <1389807925-12305-1-git-send-email-kamal@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a note to let you know that I have just added a patch titled

    clk: clk-divider: fix divisor > 255 bug

to the linux-3.8.y-queue branch of the 3.8.y.z extended stable tree 
which can be found at:

 http://kernel.ubuntu.com/git?p=ubuntu/linux.git;a=shortlog;h=refs/heads/linux-3.8.y-queue

This patch is scheduled to be released in version 3.8.13.16.

If you, or anyone else, feels it should not be added to this tree, please 
reply to this email.

For more information about the 3.8.y.z tree, see
https://wiki.ubuntu.com/Kernel/Dev/ExtendedStable

Thanks.
-Kamal

------

>From 3af84c1bd5418bf66ab5879718b66806d0fe8e41 Mon Sep 17 00:00:00 2001
From: James Hogan <james.hogan@imgtec.com>
Date: Mon, 16 Dec 2013 10:41:38 +0000
Subject: clk: clk-divider: fix divisor > 255 bug

commit 778037e1ccb75609846deca9e419449c1dc137fa upstream.

Commit 6d9252bd9a4bb (clk: Add support for power of two type dividers)
merged in v3.6 added the _get_val function to convert a divisor value to
a register field value depending on the flags. However it used the type
u8 for the div field, causing divisors larger than 255 to be masked
and the resultant clock rate to be too high.

E.g. in my case an 11bit divider was supposed to divide 24.576 MHz down
to 32.768KHz. The divisor was correctly calculated as 750 (0x2ee). This
was masked to 238 (0xee) resulting in a frequency of 103.26KHz.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Rajendra Nayak <rnayak@ti.com>
Cc: linux-arm-kernel at lists.infradead.org
Signed-off-by: Mike Turquette <mturquette@linaro.org>
Signed-off-by: Kamal Mostafa <kamal@canonical.com>
---
 drivers/clk/clk-divider.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/clk-divider.c b/drivers/clk/clk-divider.c
index a9204c6..f253ce1 100644
--- a/drivers/clk/clk-divider.c
+++ b/drivers/clk/clk-divider.c
@@ -87,7 +87,7 @@ static unsigned int _get_table_val(const struct clk_div_table *table,
 	return 0;
 }

-static unsigned int _get_val(struct clk_divider *divider, u8 div)
+static unsigned int _get_val(struct clk_divider *divider, unsigned int div)
 {
 	if (divider->flags & CLK_DIVIDER_ONE_BASED)
 		return div;
--
1.8.3.2
