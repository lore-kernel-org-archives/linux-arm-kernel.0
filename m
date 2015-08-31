From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 31 Aug 2015 17:52:42 +0200
Subject: [PATCH] usb: musb: dsps: handle the
 otg_state_a_wait_vrise_timeout case
In-Reply-To: <55D719B1.8010700@free-electrons.com> (Gregory CLEMENT's message
 of "Fri, 21 Aug 2015 14:29:37 +0200")
References: <1440087153-31084-1-git-send-email-gregory.clement@free-electrons.com>
 <55D719B1.8010700@free-electrons.com>
Message-ID: <87twrfsbed.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Felipe,
 
 On ven., ao?t 21 2015, Gregory CLEMENT <gregory.clement@free-electrons.com> wrote:
>> According to the OTG specification after a timeout of
>> OTG_TIME_A_WAIT_VRISE (the maximum value is 100ms) the driver must
>> move from the state a_wait_vrise to the state a_wait_bcon. However,
>> the dsps version of musb does not handle this case.
>> 
>> Without it, the driver could remain stuck in the a_wait_vrise. It can
>> be reproduce with the following steps:
>> 
>> 1) Boot a board with no USB adapter inserted
>> 2) Insert an empty OTG adapter
>> 3) Wait 2 seconds then remove the OTG adapter
>> 4) The unit is now stuck in host mode, the VBUS switch is latched on
>> and the ID pin is no longer polled.
>> 
>> The only way to exit this state was to insert a OTG adapter with an
>> USB device connected. Until this, the usb device mode was not
>> available.
>> 
>> It was tested on a AM35x based board.
>> 
>> CC: <stable@vger.kernel.org>
>> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
>> ---
>>  drivers/usb/musb/musb_dsps.c | 14 +++++++++++++-
>>  1 file changed, 13 insertions(+), 1 deletion(-)
>> 
>> diff --git a/drivers/usb/musb/musb_dsps.c b/drivers/usb/musb/musb_dsps.c
>> index 65d931a..2d22683 100644
>> --- a/drivers/usb/musb/musb_dsps.c
>> +++ b/drivers/usb/musb/musb_dsps.c
>> @@ -145,6 +145,7 @@ struct dsps_glue {
>>  	struct timer_list timer;	/* otg_workaround timer */
>>  	unsigned long last_timer;    /* last timer data for each instance */
>>  	bool sw_babble_enabled;
>> +	int otg_state_a_wait_vrise_timeout;
>>  
>>  	struct dsps_context context;
>>  	struct debugfs_regset32 regset;
>> @@ -268,9 +269,18 @@ static void otg_timer(unsigned long _musb)
>>  
>>  	spin_lock_irqsave(&musb->lock, flags);
>>  	switch (musb->xceiv->otg->state) {
>> +	case OTG_STATE_A_WAIT_VRISE:
>> +		if ((glue->otg_state_a_wait_vrise_timeout)) {
>> +				musb->xceiv->otg->state = OTG_STATE_A_WAIT_BCON;
>> +				musb->is_active = 0;
>> +			}
>> +		mod_timer(&glue->timer, jiffies +
>> +			  msecs_to_jiffies(OTG_TIME_A_WAIT_VRISE));
>
> After more test on more USB drive, it seems that for some of them
> OTG_TIME_A_WAIT_VRISE is too short. 200ms seems better. It is
> disturbing because according to the OTG specification the maximum
> is 100ms, however I am not so surprised that USB device maker don't
> follow it.

So after many tests on different devices, 200ms is enough for most of
them, but for one, 2000ms (2s) was needed!

I see several option:
- adding a sysfs entry to setup the time
- adding a debugs entry entry
- adding configuration option in menuconfig
- using 2000ms and hopping it was enough for everyone

My preference would go to the first option, what is your opinion?

Thanks,

Gregory

>
>
>> +		break;
>>  	case OTG_STATE_A_WAIT_BCON:
>>  		dsps_writeb(musb->mregs, MUSB_DEVCTL, 0);
>>  		skip_session = 1;
>> +		glue->otg_state_a_wait_vrise_timeout = 0;
>>  		/* fall */
>>  
>>  	case OTG_STATE_A_IDLE:
>> @@ -359,7 +369,9 @@ static irqreturn_t dsps_interrupt(int irq, void *hci)
>>  			MUSB_HST_MODE(musb);
>>  			musb->xceiv->otg->default_a = 1;
>>  			musb->xceiv->otg->state = OTG_STATE_A_WAIT_VRISE;
>> -			del_timer(&glue->timer);
>> +			glue->otg_state_a_wait_vrise_timeout = 1;
>> +			mod_timer(&glue->timer, jiffies +
>> +				  msecs_to_jiffies(OTG_TIME_A_WAIT_VRISE));
>>  		} else {
>>  			musb->is_active = 0;
>>  			MUSB_DEV_MODE(musb);
>> 
>
>
> -- 
> Gregory Clement, Free Electrons
> Kernel, drivers, real-time and embedded Linux
> development, consulting, training and support.
> http://free-electrons.com
> --
> To unsubscribe from this list: send the line "unsubscribe linux-usb" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
