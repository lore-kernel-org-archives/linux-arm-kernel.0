From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Wed, 30 Sep 2015 14:47:39 +0200
Subject: [PATCH] mmc: core: fix dead loop of mmc_retune
In-Reply-To: <560BCF1B.7050302@intel.com>
References: <1443605838-5948-1-git-send-email-chaotian.jing@mediatek.com>
 <560BCF1B.7050302@intel.com>
Message-ID: <CAPDyKFrVWGP2nXZR63v0r7eRKmHuKdX1=FMjGRhOaNtDaKTg8Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30 September 2015 at 14:01, Adrian Hunter <adrian.hunter@intel.com> wrote:
> On 30/09/15 12:37, Chaotian Jing wrote:
>> When get a CRC error, start the mmc_retune, it will issue CMD19/CMD21
>> to do tune, assume there were 10 clock phase need to try, phase 0 to
>> phase 6 is ok, phase 7 to phase 9 is NG, we try it from 0 to 9, so
>> the last CMD19/CMD21 will get CRC error, host->need_retune was set and
>> cause mmc_retune was called, then dead loop of mmc_retune
>>
>> Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
>
> Wasn't my idea to have this CRC checking in the core ;-) and sdhci
> doesn't put it's tuning commands through a mmc request so it doesn't
> see this issue.

That's not true for all sdhci variants. For those that uses sdhci's
->platform_execute_tuning() callback, all uses mmc_send_tuning().

I think for sdhci's default tuning path, we should change to use
mmc_send_tuning() and thus we would potentially hit this problem as
well.

>
> But definitely the CRC logic is not meant for the tuning commands, so
>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>

Thanks for reviewing Adrian and for keeping an eye on "tuning" related patches.

Kind regards
Uffe
