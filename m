From: mpa@pengutronix.de (Markus Pargmann)
Date: Tue, 7 Oct 2014 11:10:41 +0200
Subject: [PATCH 2/5] regulator: Set ena_gpio_valid in regulator drivers
In-Reply-To: <5433A863.1040206@samsung.com>
References: <1412626635-7404-1-git-send-email-mpa@pengutronix.de>
 <1412626635-7404-3-git-send-email-mpa@pengutronix.de>
 <5433A863.1040206@samsung.com>
Message-ID: <20141007091041.GD5042@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 07, 2014 at 10:46:27AM +0200, Krzysztof Koz?owski wrote:
> On 06.10.2014 22:17, Markus Pargmann wrote:
> >This patch sets the new field ena_gpio_valid for all drivers which set a
> >valid ena_gpio.
> >
> >Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> >---
> 
> (... looking only on s2m/s5m drivers)
> 
> >diff --git a/drivers/regulator/s2mps11.c b/drivers/regulator/s2mps11.c
> >index b16c53a8272f..4d78477b9f57 100644
> >--- a/drivers/regulator/s2mps11.c
> >+++ b/drivers/regulator/s2mps11.c
> >@@ -986,6 +986,7 @@ common_reg:
> >  			config.of_node = rdata[i].of_node;
> >  		}
> >  		config.ena_gpio = s2mps11->ext_control_gpio[i];
> >+		config.ena_gpio_valid = true;
> 
> This way you'll mark all regulators as GPIO enabled. This is won't
> produce an error (ena_gpio is initialized to -EINVAL by default) but
> I think it is misuse of the idea "ena_gpio_valid".
> 
> Instead maybe:
> +		if (gpio_is_valid(s2mps11->ext_control_gpio[i]))
> +			config.ena_gpio_valid = true;
> ?

The regulator core also checks if the gpio is valid. Perhaps the name
'ena_gpio_valid' is a bit confusing here.
But yes, it may be better to check gpio_is_valid here to see if
there is an actual valid gpio.

Thanks,

Markus

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141007/2627f5ed/attachment.sig>
