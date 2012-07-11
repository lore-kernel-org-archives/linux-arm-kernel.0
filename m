From: stigge@antcom.de (Roland Stigge)
Date: Wed, 11 Jul 2012 09:49:04 +0200
Subject: [PATCH v9] input: keyboard: Add keys driver for the LPC32xx SoC
In-Reply-To: <20120710205507.GA377@core.coreip.homeip.net>
References: <1341948910-6530-1-git-send-email-stigge@antcom.de>
 <20120710205507.GA377@core.coreip.homeip.net>
Message-ID: <4FFD2FF0.8030000@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/10/2012 10:55 PM, Dmitry Torokhov wrote:
> Hi Roland,
> 
> On Tue, Jul 10, 2012 at 09:35:10PM +0200, Roland Stigge wrote:
>> This patch adds a driver for the key scan interface of the LPC32xx SoC
>>
> 
> Could of more things that I had in my patch but forgot to specifically
> call out:
> 
>> +
>> +	/* Configure the key scanner */
>> +	clk_prepare_enable(kscandat->clk);
> 
> This may fail so we should handle errors.
> 
>> +	writel(kscandat->deb_clks, LPC32XX_KS_DEB(kscandat->kscan_base));
>> +	writel(kscandat->scan_delay, LPC32XX_KS_SCAN_CTL(kscandat->kscan_base));
>> +	writel(LPC32XX_KSCAN_FTST_USE32K_CLK,
>> +	       LPC32XX_KS_FAST_TST(kscandat->kscan_base));
>> +	writel(kscandat->matrix_sz,
>> +	       LPC32XX_KS_MATRIX_DIM(kscandat->kscan_base));
>> +	writel(1, LPC32XX_KS_IRQ(kscandat->kscan_base));
>> +	clk_disable_unprepare(kscandat->clk);
>> +
>> +	error = request_irq(irq, lpc32xx_kscan_irq, 0, pdev->name, kscandat);
> 
> ...
> 
>> +
>> +	free_irq(platform_get_irq(pdev, 0), pdev);
> 
> You are requesting IRQ with kscandat as an argument but freeing it with
> 'pdev' which will fail.
> 
>> +
>> +	if (kscandat->input->users) {
>> +		/* Enable clock and clear IRQ */
>> +		clk_prepare_enable(kscandat->clk);
> 
> Need to handle errors here as well.
> 
> Since I am partial to my rearrangement (basically I started preferring
> err_<action> style of error labels as they more explanatory than out2 or
> fail3 style of labels), could you try this version of my patch (on top
> of your v9 one). Third time is a charm maybe? :)

Yes, works fine!

Thanks!

Acked-by: Roland Stigge <stigge@antcom.de>
