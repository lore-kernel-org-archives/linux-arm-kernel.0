From: pwalmsley@nvidia.com (Paul Walmsley)
Date: Tue, 26 Nov 2013 16:56:27 -0800
Subject: [PATCH] ARM: davinci: clock: return 0 upon error from clk_round_rate()
Message-ID: <alpine.DEB.2.02.1311261653510.11450@tamien>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


clk_round_rate() should return 0 now upon an error, rather than returning 
a negative error code.  This is because clk_round_rate() is being changed 
to return an unsigned return type rather than a signed type, since some 
clock sources can generate rates higher than (2^31)-1 Hz.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Philip Avinash <avinashphilip@ti.com>
Cc: Sekhar Nori <nsekhar@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
---
Applies on v3.13-rc1.  See also:

http://marc.info/?l=linux-arm-kernel&m=138542591313620&w=2

  arch/arm/mach-davinci/clock.c |    2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-davinci/clock.c b/arch/arm/mach-davinci/clock.c
index dc9a470ff9c5..985e5fd00fb2 100644
--- a/arch/arm/mach-davinci/clock.c
+++ b/arch/arm/mach-davinci/clock.c
@@ -133,7 +133,7 @@ EXPORT_SYMBOL(clk_get_rate);
  long clk_round_rate(struct clk *clk, unsigned long rate)
  {
  	if (clk == NULL || IS_ERR(clk))
-		return -EINVAL;
+		return 0;

  	if (clk->round_rate)
  		return clk->round_rate(clk, rate);
