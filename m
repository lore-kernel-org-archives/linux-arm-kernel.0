From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Mon, 5 Sep 2011 13:59:05 +0530
Subject: [PATCH 1/2] mmc: sdhci-s3c: add default controller configuration
In-Reply-To: <001701cc6b8a$e6a78960$b3f69c20$%kim@samsung.com>
References: <1314976702-19284-1-git-send-email-thomas.abraham@linaro.org>
	<1314976702-19284-2-git-send-email-thomas.abraham@linaro.org>
	<001701cc6b8a$e6a78960$b3f69c20$%kim@samsung.com>
Message-ID: <CAJuYYwSibC1CX4NTaQ6z3Q6_TkreKgLwbY2g8TWVSV44pwzTjw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Mr. Kim,

On 5 September 2011 10:46, Kukjin Kim <kgene.kim@samsung.com> wrote:
> Thomas Abraham wrote:
>>
>> The default controller configuration which was previously setup by
>> platform helper functions is moved into the driver.
>>
>> Cc: Ben Dooks <ben-linux@fluff.org>
>> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
>> ---
>> ?drivers/mmc/host/sdhci-s3c.c | ? 28 +++++++++++++++++-----------
>> ?1 files changed, 17 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
>> index 2bd7bf4..d891682 100644
>> --- a/drivers/mmc/host/sdhci-s3c.c
>> +++ b/drivers/mmc/host/sdhci-s3c.c
>> @@ -203,17 +203,23 @@ static void sdhci_s3c_set_clock(struct sdhci_host
> *host,
>> unsigned int clock)
>> ? ? ? ? ? ? ? writel(ctrl, host->ioaddr + S3C_SDHCI_CONTROL2);
>> ? ? ? }
>>
>> - ? ? /* reconfigure the hardware for new clock rate */
>> -
>> - ? ? {
>> - ? ? ? ? ? ? struct mmc_ios ios;
>> -
>> - ? ? ? ? ? ? ios.clock = clock;
>> -
>> - ? ? ? ? ? ? if (ourhost->pdata->cfg_card)
>> - ? ? ? ? ? ? ? ? ? ? (ourhost->pdata->cfg_card)(ourhost->pdev, host-
>> >ioaddr,
>> - ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?&ios, NULL);
>> - ? ? }
>> + ? ? /* reprogram default hardware configuration */
>> + ? ? writel(S3C64XX_SDHCI_CONTROL4_DRIVE_9mA,
>> + ? ? ? ? ? ? host->ioaddr + S3C64XX_SDHCI_CONTROL4);
>
> Since there are above codes on only S5PC100 and S5PV210, I'm not sure above
> is needed on other Samsung SoCs.
>
> I need to sort out checking.


s3c6410, s5p6440, s5p6450 and s5pc110 SoC's include support for clock
out pad driver strength. All other SoC's do not use and list the two
bits as reserved. I do not know if there is any problem writing to
these reserved bits. But I have tested this patch on all the boards
that do not support this feature and it did not break anything.

>
>> +
>> + ? ? ctrl = readl(host->ioaddr + S3C_SDHCI_CONTROL2);
>
> + ? ? ? ctrl &= S3C_SDHCI_CTRL2_SELBASECLK_MASK; ?
>
>> + ? ? ctrl |= (S3C64XX_SDHCI_CTRL2_ENSTAASYNCCLR |
>> + ? ? ? ? ? ? ? S3C64XX_SDHCI_CTRL2_ENCMDCNFMSK |
>> + ? ? ? ? ? ? ? S3C_SDHCI_CTRL2_ENFBCLKRX |
>> + ? ? ? ? ? ? ? S3C_SDHCI_CTRL2_DFCNT_NONE |
>> + ? ? ? ? ? ? ? S3C_SDHCI_CTRL2_ENCLKOUTHOLD);
>> + ? ? writel(ctrl, host->ioaddr + S3C_SDHCI_CONTROL2);
>> +
>> + ? ? /* reconfigure the controller for new clock rate */
>> + ? ? ctrl = (S3C_SDHCI_CTRL3_FCSEL1 | S3C_SDHCI_CTRL3_FCSEL0);
>> + ? ? if (clock < 25 * 1000000)
>> + ? ? ? ? ? ? ctrl |= (S3C_SDHCI_CTRL3_FCSEL3 |
>> S3C_SDHCI_CTRL3_FCSEL2);
>> + ? ? writel(ctrl, host->ioaddr + S3C_SDHCI_CONTROL3);
>> ?}
>>
>> ?/**
>> --
>
> Basically, it's good to move common codes and to remove that. But I'm not
> sure we don't _really_ need to keep SoC specific control function such as
> cfg_card().

The existing cfg_card callback functions have the same functionality
except for setting the clock out drive strength on those SoC's which
do not support this feature. If writing to those reserved bits does
not cause any issues, then the cfg_card function can be made common to
all Samsung SoC's.

Since the functionality of cfg_card callback is SoC specific and not
board specific, there is another way of doing this. The id_table
member could be added to the platform_driver structure in sdhci-s3c
driver. Each SoC platform code could set the name of the sdhci device
during initialization and there could be SoC specific cfg_card
functions included in the sdhci-s3c driver itself. This would be
required only if there is a problem by writing to the reserved bits in
control4 register. But testing does not show any issues writing to
these reserved bits.

The main intention of moving the cfg_card function from platform code
to driver code is to remove the callback function pointer from the
sdhci driver platform data which is very important to get full device
tree support for sdhci-s3c driver.

Thanks for your review and comments.

Regards,
Thomas.

>
> Thanks.
>
> Best regards,
> Kgene.
> --
> Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
> SW Solution Development Team, Samsung Electronics Co., Ltd.
>
>
