From: akpm@linux-foundation.org (Andrew Morton)
Date: Wed, 18 Nov 2009 23:49:28 -0800
Subject: [PATCH] ARM: Add spi controller driver support for NUC900
In-Reply-To: <e68bb3470911182223r28e9bac0lf185c1443168ff52@mail.gmail.com>
References: <4B024748.9080001@gmail.com>
	<20091118142109.ff2c5ef6.akpm@linux-foundation.org>
	<e68bb3470911182223r28e9bac0lf185c1443168ff52@mail.gmail.com>
Message-ID: <20091118234928.8d86a9f9.akpm@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 19 Nov 2009 14:23:49 +0800 Wan ZongShun <mcuos.com@gmail.com> wrote:

> >> +static int __devexit w90p910_spi_remove(struct platform_device *dev)
> >> +{
> >> + __ __ struct w90p910_spi *hw = platform_get_drvdata(dev);
> >> +
> >> + __ __ platform_set_drvdata(dev, NULL);
> >> +
> >> + __ __ spi_unregister_master(hw->master);
> >> +
> >> + __ __ clk_disable(hw->clk);
> >> + __ __ clk_put(hw->clk);
> >
> > As far as I can tell, a hardware interrupt could still be pending, or
> > be under service while the above code is executing?
> >
> > If so, I expect bad things will happen?
> 
> Do you mean that I should put this 'free_irq()' in the front of
> w90p910_spi_remove___
> 
> such as:
> "
> free_irq(hw->irq, hw);
> 
> platform_set_drvdata(dev, NULL);
> 
> spi_unregister_master(hw->master);
> 
> clk_disable(hw->clk);
> clk_put(hw->clk);

I don't know, because I don't know what operation the hardware needs to
stop it from generating interrupts.  Perhaps that's clk_disable()?

Once you've stopped the source of interrupts then the code should wait
for the IRQ handler to complete if it's running on another CPU.  Yes,
free_irq() does that.

It's only after the clk_disable() and the free_irq() that you can
guarantee that no interrupt handler will run and attempt to access the
device and its associated data structures.
