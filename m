From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Fri, 14 May 2010 11:10:19 +0200
Subject: [PATCH] ARM: S5P: Dynamicly numbered GPIO interrupt support
In-Reply-To: <1273826403-28976-1-git-send-email-ben-linux@fluff.org>
References: <1273826403-28976-1-git-send-email-ben-linux@fluff.org>
Message-ID: <008e01caf345$50ad0610$f2071230$%szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Friday, May 14, 2010 10:40 AM Ben Dooks wrote:

> Add support for GPIO interrupts where the interrupt number
> is dynamically allocated at first request from gpiolib.
> 
> This method is employed as the newer SoCs have a large number
> of possible interrupt numbers which are very rarely heavily
> used. However, the classic code has always registered all
> possible interrupts, using a large amount of memory for the
> irq_desc[] table.

I like this idea, however I already see some problems. This solves
only gpio to irq mappings, but what about reverse mappings? There
are many i2c/spi/whatever drivers that requires a irq number to be
passed with platform data. With static gpio-irq mappings this is
trivial. However with dynamic gpio2irq mappings this becomes more
complicated. 

Machine startup code would need to:
1. request the gpio pin used for interrupt (ok)
2. convert it to irq number (ok)
3. put it in driver specific platform data (ok)
4. release the gpio pin (?)

Would request_irq() work after release of that gpio pin?
 
Best regards
--
Marek Szyprowski
Samsung Poland R&D Center
