From: j-keerthy@ti.com (Keerthy)
Date: Sun, 7 Jan 2018 21:26:44 +0530
Subject: [PATCH v6 10/10] clocksource: timer-dm: Check prescaler value
In-Reply-To: <20180104224713.GA11557@lenoch>
References: <1514887799-24605-1-git-send-email-j-keerthy@ti.com>
 <1514887799-24605-11-git-send-email-j-keerthy@ti.com>
 <20180104224713.GA11557@lenoch>
Message-ID: <f743a25e-d29e-8693-f2c6-87d2f648d613@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 1/5/2018 4:17 AM, Ladislav Michl wrote:
> On Tue, Jan 02, 2018 at 03:39:59PM +0530, Keerthy wrote:
>> From: Ladislav Michl <ladis@linux-mips.org>
>>
>> Invalid prescaler value is silently ignored. Fix that
>> by returning -EINVAL in such case. As invalid value
>> disabled use of the prescaler, use -1 explicitely for
>> that purpose.
>>
>> Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
>> ---
>>   drivers/clocksource/timer-dm.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/clocksource/timer-dm.c b/drivers/clocksource/timer-dm.c
>> index 60db173..01a9cb0 100644
>> --- a/drivers/clocksource/timer-dm.c
>> +++ b/drivers/clocksource/timer-dm.c
>> @@ -672,6 +672,9 @@ int omap_dm_timer_set_prescaler(struct omap_dm_timer *timer, int prescaler)
>>   	if (prescaler >= 0x00 && prescaler <= 0x07) {
>>   		l |= OMAP_TIMER_CTRL_PRE;
>>   		l |= prescaler << 2;
>> +	} else {
>> +		if (prescaler != -1)
>> +			return -EINVAL;
> 
> Argh... This is actually wrong, as it leaves timer enabled.
> I suggest simply dropping this patch and I'll rethink whole
> approach a bit later (and better).

Okay. I hope the rest 9 patches work well for you.

> 
>>   	}
>>   	omap_dm_timer_write_reg(timer, OMAP_TIMER_CTRL_REG, l);
>>   
> 
> Sorry for the noise,
> 	ladis
> 
