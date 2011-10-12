From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Wed, 12 Oct 2011 21:45:25 +0530
Subject: [PATCH] gpio: exynos4: Add device tree support
In-Reply-To: <4E95AE26.8080702@gmail.com>
References: <1318320974-9879-1-git-send-email-thomas.abraham@linaro.org>
	<4E945C90.1050601@gmail.com>
	<CAJuYYwRwBxkAo2fMfVV9wtQ40XeROAnc-cGJK+cssjuh9px=qQ@mail.gmail.com>
	<4E946109.2000305@gmail.com>
	<CAJuYYwQWUjVf9Z5Rdw4fTK70=B1aw-5x_wjYm_fq+zHyQAWJvg@mail.gmail.com>
	<4E95AE26.8080702@gmail.com>
Message-ID: <CAJuYYwRsM_aGkeG9v97jdsJgSQeokViuLGdF5TvqEkNZCAgFVA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12 October 2011 20:41, Rob Herring <robherring2@gmail.com> wrote:
> On 10/11/2011 11:06 AM, Thomas Abraham wrote:
>> On 11 October 2011 21:00, Rob Herring <robherring2@gmail.com> wrote:
>>> On 10/11/2011 10:19 AM, Thomas Abraham wrote:
>>>> Hi Rob,
>>>>
>>>> On 11 October 2011 20:41, Rob Herring <robherring2@gmail.com> wrote:
>>>>> Thomas,
>>>>>
>>>>> On 10/11/2011 03:16 AM, Thomas Abraham wrote:
>>>>>> As gpio chips get registered, a device tree node which represents the
>>>>>> gpio chip is searched and attached to it. A translate function is also
>>>>>> provided to convert the gpio specifier into actual platform settings
>>>>>> for pin function selection, pull up/down and driver strength settings.
>>>>>>
>>>>>> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
>>>>>> ---
>>>>>> This patch is based on the latest consolidated Samsung GPIO driver available
>>>>>> in the following tree:
>>>>>> ? https://github.com/kgene/linux-samsung.git ?branch: for-next
>>>>>>
>>>>>> ?.../devicetree/bindings/gpio/gpio-samsung.txt ? ? ?| ? 30 +++++++++++
>>>>>> ?drivers/gpio/gpio-samsung.c ? ? ? ? ? ? ? ? ? ? ? ?| ? 53 ++++++++++++++++++++
>>>>>> ?2 files changed, 83 insertions(+), 0 deletions(-)
>>>>>> ?create mode 100644 Documentation/devicetree/bindings/gpio/gpio-samsung.txt
>>>>>>
>>>>>> diff --git a/Documentation/devicetree/bindings/gpio/gpio-samsung.txt b/Documentation/devicetree/bindings/gpio/gpio-samsung.txt
>>>>>> new file mode 100644
>>>>>> index 0000000..883faeb
>>>>>> --- /dev/null
>>>>>> +++ b/Documentation/devicetree/bindings/gpio/gpio-samsung.txt
>>>>>> @@ -0,0 +1,30 @@
>>>>>> +Samsung Exynos4 GPIO Controller
>>>>>> +
>>>>>> +Required properties:
>>>>>> +- compatible: Format of compatible property value should be
>>>>>> + ?"samsung,exynos4-gpio-<controller_name>". Example: For GPA0 controller, the
>>>>>> + ?compatible property value should be "samsung,exynos4-gpio-gpa0".
>>>>>
>>>>> Isn't gpa0 an instance of the h/w, not a version?
>>>>
>>>> GPA0 is a instance of the gpio controller. There are several such
>>>> instances and there could be differences in those instances such as
>>>> the number of GPIO lines managed by that gpio controller instance.
>>>>
>>>
>>> That doesn't seem like a reason to have different compatible strings.
>>> Does that affect the programming model of the controller? Unused lines
>>> whether at the board level or SOC level shouldn't really matter.
>>
>>
>> No, that does not affect the programming of the controller. The reason
>> for the instance name extension in compatible string is to match the
>> gpio_chip with a gpio controller node. When matched, the of_node
>> pointer of the gpio_chip is set to point to that controller node.
>>
>> This might not be the best possible implementation but the device tree
>> support code in this patch is dictated by the structure of the
>> existing gpio driver code. As you suggested previously, I will look at
>> reworking the gpio driver a little later but for now, there was a need
>> for working gpio dt solution to make progress on dt support for other
>> controllers.
>
> Linux should provide clues about what's needed in a binding, but the
> binding should not be defined based on current Linux code. Doing the
> binding one way and changing it later is not a good plan.

Ok. When starting on this, two compatible values where used for the
gpio controllers, one was "samsung,exynos4-gpio" and another was
"samsung,exynos4-gpio-<ctrl_name>". And when the gpio dt support would
mature, the second compatible value could be dropped. Non-linux
platforms could always use the generic "samsung,exynos4-gpio"
compatible value to match. I moved to using only
"samsung,exynos4-gpio-<ctrl_name>" just before sending this patch
because I was not sure of the right approach.

>
> I think you need to convert all users of gpio over as well so you can
> move to dynamic gpio_chip creation and gpio numbering. Or maybe you can
> match based on base address? This is going to be a common problem as
> gpio is converted over to DT. Perhaps Grant or others have suggestions
> on the approach to use.

Yes, I agree with you about the dynamic gpio_chip creation and gpio
numbering. Probably, I should have focussed more on this before moving
to dt support for other controllers.

But matching based on base address is still an option if that is
better than matching with compatible values as defined currently. The
'struct samsung_gpio_chip' which encapsulates 'struct gpio_chip' has
information about the base address of the gpio controller. The match
of gpio device node with 'struct gpio_chip' can be quickly moved over
to base address matching. Would this be better than the current
approach?

Thank you for your comments Rob.

Regards,
Thomas.

>
> Rob
>
