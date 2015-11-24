From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Tue, 24 Nov 2015 14:35:49 +0200
Subject: [PATCH v4 2/6] mfd: axp20x: Split the driver into core and i2c
 bits
In-Reply-To: <CAGb2v65EH8sP_ONASZ5gWZXi1D0GqiJvT=X0ieYWehnfqM1Z=A@mail.gmail.com>
References: <1448336916-31212-1-git-send-email-wens@csie.org>
 <1448336916-31212-3-git-send-email-wens@csie.org>
 <CAHp75VesF5M6nJf6eaBO+Dg6nC3gj=rzL9YnQFAysQ4NFgOMHg@mail.gmail.com>
 <CAGb2v65EH8sP_ONASZ5gWZXi1D0GqiJvT=X0ieYWehnfqM1Z=A@mail.gmail.com>
Message-ID: <CAHp75VdGAAh56dJRh=ETJLJGFguuw+6mNSfRQ7Br7tAjeZv+3w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 24, 2015 at 1:28 PM, Chen-Yu Tsai <wens@csie.org> wrote:
> Hi,
>
> On Tue, Nov 24, 2015 at 5:37 PM, Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
>> On Tue, Nov 24, 2015 at 5:48 AM, Chen-Yu Tsai <wens@csie.org> wrote:
>>> The axp20x driver assumes the device is i2c based. This is not the
>>> case with later chips, which use a proprietary 2 wire serial bus
>>> by Allwinner called "Reduced Serial Bus".
>>>
>>> This patch follows the example of mfd/wm831x and splits it into
>>> an interface independent core, and an i2c specific glue layer.
>>> MFD_AXP20X and the new MFD_AXP20X_I2C are changed to tristate
>>> symbols, allowing the driver to be built as modules.
>>>
>>> Included but unused header files are removed as well.

So?

>>> +       if (dev->of_node) {
>>
>> What about
>>
>> if (?of_node) {
>>       const struct of_device_id *id;
>> ?
>> } else if ACPI_COMPANION(?) {

This should be has_acpi_companion().

>>       const struct acpi_device_id *id;
>> ?
>> } else {
>>  return -ENODEV;
>> }
>
> I really don't want to change code that I'm just moving around.
> Same goes for the other comments about this patch. I can do another
> patch on top of this to fix the style issues if it really bothers
> people.

Fair enough.
My comments mostly about unnecessity of second parameter in the functions.

So,  you already did some clean up in this patch (above), what about
to do another? I also prefer separate patch *before* you do a split.

>>> +       axp20x = devm_kzalloc(&i2c->dev, sizeof(*axp20x), GFP_KERNEL);
>>> +       if (!axp20x)
>>> +               return -ENOMEM;
>>> +
>>> +       ret = axp20x_i2c_match_device(axp20x, &i2c->dev);
>>> +       if (ret)
>>> +               return ret;
>>> +
>>> +       axp20x->dev = &i2c->dev;
>>> +       axp20x->irq = i2c->irq;
>>
>> If you move _match_device() here you will be able to drop away struct
>> device * parameter.

-- 
With Best Regards,
Andy Shevchenko
