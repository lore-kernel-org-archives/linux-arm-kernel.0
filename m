From: hdegoede@redhat.com (Hans de Goede)
Date: Thu, 22 Sep 2016 17:03:39 +0300
Subject: [PATCH v2 2/3] musb: sunxi: Remove custom babble handling
In-Reply-To: <20160922135415.GB31827@uda0271908>
References: <20160922111901.15337-1-hdegoede@redhat.com>
 <20160922111901.15337-2-hdegoede@redhat.com>
 <20160922135415.GB31827@uda0271908>
Message-ID: <39199bd7-a372-0312-6177-5b0fc2d683ac@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 09/22/2016 04:54 PM, Bin Liu wrote:
> Hi,
>
> On Thu, Sep 22, 2016 at 02:19:00PM +0300, Hans de Goede wrote:
>> The musb-core now a days always treats babble errors in host mode
>
> I don't think this statement is accurate. You might want to change it to
> "The musb core already handles babble interrupt" or something else.

It is accurate if you look in the history at drivers/usb/musb
commits around 15-03-10 you will see 2 relevant commits:

https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/drivers/usb/musb?id=b4dc38fd45b63e3da2bc98db5d283a15a637a2fa

"usb: musb: core: simplify musb_recover_work()"

This commits introduces calling musb_root_disconnect(musb)
on babble errors, that was not happening before which is why
I added the custom babble error handling. to the sunxi glue.

And:

"usb: musb: core: always try to recover from babble"

Where the title says it all.

Take these together and I believe that my commit msg:

"The musb-core now a days always treats babble errors in host mode
as disconnects, so there is no need for the sunxi specific handling
of this anymore."

Is quite accurate.

Regards,

Hans


>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>> Changes in v2:
>> -This is a new patch in v2 of this patch series
>> ---
>>  drivers/usb/musb/sunxi.c | 10 ----------
>>  1 file changed, 10 deletions(-)
>>
>> diff --git a/drivers/usb/musb/sunxi.c b/drivers/usb/musb/sunxi.c
>> index 1408245..82eba92 100644
>> --- a/drivers/usb/musb/sunxi.c
>> +++ b/drivers/usb/musb/sunxi.c
>> @@ -186,16 +186,6 @@ static irqreturn_t sunxi_musb_interrupt(int irq, void *__hci)
>>  	if (musb->int_usb)
>>  		writeb(musb->int_usb, musb->mregs + SUNXI_MUSB_INTRUSB);
>>
>> -	/*
>> -	 * sunxi musb often signals babble on low / full speed device
>> -	 * disconnect, without ever raising MUSB_INTR_DISCONNECT, since
>> -	 * normally babble never happens treat it as disconnect.
>> -	 */
>> -	if ((musb->int_usb & MUSB_INTR_BABBLE) && is_host_active(musb)) {
>> -		musb->int_usb &= ~MUSB_INTR_BABBLE;
>> -		musb->int_usb |= MUSB_INTR_DISCONNECT;
>> -	}
>> -
>>  	if ((musb->int_usb & MUSB_INTR_RESET) && !is_host_active(musb)) {
>>  		/* ep0 FADDR must be 0 when (re)entering peripheral mode */
>>  		musb_ep_select(musb->mregs, 0);
>> --
>> 2.9.3
>>
