From: hns@goldelico.com (H. Nikolaus Schaller)
Date: Sat, 16 Jun 2018 17:37:59 +0200
Subject: [PATCH v7 3/6] DTS: gta04: add uart2 child node for w2sg0004 GPS
 receiver
In-Reply-To: <20180614194428.GA17808@amd>
References: <cover.1525340143.git.hns@goldelico.com>
 <9ebb28aed589aca8e9b5bc5c910f1d2f0d62669d.1525340143.git.hns@goldelico.com>
 <20180614194428.GA17808@amd>
Message-ID: <23B66F6C-83A1-4666-A4E1-D127C6E3446B@goldelico.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pavel,

> Am 14.06.2018 um 21:44 schrieb Pavel Machek <pavel@ucw.cz>:
> 
> On Thu 2018-05-03 11:35:48, H. Nikolaus Schaller wrote:
>> GTA04 has a W2SG0004 module connected to UART2 of the OMAP3
>> processor. A GPIO can pulse the on/off toggle switch.
>> 
>> Note that there is no WAKEUP output from the W2SG0004,
>> hence we can't use the generic SirfStar binding.
>> 
>> The VSIM regulator is used to power on/off the LNA of an
>> external active GPS antenna so that a driver can turn the
>> LNA off if GPS is not needed to save battery energy.
> 
> This reads as if you did low->high->low to turn GPS on, then
> low->high->low to turn GPS off again. Is that correct?

Yes, it controls a toggle switch inside the gps module.

Data sheet (page 5, table 1):

	http://download.goldelico.com/gta04-hardware/Datasheets/W2SG0004_Datasheet_Rev1.81.pdf

Well, it says it wants a "Low going pulse (two RTC ticks), for power save".
So this indicates "high->low->high" and the chip responds on an unspecified edge.

If I speculate about the logic behind this, I think there was the concept of a
push-button at the navigator's console of a vessel (button is connected through
a single long wire and grounded at the console) to turn the receiver on or off.

Now the question is which edge turns it on or of. Pushing or releasing the button?
high->low or low->high? There is no hint in the data sheet.

If we assume it has not been changed in the w2sg0084i, we can look at page 9, figure 3

	https://www.mouser.com/ds/2/437/W2SG0084i_Datasheet_Rev1%2061-1114.pdf

to find that a rising edge changes the power state.

Experiments with manually controlling the w2sg0004 through /sys/class/gpio have
confirmed that that the rising edge is relevant.

Now on power-on there seems to be a special rule. If the on/off line is
permanently grounded (i.e. low), the module will turn on automatically at
power-on. So there is no need for any edge.

But since we don't want the module to be turned on at power-on (while U-Boot
is running) we have code there to initialize the gpio line to high.

Unfortunately you have not cited the code of the patch, so let me add it back:

> +		/* GPIO_145: trigger for on/off-impulse for w2sg0004 */
> +		enable-gpios = <&gpio5 17 GPIO_ACTIVE_HIGH>;

So there it is described as GPIO_ACTIVE_HIGH.

This might seem to contradict the data sheet which talks about a low going pulse,
but better reflects the active low->high edge.

I hope this answers your question completely.

BR and thanks,
Nikolaus
