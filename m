From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 4 Jan 2016 15:20:58 +0000
Subject: [PATCH] ASoC: cs35l32: avoid uninitialized variable access
In-Reply-To: <9222694.IRNnfpj6Tn@wuerfel>
References: <2884997.s8B8BuE04L@wuerfel> <20160102141746.GH16023@sirena.org.uk>
 <9222694.IRNnfpj6Tn@wuerfel>
Message-ID: <20160104152058.GH19062@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 04, 2016 at 04:17:47PM +0100, Arnd Bergmann wrote:
> On Saturday 02 January 2016 14:17:46 Mark Brown wrote:
> > On Sat, Jan 02, 2016 at 12:19:52AM +0100, Arnd Bergmann wrote:
> > 
> > > -             if (i2c_client->dev.of_node) {
> > > +             if (IS_ENABLED(CONFIG_OF) && i2c_client->dev.of_node) {
> > 
> > This would be a lot nicer if there was an __always_null annotation we
> > could put on of_node for !OF configurations, that'd Just Work and this
> > can't be the only case where we have this idiom.
> > 
> 
> How about an inline helper like
> 
> static inline struct device_node *dev_of_node(struct device *dev)
> {
> 	if (IS_ENABLED(CONFIG_OF))
> 		return dev->of_node;	

ITYM:

	return IS_ENABLED(CONFIG_OF) ? dev->of_node : NULL;

or

	if (IS_ENABLED(CONFIG_OF))
		return dev->of_node;
	else
		return NULL;

> }
> 
> 	Arnd
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
