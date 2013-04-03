From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 3 Apr 2013 12:37:47 +0200
Subject: [RFC PATCH v2] rtc: rtc-at91rm9200: manage IMR depending on
 revision
In-Reply-To: <20130403095150.GC27600@localhost>
References: <1364908007-5150-1-git-send-email-nicolas.ferre@atmel.com>
 <1364920566-30040-1-git-send-email-nicolas.ferre@atmel.com>
 <20130403095150.GC27600@localhost>
Message-ID: <515C067B.6070503@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/03/2013 11:51 AM, Johan Hovold :
> On Tue, Apr 02, 2013 at 06:36:06PM +0200, Nicolas Ferre wrote:
>> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
>> ---
>> Hi again,
>>
>> Here is my latest revision of this fix. It depends on the patch that is already
>> in Andrew's patch stack: "drivers-rtc-rtc-at91rm9200c-add-dt-support.patch".
> 
> That is a problem, as the patch in Andrew's stack is not (and should
> not) be marked for stable. Hence this patch cannot be applied to the
> stable trees and it won't even apply to 3.9-rc.

My intentions were to tag both patches for "stable". You highlight that
it is not a good practice: I admit that you are right.


> But there's more: The offending patch introduced the races we have been
> discussion while attempting to add support for the sam9x5 with the
> broken hardware register. But that family cannot be used without
> DT-support, which the driver currently does not support. Hence, we added
> a workaround (and introduced a regression by mistake), while adding
> support for a SoC which still could not use the driver. [ For example,
> the sam9x5 RTC-base register address can only be supplied from DT. ]
> 
> I think the only reasonable thing to do is to revert the patch and add
> whatever version of the work-around on top of the device-tree support
> when that is added to the driver (hence, earliest v3.10).

Yes. Let's do this.


>> I now use a different compatibility string to figure out what is the IP
>> revision that has the "boggus IMR" error. I think this way to handle it
>> is much simpler than the "config" structure one from Johan.
> 
> I wouldn't say it's much simpler. My solution is only more generic, but
> could of course also be reduced to "set a flag if compatible matches
> sam9x5".

The advantage is precisely to avoid the need for a "flag". Only function
pointers that are changed in case of the compatible string matching.


>> The small number of line changed and the "single patch" nature of it
>> make me think that it will be easier to send upstream and in the
>> "stable" trees...
> 
> Unfortunately, the 130-line diff isn't very small. In fact, it violates
> the stable-kernel guide line of <100 lines. And as noted above, it
> depends on another patch which adds DT-support (which is a new feature
> and not a fix).
> 
> But the fundamental problem remains: it does not fix anything which was
> working before the first work-around patch introduced the regression. I
> think this is a clear case where we need to revert.

Okay.

>> Please give feedback, but moreover, I would like to know if you (Johan and Douglas)
>> agree to give your "Signed-off-by" line because this patch is certainly
>> inspired by your comments, code and reviews.
>>
>> Thank you for your help. Best regards,
>>
>>  .../bindings/rtc/atmel,at91rm9200-rtc.txt          |   3 +-
>>  drivers/rtc/rtc-at91rm9200.c                       | 126 ++++++++++++++++-----
>>  drivers/rtc/rtc-at91rm9200.h                       |   1 +
>>  3 files changed, 101 insertions(+), 29 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/rtc/atmel,at91rm9200-rtc.txt b/Documentation/devicetree/bindings/rtc/atmel,at91rm9200-rtc.txt
>> index 2a3feab..9b87053 100644
>> --- a/Documentation/devicetree/bindings/rtc/atmel,at91rm9200-rtc.txt
>> +++ b/Documentation/devicetree/bindings/rtc/atmel,at91rm9200-rtc.txt
>> @@ -1,7 +1,8 @@
>>  Atmel AT91RM9200 Real Time Clock
>>  
>>  Required properties:
>> -- compatible: should be: "atmel,at91rm9200-rtc"
>> +- compatible: should be: "atmel,at91rm9200-rtc", "atmel,at91sam9x5-rtc" or
>> +                         "atmel,at91sam9n12-rtc".
> 
> Also at91sam9g45 and at91sam9rl use this driver.

Yes, sure, I did not want to add every single user of the RTC...

> As seems to be the case
> for other peripherals, I suggest we use "atmel,at91sam9x5-rtc" for
> sam9x5 and "atmel,at91rm9200-rtc" for the other SoCs, that is, the least
> (and first) common denominator.

... I was just following the habit of naming the changes in peripheral
revision by it first use in a SoC:
at91rm9200-rtc: from rm9200 up to 9g45
at91sam9x5-rtc: sam9x5 only (with IMR issue)
at91sam9n12-rtc: fist SoC that corrects the IMR issue with a new IP
revision, until now and sama5d3 SoC



> Either way, there's not need to add at91sam9n12-rtc in this patch.
> 
>>  - reg: physical base address of the controller and length of memory mapped
>>    region.
>>  - interrupts: rtc alarm/event interrupt
> 
> I'll respond to this mail with a revert-patch, and an updated RFC-series
> based on top of the DT-patch in Andrew's queue.

Best regards,
-- 
Nicolas Ferre
