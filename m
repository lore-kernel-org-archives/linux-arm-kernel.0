From: adrian.hunter@intel.com (Adrian Hunter)
Date: Tue, 14 Jun 2016 10:07:06 +0300
Subject: [PATCH 05/12] mmc: sdhci: add a pre voltage switch callback
 function
In-Reply-To: <D7CF8A19-9181-4A97-90AF-AC5A6517CE2B@marvell.com>
References: <1465456218-28354-1-git-send-email-gregory.clement@free-electrons.com>
 <1465456218-28354-6-git-send-email-gregory.clement@free-electrons.com>
 <575E72DC.5090604@intel.com>
 <D7CF8A19-9181-4A97-90AF-AC5A6517CE2B@marvell.com>
Message-ID: <575FAD1A.6090407@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13/06/16 17:04, Ziji Hu wrote:
> Hi Adrian,
> 
> Thanks a lot for the suggestion. I'm from Marvell Xenon SDHC team. Most
> of sdhci host ops are still used in our driver. We just change or add few
> ops. Thus, if we create our own mmc_host_ops, many static sdhci host ops
> will be exported. I would like to know whether such a modification can be
> accepted or not.
> 
> I notice that community is improving sdhci. Thus all the static sdhci ops
> called outside the sdhci.c will be exported. Is my understanding
> correct? Thank you.

The aim is to make sdhci more like a library and give more control to the
drivers.  That will mean more sdhci functions get exported, particularly mmc
host ops like sdhci_set_ios() or sdhci_start_signal_voltage_switch().

> 
> Best regards, Hu Ziji
> 
>>> ? 2016?6?13??16:52?Adrian Hunter <adrian.hunter@intel.com> ???
>>> 
>>> On 09/06/16 10:10, Gregory CLEMENT wrote: From: Victor Gu
>>> <xigu@marvell.com>
>>> 
>>> Some host controller such as Xenon needs additional setting when 
>>> switching signal voltage in eMMC mode. They also need to re-enable 
>>> internal clock before a voltage switch.
>>> 
>>> This commit adds a callback routine "voltage_switch_pre" in the
>>> struct sdhci_ops, which is used by some host controllers which need
>>> re-enable the internal clock before a voltage switch.
>> 
>> Don't want to add sdhci host ops for the "do something before a mmc
>> host op" case.
>> 
>> Instead, export sdhci_start_signal_voltage_switch() and  hook 
>> host->mmc_host_ops.start_signal_voltage_switch. Then in sdhci-xenon.c:
>> 
>> int xenon__start_signal_voltage_switch(struct mmc_host *mmc, struct
>> mmc_ios *ios) { blah blah return sdhci_start_signal_voltage_switch(mmc,
>> ios); }
>> 
>> 
>>> 
>>> [gregory.clement at free-electrons.com: split the initial commit and 
>>> reformulate the log]
>>> 
>>> Signed-off-by: Victor Gu <xigu@marvell.com> Signed-off-by: Marcin
>>> Wojtas <mw@semihalf.com> Signed-off-by: Gregory CLEMENT
>>> <gregory.clement@free-electrons.com> --- drivers/mmc/host/sdhci.c | 4
>>> ++++ drivers/mmc/host/sdhci.h | 1 + 2 files changed, 5 insertions(+)
>>> 
>>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c 
>>> index b07219426d39..cad03ffa9d9b 100644 ---
>>> a/drivers/mmc/host/sdhci.c +++ b/drivers/mmc/host/sdhci.c @@ -1729,6
>>> +1729,10 @@ static int sdhci_start_signal_voltage_switch(struct
>>> mmc_host *mmc, if (host->version < SDHCI_SPEC_300) return 0;
>>> 
>>> +    /* Some controller need to do more before switching */ +    if
>>> (host->ops->voltage_switch_pre) +
>>> host->ops->voltage_switch_pre(host); + ctrl = sdhci_readw(host,
>>> SDHCI_HOST_CONTROL2);
>>> 
>>> switch (ios->signal_voltage) { diff --git a/drivers/mmc/host/sdhci.h
>>> b/drivers/mmc/host/sdhci.h index 49c6c5b0e33b..6bec1b0368d2 100644 
>>> --- a/drivers/mmc/host/sdhci.h +++ b/drivers/mmc/host/sdhci.h @@
>>> -550,6 +550,7 @@ struct sdhci_ops { unsigned int max_dtr, int
>>> host_drv, int card_drv, int *drv_type); void    (*init_card)(struct
>>> sdhci_host *host, struct mmc_card *card); +    void
>>> (*voltage_switch_pre)(struct sdhci_host *host); };
>>> 
>>> #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
>> 
>> -- To unsubscribe from this list: send the line "unsubscribe linux-mmc"
>> in the body of a message to majordomo at vger.kernel.org More majordomo
>> info at  http://vger.kernel.org/majordomo-info.html
