From: kmpark@infradead.org (Kyungmin Park)
Date: Fri, 11 Jun 2010 17:18:42 +0900
Subject: [PATCH] sdhci-s3c: Add SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK quirk
	for Samsung SoC
In-Reply-To: <003901cb093d$3dd14110$b973c330$%kim@samsung.com>
References: <1276169991-16396-1-git-send-email-kgene.kim@samsung.com>
	<AANLkTim2LzIh7dadCAWCo6jltS4CYA8gLKaiQne_VzqK@mail.gmail.com>
	<003901cb093d$3dd14110$b973c330$%kim@samsung.com>
Message-ID: <AANLkTilyfUvwRUP1M1HD5r_cx3PWxDG9SbmqZd6M1MT1@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 11, 2010 at 5:08 PM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> Kyungmin Park wrote:
>>
>> Hi,
>>
>> On Thu, Jun 10, 2010 at 8:39 PM, Kukjin Kim <kgene.kim@samsung.com> wrote:
>> > From: Lee Hyuk <hyuk1.lee@samsung.com>
>> >
>> > On Samsung's SDMMC hosts the timeout clock is derivied from the SD
>> > Clock, which is set dynamically.
>> > So, checked 'SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK' quirk and removed
>> > 'sdhci_s3c_get_timeout_clk' callback which doesn't need any more.
>> >
>> > Signed-off-by: Hyuk Lee <hyuk1.lee@samsung.com>
>> > Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
>> > ---
>> > ?drivers/mmc/host/sdhci-s3c.c | ? 10 +++-------
>> > ?1 files changed, 3 insertions(+), 7 deletions(-)
>> >
>> > diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
>> > index af21792..ca09382 100644
>> > --- a/drivers/mmc/host/sdhci-s3c.c
>> > +++ b/drivers/mmc/host/sdhci-s3c.c
>> > @@ -110,11 +110,6 @@ static unsigned int sdhci_s3c_get_max_clk(struct
>> sdhci_host *host)
>> > ? ? ? ?return max;
>> > ?}
>> >
>> > -static unsigned int sdhci_s3c_get_timeout_clk(struct sdhci_host *host)
>> > -{
>> > - ? ? ? return sdhci_s3c_get_max_clk(host) / 1000000;
>> > -}
>> > -
>> > ?/**
>> > ?* sdhci_s3c_consider_clock - consider one the bus clocks for current
> setting
>> > ?* @ourhost: Our SDHCI instance.
>> > @@ -188,7 +183,6 @@ static void sdhci_s3c_set_clock(struct sdhci_host
> *host,
>> unsigned int clock)
>> >
>> > ? ? ? ? ? ? ? ?ourhost->cur_clk = best_src;
>> > ? ? ? ? ? ? ? ?host->max_clk = clk_get_rate(clk);
>> > - ? ? ? ? ? ? ? host->timeout_clk = sdhci_s3c_get_timeout_clk(host);
>> >
>> > ? ? ? ? ? ? ? ?ctrl = readl(host->ioaddr + S3C_SDHCI_CONTROL2);
>> > ? ? ? ? ? ? ? ?ctrl &= ~S3C_SDHCI_CTRL2_SELBASECLK_MASK;
>> > @@ -211,7 +205,6 @@ static void sdhci_s3c_set_clock(struct sdhci_host
> *host,
>> unsigned int clock)
>> >
>> > ?static struct sdhci_ops sdhci_s3c_ops = {
>> > ? ? ? ?.get_max_clock ? ? ? ? ?= sdhci_s3c_get_max_clk,
>> > - ? ? ? .get_timeout_clock ? ? ?= sdhci_s3c_get_timeout_clk,
>> > ? ? ? ?.set_clock ? ? ? ? ? ? ?= sdhci_s3c_set_clock,
>> > ?};
>> >
>> > @@ -335,6 +328,9 @@ static int __devinit sdhci_s3c_probe(struct
>> platform_device *pdev)
>> > ? ? ? ?host->quirks |= (SDHCI_QUIRK_32BIT_DMA_ADDR |
>> > ? ? ? ? ? ? ? ? ? ? ? ? SDHCI_QUIRK_32BIT_DMA_SIZE);
>> >
>> > + ? ? ? /* HSMMC on Samsung SoCs uses SDCLK as timeout clock. */
>> > + ? ? ? host->quirks |= SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK;
>>
>> How do you know Samsung SoCs use SDCLK in the spec?
>>
> Samsung SoC hardware engineer guided about that.

Of course H/W team know it. they made it. I mean how can we know it at Spec?

If MMC developer don't know the samsung socs well, then how to set it
quirk from Spec.

Thank you,
Kyungmin Park

>
>> Is it also true at s3c64xx series?
>>
> Yes, of course.
>
>
>
>>
>> > +
>> > ? ? ? ?ret = sdhci_add_host(host);
>> > ? ? ? ?if (ret) {
>> > ? ? ? ? ? ? ? ?dev_err(dev, "sdhci_add_host() failed\n");
>> > --
>> > 1.6.2.5
>> >
>> > --
>
> Thanks.
>
> Best regards,
> Kgene.
> --
> Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
> SW Solution Development Team, Samsung Electronics Co., Ltd.
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at ?http://vger.kernel.org/majordomo-info.html
>
