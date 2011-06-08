From: hans-christian.egtvedt@atmel.com (Hans-Christian Egtvedt)
Date: Wed, 08 Jun 2011 16:02:20 +0200
Subject: [PATCH] atmel_serial: keep the platform_device unchanged
In-Reply-To: <20110608134730.GA17584@game.jcrosoft.org>
References: <1302724038-26236-1-git-send-email-plagnioj@jcrosoft.com>
	<1307522703.10626.9.camel@hcegtvedt.norway.atmel.com>
	<20110608134730.GA17584@game.jcrosoft.org>
Message-ID: <1307541740.10626.15.camel@hcegtvedt.norway.atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2011-06-08 at 15:47 +0200, Jean-Christophe PLAGNIOL-VILLARD
wrote:
> On 10:45 Wed 08 Jun     , Hans-Christian Egtvedt wrote:
> > On Wed, 2011-04-13 at 21:47 +0200, Jean-Christophe PLAGNIOL-VILLARD
> > wrote:

<snipp>

> > > diff --git a/arch/avr32/mach-at32ap/at32ap700x.c b/arch/avr32/mach-at32ap/at32ap700x.c
> > > index bfc9d07..aa677e2 100644
> > > --- a/arch/avr32/mach-at32ap/at32ap700x.c
> > > +++ b/arch/avr32/mach-at32ap/at32ap700x.c
> > > @@ -1014,6 +1014,7 @@ static struct platform_device *__initdata at32_usarts[4];
> > >  void __init at32_map_usart(unsigned int hw_id, unsigned int line, int flags)
> > >  {
> > >  	struct platform_device *pdev;
> > > +	struct atmel_uart_data *pdata;
> > >  
> > >  	switch (hw_id) {
> > >  	case 0:
> > > @@ -1042,7 +1043,8 @@ void __init at32_map_usart(unsigned int hw_id, unsigned int line, int flags)
> > >  		data->regs = (void __iomem *)pdev->resource[0].start;
> > >  	}
> > >  
> > > -	pdev->id = line;
> > 
> > AVR32 needs this to be present to work independent of which USART
> > peripheral the user chooses to use for console.
> > 
> > > +	pdata = pdev->dev.platform_data;
> > > +	pdata->num = portnr;
> here supposed to be
> 	pdata->num = line;

I know, but that doesn't fix the problem about not able to find a
console, the platform data id must also be 0 (if console is on ttyS0)
AFAICT.

-- 
Hans-Christian Egtvedt
