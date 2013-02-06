From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 6 Feb 2013 07:20:55 +0100
Subject: [PATCH v5 1/3] cpufreq: kirkwood: Add a cpufreq driver for
 Marvell Kirkwood SoCs
In-Reply-To: <20130206034427.GE16787@S2101-09.ap.freescale.net>
References: <1360094115-14999-1-git-send-email-andrew@lunn.ch>
 <1360094115-14999-2-git-send-email-andrew@lunn.ch>
 <20130206034427.GE16787@S2101-09.ap.freescale.net>
Message-ID: <20130206062055.GD20212@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 06, 2013 at 11:44:31AM +0800, Shawn Guo wrote:
> On Tue, Feb 05, 2013 at 08:55:13PM +0100, Andrew Lunn wrote:
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/clk.h>
> > +#include <linux/clk-provider.h>
> 
> Again, why do you need this header?  It's supposed to only be included
> by clock drivers who provide clocks.

I already answered this a few times....

http://permalink.gmane.org/gmane.linux.kernel.cpufreq/9008
http://permalink.gmane.org/gmane.linux.kernel.cpufreq/9011

> > +static int kirkwood_cpufreq_probe(struct platform_device *pdev)
> > +{
> > +	struct device_node *np;
> > +	struct resource *res;
> > +	int err;
> > +
> > +	priv.dev = &pdev->dev;
> > +
> > +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +	if (!res) {
> > +		dev_err(&pdev->dev, "Cannot get memory resource\n");
> > +		return -ENODEV;
> > +	}
> > +	priv.base = devm_request_and_ioremap(&pdev->dev, res);
> > +	if (!priv.base) {
> > +		dev_err(&pdev->dev, "Cannot ioremap\n");
> > +		return -EADDRNOTAVAIL;
> > +	}
> > +
> > +	np = of_find_node_by_path("/cpus/cpu at 0");
> > +	if (!np)
> > +		return -ENODEV;
> 
> 	pdev->dev.of_node = np;
> 
> > +
> > +	priv.cpu_clk = of_clk_get_by_name(np, "cpu_clk");
> 
> Then, devm_clk_get(pdev->dev, "cpu_clk") should just work for you.
> You are really hating to use devm_clk_get()?

What i don't like is it gives the idea the driver is using its own DT
node. Its not, the driver does not have a node in the tree, it is
using some other node from within the tree. What assumptions are made
about pdev->dev.of_node? e.g. of_find_device_by_node() would now
return this driver if somebody was to lookup the cpu at 0 node. You could
imaging in the future a thermal driver using this node, a voltage
scaling driver, etc.

What other uses are there of dev.of_node and do they make sense when
it points to some random node in the tree?

   Andrew
