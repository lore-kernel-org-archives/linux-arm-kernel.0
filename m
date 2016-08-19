From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Fri, 19 Aug 2016 08:53:21 +0100
Subject: [PATCH] amba: Support clk parents and rates assigned in DT
In-Reply-To: <453b7ea6-b6c9-ae42-6ac5-81faa1eb2b5d@linaro.org>
References: <20160711210852.31553-1-sboyd@codeaurora.org>
 <453b7ea6-b6c9-ae42-6ac5-81faa1eb2b5d@linaro.org>
Message-ID: <20160819075321.GH1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 19, 2016 at 08:52:35AM +0200, Jorge Ramirez wrote:
> On 07/11/2016 11:08 PM, Stephen Boyd wrote:
> >Add the call to of_clk_set_defaults() into the amba probe path so
> >that devices on the amba bus can use the assigned rates and
> >parents feature of the common clock framework.
> >
> >Cc: Michael Turquette <mturquette@baylibre.com>
> >Cc: Jorge Ramirez Ortiz <jorge.ramirez-ortiz@linaro.org>
> >Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> >---
> >  drivers/amba/bus.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> >diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
> >index a5b5c87e2114..a56fa2a1e9aa 100644
> >--- a/drivers/amba/bus.c
> >+++ b/drivers/amba/bus.c
> >@@ -19,6 +19,7 @@
> >  #include <linux/amba/bus.h>
> >  #include <linux/sizes.h>
> >  #include <linux/limits.h>
> >+#include <linux/clk/clk-conf.h>
> >  #include <asm/irq.h>
> >@@ -237,6 +238,10 @@ static int amba_probe(struct device *dev)
> >  	int ret;
> >  	do {
> >+		ret = of_clk_set_defaults(dev->of_node, false);
> >+		if (ret < 0)
> >+			break;
> >+
> >  		ret = dev_pm_domain_attach(dev, true);
> >  		if (ret == -EPROBE_DEFER)
> >  			break;
> 
> Stephen/Russell,
> 
> what is the status of this patch? has it been merged?

I assume by that comment that you don't follow linux-next.  Please
follow and test linux-next, so you can check for any regressions
that may occur for your platforms in the next merge window, thanks.

You'll find the above patch in linux-next already.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
