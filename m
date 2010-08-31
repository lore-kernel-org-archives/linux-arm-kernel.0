From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Tue, 31 Aug 2010 16:35:31 +0200
Subject: [PATCH] MMC: move regulator handling closer to core
In-Reply-To: <4C7C1A2B.1010400@nokia.com>
References: <1283102159-25804-1-git-send-email-linus.walleij@stericsson.com>
	<4C7C1A2B.1010400@nokia.com>
Message-ID: <AANLkTikQupSvmvcd92h6-pcuRM8keZRbU9g2bepq9NC-@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/8/30 Adrian Hunter <adrian.hunter@nokia.com>:

> [Me]
>> diff --git a/drivers/mmc/host/pxamci.c b/drivers/mmc/host/pxamci.c
>> index 0a4e43f..47dae9b 100644
>> --- a/drivers/mmc/host/pxamci.c
>> +++ b/drivers/mmc/host/pxamci.c
>> @@ -99,14 +99,26 @@ static inline void pxamci_init_ocr(struct pxamci_host
>> *host)
>> ? ? ? ?}
>> ?}
>> ?-static inline void pxamci_set_power(struct pxamci_host *host, unsigned
>> int vdd)
>> +static inline void pxamci_set_power(struct pxamci_host *host,
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? unsigned char power_mode,
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? unsigned int vdd)
>> ?{
>> ? ? ? ?int on;
>> ?-#ifdef CONFIG_REGULATOR
>> - ? ? ? if (host->vcc)
>> - ? ? ? ? ? ? ? mmc_regulator_set_ocr(host->vcc, vdd);
>> -#endif
>> + ? ? ? if (host->vcc) {
>> + ? ? ? ? ? ? ? int ret;
>> +
>> + ? ? ? ? ? ? ? if (power_mode == MMC_POWER_UP) {
>> + ? ? ? ? ? ? ? ? ? ? ? ret = mmc_regulator_set_ocr(host->mmc, host->vcc,
>> vdd);
>> + ? ? ? ? ? ? ? ? ? ? ? if (ret)
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? dev_err(mmc_dev(host->mmc),
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? "could not set regulator OCR\n");
>> + ? ? ? ? ? ? ? } else if (power_mode == MMC_POWER_OFF)
>> + ? ? ? ? ? ? ? ? ? ? ? ret = mmc_regulator_set_ocr(host->mmc, host->vcc,
>> 0);
>> + ? ? ? ? ? ? ? ? ? ? ? if (ret)
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? dev_err(mmc_dev(host->mmc),
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? "could not disable regulator\n");
>> + ? ? ? }
>
> mmc_power_off() does set ios->vdd to 0 so the original code was fine
> wrt to ignoring power_mode.

Yeah I know. This bit was to increase readability, explicitly showing
the power state like this makes it more clear what is happening I think.

The rest of the comments are fixed, new patch soon.

Yours,
Linus Walleij
