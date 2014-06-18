From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Wed, 18 Jun 2014 12:24:04 +0100
Subject: [RFC v3 1/9] arm: fiq: arbitrary mappings from IRQ to FIQ virqs
In-Reply-To: <CAL_JsqK-jCQjCCw4qfJOCfNKLVRDTAYSYsGpmYLDzoSVsBaHrA@mail.gmail.com>
References: <1400853478-5824-1-git-send-email-daniel.thompson@linaro.org>
 <1401961994-18033-1-git-send-email-daniel.thompson@linaro.org>
 <1401961994-18033-2-git-send-email-daniel.thompson@linaro.org>
 <CAL_JsqK-jCQjCCw4qfJOCfNKLVRDTAYSYsGpmYLDzoSVsBaHrA@mail.gmail.com>
Message-ID: <53A176D4.90002@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13/06/14 15:29, Rob Herring wrote:
> On Thu, Jun 5, 2014 at 4:53 AM, Daniel Thompson
> <daniel.thompson@linaro.org> wrote:
>> Currently enable_fiq/disable_fiq use a simple offset to convert an IRQ
>> virq into a FIQ virq. This is too inflexible for multi-platform kernels
>> and makes runtime error checking impossible.
>>
>> We solve this by introducing a flexible mapping that allows interrupt
>> controllers that support FIQ to register those mappings. This, in turn,
>> makes it much possible for drivers in DT kernels to gain access to
>> FIQ virqs.
> 
> I don't get why you need a separate linux irq numbers for FIQ. Isn't
> enabling FIQ simply a property of an irq like edge vs. level trigger?
> Also, given the constraints on FIQ, we can't really have more that 1
> IRQ assigned to FIQ.

No particular reason. I mostly went that way because it mimics the
effect of fiq_start on enable_fiq/disable_fiq whilst supporting
multi-platform.

I'm tempted to keep the radix tree in the FIQ infrastructure but rather
than messing about with shadow virqs use it to lookup a fiq_chip
structure. I think this would keep a clean separation between the ARM
centric (and slightly weird) FIQ from the generic irq code.


Daniel.
