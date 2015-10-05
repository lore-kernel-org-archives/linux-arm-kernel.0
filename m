From: balbi@ti.com (Felipe Balbi)
Date: Mon, 5 Oct 2015 15:02:20 -0500
Subject: [PATCH] usb: musb: dsps: handle the
 otg_state_a_wait_vrise_timeout case
In-Reply-To: <87twrfsbed.fsf@free-electrons.com>
References: <1440087153-31084-1-git-send-email-gregory.clement@free-electrons.com>
 <55D719B1.8010700@free-electrons.com> <87twrfsbed.fsf@free-electrons.com>
Message-ID: <87d1wtf5ir.fsf@saruman.tx.rr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Gregory CLEMENT <gregory.clement@free-electrons.com> writes:

> Hi Felipe,
>  
>  On ven., ao?t 21 2015, Gregory CLEMENT <gregory.clement@free-electrons.com> wrote:
>>> According to the OTG specification after a timeout of
>>> OTG_TIME_A_WAIT_VRISE (the maximum value is 100ms) the driver must
>>> move from the state a_wait_vrise to the state a_wait_bcon. However,
>>> the dsps version of musb does not handle this case.
>>> 
>>> Without it, the driver could remain stuck in the a_wait_vrise. It can
>>> be reproduce with the following steps:
>>> 
>>> 1) Boot a board with no USB adapter inserted
>>> 2) Insert an empty OTG adapter
>>> 3) Wait 2 seconds then remove the OTG adapter
>>> 4) The unit is now stuck in host mode, the VBUS switch is latched on
>>> and the ID pin is no longer polled.
>>> 
>>> The only way to exit this state was to insert a OTG adapter with an
>>> USB device connected. Until this, the usb device mode was not
>>> available.
>>> 
>>> It was tested on a AM35x based board.
>>> 
>>> CC: <stable@vger.kernel.org>
>>> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
>>> ---
>>>  drivers/usb/musb/musb_dsps.c | 14 +++++++++++++-
>>>  1 file changed, 13 insertions(+), 1 deletion(-)
>>> 
>>> diff --git a/drivers/usb/musb/musb_dsps.c b/drivers/usb/musb/musb_dsps.c
>>> index 65d931a..2d22683 100644
>>> --- a/drivers/usb/musb/musb_dsps.c
>>> +++ b/drivers/usb/musb/musb_dsps.c
>>> @@ -145,6 +145,7 @@ struct dsps_glue {
>>>  	struct timer_list timer;	/* otg_workaround timer */
>>>  	unsigned long last_timer;    /* last timer data for each instance */
>>>  	bool sw_babble_enabled;
>>> +	int otg_state_a_wait_vrise_timeout;
>>>  
>>>  	struct dsps_context context;
>>>  	struct debugfs_regset32 regset;
>>> @@ -268,9 +269,18 @@ static void otg_timer(unsigned long _musb)
>>>  
>>>  	spin_lock_irqsave(&musb->lock, flags);
>>>  	switch (musb->xceiv->otg->state) {
>>> +	case OTG_STATE_A_WAIT_VRISE:
>>> +		if ((glue->otg_state_a_wait_vrise_timeout)) {
>>> +				musb->xceiv->otg->state = OTG_STATE_A_WAIT_BCON;
>>> +				musb->is_active = 0;
>>> +			}
>>> +		mod_timer(&glue->timer, jiffies +
>>> +			  msecs_to_jiffies(OTG_TIME_A_WAIT_VRISE));
>>
>> After more test on more USB drive, it seems that for some of them
>> OTG_TIME_A_WAIT_VRISE is too short. 200ms seems better. It is
>> disturbing because according to the OTG specification the maximum
>> is 100ms, however I am not so surprised that USB device maker don't
>> follow it.
>
> So after many tests on different devices, 200ms is enough for most of
> them, but for one, 2000ms (2s) was needed!
>
> I see several option:
> - adding a sysfs entry to setup the time
> - adding a debugs entry entry
> - adding configuration option in menuconfig
> - using 2000ms and hopping it was enough for everyone
>
> My preference would go to the first option, what is your opinion?

I'm not sure if either of them is good. man 2s is just too large. If the
device isn't following the specification, I'm afraid that device needs
to be fixed.

I think the real issue here is the lack of a disconnect IRQ from AM335x
devices. But here's something I've been meaning to test but never had
time. If you look into AM335x address space, there's a bit in the
wrapper which tells it to use the standard MUSB registers for IRQ,
instead of the TI-specific thing. Can you see if we get a disconnect IRQ
with that ?

TRM is at [1], see page 2566. Basically, if you set bit 3 in register
offset 0x1014, then it should use Mentor IRQ registers. If that works,
quite a few problems will actually vanish :-p

[1] http://www.ti.com/lit/ug/spruh73l/spruh73l.pdf

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151005/bf90ce4c/attachment-0001.sig>
