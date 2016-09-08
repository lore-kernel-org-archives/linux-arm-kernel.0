From: pku.leo@gmail.com (Leo Li)
Date: Thu, 8 Sep 2016 18:57:40 -0500
Subject: [PATCH v5] i2c: imx: make bus recovery through pinctrl optional
In-Reply-To: <8f8f7ffc4aef513ef5064ba0491fbc63@agner.ch>
References: <1471644322-22670-1-git-send-email-leoyang.li@nxp.com>
 <20160906185849.27pjhawadca5pwow@pengutronix.de>
 <CADRPPNQ+1qBNL5WA=Jo_keE7BPnoOs7a2T6CpTuciiF16qK6xQ@mail.gmail.com>
 <87ca69fb85848a0a86b34a9a9037a57b@agner.ch>
 <CADRPPNSPye45bmFshfwb+gDA0x0ygs4Ofa6HMYbKt9ER0oeccg@mail.gmail.com>
 <8f8f7ffc4aef513ef5064ba0491fbc63@agner.ch>
Message-ID: <CADRPPNR4oiRVgFqaM=1=Zn_JzrVJDVmozWsouLByXRtaHCh=qQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 8, 2016 at 5:39 PM, Stefan Agner <stefan@agner.ch> wrote:
> On 2016-09-06 15:40, Leo Li wrote:
>> On Tue, Sep 6, 2016 at 4:51 PM, Stefan Agner <stefan@agner.ch> wrote:
>>> On 2016-09-06 13:06, Leo Li wrote:
>>>> On Tue, Sep 6, 2016 at 1:58 PM, Uwe Kleine-K?nig
>>>> <u.kleine-koenig@pengutronix.de> wrote:
>>>>> On Fri, Aug 19, 2016 at 05:05:22PM -0500, Li Yang wrote:
> <snip>
>>>>>> @@ -1081,8 +1090,11 @@ static int i2c_imx_probe(struct platform_device *pdev)
>>>>>>               return ret;
>>>>>>       }
>>>>>>
>>>>>> +     /* optional bus recovery feature through pinctrl */
>>>>>>       i2c_imx->pinctrl = devm_pinctrl_get(&pdev->dev);
>>>>>> -     if (IS_ERR(i2c_imx->pinctrl)) {
>>>>>> +     /* bailout on -ENOMEM or -EPROBE_DEFER, continue for other errors */
>>>>>> +     if (PTR_ERR(i2c_imx->pinctrl) == -ENOMEM ||
>>>>>> +                     PTR_ERR(i2c_imx->pinctrl) == -EPROBE_DEFER) {
>>>>>>               ret = PTR_ERR(i2c_imx->pinctrl);
>>>>>>               goto clk_disable;
>>>>>>       }
>>>>>
>>>>> devm_pinctrl_get might return the following error-valued pointers:
>>>>>  - -EINVAL
>>>>>  - -ENOMEM
>>>>>  - -ENODEV
>>>>>  - -EPROBE_DEFER
>>>>>
>>>>> There are several error paths returning -EINVAL, one is when an invalid
>>>>> phandle is used. Do you really want to ignore that?
>>>>>
>>>>> IMO error handling is better done with inverse logic, that is continue
>>>>> on some explicit error, bail out on all unknown stuff. This tends to be
>>>>> more robust. Also the comment should be improved to not explain that for
>>>>> -ENOMEM and -EPROBE_DEFER we bail out (which should be obvious for
>>>>> anyone who can read C) but to explain why.
>>>>
>>>> What you said is true for normal error handling, but in this scenario
>>>> it is intentional to ignore all pinctrl related errors except critical
>>>> ones because failing to have pinctrl for an optional feature shouldn't
>>>> impact the function of normal i2c.  We choose to catch -ENOMEM because
>>>> the error could also cause problem for i2c probe, and -EPROBE_DEFER
>>>> because it's possible that the pinctrl will be ready later and we want
>>>> to give it a chance.  The i2c driver really don't care why the pinctrl
>>>> was not usable.  I thought I added comment before the
>>>
>>> I don't agree. E.g. -EINVAL would appear if you pass devm_pinctrl_get an
>>> invalid device. Currently you would silently ignore that, which is not
>>> what you want.
>>
>> It is not silently ignored, there will be a message printed out saying
>> pinctrl is not available and bus recovery is not supported.  On the
>> contrary, without this change the entire i2c driver fails to work
>> silently if pinctrl is somehow not working.  And if the system is so
>> broken that the pointer to the i2c device is NULL, the probe of i2c
>> would have already failed before this point.  We shouldn't count on an
>> optional function of the driver to catch fundamental issues like this.
>>
>>>
>>> You want to get the pinctrl in any case expect there isn't one. And that
>>> is how you should formulate your if statement.
>>>
>>> /*
>>>  * It is ok if no pinctrl device is available. We'll not be able to use
>>> the
>>>  * bus recovery feature, but otherwise the driver works fine...
>>>  */
>>> if (PTR_ERR(i2c_imx->pinctrl) != -ENODEV)
>>
>> I agree that there could be other possibilities that the pinctrl
>> failed to work beside the reason I described in the commit
>> message(platform doesn't support pinctrl at all).  But I don't think
>> any of them other than the -ENOMEM and -EPROBE_DEFER deserves a bail
>> out for the entire i2c driver.
>
> FWIW, I disagree. If there is pinctrl defined, you want be sure that it
> gets applied properly, no matter what. E.g. when devm_pinctrl_get return
> EINVAL (Uwe's example) the driver will continue and likely fail in
> mysterious ways later on because the pins have not been muxed properly.
> The driver should not load in that situation so that the developer is
> forced to fix his mistakes. The only reason to bail out here is if there
> is no pin controller (ENODEV). And it seems that Uwe also tends to that
> solution.

With this patch the i2c bus recovery feature will be disabled if the
devm_pinctrl_get() fails.  The pin mux setting will not be changed in
either i2c probe stage or at runtime.  I don't think it can cause any
trouble to normal I2C operation.  IMO, it is not good to *force*
people fix problem that they don't really care by deliberately enlarge
the problem.  That's why we don't panic() on any error we found.  For
those who do care about the bus recovery, they can get the information
from the console.

Regards,
Leo
