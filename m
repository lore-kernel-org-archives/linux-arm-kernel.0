From: horms@verge.net.au (Simon Horman)
Date: Mon, 18 Mar 2013 21:19:04 +0900
Subject: [PATCH 43/43] ARM: shmobile: fix kzm9g-reference compile breakage
In-Reply-To: <20130318120808.GA24552@verge.net.au>
References: <1363607255-6385-1-git-send-email-horms+renesas@verge.net.au>
 <1363607255-6385-44-git-send-email-horms+renesas@verge.net.au>
 <Pine.LNX.4.64.1303181258080.30957@axis700.grange>
 <20130318120808.GA24552@verge.net.au>
Message-ID: <20130318121904.GD24552@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 18, 2013 at 09:08:12PM +0900, Simon Horman wrote:
> On Mon, Mar 18, 2013 at 12:58:49PM +0100, Guennadi Liakhovetski wrote:
> > Hi Simon
> > 
> > On Mon, 18 Mar 2013, Simon Horman wrote:
> > 
> > > From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> > > 
> > > Recently many pin function names have been removed, as their users have
> > > been switched to use pinctrl. However, kzm9g-reference has been left
> > > unchanged, which broke its compilation. Fix this by switching over to
> > > pinctrl.
> > > 
> > > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> > > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> > 
> > I think, there's a problem with this one. The description doesn't match 
> > the body, this isn't my patch.
> 
> Thanks, I'll investigate.

It seems that the correct patch is:

From: Phil Edworthy <phil.edworthy@renesas.com>

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
[Rename device from to rcarfb to rcar-du]
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/mach-shmobile/clock-r8a7779.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/clock-r8a7779.c b/arch/arm/mach-shmobile/clock-r8a7779.c
index c019609..8cc9bce 100644
--- a/arch/arm/mach-shmobile/clock-r8a7779.c
+++ b/arch/arm/mach-shmobile/clock-r8a7779.c
@@ -87,7 +87,7 @@ static struct clk div4_clks[DIV4_NR] = {
 };
 
 enum { MSTP323, MSTP322, MSTP321, MSTP320,
-	MSTP101, MSTP100,
+	MSTP103, MSTP101, MSTP100,
 	MSTP030,
 	MSTP029, MSTP028, MSTP027, MSTP026, MSTP025, MSTP024, MSTP023, MSTP022, MSTP021,
 	MSTP016, MSTP015, MSTP014,
@@ -99,6 +99,7 @@ static struct clk mstp_clks[MSTP_NR] = {
 	[MSTP322] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR3, 22, 0), /* SDHI1 */
 	[MSTP321] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR3, 21, 0), /* SDHI2 */
 	[MSTP320] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR3, 20, 0), /* SDHI3 */
+	[MSTP103] = SH_CLK_MSTP32(&div4_clks[DIV4_S], MSTPCR1,  3, 0), /* DU */
 	[MSTP101] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR1,  1, 0), /* USB2 */
 	[MSTP100] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR1,  0, 0), /* USB0/1 */
 	[MSTP030] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR0, 30, 0), /* I2C0 */
@@ -179,6 +180,7 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("sh_mobile_sdhi.1", &mstp_clks[MSTP322]), /* SDHI1 */
 	CLKDEV_DEV_ID("sh_mobile_sdhi.2", &mstp_clks[MSTP321]), /* SDHI2 */
 	CLKDEV_DEV_ID("sh_mobile_sdhi.3", &mstp_clks[MSTP320]), /* SDHI3 */
+	CLKDEV_DEV_ID("rcar-du.0", &mstp_clks[MSTP103]), /* DU */
 };
 
 void __init r8a7779_clock_init(void)
-- 
1.7.12.4

--
To unsubscribe from this list: send the line "unsubscribe linux-sh" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
