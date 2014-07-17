From: balbi@ti.com (Felipe Balbi)
Date: Thu, 17 Jul 2014 11:04:21 -0500
Subject: [PATCH 5/5] tty: serial: Add 8250-core based omap driver
In-Reply-To: <53C7E7BE.7030403@linutronix.de>
References: <1405521903-5877-1-git-send-email-bigeasy@linutronix.de>
 <1405521903-5877-6-git-send-email-bigeasy@linutronix.de>
 <20140717145430.GF10459@saruman.home>
 <53C7E7BE.7030403@linutronix.de>
Message-ID: <20140717160421.GJ10459@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 17, 2014 at 05:11:58PM +0200, Sebastian Andrzej Siewior wrote:
> On 07/17/2014 04:54 PM, Felipe Balbi wrote:
> > Hi,
> > 
> > On Wed, Jul 16, 2014 at 04:45:03PM +0200, Sebastian Andrzej Siewior wrote:
> >> +static int omap_8250_startup(struct uart_port *port)
> >> +{
> >> +	struct uart_8250_port *up =
> >> +		container_of(port, struct uart_8250_port, port);
> >> +	struct omap8250_priv *priv = port->private_data;
> >> +
> >> +	int ret;
> >> +
> >> +	if (priv->wakeirq) {
> >> +		ret = request_irq(priv->wakeirq, omap_wake_irq,
> >> +				port->irqflags, "wakeup irq", port);
> >> +		if (ret)
> >> +			return ret;
> >> +		disable_irq(priv->wakeirq);
> >> +	}
> >> +
> >> +	ret = serial8250_do_startup(port);
> >> +	if (ret)
> >> +		goto err;
> >> +
> >> +	pm_runtime_get_sync(port->dev);
> > 
> > should this pm_runtime_get_sync() be placed above
> > serial8250_do_startup() call ?
> 
> I don't think it matters since serial8250_do_startup() has its own
> pm_runtime_get_sync().

oh right, saw that now.

> ->startup(), ->shutdown() are called via omap callbacks so we could
> spare in the 8250-core if we do it in the omap code before invoking the
> function. The same goes for serial8250_set_termios() which is not used
> by omap but has those runtime-pm stuff, too.
> It would be wrong if someone would use the serial8250_do_startup()
> without his own runtime-pm get but it is omap only which does this
> things.
> So it is not used by anyone else (right now) and if you want to keep it
> to a minimum I could remove them from those places.

I don't think it matters as long as the calls are balanced.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140717/fe4ab5fe/attachment.sig>
