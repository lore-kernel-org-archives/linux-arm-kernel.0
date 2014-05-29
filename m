From: robherring2@gmail.com (Rob Herring)
Date: Thu, 29 May 2014 08:44:00 -0500
Subject: [RFC v2 04/10] ARM: vexpress: Extend UART with FIQ support
In-Reply-To: <53870C8C.1070108@linaro.org>
References: <1400083125-1464-1-git-send-email-daniel.thompson@linaro.org>
 <1400853478-5824-1-git-send-email-daniel.thompson@linaro.org>
 <1400853478-5824-5-git-send-email-daniel.thompson@linaro.org>
 <20140523150452.GX3693@n2100.arm.linux.org.uk>
 <53870C8C.1070108@linaro.org>
Message-ID: <CAL_JsqL0pYOEiyo8KfJA1aO_MOmwvn6a4hibZcamm0Jcw4Q6bA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 29, 2014 at 5:31 AM, Daniel Thompson
<daniel.thompson@linaro.org> wrote:
> On 23/05/14 16:04, Russell King - ARM Linux wrote:
>> On Fri, May 23, 2014 at 02:57:52PM +0100, Daniel Thompson wrote:
>>> @@ -140,7 +140,7 @@
>>>                      v2m_serial0: uart at 090000 {
>>>                              compatible = "arm,pl011", "arm,primecell";
>>>                              reg = <0x090000 0x1000>;
>>> -                            interrupts = <5>;
>>> +                            interrupts = <5>, <69>;
>>
>> NAK.  This is obviously a Linux implementation detail - the second
>> number is your "FIQ" number which you've decided will be offset by
>> 64.

+1

> Certainly the offset of 64 is a more or less meaningless magic number
> that I decided on, however I don't think it originates within Linux. It
> is both introduced and consumed within the device tree itself.
>
> I've proposed adding a flag to the gic bindings to mark a FIQ; the GIC
> calls interrupt 69 (above) <0 5 0x84> (where 0x80 is the flag to request
> FIQ routing alongside 0x04 which is the trigger type).

That would be better than the magic number, but I'm not convinced that
belongs in the DT either.

Whether the uart uses FIQ is not dependent on this DT setting, but
based on whether the user wants to use the uart for kdb or not. You
have enough information already to figure out which interrupt. What's
missing is whether you have the capability to use FIQ or not. I don't
recall if you can tell that from the GIC or not.

Rob
