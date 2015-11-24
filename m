From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Tue, 24 Nov 2015 17:21:31 +0200
Subject: [PATCH v4 2/6] mfd: axp20x: Split the driver into core and i2c
 bits
In-Reply-To: <CAGb2v6592Yvh0=Q3=fgzj8AdRb37D4mRj0vnyJ3gXqGFBv2saw@mail.gmail.com>
References: <1448336916-31212-1-git-send-email-wens@csie.org>
 <1448336916-31212-3-git-send-email-wens@csie.org>
 <CAHp75VesF5M6nJf6eaBO+Dg6nC3gj=rzL9YnQFAysQ4NFgOMHg@mail.gmail.com>
 <CAGb2v65EH8sP_ONASZ5gWZXi1D0GqiJvT=X0ieYWehnfqM1Z=A@mail.gmail.com>
 <CAHp75VdGAAh56dJRh=ETJLJGFguuw+6mNSfRQ7Br7tAjeZv+3w@mail.gmail.com>
 <CAGb2v6592Yvh0=Q3=fgzj8AdRb37D4mRj0vnyJ3gXqGFBv2saw@mail.gmail.com>
Message-ID: <CAHp75VcPTYfnN4xj5d3Z51qtJ5CyK5U3T7qyfmXU4PcrqSHXgg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 24, 2015 at 5:09 PM, Chen-Yu Tsai <wens@csie.org> wrote:
> On Tue, Nov 24, 2015 at 8:35 PM, Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
>> On Tue, Nov 24, 2015 at 1:28 PM, Chen-Yu Tsai <wens@csie.org> wrote:
>>> On Tue, Nov 24, 2015 at 5:37 PM, Andy Shevchenko
>>> <andy.shevchenko@gmail.com> wrote:
>>>> On Tue, Nov 24, 2015 at 5:48 AM, Chen-Yu Tsai <wens@csie.org> wrote:
>>>>> The axp20x driver assumes the device is i2c based. This is not the
>>>>> case with later chips, which use a proprietary 2 wire serial bus
>>>>> by Allwinner called "Reduced Serial Bus".
>>>>>
>>>>> This patch follows the example of mfd/wm831x and splits it into
>>>>> an interface independent core, and an i2c specific glue layer.
>>>>> MFD_AXP20X and the new MFD_AXP20X_I2C are changed to tristate
>>>>> symbols, allowing the driver to be built as modules.
>>>>>
>>>>> Included but unused header files are removed as well.
>>
>> So?
>>
>>>>> +       if (dev->of_node) {
>>>>
>>>> What about
>>>>
>>>> if (?of_node) {
>>>>       const struct of_device_id *id;
>>>> ?
>>>> } else if ACPI_COMPANION(?) {
>>
>> This should be has_acpi_companion().
>
> I don't think the "else if" is necessary. There's only 2 possible ways
> the device gets probed, either device tree or ACPI.

OK.

It would be ideal to move to unified device properties API at some
point, but it's out of scope of this series anyway.

>
>>>>       const struct acpi_device_id *id;
>>>> ?
>>>> } else {
>>>>  return -ENODEV;
>>>> }
>>>
>>> I really don't want to change code that I'm just moving around.
>>> Same goes for the other comments about this patch. I can do another
>>> patch on top of this to fix the style issues if it really bothers
>>> people.
>>
>> Fair enough.
>> My comments mostly about unnecessity of second parameter in the functions.
>>
>> So,  you already did some clean up in this patch (above), what about
>> to do another? I also prefer separate patch *before* you do a split.
>
> Sure. I'll do a patch or 2 before the split. Would you mind if I add your
> Suggested-by tag?

I would not.

-- 
With Best Regards,
Andy Shevchenko
