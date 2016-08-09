From: peter.chen@nxp.com (Peter Chen)
Date: Tue, 9 Aug 2016 00:42:07 +0000
Subject: [PATCH v2 08/22] usb: chipidea: Remove locking in ci_udc_start()
In-Reply-To: <147070007426.10825.11324896309403492272@sboyd-linaro>
References: <20160707222114.1673-1-stephen.boyd@linaro.org>
 <20160707222114.1673-9-stephen.boyd@linaro.org>
 <20160708094528.GF20485@shlinux2>
 <147043403652.26915.10865210145828633146@sboyd-linaro>
 <20160806075435.GB12298@shlinux2>
 <147070007426.10825.11324896309403492272@sboyd-linaro>
Message-ID: <VI1PR04MB1455B5AF1542F631C84F54F28B1C0@VI1PR04MB1455.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>Quoting Peter Chen (2016-08-06 00:54:35)
>> On Fri, Aug 05, 2016 at 02:53:56PM -0700, Stephen Boyd wrote:
>> > Quoting Peter Chen (2016-07-08 02:45:28)
>> > > On Thu, Jul 07, 2016 at 03:20:59PM -0700, Stephen Boyd wrote:
>> > > > We don't call hw_device_reset() with the ci->lock held, so it
>> > > > doesn't seem like this lock here is protecting anything. Let's
>> > > > just remove it. This allows us to call sleeping functions like
>> > > > phy_init() from within the CI_HDRC_CONTROLLER_RESET_EVENT hook.
>> > > >
>> > > > Cc: Peter Chen <peter.chen@nxp.com>
>> > > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> > > > Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>
>> > > > ---
>> > > >  drivers/usb/chipidea/udc.c | 3 ---
>> > > >  1 file changed, 3 deletions(-)
>> > > >
>> > > > diff --git a/drivers/usb/chipidea/udc.c
>> > > > b/drivers/usb/chipidea/udc.c index 065f5d97aa67..f16be4710cdb
>> > > > 100644
>> > > > --- a/drivers/usb/chipidea/udc.c
>> > > > +++ b/drivers/usb/chipidea/udc.c
>> > > > @@ -1719,7 +1719,6 @@ static int ci_udc_start(struct usb_gadget *gadget,
>> > > >                        struct usb_gadget_driver *driver)  {
>> > > >       struct ci_hdrc *ci = container_of(gadget, struct ci_hdrc, gadget);
>> > > > -     unsigned long flags;
>> > > >       int retval = -ENOMEM;
>> > > >
>> > > >       if (driver->disconnect == NULL) @@ -1746,7 +1745,6 @@
>> > > > static int ci_udc_start(struct usb_gadget *gadget,
>> > > >
>> > > >       pm_runtime_get_sync(&ci->gadget.dev);
>> > > >       if (ci->vbus_active) {
>> > > > -             spin_lock_irqsave(&ci->lock, flags);
>> > > >               hw_device_reset(ci);
>> > > >       } else {
>> > > >               usb_udc_vbus_handler(&ci->gadget, false); @@
>> > > > -1755,7 +1753,6 @@ static int ci_udc_start(struct usb_gadget *gadget,
>> > > >       }
>> > > >
>> > > >       retval = hw_device_state(ci, ci->ep0out->qh.dma);
>> > > > -     spin_unlock_irqrestore(&ci->lock, flags);
>> > > >       if (retval)
>> > > >               pm_runtime_put_sync(&ci->gadget.dev);
>> > > >
>> > >
>> > > The main purpose for this is disabling interrupt when reset
>> > > controller, in case the unexpected interrupts occur.
>> > >
>> > > You can move this between hw_device_state.
>> > >
>> >
>> > Ok, but we don't hold the ci->lock in ci_udc_vbus_session(). Is that
>> > a bug as well?
>>
>> I agree with your patch. In fact, during the reset controller, the
>> interrupt has not been enabled, it should no unexpected interrupt.
>>
>
>So then we can leave this patch as is? It still isn't clear to me what sequence of
>events that would cause a problem if we don't hold the
>ci->lock around hw_device_state().

Yes. I am ok with this patch.  After thinking more, it is safe to be without lock.
And we have this unlock code in nxp internal tree, and without any problems
during 1-2 years.

Acked-by: Peter Chen <peter.chen@nxp.com>

Peter
