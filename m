From: abrestic@chromium.org (Andrew Bresticker)
Date: Mon, 23 Sep 2013 14:36:08 -0700
Subject: [PATCH 1/6] clk: exynos-audss: convert to platform device
In-Reply-To: <1736317.9RH9hT0fWO@flatron>
References: <1379711637-5226-1-git-send-email-abrestic@chromium.org>
 <1530327.jvk44KuFQA@flatron>
 <CAL1qeaGjUTrfDaAr1rgsgDaZscjaV7tqi3Jd_-zo2sMtCCFSAQ@mail.gmail.com>
 <1736317.9RH9hT0fWO@flatron>
Message-ID: <CAL1qeaEGpYgM8kjgSCtBwLqahzvrbD9DVNPSb+qEY=-NmGsghA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 23, 2013 at 2:30 PM, Tomasz Figa <tomasz.figa@gmail.com> wrote:
> On Monday 23 of September 2013 14:25:12 Andrew Bresticker wrote:
>> >> +static int __init exynos_audss_clk_init(void)
>> >> +{
>> >> +     return platform_driver_register(&exynos_audss_clk_driver);
>> >> +}
>> >> +core_initcall(exynos_audss_clk_init);
>> >
>> > Does it need to be core_initcall? Drivers depending on clocks provided
>> > by this driver should be able to defer probing if they are probed
>> > before this driver.
>>
>> Unfortunately there are a couple of issues with making this a
>> module_initcall: 1. On the Exynos5420, the AudioSS block provides the
>> apb_pclk gate for the ADMA bus, which is probed at postcore_initcall
>> time and does not support deferred probing, and
>
> Just out of curiosity, what is this ADMA bus?

It's the DMA controller used for PCM and I2S.  Looks like the DMA
nodes aren't in the 5420 device-tree yet...

-Andrew
