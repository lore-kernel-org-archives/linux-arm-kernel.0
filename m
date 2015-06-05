From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Fri, 5 Jun 2015 10:48:20 +0200
Subject: [PATCH v2 2/2] mmc: sdhci-bcm2835: Actually enable the clock
In-Reply-To: <557110A7.8070705@wwwdotorg.org>
References: <1432933572-8695-1-git-send-email-eric@anholt.net>
 <1432933572-8695-2-git-send-email-eric@anholt.net>
 <557110A7.8070705@wwwdotorg.org>
Message-ID: <CAPDyKFrC-fbfuZEd_OfW0pCVAAV1tENz9xaVs5=pQsJW+08xWw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5 June 2015 at 04:59, Stephen Warren <swarren@wwwdotorg.org> wrote:
> On 05/29/2015 03:06 PM, Eric Anholt wrote:
>> We're currently using a fixed frequency clock specified in the DT, so
>> enabling is a no-op.  However, the RPi firmware-based clocks driver
>> can actually disable unused clocks, so when switching to use it we
>> ended up losing our MMC clock once all devices were probed.
>
>> diff --git a/drivers/mmc/host/sdhci-bcm2835.c b/drivers/mmc/host/sdhci-bcm2835.c
>
>> +     ret = clk_prepare_enable(pltfm_host->clk);
>> +     if (ret) {
>> +             dev_err(&pdev->dev, "failed to enable host clk\n");
>> +             goto err;
>> +     }
>
> Given that pltfm_host is a "struct sdhci_pltfm_host" i.e. a type
> defined/handled by sdhci-pltfm.c , I'm rather surprised that
> sdhci-pltfm.c doesn't do this itself. Wouldn't it make sense for it to
> do so?

We could likely move additional clock management into the sdhci-pltfm.
So we would then remove some duplicated code, but we would potentially
also loose some in flexibility. It's worth an effort to look into.

Please go ahead and have a try. :-)

Kind regards
Uffe
