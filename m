From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 7 May 2017 21:23:58 +0200
Subject: [PATCH 2/2] reset: Add a Gemini reset controller
In-Reply-To: <1493109822.2394.15.camel@pengutronix.de>
References: <20170424192802.27430-1-linus.walleij@linaro.org>
 <1493109822.2394.15.camel@pengutronix.de>
Message-ID: <CACRpkdaRkWY7qF43-XxOPu5h0cR3_w3ydHs3Ln-Oay+bzw4JWA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 25, 2017 at 10:43 AM, Philipp Zabel <p.zabel@pengutronix.de> wrote:
> [Me]
>> +/*
>> + * Cortina Gemini Reset controller driver
>> + * Copyright (c) 2017 Linus Walleij <linus.walleij@linaro.org>
>
> No license statement, choice or oversight?

Choice. I'm one of those guys who think that the top-level COPYING file
in the kernel is by far enough of legalese. If you want, I can put in a license
of course.

>> +struct gemini_reset {
>> +     struct regmap *map;
>> +     struct device *dev;
>
> dev is unused, can be dropped.

OK

> BIT(30) is called CPU1 reset in the DT binding, maybe add a #define?

OK I have the new .h file that Rob asked for.

>> +static int gemini_reset_probe(struct platform_device *pdev)
>> +{
>> +     struct gemini_reset *gr;
>> +     struct device *dev = &pdev->dev;
>> +     struct device_node *np = dev->of_node;
>> +     struct device_node *parent_np = np->parent;
>> +     int ret;
>> +
>> +     if (!parent_np) {
>
> Is this even possible?

Goes away anyways when i fuse the syscon and reset controller
as Rob suggested.

>> +     if (IS_ERR(gr->map)) {
>> +             dev_err(dev, "unable to get regmap");
>
> It might be helpful to print the error code here.

OK.

>> +     ret = devm_reset_controller_register(&pdev->dev, &gr->rcdev);
>> +     if (ret)
>> +             return ret;
>> +
>> +     dev_info(dev, "registered Gemini reset controller\n");
>
> This is a bit verbose. I'd remove it and shorten the last part to:
>
>         return devm_reset_controller_register(&pdev->dev, &gr->rcdev);

It's always this thing whether to be in the camp that like drivers to announce
themselves or not, but I can do as you suggest if it's a strong preference.

The reason I want it is: deselect the driver from Kconfig, something stops
working. Compare the dmesg: they both look the same. You don't immediately
see that something is missing.

So some people think that it is time to go around in /sys, and then what
if it is a boot regression, like the system can't mount root without the
reset controller. (Yeah I know, the thing mounting root should select the
reset controller then, OK another bug we would have seen with this...)

And then all of a sudden there is a lot of debug time spent looking for this
fact that would be spotted in no time if the was a dev_info() about the
driver being probed.

But if you insist, I will remove it.

Yours,
Linus Walleij
