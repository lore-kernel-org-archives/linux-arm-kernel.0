From: mathias.nyman@linux.intel.com (Mathias Nyman)
Date: Thu, 23 Nov 2017 12:59:45 +0200
Subject: [PATCH 1/2] usb: xhci: add relaxed timing quirk bit
In-Reply-To: <3c44d4d0-e10c-bacc-8e7f-df04bed5dc21@codeaurora.org>
References: <1511284690-3878-1-git-send-email-awallis@codeaurora.org>
 <1511284690-3878-2-git-send-email-awallis@codeaurora.org>
 <20171121191103.5oczqvrlo4gtwjqc@rob-hp-laptop>
 <f200ce55-ac67-02f9-4dbf-7a3ba5b52b39@codeaurora.org>
 <CAL_JsqLZgnTTEiLXD8ZOK-0qd58i16e7h_-2yjHN+zRFfqvH4Q@mail.gmail.com>
 <32f8dc7e-9fde-5e45-1570-a9ec372579fa@codeaurora.org>
 <ee0ca959-1812-a4e4-346f-d57a1fdade13@linux.intel.com>
 <3c44d4d0-e10c-bacc-8e7f-df04bed5dc21@codeaurora.org>
Message-ID: <c46e19a2-4b37-473c-a563-6fddf0c62070@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23.11.2017 01:32, Adam Wallis wrote:
> On 11/22/2017 10:24 AM, Mathias Nyman wrote:
> [..]
>>
>> We know have at least two hosts/platforms that need custom interrupt moderation
>> values
>>
>> How about adding a u32 device property for xhci with the interrupt moderation
>> interval in
>> nanoseconds?? And also add a u32 imod_interval variable to struct xhci_hcd?
>>   
>> imod_interval can be set to the current default 40000ns (160*250ns) and
>> overwritten if
>> device_property_read_u32() returns something else.
>>
> 
> Isn't the 160 value quite aggressive anyway? Section 5.5.2.2 of the xHCI spec
> says that maximum observable interrupt rate should never exceed 8000
> interrupts/second. I believe the IMOD value in the most aggressive case would
> then be 500 by this statement [ 1 / (250e-9 * 500) = 8000 irqs/second ]
> 
> Perhaps I am misreading the spec or just doing the math wrong? With the default
> value of 160, we are interrupting 25,000 irq/second...which is over 3 times the
> maximum stated value (again, assuming I did the math right)
> 
> Anyway, my preference would be to set the IMOD default val to 4000 (~1ms) per
> the recommended value in Table 49 of the spec and allow platforms to adjust as
> necessary from that point.
> 
> Thoughts on this?
> 

I think current 40us is still reasonable, it's about ~3 times per
usb microframe (125us) .8000 interrupts per second just covers the microframe rate,
which is the shortest interval a interrupt transfer can require service.

1ms interrupt interval is too long. In the worst case ~8 microframes could pass
before the driver is aware of a error it needs to take care of.
USB 3.1 devices can transfer 6 burst of 16 max sized packets (6 x 16 x 2014) bytes
per microframe.

closer to 125us could probably work as well, but unless we are fixing some issue or
getting some other bigger benefit out of it I don't think it's worth changing it
just to see if it breaks stuff.

Thanks
-Mathias
