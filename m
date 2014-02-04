From: william.towle@codethink.co.uk (William Towle)
Date: Tue,  4 Feb 2014 18:17:36 +0000
Subject: [PATCH 1/3] clk: rcar-h2: fix sd0/sd1 divisor table
In-Reply-To: <1391537858-28593-1-git-send-email-william.towle@codethink.co.uk>
References: <1391537858-28593-1-git-send-email-william.towle@codethink.co.uk>
Message-ID: <1391537858-28593-2-git-send-email-william.towle@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The clk_div_table for cpg_sd01_div_table[] concurs with the manual
but not with values found in the device itself (which are also the
same as the ones in arch/arm/mach-shmobile/clock-r8a7790.c).

Update the clk-rcar-gen2.c driver to have the same table as the one
used by the mach-shmobile driver which work once further issues are
fixed in the clk-rcar-gen2.c driver.

Part of the fix for the following error where the driver reports the
output as 1MHz but is really 97.5MHz:
    sh_mobile_sdhi ee100000.sd: mmc0 base at 0xee100000 clock rate 1 MHz

[ben.dooks at codethink.co.uk: updated patch description]
Signed-off-by: William Towle <william.towle@codethink.co.uk>
Reviewed-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 drivers/clk/shmobile/clk-rcar-gen2.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/shmobile/clk-rcar-gen2.c b/drivers/clk/shmobile/clk-rcar-gen2.c
index a59ec21..df4a1e6 100644
--- a/drivers/clk/shmobile/clk-rcar-gen2.c
+++ b/drivers/clk/shmobile/clk-rcar-gen2.c
@@ -170,6 +170,8 @@ static const struct clk_div_table cpg_sdh_div_table[] = {
 };
 
 static const struct clk_div_table cpg_sd01_div_table[] = {
+	{  0,  2 }, {  1,  3 }, {  2,  4 }, {  3,  6 },
+	{  4,  8 },
 	{  5, 12 }, {  6, 16 }, {  7, 18 }, {  8, 24 },
 	{ 10, 36 }, { 11, 48 }, { 12, 10 }, {  0,  0 },
 };
-- 
1.7.10.4
