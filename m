From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 29 Jul 2011 17:55:47 +0100
Subject: [PATCH v2 6/7] i2c: pxa: support i2c controller from DT
In-Reply-To: <20110729165222.GN11164@ponder.secretlab.ca>
References: <1311835293-18125-1-git-send-email-haojian.zhuang@marvell.com>
	<1311835293-18125-2-git-send-email-haojian.zhuang@marvell.com>
	<1311835293-18125-3-git-send-email-haojian.zhuang@marvell.com>
	<1311835293-18125-4-git-send-email-haojian.zhuang@marvell.com>
	<1311835293-18125-5-git-send-email-haojian.zhuang@marvell.com>
	<1311835293-18125-6-git-send-email-haojian.zhuang@marvell.com>
	<1311835293-18125-7-git-send-email-haojian.zhuang@marvell.com>
	<20110729165222.GN11164@ponder.secretlab.ca>
Message-ID: <20110729165547.GB30298@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 29, 2011 at 10:52:22AM -0600, Grant Likely wrote:
> On Thu, Jul 28, 2011 at 02:41:32PM +0800, Haojian Zhuang wrote:
> > -	/*
> > -	 * If "dev->id" is negative we consider it as zero.
> > -	 * The reason to do so is to avoid sysfs names that only make
> > -	 * sense when there are multiple adapters.
> > -	 */
> > -	i2c->adap.nr = dev->id;
> > -	snprintf(i2c->adap.name, sizeof(i2c->adap.name), "pxa_i2c-i2c.%u",
> > -		 i2c->adap.nr);
> >  
> > -	i2c->clk = clk_get(&dev->dev, NULL);
> > +	if (np) {
> > +		i2c->adap.nr = idx++;
> 
> Use this so that a bus number gets dynamically assigned:
> 		i2c->adap.nr = -1;
> 
> > +		snprintf(i2c->adap.name, sizeof(i2c->adap.name),
> > +			"pxa2xx-i2c.%u", i2c->adap.nr);
> > +		i2c->clk = clk_get_sys(i2c->adap.name, NULL);
> 
> Missing i2c->adap.dev.of_node = dev->dev.of_node;

And here we go again.  Is it really the case that this DT stuff doesn't
have stable device names?
