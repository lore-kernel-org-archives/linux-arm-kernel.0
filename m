From: grant.likely@secretlab.ca (Grant Likely)
Date: Tue, 4 Oct 2011 10:52:26 -0600
Subject: [RFC PATCH] tty/serial: atmel_serial: add device tree support
In-Reply-To: <4E8A6858.6020700@gmail.com>
References: <1317635502-9430-1-git-send-email-nicolas.ferre@atmel.com>
	<4E8A6858.6020700@gmail.com>
Message-ID: <20111004165226.GA10919@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 03, 2011 at 08:58:48PM -0500, Rob Herring wrote:
> On 10/03/2011 04:51 AM, Nicolas Ferre wrote:
> >  static int __devinit atmel_serial_probe(struct platform_device *pdev)
> >  {
> >  	struct atmel_uart_port *port;
> > +	struct device_node *np = pdev->dev.of_node;
> >  	struct atmel_uart_data *pdata = pdev->dev.platform_data;
> >  	void *data;
> >  	int ret;
> >  
> >  	BUILD_BUG_ON(ATMEL_SERIAL_RINGSIZE & (ATMEL_SERIAL_RINGSIZE - 1));
> >  
> > -	port = &atmel_ports[pdata->num];
> > +	if (np) {
> > +		ret = of_alias_get_id(np, "serial");
> > +		if (ret < 0)
> > +			goto err;
> 
> I'll defer to Grant on this. There aren't any other drivers using this.
> 

This is the correct thing to do.

One note however; I prefer driver to *not* require an alias to be
present.  By all means, use an alias if it is available, but the
driver should auto-enumerate if it is not.  There is a patch that
makes of_alias_get_id() do this for you, but it hasn't been mainlined
yet and it is still a bit in flux.  There will be something that takes
care of this for you, but be aware that the function name may change.

In the mean time, this patch is okay.

Acked-by: Grant Likely <grant.likely@secretlab.ca>

g.
