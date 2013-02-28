From: peter.chen@freescale.com (Peter Chen)
Date: Thu, 28 Feb 2013 14:21:17 +0800
Subject: [PATCH v10 4/8] usb: chipidea: udc: add pullup/pulldown dp at
 hw_device_state
In-Reply-To: <CAB7JpEFWMQaAS+tnR2Xd9OL+3eFeOp5ELLA92t55Vu0oMfKn7Q@mail.gmail.com>
References: <1361946799-29471-1-git-send-email-peter.chen@freescale.com>
 <1361946799-29471-5-git-send-email-peter.chen@freescale.com>
 <CAB7JpEFWMQaAS+tnR2Xd9OL+3eFeOp5ELLA92t55Vu0oMfKn7Q@mail.gmail.com>
Message-ID: <20130228062116.GE19387@nchen-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 27, 2013 at 11:06:05PM +0200, Alexander Shishkin wrote:
>    On Feb 27, 2013 8:33 AM, "Peter Chen" <peter.chen@freescale.com> wrote:
>    >
>    > - During the connect/disconnect host, we need to pullup
>    > and pulldown dp
>    > - Make sure the dp is not pullup until the vbus is on when
>    > flag CI13XXX_PULLUP_ON_VBUS is set
>    > - Using hw_device_state when set run/stop bit
>    >
>    > Signed-off-by: Peter Chen <peter.chen@freescale.com>
>    > ---
>    >  drivers/usb/chipidea/udc.c |   10 ++++++++--
>    >  1 files changed, 8 insertions(+), 2 deletions(-)
>    >
>    > diff --git a/drivers/usb/chipidea/udc.c b/drivers/usb/chipidea/udc.c
>    > index e82dae4..597ae64 100644
>    > --- a/drivers/usb/chipidea/udc.c
>    > +++ b/drivers/usb/chipidea/udc.c
>    > @@ -91,8 +91,10 @@ static int hw_device_state(struct ci13xxx *ci, u32
>    dma)
>    >                 /* interrupt, error, port change, reset, sleep/suspend
>    */
>    >                 hw_write(ci, OP_USBINTR, ~0,
>    >                            
>     USBi_UI|USBi_UEI|USBi_PCI|USBi_URI|USBi_SLI);
>    > +               hw_write(ci, OP_USBCMD, USBCMD_RS, USBCMD_RS);
>    >         } else {
>    >                 hw_write(ci, OP_USBINTR, ~0, 0);
>    > +               hw_write(ci, OP_USBCMD, USBCMD_RS, 0);
>    >         }
>    >         return 0;
>    >  }
>    > @@ -1424,10 +1426,14 @@ static int ci13xxx_pullup(struct usb_gadget
>    *_gadget, int is_on)
>    >  {
>    >         struct ci13xxx *ci = container_of(_gadget, struct ci13xxx,
>    gadget);
>    >
>    > +       if ((ci->platdata->flags & CI13XXX_PULLUP_ON_VBUS) &&
>    > +                       !ci->vbus_active)
>    > +               return -ENOTSUPP;
> 
>    This doesn't look right, if !ci->vbus_active *and* is_on, then we can't do
>    what we're asked to do, so it makes sense to return error (which, by the
>    looks of it, will be ignored by gadgets anyway, but that's another thing),
>    and I don't think ENOTSUPP is the right choice here.
> 
>    In case !ci->vbus_active and !is_on, it should be safe to return 0.

At later patch, the flag CI13XXX_PULLUP_ON_VBUS is retired. The code likes
below:

static int ci13xxx_pullup(struct usb_gadget *_gadget, int is_on)
{
	struct ci13xxx *ci = container_of(_gadget, struct ci13xxx, gadget);

	if (!ci->vbus_active)
		return -ENOTSUPP;

	if (is_on)
		hw_device_state(ci, ci->ep0out->qh.dma);
	else
		hw_device_state(ci, 0);

	return 0;
}

So you suggested I change like below:

static int ci13xxx_pullup(struct usb_gadget *_gadget, int is_on)
{
	struct ci13xxx *ci = container_of(_gadget, struct ci13xxx, gadget);

	if (!ci->vbus_active)
		return -EPERM;

	if (is_on)
		hw_device_state(ci, ci->ep0out->qh.dma);
	else
		hw_device_state(ci, 0);

	return 0;
}

-- 

Best Regards,
Peter Chen
