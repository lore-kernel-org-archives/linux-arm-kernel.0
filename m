From: sboyd@kernel.org (Stephen Boyd)
Date: Tue, 28 Aug 2018 20:08:38 -0700
Subject: [PATCH V3 0/4] clk: new APIs to handle all available clocks
In-Reply-To: <AM0PR04MB4211368561A415B255782CBE803D0@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1527244643-10736-1-git-send-email-aisheng.dong@nxp.com>
 <AM0PR04MB421114F8AFAE56B6D7C2D1E480770@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <AM0PR04MB4211368561A415B255782CBE803D0@AM0PR04MB4211.eurprd04.prod.outlook.com>
Message-ID: <153551211897.129321.14630649454821319736@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting A.s. Dong (2018-08-16 19:33:52)
> Hi Stephen,
> 
> Do you want me to resend this series for review?
> It seems have been pending for quite a long time.
> 
> Thor just pinged me for its status as he wants to use it.
> 

I was waiting for someone to try them out or review them. Good that it
happened!

I've taken a look at the patches and I'm slightly annoyed with the API
that passes in a double pointer to clk_bulk_data and returns a count of
the number of clks found. I guess it's ok though. It's really just this
line:

	devres->clks = *clks;

which makes my brain all confused and go think about what's being
assigned and if it's a struct copy or not.

Maybe this on top would make it easier to take? I'll think about it
tonight.

---8<---
diff --git a/drivers/clk/clk-devres.c b/drivers/clk/clk-devres.c
index 6d3ca5ec5de8..12c87457eca1 100644
--- a/drivers/clk/clk-devres.c
+++ b/drivers/clk/clk-devres.c
@@ -81,9 +81,9 @@ int __must_check devm_clk_bulk_get_all(struct device *dev,
 	if (!devres)
 		return -ENOMEM;
 
-	ret = clk_bulk_get_all(dev, clks);
+	ret = clk_bulk_get_all(dev, &devres->clks);
 	if (ret > 0) {
-		devres->clks = *clks;
+		*clks = devres->clks;
 		devres->num_clks = ret;
 		devres_add(dev, devres);
 	} else {
