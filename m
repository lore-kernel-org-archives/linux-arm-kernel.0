From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Mon, 22 Apr 2013 08:58:00 +0800
Subject: gpio-pxa initcall level change and machine init breakage
In-Reply-To: <517466F6.3000003@newsguy.com>
References: <5172B398.7060706@newsguy.com>
 <CAD6h2NSRA9w7GZLQGgK-+TvEAsxwOHow5_26JyVUA6YQyj3OQg@mail.gmail.com>
 <517466F6.3000003@newsguy.com>
Message-ID: <CAD6h2NSy0=3P-PHdCiJJQG_jvGaFnr7uex+Uxs=0F-VsUxtPWg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22 April 2013 06:23, Mike Dunn <mikedunn@newsguy.com> wrote:
> On 04/20/2013 11:02 PM, Haojian Zhuang wrote:
>> On 20 April 2013 23:26, Mike Dunn <mikedunn@newsguy.com> wrote:
>>> Hi,
>>>
>>> After a few months of neglect, I rebased my palm treo 680 kernel with the latest
>>> from Linus' official tree, and now all the calls to gpio lib functions
>>> (gpio_request(), etc) made from the init_machine() method in struct machine_desc
>>> fail.  I tracked this back to commit 6c7e660a27da7494c670bfba21cfeba30457656c
>>> dated Jan 23 2013
>>>
>>>     gpio: pxa: set initcall level to module init
>>>
>>>     gpio & pinctrl driver are used together. The pinctrl driver is already
>>>     launched before gpio driver in Makefile. So set gpio driver to module
>>>     init level. Otherwise, the sequence will be inverted.
>>>
>>>     Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
>>>     Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>>>
>>> At the time, Haojian addressed a question about this patch regarding module
>>> dependencies, advising use of the deferred probe infrastructure.  But unless I'm
>>> mistaken, mine is an initcall level problem, not a dependency issue among driver
>>> probes.  Now that gpio-pxa initialization is at the device level (initcall6),
>>> calls to gpiolib are no longer possible from init_machine(), which remains at
>>> the initcall3 level.
>>>
>>> I feel like I must be missing something, because a lot of pxa boards call
>>> gpiolib from init machine(), so my breakage should not be an isolated case.
>>>
>>> If I'm not missing anything and the patch is necessary, it looks like one
>>> solution would be to move all the initializations that use gpiolib to the
>>> init_late method in struct machine_desc, which runs as initcall7.
>>>
>>> Grateful for any advice!
>>>
>>> Thanks,
>>> Mike
>>
>> Actually gpio request should be handled in the driver, not machine platform
>> driver. For example, lcd init may request gpio. pxafb.c provides the callback
>> to handle it. We need to move code of requesting gpio into the callback.
>
>
> Yes, I see.  Thanks for the example.
>
>
>>
>> Since this change breaks current platform, we have to revert it. We still need
>> a code cleanup in arch-pxa directory.
>
>
> I knew some cleanup was needed to the palm stuff, but didn't realize the extent.
>  Should not be too difficult; I hope to have patches soon.  But there are other
> pxa boards that grab various gpios in init_machine() and may not be as
> straightforward.
>
>
>>
>> Linus,
>> Could you help to revert this commit? Or do I need to send a revert commit
>> to you?
>
>
> Will the big guy see this?  Only posted to linux-arm-kernel ML.
>
> Thanks Haojian,
> Mike

Sorry, I forgot to loop him in.

Linus,
Should I send the revert commit to you? Or will you revert it directly?

Regards
Haojian
