From: yoshihiro.shimoda.uh@renesas.com (Yoshihiro Shimoda)
Date: Fri, 22 May 2015 11:33:57 +0000
Subject: [PATCH] usb: renesas_usbhs: avoid uninitialized variable use
In-Reply-To: <16028110.26u0uMKA2O@wuerfel>
References: <16028110.26u0uMKA2O@wuerfel>
Message-ID: <SG2PR06MB09192B9386F7E2BA5AF01D0ED8C00@SG2PR06MB0919.apcprd06.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

> Sent: Friday, May 22, 2015 8:07 PM
> 
> After the renesas_usbhs driver is enabled in ARM multi_v7_defconfig,
> we now get a new warning:
> 
> renesas_usbhs/mod.c: In function 'usbhs_interrupt':
> renesas_usbhs/mod.c:246:7: warning: 'intenb1' may be used uninitialized in this function [-Wmaybe-uninitialized]
> 
> gcc correctly points to a problem here, for the case that the
> device is in host mode, we use the intenb1 variable without
> having assigned it first. The state->intsts1 has a similar
> problem, but gcc cannot know that.
> 
> This avoids the problem by initializing both sides of the
> comparison to zero when we don't read them from the respective
> registers.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 88a25e02f3 ("usb: renesas_usbhs: Add access control for INTSTS1 and INTENB1 register")

Thank you very much for the patch!

Acked-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

(I'm not sure why a toolchain I used (Linaro GCC 2014.11) doesn't show this warning...)

Best regards,
Yoshihiro Shimoda

> diff --git a/drivers/usb/renesas_usbhs/mod.c b/drivers/usb/renesas_usbhs/mod.c
> index e5ce6e6d4f51..d4be5d594896 100644
> --- a/drivers/usb/renesas_usbhs/mod.c
> +++ b/drivers/usb/renesas_usbhs/mod.c
> @@ -223,6 +223,8 @@ static int usbhs_status_get_each_irq(struct usbhs_priv *priv,
>  	if (usbhs_mod_is_host(priv)) {
>  		state->intsts1 = usbhs_read(priv, INTSTS1);
>  		intenb1 = usbhs_read(priv, INTENB1);
> +	} else {
> +		state->intsts1 = intenb1 = 0;
>  	}
> 
>  	/* mask */
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-usb" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
