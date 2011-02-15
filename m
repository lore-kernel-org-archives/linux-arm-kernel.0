From: khilman@ti.com (Kevin Hilman)
Date: Tue, 15 Feb 2011 08:19:35 -0800
Subject: [PATCHv2] omap2/3: dmtimer: Enable autoidle
In-Reply-To: <6038d98e9a2eb2129200f5e08560cf7e@mail.gmail.com> (Santosh
	Shilimkar's message of "Tue, 15 Feb 2011 21:07:53 +0530")
References: <1297787428-5717-1-git-send-email-tero.kristo@nokia.com>
	<6038d98e9a2eb2129200f5e08560cf7e@mail.gmail.com>
Message-ID: <878vxhuv6w.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Santosh Shilimkar <santosh.shilimkar@ti.com> writes:

>> -----Original Message-----
>> From: linux-omap-owner at vger.kernel.org [mailto:linux-omap-
>> owner at vger.kernel.org] On Behalf Of Tero Kristo
>> Sent: Tuesday, February 15, 2011 10:00 PM
>> To: linux-omap at vger.kernel.org
>> Cc: linux-arm-kernel at lists.infradead.org
>> Subject: [PATCHv2] omap2/3: dmtimer: Enable autoidle
>>
>> This saves some power. OMAP4 version should check for GPT module ID,
>> as
>> autoidle is only supported on a subset of these.
>>
>> Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
>> ---
>>  arch/arm/plat-omap/dmtimer.c |    4 ++++
>>  1 files changed, 4 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-
>> omap/dmtimer.c
>> index 1d706cf..ee9f6eb 100644
>> --- a/arch/arm/plat-omap/dmtimer.c
>> +++ b/arch/arm/plat-omap/dmtimer.c
>> @@ -342,6 +342,10 @@ static void omap_dm_timer_reset(struct
>> omap_dm_timer *timer)
>>  	l |= 0x02 << 3;  /* Set to smart-idle mode */
>>  	l |= 0x2 << 8;   /* Set clock activity to perserve f-clock on
>> idle */
>>
>> +	/* Enable autoidle on OMAP2 / OMAP3 */
>> +	if (cpu_is_omap24xx() || cpu_is_omap34xx())
>> +		l |= 0x1 << 0;
>> +
> We should get rid of this CPU checks. How about adding a flag
> and populating it on init for the architectures it supports.
>

Instead, this should be implemented on top of Tarun's hwmod conversion
which knows that different timers have different capabilities (e.g. 1ms)
and autoidle can be set based on capabilities.

Kevin
