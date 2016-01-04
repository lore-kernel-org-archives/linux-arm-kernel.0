From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 04 Jan 2016 16:17:47 +0100
Subject: [PATCH] ASoC: cs35l32: avoid uninitialized variable access
In-Reply-To: <20160102141746.GH16023@sirena.org.uk>
References: <2884997.s8B8BuE04L@wuerfel> <20160102141746.GH16023@sirena.org.uk>
Message-ID: <9222694.IRNnfpj6Tn@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 02 January 2016 14:17:46 Mark Brown wrote:
> On Sat, Jan 02, 2016 at 12:19:52AM +0100, Arnd Bergmann wrote:
> 
> > -             if (i2c_client->dev.of_node) {
> > +             if (IS_ENABLED(CONFIG_OF) && i2c_client->dev.of_node) {
> 
> This would be a lot nicer if there was an __always_null annotation we
> could put on of_node for !OF configurations, that'd Just Work and this
> can't be the only case where we have this idiom.
> 

How about an inline helper like

static inline struct device_node *dev_of_node(struct device *dev)
{
	if (IS_ENABLED(CONFIG_OF))
		return dev->of_node;	
}

	Arnd
