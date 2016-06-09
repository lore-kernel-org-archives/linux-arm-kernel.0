From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 09 Jun 2016 14:27:16 +0200
Subject: [PATCH 03/12] mmc: tegra: restrict the voltage_switch() callback
 to the 1.8V case
In-Reply-To: <1465466097.18807.7.camel@lynxeye.de> (Lucas Stach's message of
 "Thu, 09 Jun 2016 11:54:57 +0200")
References: <1465456218-28354-1-git-send-email-gregory.clement@free-electrons.com>
 <1465456218-28354-4-git-send-email-gregory.clement@free-electrons.com>
 <1465466097.18807.7.camel@lynxeye.de>
Message-ID: <8737omo8d7.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lucas,
 
 On jeu., juin 09 2016, Lucas Stach <dev@lynxeye.de> wrote:

> Am Donnerstag, den 09.06.2016, 09:10 +0200 schrieb Gregory CLEMENT:
>> Given its name the voltage_switch() should be called for any
>> voltage. However currently it is only called for the 1.8V case.
>> 
>> That means that the current implementation of the callback could have
>> made this assumption. In order to not adding a regression when the
>> voltage_switch() function will be called for the other voltage
>> targets,
>> this patch ensure that the code of the current callback won't be
>> executed
>> for the other case than 1.8V.
>> 
> This isn't necessary, it's fine to re-execute the pad calibration for
> any voltage switch.

Thanks for your feedback, so I can remove this patch from the series.

Gregory

>
> Regards,
> Lucas
>
>> Cc: Lucas Stach <dev@lynxeye.de>
>> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
>> ---
>> ?drivers/mmc/host/sdhci-tegra.c | 4 ++++
>> ?1 file changed, 4 insertions(+)
>> 
>> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-
>> tegra.c
>> index bcc0de47fe7e..01f58296125e 100644
>> --- a/drivers/mmc/host/sdhci-tegra.c
>> +++ b/drivers/mmc/host/sdhci-tegra.c
>> @@ -302,6 +302,10 @@ static void tegra_sdhci_voltage_switch(struct
>> sdhci_host *host)
>> ?	struct sdhci_tegra *tegra_host =
>> sdhci_pltfm_priv(pltfm_host);
>> ?	const struct sdhci_tegra_soc_data *soc_data = tegra_host-
>> >soc_data;
>> ?
>> +	/* initially this function was called only for the 1.8V case
>> */
>> +	if (host->mmc->ios.signal_voltage != MMC_SIGNAL_VOLTAGE_180)
>> +		return;
>> +
>> ?	if (soc_data->nvquirks & NVQUIRK_HAS_PADCALIB)
>> ?		tegra_host->pad_calib_required = true;
>> ?}

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
