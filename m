From: pwalmsley@nvidia.com (Paul Walmsley)
Date: Tue, 26 Nov 2013 17:02:13 -0800
Subject: [PATCH] ARM: versatile: clock: return 0 upon error from
 clk_round_rate()
Message-ID: <alpine.DEB.2.02.1311261700560.11450@tamien>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


clk_round_rate() should return 0 upon an error, rather than returning a 
negative error code.  This is because clk_round_rate() is being changed to 
return an unsigned return type rather than a signed type, since some clock 
sources can generate rates higher than (2^31)-1 Hz.

Signed-off-by: Paul Walmsley <pwalmsley@nvidia.com>
Cc: Russell King <linux@arm.linux.org.uk>
---

Applies on v3.13-rc1.  See also:

http://marc.info/?l=linux-arm-kernel&m=138542591313620&w=2

  arch/arm/plat-versatile/clock.c |    2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/plat-versatile/clock.c b/arch/arm/plat-versatile/clock.c
index 5c8b6564fdc2..14730a8a2c8d 100644
--- a/arch/arm/plat-versatile/clock.c
+++ b/arch/arm/plat-versatile/clock.c
@@ -37,7 +37,7 @@ EXPORT_SYMBOL(clk_get_rate);

  long clk_round_rate(struct clk *clk, unsigned long rate)
  {
-	long ret = -EIO;
+	long ret = 0;
  	if (clk->ops && clk->ops->round)
  		ret = clk->ops->round(clk, rate);
  	return ret;
