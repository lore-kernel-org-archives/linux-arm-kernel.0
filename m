From: pavel@ucw.cz (Pavel Machek)
Date: Thu, 10 May 2018 13:21:01 +0200
Subject: [PATCH v3 1/3] leds: triggers: provide
 led_trigger_register_format()
In-Reply-To: <20180508100543.12559-2-u.kleine-koenig@pengutronix.de>
References: <20180508100543.12559-1-u.kleine-koenig@pengutronix.de>
 <20180508100543.12559-2-u.kleine-koenig@pengutronix.de>
Message-ID: <20180510112101.GD6977@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> This allows one to simplify drivers that provide a trigger with a
> non-constant name (e.g. one trigger per device with the trigger name
> depending on the device's name).
> 
> Internally the memory the name member of struct led_trigger points to
> now always allocated dynamically instead of just taken from the caller.
> 
> The function led_trigger_rename_static() must be changed accordingly and
> was renamed to led_trigger_rename() for consistency, with the only user
> adapted.

Well, I'm not sure if we want to have _that_ many trigger. Trigger
interface is going to become.. "interesting".

We have 4K limit on total number of triggers. We use rather strange
interface to select trigger.

> @@ -115,13 +115,13 @@ static int can_led_notifier(struct notifier_block *nb, unsigned long msg,
>  
>  	if (msg == NETDEV_CHANGENAME) {
>  		snprintf(name, sizeof(name), "%s-tx", netdev->name);
> -		led_trigger_rename_static(name, priv->tx_led_trig);
> +		led_trigger_rename(priv->tx_led_trig, name);
>  
>  		snprintf(name, sizeof(name), "%s-rx", netdev->name);
> -		led_trigger_rename_static(name, priv->rx_led_trig);
> +		led_trigger_rename(priv->rx_led_trig, name);
>  
>  		snprintf(name, sizeof(name), "%s-rxtx", netdev->name);
> -		led_trigger_rename_static(name, priv->rxtx_led_trig);
> +		led_trigger_rename(priv->rxtx_led_trig, name);
>  	}
>  

I know this is not your fault, but if you have a space or "[]" in
netdev names, confusing things will happen.

I believe we should have triggers "net-rx, net-tx" and it should have
parameter "which device it acts on". 
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180510/4e84c1e3/attachment.sig>
