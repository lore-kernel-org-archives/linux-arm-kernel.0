From: khilman@linaro.org (Kevin Hilman)
Date: Thu, 13 Jun 2013 15:21:43 -0700
Subject: [PATCH 2/2] rtc: omap: add rtc wakeup support to alarm events
In-Reply-To: <1BAFE6F6C881BF42822005164F1491C33EC34679@DBDE04.ent.ti.com>
 (Gururaja Hebbar's message of "Thu, 13 Jun 2013 09:39:54 +0000")
References: <1369982005-8572-1-git-send-email-gururaja.hebbar@ti.com>
 <1369982005-8572-3-git-send-email-gururaja.hebbar@ti.com>
 <87a9nb2gjh.fsf@linaro.org>
 <1BAFE6F6C881BF42822005164F1491C33EC34679@DBDE04.ent.ti.com>
Message-ID: <87k3lxabyg.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

"Hebbar, Gururaja" <gururaja.hebbar@ti.com> writes:

> Hi Kevin,
>
> On Mon, Jun 10, 2013 at 16:55:17, Hebbar, Gururaja wrote:
>> On Fri, May 31, 2013 at 23:11:22, Kevin Hilman wrote:
>> > Hebbar Gururaja <gururaja.hebbar@ti.com> writes:
>> > 
>> > > On some platforms (like AM33xx), a special register (RTC_IRQWAKEEN)
>> > > is available to enable Wakeup feature for Alarm Events.
>> > >
>> > > Since new platforms/Boards are now added through DT only, this feature
>> > > is supported via DT property only.
>> > 
>> > > Platforms using such IP should add the property "ti,has_irq_wake_enb"
>> > > in rtc DT node.
>> > 
>> > This is a property of the IP, not the board.  Can't you detect this
>> > based on the revision of the IP?
>> 
>> Here is what I found out till now.
>> 
>> 1. rtc-omap driver is used by Davinci, OMAP-1/2 & AM33xx SoC.
>> 
>> 2. Only AM33xx soc rtc ip has revision register (& populated). Older OMAP
>>    Or davinci doesn't have this register.
>> 
>> 3. AFAIK, this was the reason why Afzal used platform_device_id & 
>>    of_device_id->data method to detect new versions (commit
>>    9e0344dcc225fe1a0e8b8af9ff7df44ec4613580)
>> 
>> 
>> So now either 
>> a. I can follow the same method and add new member to omap_rtc_devtype & add a new compatible in 
>>  omap_rtc_of_match in rtc-omap.c
>> 
>> or
>> 
>> b. use dt property to indicate existence of above property.
>> 
>> 
>> Kindly let me know your opinion about the same.
>
> Any update on this. I have patch ready for both the choices. Waiting for your ok to send

I think (a) is better.

The driver should always do a device_init_wakeup(dev, true), *except*
for devtypes that don't have this feature.

Kevin
