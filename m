From: mturquette@linaro.org (Mike Turquette)
Date: Fri, 15 Feb 2013 12:11:21 -0800
Subject: randconfig errors
In-Reply-To: <201302151800.36948.arnd@arndb.de>
References: <511E6FA4.2000709@gmail.com> <201302151800.36948.arnd@arndb.de>
Message-ID: <20130215201121.11471.66349@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Arnd Bergmann (2013-02-15 10:00:36)
> On Friday 15 February 2013, Rob Herring wrote:
> > /var/lib/jenkins/jobs/linux-randconfig/workspace/drivers/clk/clk-vt8500.c:160:24: error: 'prate' undeclared (first use in this function)
> 
> I've seen this one with allyesconfig but have not tried to make a fix

Looks like this one was introduced by 7248001, "clk: vt8500: Fix device
clock divisor calculations".

Looks like a copy/paste error where prate was used instead of
parent_rate.

Tony can you test the below patch?

Regards,
Mike


>From efb8dbe114579b4f459b3810e83d79b11593436a Mon Sep 17 00:00:00 2001
From: Mike Turquette <mturquette@linaro.org>
Date: Fri, 15 Feb 2013 12:03:51 -0800
Subject: [PATCH] clk: vt8500: copy-paste mistake in dclk_set_rate

Commit 7248001, "clk: vt8500: Fix device clock divisor calculations"
introduced logic to improve divider selection while changing rates for
the VT8500 dclk.  However a copy-paste error results in using the wrong
variable name in the .set_rate callback.  Fixed by changing *prate to
parent_rate.  The .round_rate function is correct and remains unchanged.

Signed-off-by: Mike Turquette <mturquette@linaro.org>
Cc: Tony Prisk <linux@prisktech.co.nz>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Rob Herring <robherring2@gmail.com>
---
 drivers/clk/clk-vt8500.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/clk-vt8500.c b/drivers/clk/clk-vt8500.c
index b5538bb..c010861 100644
--- a/drivers/clk/clk-vt8500.c
+++ b/drivers/clk/clk-vt8500.c
@@ -156,8 +156,8 @@ static int vt8500_dclk_set_rate(struct clk_hw *hw, unsigned long rate,
 
 	divisor =  parent_rate / rate;
 
-	/* If prate / rate would be decimal, incr the divisor */
-	if (rate * divisor < *prate)
+	/* If parent_rate / rate would be decimal, incr the divisor */
+	if (rate * divisor < parent_rate)
 		divisor++;
 
 	if (divisor == cdev->div_mask + 1)
-- 
1.7.10.4
