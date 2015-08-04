From: balbi@ti.com (Felipe Balbi)
Date: Tue, 4 Aug 2015 16:35:53 -0500
Subject: [PATCH] musb: sunxi: Ignore VBus errors in host-only mode
In-Reply-To: <1438723553-4136-1-git-send-email-hdegoede@redhat.com>
References: <1438723553-4136-1-git-send-email-hdegoede@redhat.com>
Message-ID: <20150804213553.GI9623@saruman.tx.rr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 04, 2015 at 11:25:53PM +0200, Hans de Goede wrote:
> For some unclear reason sometimes we get VBus errors in host-only mode,
> even though we do not have any vbus-detection then. Ignore these.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/usb/musb/sunxi.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/usb/musb/sunxi.c b/drivers/usb/musb/sunxi.c
> index f9f6304..34ce5df 100644
> --- a/drivers/usb/musb/sunxi.c
> +++ b/drivers/usb/musb/sunxi.c
> @@ -194,6 +194,10 @@ static irqreturn_t sunxi_musb_interrupt(int irq, void *__hci)
>  		musb_writeb(musb->mregs, MUSB_FADDR, 0);
>  	}
>  
> +	/*  Ignore Vbus errors when in host only mode */
> +	if (musb->port_mode == MUSB_PORT_MODE_HOST)
> +		musb->int_usb &= ~MUSB_INTR_VBUSERROR;

check with a scope if VBUS is really dropping. Host does VBUS detection
indeed, at a minimum, for overcurrent protection. You might have
something causing VBUS to drop and that something needs to be found,
rather than masked.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150804/4dbbb53a/attachment.sig>
