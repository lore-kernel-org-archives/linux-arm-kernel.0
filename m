From: adrian.hunter@intel.com (Adrian Hunter)
Date: Tue, 10 Feb 2015 09:29:13 +0200
Subject: [RFC] MMC: CMD52 During Data Transfer support
In-Reply-To: <CAGsJ_4xeWOXtav4HhpB_4XhkXHqS4+V81tSw4LGT3Yvtq79qxQ@mail.gmail.com>
References: <CAGsJ_4xeWOXtav4HhpB_4XhkXHqS4+V81tSw4LGT3Yvtq79qxQ@mail.gmail.com>
Message-ID: <54D9B349.3080905@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/02/15 05:14, Barry Song wrote:
> hi Chris, Ulf,
> According to https://www.sdcard.org/downloads/pls/simplified_specs/archive/partE1_200.pdf
> (section CMD52 During Data Transfer ),
> A card may accept CMD52 during data transfer if it supports Direct
> Commands (see SDC, Table 6-3). For both SD and SPI modes, if an error
> occurs during data transfer the SDIO card shall accept CMD52 to allow
> I/O abort and reset regardless of this bit value of the value of SDC.
> 
> But drivers/mmc/host/sdhci.c doesn't support this mode if i didn't
> miss something:-) we need it now to improve he throughput of a high
> speed Software Digital Radio SDIO card. so we'd like to add support
> for it.
> 
> a simple idea is
> 
> 1. we need to drop this WARN_ON:
> 
> 1343 static void sdhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
> 1344 {
> 1345         struct sdhci_host *host;
> 1346         int present;
> 1347         unsigned long flags;
> 1348         u32 tuning_opcode;
> 1349
> 1350         host = mmc_priv(mmc);
> 1351
> 1352         sdhci_runtime_pm_get(host);
> 1353
> 1354         present = mmc_gpio_get_cd(host->mmc);
> 1355
> 1356         spin_lock_irqsave(&host->lock, flags);
> 1357
> 1358         WARN_ON(host->mrq != NULL);
> 
> 2. we need to permit a new command to execute even when host->mrq is
> not NULL and a CMD53 is ongoing.
> this means we might add a new cmd52 request field in host struct to
> buffer CMD52 request. and after the cmd52 finishes, we still need the
> capability to wake up the blocking thread.
> 
> I'd like to know your suggestions on this feature.

Can you explain more about how CMD52 will be used with CMD53? Will you have
separate threads processing CMD52 and CMD53? If you did, how would you stop
the CMD53 thread from starting another CMD53 while a CMD52 is in progress?

Also you mention you might need to buffer the CMD52. Under what circumstances?

Will the CMD53 request need to use the cmd line for other commands like the
STOP command?

Also what is the benefit of using CMD52 during CMD53? Is it really worth
doing? Could it be done another way?

Finally, there are other drivers, are you looking only at SDHCI? What about
the others?
