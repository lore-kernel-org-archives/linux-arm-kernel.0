From: bhupesh.linux@gmail.com (Bhupesh SHARMA)
Date: Sun, 29 Nov 2015 03:14:40 +0530
Subject: [PATCH 1/2] Documentation: DT: Add entry for ARM SP805-WDT
In-Reply-To: <CAFTCetQpb4M0dxCWYHXVZYgNKjZT7-J91hhx1=aa7FhPWgEf6A@mail.gmail.com>
References: <1447683883-6600-1-git-send-email-bhupesh.sharma@freescale.com>
 <1447683883-6600-2-git-send-email-bhupesh.sharma@freescale.com>
 <20151116144525.GM20696@leverpostej>
 <CAFTCetQpb4M0dxCWYHXVZYgNKjZT7-J91hhx1=aa7FhPWgEf6A@mail.gmail.com>
Message-ID: <CAFTCetQS=qd7Ey_KGNG5yegqnnG2KS5Ua7J9joOSOkN_9wdYRg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On Wed, Nov 18, 2015 at 7:21 PM, Bhupesh SHARMA <bhupesh.linux@gmail.com> wrote:
> Hi Mark,
>
> Thanks for the review.
>
> On Mon, Nov 16, 2015 at 8:15 PM, Mark Rutland <mark.rutland@arm.com> wrote:
>> On Mon, Nov 16, 2015 at 07:54:42PM +0530, Bhupesh Sharma wrote:
>>> This patch adds a devicetree binding documentation for ARM's
>>> SP805 WatchDog Timer.
>>>
>>> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@freescale.com>
>>> ---
>>>  .../devicetree/bindings/watchdog/sp805-wdt.txt     |   33 ++++++++++++++++++++
>>>  1 file changed, 33 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/watchdog/sp805-wdt.txt
>>>
>>> diff --git a/Documentation/devicetree/bindings/watchdog/sp805-wdt.txt b/Documentation/devicetree/bindings/watchdog/sp805-wdt.txt
>>> new file mode 100644
>>> index 0000000..ec70fe9
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/watchdog/sp805-wdt.txt
>>> @@ -0,0 +1,33 @@
>>> +* ARM SP805 Watchdog Timer (WDT) Controller
>>> +
>>> +SP805 WDT is a ARM Primecell Peripheral and has a standard-id register that
>>> +can be used to identify the peripheral type, vendor, and revision.
>>> +This value can be used for driver matching.
>>> +
>>> +Note that the current sp805_wdt driver relies on the 'drivers/amba/bus.c'
>>> +framework to invoke the probe function of the sp805_wdt driver using the
>>> +unique PRIMECELL identifiers of the sp805 wdt IP.
>>
>> This paragraph can go. We shouldn't describe kernel internals.
>
> Ok.
>
>>> +As SP805 WDT is a primecell IP, it follows the base bindings specified in
>>> +'arm/primecell.txt'
>>> +
>>> +Required properties:
>>> +- compatible : Should be "arm,sp805-wdt", "arm,primecell"
>>> +- reg : Base address and size of the watchdog timer registers.
>>> +- interrupts : Should specify WDT interrupt number.
>>> +
>>> +Optional properties:
>>> +- clocks : From common clock binding. First clock is phandle to clock for apb
>>> +           pclk. Additional clocks are optional.
>>> +- clock-names : From common clock binding. Shall be "apb_pclk" for first clock.
>>
>> The hardware has "WDOGCLK", which is what the driver appears to expect
>> first implicitly.
>
> Ok.
>
>>> +Examples:
>>> +
>>> +             cluster1_core0_watchdog: wdt at c000000 {
>>> +                     compatible = "arm,sp805-wdt", "arm,primecell";
>>> +                     reg = <0x0 0xc000000 0x0 0x1000>;
>>> +                     interrupts = <1 12 0x8>; /* PPI, Level low type */
>>
>> I don't see how you can use PPIs here. This is not banked per CPU.
>
> I have raised this concern to my hardware team. This might be an issue
> with the documentation.
> I will change it in v2 as per their comments.

I just checked back with the hardware team. They confirm that the
WDOGINT interrupts lines
from the eight instances of the SP805 WDT are infact connected to PPI
input of the GICv3 controller.

Also this SP805 WDT IP supports 2 interrupt lines:
- WDOGINT
- WDOGRES

but the current sp805_wdt.c driver doesn't handle the WDOGINT
interrupt (irrespective of whether
it is a SPI or PPI). I could not trace a request_irq being called for
the same in the driver.

So, I would suggest the following:

I can spin a patch for sp805_wdt.c to add support to handle WDOGINT
interrupt when the WDT counter expires
as currently the cadence_wdt driver does (see [1] and [2] as reference):

[1] http://lxr.free-electrons.com/source/drivers/watchdog/cadence_wdt.c#L343
[2] http://lxr.free-electrons.com/source/drivers/watchdog/cadence_wdt.c#L254

Please suggest if this approach seems fine to you.

Regards,
Bhupesh


>
> Regards,
> Bhupesh
>
>> Mark.
>>
>>> +                     clocks = <&clockgen 4 3>;
>>> +                     clock-names = "apb_pclk";
>>> +             };
>>> +
>>> --
>>> 1.7.9.5
>>>
>>>
