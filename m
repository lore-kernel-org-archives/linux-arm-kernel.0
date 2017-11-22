From: mathias.nyman@linux.intel.com (Mathias Nyman)
Date: Wed, 22 Nov 2017 17:24:45 +0200
Subject: [PATCH 1/2] usb: xhci: add relaxed timing quirk bit
In-Reply-To: <32f8dc7e-9fde-5e45-1570-a9ec372579fa@codeaurora.org>
References: <1511284690-3878-1-git-send-email-awallis@codeaurora.org>
 <1511284690-3878-2-git-send-email-awallis@codeaurora.org>
 <20171121191103.5oczqvrlo4gtwjqc@rob-hp-laptop>
 <f200ce55-ac67-02f9-4dbf-7a3ba5b52b39@codeaurora.org>
 <CAL_JsqLZgnTTEiLXD8ZOK-0qd58i16e7h_-2yjHN+zRFfqvH4Q@mail.gmail.com>
 <32f8dc7e-9fde-5e45-1570-a9ec372579fa@codeaurora.org>
Message-ID: <ee0ca959-1812-a4e4-346f-d57a1fdade13@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22.11.2017 02:07, Adam Wallis wrote:
> On 11/21/2017 3:06 PM, Rob Herring wrote:
> 
> [..]
> 
>>> I like where you are going with this. Are you saying that I could read for a
>>> device property read from firmware (for DTB or ACPI) like DWC3 does for
>>> "snps,hird-threshold"?
>>
>> Is that for the same thing? If so, drop the vendor prefix and use
>> that. Otherwise, a separate property should really be something that
>> is per board rather than per SoC.
> 
> I don't think that's exactly the same property, but it's the same idea I would
> prefer to go with. That way, an integer can be passed in via the firmware tables.
> 
>>
>>> If you mean this, where do you recommend I store the
>>> desired IRQ_CONTROL value - in struct xhci_hcd ?
>>
>> No idea.
>>
>>> Or by "compatible" strings, did you mean storing hard-coded values in the
>>> of_device_id usb_xhci_of_match[] array? This would still be hard-coding (which I
>>> would like to avoid) and also would not work for the ACPI case.
>>
>> ACPI has match tables too?
>>
> 
> Yes, you can use DSD in a way that is similar to OF properties
> 
>> It would only be hardcoded per compatible which should be per SoC. Do
>> you need per board/device tuning? If so, use a property.
>>
> 
> The reason why I think it should dynamic via firmware tables is that
> 
> * It's much less invasive for vendors to update their DT tables if they need to
> adjust on a per device/controller/family/etc basis then to adjust a properties
> table in xhci-plat
> * This would lead to less polluting in xhci-plat code
> 
>> Rob
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-usb" in
>> the body of a message to majordomo at vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
> 
> I will provide an updated proposed patch sometime this week. I also hope to get
> some feedback from Mathias to see what he prefers.

We know have at least two hosts/platforms that need custom interrupt moderation values

How about adding a u32 device property for xhci with the interrupt moderation interval in
nanoseconds?  And also add a u32 imod_interval variable to struct xhci_hcd?
  
imod_interval can be set to the current default 40000ns (160*250ns) and overwritten if
device_property_read_u32() returns something else.

XHCI_MTK_HOST could then use whatever preferred device propery interval value,
and we can get rid of using XHCI_MTK_HOST quirk flag when setting up the IMODI
  
-Mathias
