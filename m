From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 14 Jun 2016 10:19:12 +0200
Subject: [PATCH 09/12] mmc: sdhci-xenon: add initial Xenon eMMC driver
In-Reply-To: <575FA9BF.6070703@intel.com> (Adrian Hunter's message of "Tue, 14
 Jun 2016 09:52:47 +0300")
References: <1465456218-28354-1-git-send-email-gregory.clement@free-electrons.com>
 <1465456218-28354-10-git-send-email-gregory.clement@free-electrons.com>
 <575FA9BF.6070703@intel.com>
Message-ID: <878ty8chdr.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Adrian,
 
 On mar., juin 14 2016, Adrian Hunter <adrian.hunter@intel.com> wrote:

> On 09/06/16 10:10, Gregory CLEMENT wrote:
>> From: Victor Gu <xigu@marvell.com>
>> 
>> This path adds the driver for the Marvell Xenon eMMC host controller
>> which supports eMMC 5.1, SD 3.0.
>> 
>> However this driver supports only up to eMMC 5.0 since the command queue
>> feature is not included (yet) in the driver.
>> 
>> [gregory.clement at free-electrons.com:
>>  - reformulate commit log
>>  - overload the sdhci_set_uhs_signaling function instead of using a quirk
>>  - fix a kconfig dependency
>>  - remove dead code]
>> 
>> Signed-off-by: Victor Gu <xigu@marvell.com>
>> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
>> ---
>>  drivers/mmc/host/Kconfig       |   10 +
>>  drivers/mmc/host/Makefile      |    1 +
>>  drivers/mmc/host/sdhci-xenon.c | 1164 ++++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 1175 insertions(+)
>>  create mode 100644 drivers/mmc/host/sdhci-xenon.c
>> 
>
> <SNIP>
>
>> diff --git a/drivers/mmc/host/sdhci-xenon.c b/drivers/mmc/host/sdhci-xenon.c
>> new file mode 100644
>> index 000000000000..43c06db95872
>> --- /dev/null
>> +++ b/drivers/mmc/host/sdhci-xenon.c
>
> <SNIP>
>
>> +static int sdhci_xenon_delay_adj_test(struct sdhci_host *host,
>> +		struct mmc_card *card, unsigned int delay,
>> +		bool invert, bool phase)
>> +{
>> +	int ret;
>> +	struct mmc_card *oldcard;
>> +
>> +	sdhci_xenon_set_fix_delay(host, delay, invert, phase);
>> +
>> +	/*
>> +	 * If the card is not yet associated to the host, we
>> +	 * temporally do it
>> +	 */
>> +	oldcard = card->host->card;
>> +	if (!oldcard)
>> +		card->host->card = card;
>> +	ret =  card_alive(card);
>
> This looks like an abuse of bus_ops->alive().  You will need to get
> agreement with Ulf how to handle this.  I will wait for Ulf's comments
> before reviewing this patch set further.

Actually I modified this part of the driver to use
bus_ops->alive(). Initially, the alive() code was more or less copied
and paste from the mmc core with ugly include from mmc_ops.h and
sdio_ops.h to make it work. I find it cleaner to directly access the
alive() function.

Could you explain why it is an abuse of  bus_ops->alive()?

Thanks,

Gregory


>> +	card->host->card = oldcard;
>> +	if (ret) {
>> +		pr_debug("Xenon failed when sampling fix delay %d, inverted %d, phase %d\n",
>> +			 delay, invert, phase);
>> +		return -EIO;
>> +	}
>> +
>> +	pr_debug("Xenon succeeded when sampling fixed delay %d, inverted %d, phase %d\n",
>> +		 delay, invert, phase);
>> +	return 0;
>> +}
>
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
