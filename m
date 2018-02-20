From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Tue, 20 Feb 2018 21:39:11 +0200
Subject: [PATCH 2/2] i2c: add support for Socionext SynQuacer I2C
 controller
In-Reply-To: <CAKv+Gu8A1YKr5t0B=Fe2sF6+QT9iCVeRW+99K37g22viEoismA@mail.gmail.com>
References: <20180220090827.913-1-ard.biesheuvel@linaro.org>
 <20180220090827.913-3-ard.biesheuvel@linaro.org>
 <CAHp75VeUJpXLpL55erp+uoMH4jqppoG5zTt1DcffqNYPsJMdUQ@mail.gmail.com>
 <CAKv+Gu8A1YKr5t0B=Fe2sF6+QT9iCVeRW+99K37g22viEoismA@mail.gmail.com>
Message-ID: <CAHp75Vd=dww8AQM4tC5Z38i4PNaV4vxMFsTf=ozJ1Yw3Gd9DWg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 20, 2018 at 8:04 PM, Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
> On 20 February 2018 at 14:02, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
>> On Tue, Feb 20, 2018 at 11:08 AM, Ard Biesheuvel
>> <ard.biesheuvel@linaro.org> wrote:

>>> +/* SPDX-License-Identifier: GPL-2.0 */
>>
>> Shouldn't be // ?

> IIUC, this applies to .h files only, and /* */ is preferred for .c files.

Other way around.

Documentation/process/license-rules.rst

>>> +#define WAIT_PCLK(n, rate)     ndelay((((1000000000 +  (rate) - 1) / \
>>> +                                        (rate) + n - 1) / n) + 10)
>>
>> This split makes it harder to catch the calculus.
>> Also, you can use DIV_ROUND_UP(), though it longer, but adds a bit of
>> clarity to the calculus.

> Yeah. This was present in the original code, and I tried to avoid
> touching it :-)

Yeah, but below there are several instances with DIV_ROUND_UP().

>>> +static void synquacer_i2c_stop(struct synquacer_i2c *i2c, int ret)
>>> +{
>>> +       dev_dbg(i2c->dev, "STOP\n");
>>
>> Hmm... Can't use FTRACE ?

> What do you mean?

The message kinda useless, esp. if you can enable functional tracing.
I saw a lot of debugging messages in the code, perhaps it makes sense
at some point to make some trace points in I2C core and leave only HW
related here.

>>> +       if (dev_of_node(&pdev->dev)) {
>>> +               i2c->clk = devm_clk_get(&pdev->dev, "pclk");
>>> +               if (IS_ERR(i2c->clk)) {
>>> +                       dev_err(&pdev->dev, "cannot get clock\n");
>>> +                       return PTR_ERR(i2c->clk);
>>> +               }
>>> +               dev_dbg(&pdev->dev, "clock source %p\n", i2c->clk);
>>> +
>>> +               i2c->clkrate = clk_get_rate(i2c->clk);
>>> +               dev_dbg(&pdev->dev, "clock rate %d\n", i2c->clkrate);
>>> +               clk_prepare_enable(i2c->clk);
>>> +       } else {
>>
>>> +               ret = device_property_read_u32(&pdev->dev,
>>> +                                              "socionext,pclk-rate",
>>> +                                              &i2c->clkrate);
>>
>> I suppose for ACPI we just register a fixed rate clock and use it in
>> the driver in the same way as in OF case.
>> I guess at some point we even can provide a generic clock provider for
>> ACPI based on rate property.

> Is there a question here? Do you want me to change anything?

Is it opener for discussion. At least in the drivers we have done for
x86 we do the way I described.

See, for example, drivers/mfd/intel-lpss.c

-- 
With Best Regards,
Andy Shevchenko
