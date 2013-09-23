From: sylvester.nawrocki@gmail.com (Sylwester Nawrocki)
Date: Tue, 24 Sep 2013 00:50:29 +0200
Subject: [PATCH 1/6] clk: exynos-audss: convert to platform device
In-Reply-To: <CAL1qeaGjUTrfDaAr1rgsgDaZscjaV7tqi3Jd_-zo2sMtCCFSAQ@mail.gmail.com>
References: <1379711637-5226-1-git-send-email-abrestic@chromium.org>
 <1530327.jvk44KuFQA@flatron>
 <CAL1qeaGjUTrfDaAr1rgsgDaZscjaV7tqi3Jd_-zo2sMtCCFSAQ@mail.gmail.com>
Message-ID: <5240C5B5.4090702@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 09/23/2013 11:25 PM, Andrew Bresticker wrote:
>>> +static int exynos_audss_clk_remove(struct platform_device *pdev)
>>> +{
>>> +     of_clk_del_provider(pdev->dev.of_node);
>>> +
>>> +     return 0;
>>>   }
>>
>> Don't we need to unregister all the registered clocks in remove? This also
>> leads to another question: Do we even need removal support for this
>> driver?
>
> Agreed - I don't think we should support removal of this device, but
> it looks like __device_release_driver() just ignores the lack of a
> remove callback or the return value from remove.  I suppose we could
> just yell that removal is not supported if it is ever attempted.

That might be a good idea, without proper remove() method deferred
probing will also not work. I'd assume there should be only, e.g.
WARN() in the remove() callback or it should be properly implemented,
with clk_unregister() call for each currently registered clock.

Note that clk_unregister() is currently not implemented and removal
of this driver cannot be properly supported at the moment anyway.

Not sure what's more appropriate, it's probably better to add
clk_unregister() calls. This would be effectively a dead code though,
as long as core_initcall is used.

>>> +static int __init exynos_audss_clk_init(void)
>>> +{
>>> +     return platform_driver_register(&exynos_audss_clk_driver);
>>> +}
>>> +core_initcall(exynos_audss_clk_init);
>>
>> Does it need to be core_initcall? Drivers depending on clocks provided by
>> this driver should be able to defer probing if they are probed before this
>> driver.
>
> Unfortunately there are a couple of issues with making this a module_initcall:
>      1. On the Exynos5420, the AudioSS block provides the apb_pclk gate
> for the ADMA bus, which is probed at postcore_initcall time and does
> not support deferred probing, and
>      2. the common clock framework doesn't differentiate between the
> clock not being specified at all and the clock being specified, but
> the provider not being registered yet (i.e. the case where probe
> deferral would be appropriate) - it just returns ENOENT in both cases.

AFAICS this shouldn't be difficult to improve. I guess it has not been
properly addressed so far because there is currently no properly working
modular clock provider drivers, using the common clock framework, yet.
Unless someone bits me to it, I might have a look at that, as I also found
it a bit it inconvenient.

--
Regards,
Sylwester
