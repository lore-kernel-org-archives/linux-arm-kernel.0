From: robherring2@gmail.com (Rob Herring)
Date: Tue, 16 Jun 2015 08:02:33 -0500
Subject: [PATCH 1/4] mfd: 88pm800: add device tree support
In-Reply-To: <557FD5AD.5020405@linaro.org>
References: <1432937962-4537-1-git-send-email-vaibhav.hiremath@linaro.org>
 <1432937962-4537-2-git-send-email-vaibhav.hiremath@linaro.org>
 <20150601083835.GE3329@x1> <557FD5AD.5020405@linaro.org>
Message-ID: <CAL_Jsq+6yk59Z4swi2xq4=_=m89pBUt-fNXJF8smjw7qS8xazA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 16, 2015 at 2:52 AM, Vaibhav Hiremath
<vaibhav.hiremath@linaro.org> wrote:
>
>
> On Monday 01 June 2015 02:08 PM, Lee Jones wrote:
>>
>> On Sat, 30 May 2015, Vaibhav Hiremath wrote:
>>
>
> Thanks for your review. and sorry for delayed response.
>
>>> Add DT support to the 88pm800 driver along with below properties
>>>         - marvell,88pm800-irq-write-clear :
>>>           Idicates whether interrupt status is cleared by write
>>>
>>> Also, creates the DT binding text file,
>>> Documentation/devicetree/bindings/mfd/88pm800.txt
>>>
>>> Signed-off-by: Chao Xie <chao.xie@marvell.com>
>>> Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
>>> ---
>>>   Documentation/devicetree/bindings/mfd/88pm800.txt | 57
>>> +++++++++++++++++++++++
>>>   drivers/mfd/88pm800.c                             | 39 ++++++++++++++++
>>
>>
>> These should be submitted separately.
>>
>
>
> Ok, will separate it in next version.
>
>
>>>   2 files changed, 96 insertions(+)
>>>   create mode 100644 Documentation/devicetree/bindings/mfd/88pm800.txt
>>>
>>> diff --git a/Documentation/devicetree/bindings/mfd/88pm800.txt
>>> b/Documentation/devicetree/bindings/mfd/88pm800.txt
>>> new file mode 100644
>>> index 0000000..094951b
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/mfd/88pm800.txt
>>> @@ -0,0 +1,57 @@
>>> +* Marvell 88PM800 Power Management IC

Might as well name this 88PM8xx from the start.

>>> +
>>> +Required parent device properties:
>>> +- compatible : "marvell,88pm800"

You might as well include 88pm805 and 88pm860 here since 805 support
is in the kernel and you will be submitting 860 support. They don't
have to be added with driver support.

>>> +- reg : the I2C slave address for the 88pm800 chip
>>> +- interrupts : IRQ line for the 88pm800 chip
>>> +- interrupt-controller: describes the 88pm800 as an interrupt controller
>>> +- #interrupt-cells : should be 1.
>>> +               - The cell is the 88pm800 local IRQ number
>>> +
>>> +Optional parent device properties:
>>> +- marvell,88pm800-irq-write-clr: indicates whether interrupt status is
>>> cleared by write
>>
>>
>> Drop the device name.  These bindings should be as generic as possible.
>>
>
> OK, how about simply
>
> "mfd-irq_clr_on_write"

No, mfd is a Linux name which doesn't belong in bindings, and
underscores are generally not used.

I think Lee meant marvell,irq-write-clr or irq-write-clr.

This could also just be dropped altogether and set based on the
compatible strings with match data.

>> Also describe what the absence of the property means.
>>
>
> Ok.
>
>>> +88pm800 consists of a large and varied group of sub-devices:
>>
>>
>> 3?
>>
>
> I have explicitly mentioned in note that more device list will follow.
> I just wanted to add entries as and when we add/enable driver support.
>
>>> +Device                  Supply Names    Description
>>> +------                  ------------    -----------
>>> +88pm80x-onkey          :               : On key
>>> +88pm80x-rtc            :               : RTC
>>> +88pm80x                        :               : Regulators
>>
>>
>> Surely regulators is 88pm80x-regulator, no?
>>
>
> did not understand what change is expected here.

The node name for regulators node should be 88pm80x-regulator? But
these don't correspond to node names based on the example and the
example is correct IMO. So these are Linux driver names? If so, they
don't belong in the binding doc. What you need is to document the
sub-node compatible strings

Rob
