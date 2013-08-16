From: nsekhar@ti.com (Sekhar Nori)
Date: Fri, 16 Aug 2013 21:11:30 +0530
Subject: [PATCH v3 1/2] rtc: omap: update of_device_id to reflect latest
 ip revisions
In-Reply-To: <520E341D.4080206@baylibre.com>
References: <1376653017-21935-1-git-send-email-gururaja.hebbar@ti.com>
 <1376653017-21935-2-git-send-email-gururaja.hebbar@ti.com>
 <520E341D.4080206@baylibre.com>
Message-ID: <520E482A.1070504@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 8/16/2013 7:45 PM, Benoit Cousson wrote:
> Hi Gururaja,
> 
> On 16/08/2013 13:36, Hebbar, Gururaja wrote:
>> The syntax of compatible property in DT is to mention the Most specific
>> match to most generic match.
>>
>> Since AM335x is the platform with latest IP revision, add it 1st in
>> the device id table.
> 
> I don't understand why? The order should not matter at all.

Yes, it should not. We are trying to work around a bug in the kernel
where the compatible order is not honored (instead the order in
of_match[] array matters). There were patches being discussed to fix this.

> 
> I've tried to follow the thread you had with Mark on the v2, but AFAIK,
> you've never answered to his latest question.
> 
> Moreover, checking the differences between the Davinci and the am3352
> RTC IP, I would not claim that both are compatible.
> 
> Sure you can use the am3352 with the Davinci driver, but you will lose
> the wakeup functionality without even being notify about that.

When the kernel is fixed for the bug pointed out above, this should not
happen with properly defined compatible property.

> 
> For my point of view, compatible mean that the HW will still be fully
> functional with both versions of the driver, which is not the case here.

I do not think that's the interpretation of compatible. Its goes from
most specific to most generic per the ePAPR spec. That in itself says
that 100% functionality is not expected if you don't find a match for
the more specific property.

> 
> am3352 DTS must use the ti,am3352-rtc to have the expected behavior.

Yes, that's what patch 2/2 does.

> Using the ti,da830-rtc version will not make the board working as
> expected. So we cannot claim the compatibility.

Ideally, the DT file was *always* written as

	compatible = "ti,am3352-rtc", "ti,da830-rtc";

even when there was no kernel support for AM3352 RTC.

That way, there is no need to update the .dts[i] file. As kernel gains
functionality, more features (like rtc wake) is available to users.
Otherwise they get plain RTC functionality - but at least they get
something instead of no RTC.

Thanks,
Sekhar
