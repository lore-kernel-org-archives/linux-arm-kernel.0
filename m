From: pavel@ucw.cz (Pavel Machek)
Date: Sun, 25 Dec 2016 22:20:35 +0100
Subject: [PATCH 1/4] serial: core: Add LED trigger support
In-Reply-To: <20161123100106.15969-2-s.hauer@pengutronix.de>
References: <20161123100106.15969-1-s.hauer@pengutronix.de>
 <20161123100106.15969-2-s.hauer@pengutronix.de>
Message-ID: <20161225212034.GC26891@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> As the serial core layer does not know when the hardware actually sends
> or receives characters, this needs help from the UART drivers. The
> LED triggers are registered in uart_add_led_triggers() called from
> the UART drivers which want to support LED triggers. All the driver
> has to do then is to call uart_led_trigger_[tx|rx] to indicate
> activity.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  drivers/tty/serial/serial_core.c | 73 ++++++++++++++++++++++++++++++++++++++++
>  include/linux/serial_core.h      | 10 ++++++
>  2 files changed, 83 insertions(+)
> 

> +	if (!IS_ENABLED(CONFIG_LEDS_TRIGGERS))
> +		return 0;
> +
> +	uport->led_trigger_tx_name = kasprintf(GFP_KERNEL, "%s%d-tx",
> +					       drv->dev_name, uport->line);
> +	uport->led_trigger_rx_name = kasprintf(GFP_KERNEL, "%s%d-rx",
> +					       drv->dev_name, uport->line);

Is it neccessary to have separate triggers for rx and tx?

Won't most common application be "light a led for rx _or_ tx", which
is something this can not do?

If I have system with 200 serials, this creates 400 triggers, each
trigger name will be about 10 characters AFAICT... and we'll overflow
some buffer when doing "cat triggers", no?

Would it be enough to have 3 triggers? (Any activity, any rx, any tx)?

Thanks,
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161225/5bbd182d/attachment.sig>
