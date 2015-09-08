From: vaibhav.hiremath@linaro.org (Vaibhav Hiremath)
Date: Tue, 8 Sep 2015 20:37:11 +0530
Subject: [PATCH-v2 4/7] mmc: sdhci-pxav3: Add pinctl setting according to
 bus clock
In-Reply-To: <CACRpkdY59roEBgUd9TR39yNgfhw393+WmHQQAeLkOEZLChOcWQ@mail.gmail.com>
References: <1441624721-15612-1-git-send-email-vaibhav.hiremath@linaro.org>
 <1441624721-15612-5-git-send-email-vaibhav.hiremath@linaro.org>
 <CACRpkdY59roEBgUd9TR39yNgfhw393+WmHQQAeLkOEZLChOcWQ@mail.gmail.com>
Message-ID: <55EEF99F.1020904@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Tuesday 08 September 2015 08:12 PM, Linus Walleij wrote:
> On Mon, Sep 7, 2015 at 1:18 PM, Vaibhav Hiremath
> <vaibhav.hiremath@linaro.org> wrote:
>
>> Different bus clock may need different pin setting.
>> For example, fast bus clock like 208Mhz need pin drive fast
>> while slow bus clock prefer pin drive slow to guarantee
>> signal quality.
>>
>> So this patch creates two states,
>>    - Default (slow/normal) pin state
>>    - And fast pin state for higher freq bus speed.
>>
>> And selection of pin state is done based on timing mode.
>>
>> Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
>> Signed-off-by: Kevin Liu <kliu5@marvell.com>
> (...)
>> +       pxa->pinctrl = devm_pinctrl_get(dev);
>> +       if (!IS_ERR(pxa->pinctrl)) {
>> +               pxa->pins_default = pinctrl_lookup_state(pxa->pinctrl, "default");
>> +               if (IS_ERR(pxa->pins_default))
>> +                       dev_err(dev, "could not get default pinstate\n");
>> +               pxa->pins_fast = pinctrl_lookup_state(pxa->pinctrl, "fast");
>> +               if (IS_ERR(pxa->pins_fast))
>> +                       dev_info(dev, "could not get fast pinstate\n");
>> +       }
>
> This is exactly how I think it should be used from a pin control
> point of view.
>
> If you depended on CONFIG_PM you could use
> pinctrl_pm_select_default_state() but for this simple scenario
> this is fine.
>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>  From a pinctrl point of view.
>


Thanks for your review.

Linus,

I agree this is how it should be used.
But I still have one small doubt on expectation from
devm_pinctrl_get() function.


If pinctrl properties are not populated in Devicetree node,
then, shouldn't devm_pinctrl_get() return error ?
I followed the code flow, and it seems even if pinctrl properties are
not populated in DT node, the devm_pinctrl_get() returns valid
pointer to "struct pinctrl", isn't this against the expectation of the
call?


Code flow -

devm_pinctrl_get()
...
--> creat_pinctrl()
--> pinctrl_dt_to_map()
...



pinctrl_dt_to_map() iterates for pinctrl-x (x = 0,1,...) and if it
founds the entry then it parses the node. If it doesn't find any
pinctrl property then also it returns 0. and subsequently rreturns
handle to "struct pinctrl" for the device. Why is so?


Thanks,
Vaibhav
