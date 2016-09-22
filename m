From: hdegoede@redhat.com (Hans de Goede)
Date: Thu, 22 Sep 2016 11:05:37 +0300
Subject: [PATCH 2/2] musb: sunxi: Force session end on babble errors in
 host-mode
In-Reply-To: <20160922023344.GE3981@uda0271908>
References: <20160918165018.24547-1-hdegoede@redhat.com>
 <20160918165018.24547-2-hdegoede@redhat.com>
 <20160922023344.GE3981@uda0271908>
Message-ID: <70005359-6632-0230-8f5a-79a0e2fe35f2@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 09/22/2016 05:33 AM, Bin Liu wrote:
> Hi,
>
> On Sun, Sep 18, 2016 at 06:50:18PM +0200, Hans de Goede wrote:
>> The sunxi musb has a bug where sometimes it will generate a babble
>> error on device disconnect instead of a disconnect irq. When this
>> happens the musb-controller switches from host mode to device mode
>> (it clears MUSB_DEVCTL_SESSION and sets MUSB_DEVCTL_BDEVICE) and
>> gets stuck in this state.
>>
>> Clearing this requires reporting Vbus low for 200 or more ms, but
>> on some devices Vbus is simply always high (host-only mode, no Vbus
>> control).
>>
>> This commit calls sun4i_usb_phy_force_session_end() on babble errors
>> in host-mode, fixing the musb controller being stuck in this state
>> on systems without Vbus control; and also fixes the need to unplug
>> the usb-b -> usb-a cable to get out of this state on systems with
>> Vbus control.
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>  drivers/usb/musb/sunxi.c | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
>>
>> diff --git a/drivers/usb/musb/sunxi.c b/drivers/usb/musb/sunxi.c
>> index 1408245..5079d90 100644
>> --- a/drivers/usb/musb/sunxi.c
>> +++ b/drivers/usb/musb/sunxi.c
>> @@ -192,8 +192,18 @@ static irqreturn_t sunxi_musb_interrupt(int irq, void *__hci)
>>  	 * normally babble never happens treat it as disconnect.
>>  	 */
>>  	if ((musb->int_usb & MUSB_INTR_BABBLE) && is_host_active(musb)) {
>
> musb_interrupt() handle BABBLE in host mode, and has a glue hook
> musb_platform_recover() in musb_recover_from_babble().
>
> Maybe you can use it?

Ah yes, I looked at this at the past, but that was before the babble
recover rework by Felipe Balbi which got commited on 2015-03-10.

With this rework the sunxi code should indeed be able to use the core
recovery, and we can use the musb_platform_recover() to force a
session end.

And thinking more about you're other remark, I do think I can
actually modify the sun4i phy_set_mode callback so that it can
be used for this.

I'll post a v2 with these changes soon-ish.

Regards,

Hans


>> +		struct sunxi_glue *glue =
>> +				dev_get_drvdata(musb->controller->parent);
>> +
>> +		dev_warn(musb->controller->parent, "babble, treating as disconnect\n");
>> +
>>  		musb->int_usb &= ~MUSB_INTR_BABBLE;
>>  		musb->int_usb |= MUSB_INTR_DISCONNECT;
>> +		/*
>> +		 * Fix the musb controller sometimes getting stuck in
>> +		 * bdevice state after a babble error.
>> +		 */
>> +		sun4i_usb_phy_force_session_end(glue->phy);
>
> As I commented in PATCH 1/2, can you somehow reuse
> sun4i_usb_phy_set_mode() instead?
>
>>  	}
>>
>>  	if ((musb->int_usb & MUSB_INTR_RESET) && !is_host_active(musb)) {
>> --
>> 2.9.3
>
> Regards,
> -Bin.
>
