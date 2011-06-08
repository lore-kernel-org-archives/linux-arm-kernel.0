From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Wed, 8 Jun 2011 15:47:30 +0200
Subject: [PATCH] atmel_serial: keep the platform_device unchanged
In-Reply-To: <1307522703.10626.9.camel@hcegtvedt.norway.atmel.com>
References: <1302724038-26236-1-git-send-email-plagnioj@jcrosoft.com>
	<1307522703.10626.9.camel@hcegtvedt.norway.atmel.com>
Message-ID: <20110608134730.GA17584@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10:45 Wed 08 Jun     , Hans-Christian Egtvedt wrote:
> On Wed, 2011-04-13 at 21:47 +0200, Jean-Christophe PLAGNIOL-VILLARD
> wrote:
> > specify the port num via platform_data this will allow to match the clock
> > with the plaform_dev staticly
> 
> Sure this works as intended, now the platform device id is off, and at
> least for my 3.0 testing it is no longer able to open the console,
> unless I explicit set the id field again.
> 
> Example on NGW100 mkII I use USART instance 1 as serial console, if not
> setting the platform device id to 0 (re-mapping), then I get a warning
> about unable to open console.
> 
> Is you clock optimization an additional patch?
no but we can also switch the avr32 to clkdev
> 
> <snipp AT91 changes)
> 
> > diff --git a/arch/avr32/mach-at32ap/at32ap700x.c b/arch/avr32/mach-at32ap/at32ap700x.c
> > index bfc9d07..aa677e2 100644
> > --- a/arch/avr32/mach-at32ap/at32ap700x.c
> > +++ b/arch/avr32/mach-at32ap/at32ap700x.c
> > @@ -1014,6 +1014,7 @@ static struct platform_device *__initdata at32_usarts[4];
> >  void __init at32_map_usart(unsigned int hw_id, unsigned int line, int flags)
> >  {
> >  	struct platform_device *pdev;
> > +	struct atmel_uart_data *pdata;
> >  
> >  	switch (hw_id) {
> >  	case 0:
> > @@ -1042,7 +1043,8 @@ void __init at32_map_usart(unsigned int hw_id, unsigned int line, int flags)
> >  		data->regs = (void __iomem *)pdev->resource[0].start;
> >  	}
> >  
> > -	pdev->id = line;
> 
> AVR32 needs this to be present to work independent of which USART
> peripheral the user chooses to use for console.
> 
> > +	pdata = pdev->dev.platform_data;
> > +	pdata->num = portnr;
here supposed to be
	pdata->num = line;

Best Regards,
J.
