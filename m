From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 6 Mar 2013 06:31:03 +0000
Subject: [PATCH] ARM: bcm281xx: Add L2 cache enable code
In-Reply-To: <513677BB.9010309@broadcom.com>
References: <1362451632-18806-1-git-send-email-csd@broadcom.com>
 <201303050901.12317.arnd@arndb.de> <513677BB.9010309@broadcom.com>
Message-ID: <201303060631.03782.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 05 March 2013, Christian Daudt wrote:
> On 13-03-05 01:01 AM, Arnd Bergmann wrote:
> > On Tuesday 05 March 2013, Christian Daudt wrote:
> > For other firmware interfaces like this, we tend to list the specific commands
> > that the firmware understands. If you think there might be different versions
> > to consider, you might want to model this like
> >
> > Documentation/devicetree/bindings/arm/psci.txt
> This interface is stable and in shipping products at this time, and so 
> the api will remain constant.

But what about future products? Wouldn't they be able to extend the
current interface in a compatible way?

> >> +static void __init init_irq(void)
> >> +{
> >> +	irqchip_init();
> >> +	bcm_kona_smc_init();
> >> +
> >> +#ifdef CONFIG_CACHE_L2X0
> >> +	kona_l2_cache_init();
> >> +#endif /* CONFIG_CACHE_L2X0 */
> >> +}
> > Why are you calling bcm_kona_smc_init() and kona_l2_cache_init() from init_irq()?
> >
> > It seems completely unrelated to interrupt handling.
> >
> It was originally in init_machine section but I was told that that was 
> too late and init_irq would be better, and I saw that highbank also has 
> it in init_irq. I agree that it is unrelated to irq - is there a better 
> place to put this in ?

IMHO the later the better. Do you know what issues were caused  by having it
in init_machine?

	Arnd
