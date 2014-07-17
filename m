From: balbi@ti.com (Felipe Balbi)
Date: Thu, 17 Jul 2014 09:54:30 -0500
Subject: [PATCH 5/5] tty: serial: Add 8250-core based omap driver
In-Reply-To: <1405521903-5877-6-git-send-email-bigeasy@linutronix.de>
References: <1405521903-5877-1-git-send-email-bigeasy@linutronix.de>
 <1405521903-5877-6-git-send-email-bigeasy@linutronix.de>
Message-ID: <20140717145430.GF10459@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Jul 16, 2014 at 04:45:03PM +0200, Sebastian Andrzej Siewior wrote:
> +static int omap_8250_startup(struct uart_port *port)
> +{
> +	struct uart_8250_port *up =
> +		container_of(port, struct uart_8250_port, port);
> +	struct omap8250_priv *priv = port->private_data;
> +
> +	int ret;
> +
> +	if (priv->wakeirq) {
> +		ret = request_irq(priv->wakeirq, omap_wake_irq,
> +				port->irqflags, "wakeup irq", port);
> +		if (ret)
> +			return ret;
> +		disable_irq(priv->wakeirq);
> +	}
> +
> +	ret = serial8250_do_startup(port);
> +	if (ret)
> +		goto err;
> +
> +	pm_runtime_get_sync(port->dev);

should this pm_runtime_get_sync() be placed above
serial8250_do_startup() call ?

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140717/86425844/attachment.sig>
