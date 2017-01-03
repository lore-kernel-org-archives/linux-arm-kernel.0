From: hzpeterchen@gmail.com (Peter Chen)
Date: Tue, 3 Jan 2017 14:46:33 +0800
Subject: [PATCH v6 22/25] usb: chipidea: Drop lock across event_notify
 during gadget stop
In-Reply-To: <20161228225711.698-23-stephen.boyd@linaro.org>
References: <20161228225711.698-1-stephen.boyd@linaro.org>
 <20161228225711.698-23-stephen.boyd@linaro.org>
Message-ID: <20170103064633.GA14542@b29397-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 28, 2016 at 02:57:08PM -0800, Stephen Boyd wrote:
> The CI_HDRC_CONTROLLER_STOPPED_EVENT may want to call sleeping
> APIs similar to how _gadget_stop_activity() may. Let's drop the
> lock across the event so that glue drivers can make sleeping
> calls.
> 
> Cc: Peter Chen <peter.chen@nxp.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>
> ---
>  drivers/usb/chipidea/udc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/chipidea/udc.c b/drivers/usb/chipidea/udc.c
> index 0db56fb7e9e9..0d532a724d48 100644
> --- a/drivers/usb/chipidea/udc.c
> +++ b/drivers/usb/chipidea/udc.c
> @@ -1793,10 +1793,10 @@ static int ci_udc_stop(struct usb_gadget *gadget)
>  
>  	if (ci->vbus_active) {
>  		hw_device_state(ci, 0);
> +		spin_unlock_irqrestore(&ci->lock, flags);
>  		if (ci->platdata->notify_event)
>  			ci->platdata->notify_event(ci,
>  			CI_HDRC_CONTROLLER_STOPPED_EVENT);
> -		spin_unlock_irqrestore(&ci->lock, flags);
>  		_gadget_stop_activity(&ci->gadget);
>  		spin_lock_irqsave(&ci->lock, flags);
>  		pm_runtime_put(&ci->gadget.dev);
> -- 

Acked-by: Peter Chen <peter.chen@nxp.com>

-- 

Best Regards,
Peter Chen
