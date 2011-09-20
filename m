From: shawn.guo@freescale.com (Shawn Guo)
Date: Tue, 20 Sep 2011 10:57:01 +0800
Subject: [PATCH 3/4] net/fec: set phy_speed to the optimal frequency 2.5
	MHz
In-Reply-To: <4E77C4A2.1060802@boundarydevices.com>
References: <1316346852-17090-1-git-send-email-shawn.guo@linaro.org>
	<1316346852-17090-4-git-send-email-shawn.guo@linaro.org>
	<4E77C4A2.1060802@boundarydevices.com>
Message-ID: <20110920025700.GE28084@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 19, 2011 at 03:39:30PM -0700, Troy Kisky wrote:
> On 9/18/2011 4:54 AM, Shawn Guo wrote:
> >With the unnecessary 1 bit left-shift on fep->phy_speed during the
> >calculation, the phy_speed always runs at the half frequency of the
> >optimal one 2.5 MHz.
> >
> >The patch removes that 1 bit left-shift to get the optimal phy_speed.
> >
> >Signed-off-by: Shawn Guo<shawn.guo@linaro.org>
> >---
> >  drivers/net/fec.c |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> >
> >diff --git a/drivers/net/fec.c b/drivers/net/fec.c
> >index 5ef0e34..04206e4 100644
> >--- a/drivers/net/fec.c
> >+++ b/drivers/net/fec.c
> >@@ -1007,7 +1007,7 @@ static int fec_enet_mii_init(struct platform_device *pdev)
> >  	/*
> >  	 * Set MII speed to 2.5 MHz (= clk_get_rate() / 2 * phy_speed)
> >  	 */
> >-	fep->phy_speed = DIV_ROUND_UP(clk_get_rate(fep->clk), 5000000)<<  1;
> >+	fep->phy_speed = DIV_ROUND_UP(clk_get_rate(fep->clk), 5000000);
> >  	writel(fep->phy_speed, fep->hwp + FEC_MII_SPEED);
> >
> >  	fep->mii_bus = mdiobus_alloc();
> Do you need to round up to an even value? Is the hardware
> documentation wrong?

The round up is something existed, and the patch does not touch that
part.

> Does this need a quirk? What boards has this been verified to fix?
> 

I tested this on i.mx28, i.mx53 and i.mx6q.  Do you see problem on
your platform?

-- 
Regards,
Shawn
