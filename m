From: balbi@ti.com (Felipe Balbi)
Date: Wed, 6 Mar 2013 13:26:33 +0200
Subject: [PATCH v11 4/9] usb: chipidea: udc: add pullup/pulldown dp at
 hw_device_state
In-Reply-To: <1362563800-16673-5-git-send-email-peter.chen@freescale.com>
References: <1362563800-16673-1-git-send-email-peter.chen@freescale.com>
 <1362563800-16673-5-git-send-email-peter.chen@freescale.com>
Message-ID: <20130306112633.GS28587@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Mar 06, 2013 at 05:56:35PM +0800, Peter Chen wrote:
> - During the connect/disconnect host, we need to pullup
> and pulldown dp
> - Make sure the dp is not pullup until the vbus is on when
> flag CI13XXX_PULLUP_ON_VBUS is set
> - Using hw_device_state when set run/stop bit
> 
> Signed-off-by: Peter Chen <peter.chen@freescale.com>
> ---
>  drivers/usb/chipidea/udc.c |   10 ++++++++--
>  1 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/chipidea/udc.c b/drivers/usb/chipidea/udc.c
> index e82dae4..70f9f2d 100644
> --- a/drivers/usb/chipidea/udc.c
> +++ b/drivers/usb/chipidea/udc.c
> @@ -91,8 +91,10 @@ static int hw_device_state(struct ci13xxx *ci, u32 dma)
>  		/* interrupt, error, port change, reset, sleep/suspend */
>  		hw_write(ci, OP_USBINTR, ~0,
>  			     USBi_UI|USBi_UEI|USBi_PCI|USBi_URI|USBi_SLI);
> +		hw_write(ci, OP_USBCMD, USBCMD_RS, USBCMD_RS);
>  	} else {
>  		hw_write(ci, OP_USBINTR, ~0, 0);
> +		hw_write(ci, OP_USBCMD, USBCMD_RS, 0);

this patch doesn't make sense to me. What will happen is that you will
be enabling pullups when vbus_session() gets called and this might not
be what gadget driver wants.

You don't want to fiddle with that yourself since I'm changing the
framework so that gadget driver will always request pullups to be
enabled.

Alex, I don't think this patch is correct

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130306/5cf68fda/attachment.sig>
