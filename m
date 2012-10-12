From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 12 Oct 2012 23:09:30 +0200
Subject: [PATCH 2/2] input: gpio-keys: Add runtime support
In-Reply-To: <CAM=Q2ctwTBAvKs401GgrGfz9NvaLspquje-6YfnuS5TZYeqY4Q@mail.gmail.com>
References: <1349964927-18619-1-git-send-email-lee.jones@linaro.org>
 <1349964927-18619-2-git-send-email-lee.jones@linaro.org>
 <CAM=Q2ctwTBAvKs401GgrGfz9NvaLspquje-6YfnuS5TZYeqY4Q@mail.gmail.com>
Message-ID: <CACRpkdb+kWW903VD45i5s_LrZ2BKX=k6enGP2R9v2ptSRkvJ9w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 11, 2012 at 4:22 PM, Shubhrajyoti Datta
<omaplinuxkernel@gmail.com> wrote:

>> @@ -526,6 +527,7 @@ static int gpio_keys_open(struct input_dev *input)
>>  {
>>         struct gpio_keys_drvdata *ddata = input_get_drvdata(input);
>>
>> +       pm_runtime_get_sync(input->dev.parent);
>
> I am not an expert of the runtime.
>
> However would be grateful if you explain me what it actually do.

This increase the reference count of the runtime status container
for the device. _sync makes sure it happens now.

Consult:
Documentation/power/runtime_pm.txt

> Also I did not see any runtime suspend/ resume handlers populated.

It is not necessary to handle the power state at the driver level,
it can just as well be handled by the voltage/power domain,
or at the class, type or bus level.

But the individual driver has to notify the system upward if it
needs to be powered on or when it may or must be relaxed.

Yours,
Linus Walleij
