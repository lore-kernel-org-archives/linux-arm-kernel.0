From: ckeepax@opensource.wolfsonmicro.com (Charles Keepax)
Date: Tue, 26 Nov 2013 13:05:53 +0000
Subject: [PATCH] I2C: BCM2835: Linking platform nodes to adapter nodes
In-Reply-To: <527D1870.8080302@wwwdotorg.org>
References: <527CB3A1.7050808@koalo.de> <527D1870.8080302@wwwdotorg.org>
Message-ID: <20131126130553.GF25130@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 08, 2013 at 09:59:28AM -0700, Stephen Warren wrote:
> On 11/08/2013 02:49 AM, Florian Meier wrote:
> > In order to find I2C devices in the device tree, the platform nodes
> > have to be known by the I2C core. Analogous to the i2c-omap driver
> > this requires setting the dev.of_node parameter of the adapter.
> 
> (CCing the I2C maintainers...)
> 
> > diff --git a/drivers/i2c/busses/i2c-bcm2835.c b/drivers/i2c/busses/i2c-bcm2835.c
> 
> > @@ -299,6 +299,7 @@ static int bcm2835_i2c_probe(struct platform_device *pdev)
> >  	strlcpy(adap->name, "bcm2835 I2C adapter", sizeof(adap->name));
> >  	adap->algo = &bcm2835_i2c_algo;
> >  	adap->dev.parent = &pdev->dev;
> > +	adap->dev.of_node = pdev->dev.of_node;
> 
> Ah, that makes sense. Thinking about it now, I'd only ever used i2cget
> etc. to access I2C devices, rather than instantiating drivers from DT.
> 
> That all said, I wonder if the I2C core shouldn't do something like the
> following inside i2c_add_adapter():
> 
> if (!adap->dev.of_node && adap->dev.parent)
> 	adap->dev.of_node = adap->dev.parent->of_node;

Should this not also have an of_node_get to increment the ref
count on the node?

Thanks,
Charles
