From: binmlist@gmail.com (Bin Liu)
Date: Mon, 14 Oct 2013 08:54:09 -0500
Subject: [RFC] usb: musb: dsps, OTG detection
In-Reply-To: <1381757734-2976-1-git-send-email-mpa@pengutronix.de>
References: <1381757734-2976-1-git-send-email-mpa@pengutronix.de>
Message-ID: <CADYTM3bY91tcp7yWteQZo9C5==fSjPv2ncqqUo7fzfA2=YRnaw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 14, 2013 at 8:35 AM, Markus Pargmann <mpa@pengutronix.de> wrote:
> The USB Controller does not support ID pin change interrupts. So we have
> to use a polling function to detect changes of A/B device state
> (otg_timer). This poll function has to check in several states if a
> other device type might be connected to the USB port. This check is
> triggered by manually starting/stopping a USB Session.

I think this is an arguable approach. Toggling the SESSION in
otg_timer() causes voltage pulses on VBUS, which will not pass the USB
certification.

I have not seen any products required the dynamic dual role switching
yet. It always fixed in either device mode or host mode.

Regards,
-Bin.

>
> So in A mode, we cancel the currently running session which also
> disables the possibility to detect new devices via interrupt. In B mode,
> we start a session to check for ID-Pin and possibly connected devices.
>
> Whenever a real USB session ends, we have to trigger the otg_timer poll
> function again.
>
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> ---
>  drivers/usb/musb/musb_dsps.c | 84 ++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 78 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/usb/musb/musb_dsps.c b/drivers/usb/musb/musb_dsps.c
> index b24b697..0245e8d 100644
> --- a/drivers/usb/musb/musb_dsps.c
> +++ b/drivers/usb/musb/musb_dsps.c
> @@ -178,6 +178,43 @@ static const struct file_operations musb_regdump_fops = {
>
>  #endif /* IS_ENABLED(CONFIG_DEBUG_FS) */
>
> +/*
> + * Compare driver and hardware mode and update driver state if necessary.
> + * Not all hardware changes actually reach the driver through interrupts.
> + */
> +static void dsps_update_mode(struct musb *musb)
> +{
> +       u8 devctl;
> +
> +       devctl = dsps_readb(musb->mregs, MUSB_DEVCTL);
> +
> +       switch (musb->xceiv->state) {
> +       case OTG_STATE_A_IDLE:
> +               if (devctl & MUSB_DEVCTL_BDEVICE) {
> +                       dev_dbg(musb->controller, "detected controller state B, software state A\n");
> +                       musb->xceiv->state = OTG_STATE_B_IDLE;
> +               }
> +               break;
> +       case OTG_STATE_B_IDLE:
> +               if (!(devctl & MUSB_DEVCTL_BDEVICE)) {
> +                       dev_dbg(musb->controller, "detected controller state A, software state B\n");
> +                       musb->xceiv->state = OTG_STATE_A_IDLE;
> +               }
> +               break;
> +       default:
> +               if (!(devctl & MUSB_DEVCTL_SESSION)) {
> +                       dev_dbg(musb->controller, "detected controller out of session (%x), software state %s\n",
> +                               devctl,
> +                               usb_otg_state_string(musb->xceiv->state));
> +                       if (devctl & MUSB_DEVCTL_BDEVICE)
> +                               musb->xceiv->state = OTG_STATE_B_IDLE;
> +                       else
> +                               musb->xceiv->state = OTG_STATE_A_IDLE;
> +               }
> +               break;
> +       }
> +}
> +
>  /**
>   * dsps_musb_enable - enable interrupts
>   */
> @@ -229,6 +266,8 @@ static void otg_timer(unsigned long _musb)
>         u8 devctl;
>         unsigned long flags;
>
> +       dsps_update_mode(musb);
> +
>         /*
>          * We poll because DSPS IP's won't expose several OTG-critical
>          * status change events (from the transceiver) otherwise.
> @@ -239,6 +278,16 @@ static void otg_timer(unsigned long _musb)
>
>         spin_lock_irqsave(&musb->lock, flags);
>         switch (musb->xceiv->state) {
> +       case OTG_STATE_A_IDLE:
> +       case OTG_STATE_A_WAIT_VRISE:
> +               /*
> +                * Poll the devctl register to know when the controller switches
> +                * back to B state.
> +                */
> +               musb_writeb(mregs, MUSB_DEVCTL,
> +                               devctl & (~MUSB_DEVCTL_SESSION));
> +               mod_timer(&glue->timer, jiffies + wrp->poll_seconds * HZ);
> +               break;
>         case OTG_STATE_A_WAIT_BCON:
>                 devctl &= ~MUSB_DEVCTL_SESSION;
>                 dsps_writeb(musb->mregs, MUSB_DEVCTL, devctl);
> @@ -251,6 +300,8 @@ static void otg_timer(unsigned long _musb)
>                         musb->xceiv->state = OTG_STATE_A_IDLE;
>                         MUSB_HST_MODE(musb);
>                 }
> +               mod_timer(&glue->timer,
> +                               jiffies + wrp->poll_seconds * HZ);
>                 break;
>         case OTG_STATE_A_WAIT_VFALL:
>                 musb->xceiv->state = OTG_STATE_A_WAIT_VRISE;
> @@ -258,12 +309,24 @@ static void otg_timer(unsigned long _musb)
>                             MUSB_INTR_VBUSERROR << wrp->usb_shift);
>                 break;
>         case OTG_STATE_B_IDLE:
> +               /*
> +                * There's no ID-changed IRQ, so we have no good way to tell
> +                * when to switch to the A-Default state machine (by setting
> +                * the DEVCTL.Session bit).
> +                *
> +                * Workaround:  whenever we're in B_IDLE, try setting the
> +                * session flag every few seconds.  If it works, ID was
> +                * grounded and we're now in the A-Default state machine.
> +                *
> +                * NOTE: setting the session flag is _supposed_ to trigger
> +                * SRP but clearly it doesn't.
> +                */
> +               musb_writeb(mregs, MUSB_DEVCTL, devctl | MUSB_DEVCTL_SESSION);
>                 devctl = dsps_readb(mregs, MUSB_DEVCTL);
> -               if (devctl & MUSB_DEVCTL_BDEVICE)
> -                       mod_timer(&glue->timer,
> -                                       jiffies + wrp->poll_seconds * HZ);
> -               else
> +               if (!(devctl & MUSB_DEVCTL_BDEVICE))
>                         musb->xceiv->state = OTG_STATE_A_IDLE;
> +               mod_timer(&glue->timer,
> +                               jiffies + wrp->poll_seconds * HZ);
>                 break;
>         default:
>                 break;
> @@ -376,7 +439,6 @@ static irqreturn_t dsps_interrupt(int irq, void *hci)
>                         MUSB_HST_MODE(musb);
>                         musb->xceiv->otg->default_a = 1;
>                         musb->xceiv->state = OTG_STATE_A_WAIT_VRISE;
> -                       del_timer(&glue->timer);
>                 } else {
>                         musb->is_active = 0;
>                         MUSB_DEV_MODE(musb);
> @@ -397,8 +459,16 @@ static irqreturn_t dsps_interrupt(int irq, void *hci)
>                 ret |= musb_interrupt(musb);
>
>         /* Poll for ID change */
> -       if (musb->xceiv->state == OTG_STATE_B_IDLE)
> +       switch (musb->xceiv->state) {
> +       case OTG_STATE_A_IDLE:
> +       case OTG_STATE_A_WAIT_BCON:
> +       case OTG_STATE_A_WAIT_VRISE:
> +       case OTG_STATE_B_IDLE:
>                 mod_timer(&glue->timer, jiffies + wrp->poll_seconds * HZ);
> +               break;
> +       default:
> +               break;
> +       }
>  out:
>         spin_unlock_irqrestore(&musb->lock, flags);
>
> @@ -479,6 +549,8 @@ static int dsps_musb_init(struct musb *musb)
>
>         dev_info(dev, "%s:%d %s: OK\n", __FILE__, __LINE__, __func__);
>
> +       musb->xceiv->otg->default_a = 0;
> +
>         return 0;
>  }
>
> --
> 1.8.4.rc3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-usb" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
