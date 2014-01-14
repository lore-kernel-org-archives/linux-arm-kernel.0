From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Mon, 13 Jan 2014 16:28:19 -0800
Subject: [PATCH 3.12 58/77] clk: clk-divider: fix divisor > 255 bug
In-Reply-To: <20140114002752.497010554@linuxfoundation.org>
References: <20140114002752.497010554@linuxfoundation.org>
Message-ID: <20140114002754.147369432@linuxfoundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

3.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: James Hogan <james.hogan@imgtec.com>

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/clk/clk-divider.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/clk/clk-divider.c
+++ b/drivers/clk/clk-divider.c
@@ -87,7 +87,7 @@ static unsigned int _get_table_val(const
 	return 0;
 }
 
-static unsigned int _get_val(struct clk_divider *divider, u8 div)
+static unsigned int _get_val(struct clk_divider *divider, unsigned int div)
 {
 	if (divider->flags & CLK_DIVIDER_ONE_BASED)
 		return div;
