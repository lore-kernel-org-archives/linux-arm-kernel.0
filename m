From: ben-linux@fluff.org (Ben Dooks)
Date: Sat, 15 May 2010 01:11:03 +0100
Subject: [PATCH] ARM: S5P: Dynamicly numbered GPIO interrupt support
In-Reply-To: <008e01caf345$50ad0610$f2071230$%szyprowski@samsung.com>
References: <1273826403-28976-1-git-send-email-ben-linux@fluff.org>
	<008e01caf345$50ad0610$f2071230$%szyprowski@samsung.com>
Message-ID: <20100515001103.GQ26401@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 14, 2010 at 11:10:19AM +0200, Marek Szyprowski wrote:
> Hello,
> 
> On Friday, May 14, 2010 10:40 AM Ben Dooks wrote:
> 
> > Add support for GPIO interrupts where the interrupt number
> > is dynamically allocated at first request from gpiolib.
> > 
> > This method is employed as the newer SoCs have a large number
> > of possible interrupt numbers which are very rarely heavily
> > used. However, the classic code has always registered all
> > possible interrupts, using a large amount of memory for the
> > irq_desc[] table.
> 
> I like this idea, however I already see some problems. This solves
> only gpio to irq mappings, but what about reverse mappings? There
> are many i2c/spi/whatever drivers that requires a irq number to be
> passed with platform data. With static gpio-irq mappings this is
> trivial. However with dynamic gpio2irq mappings this becomes more
> complicated. 
> 
> Machine startup code would need to:
> 1. request the gpio pin used for interrupt (ok)
> 2. convert it to irq number (ok)
> 3. put it in driver specific platform data (ok)
> 4. release the gpio pin (?)
> 
> Would request_irq() work after release of that gpio pin?

I was actually considering exporting it as both a gpiolib call
and a call which is s5p specific, say s5p_map_gpio_irq() which
odes the neessary chip mampping.

At the moment, we don't release the interrupt range once we get
it as there's no call in gpiolib to reverse to_irq() and even
if you release the irq, it is still possible the driver will
have noted the irq number and then re-request it.
  
> Best regards
> --
> Marek Szyprowski
> Samsung Poland R&D Center
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
