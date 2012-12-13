From: keyuan.liu@gmail.com (Kevin Liu)
Date: Thu, 13 Dec 2012 09:51:38 +0800
Subject: FW: [PATCH] mmc: mmci: Gate the clock in runtime suspend to save
 power
In-Reply-To: <25B60CDC2F704E4E9D88FFD52780CB4C08B00BD3B1@SC-VEXCH1.marvell.com>
References: <25B60CDC2F704E4E9D88FFD52780CB4C08B00BD3B1@SC-VEXCH1.marvell.com>
Message-ID: <CADz5_gJ70KrHL5NoSPQbFdeHnQxWLh87zq6N+-V7J7Yq7t+aPQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: linux-mmc-owner at vger.kernel.org [mailto:linux-mmc-owner at vger.kernel.org] On Behalf Of Linus Walleij
> Sent: Thursday, December 13, 2012 2:54 AM
> To: Ulf Hansson
> Cc: Russell King - ARM Linux; Ulf Hansson; linux-mmc at vger.kernel.org; Chris Ball; linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH] mmc: mmci: Gate the clock in runtime suspend to save power
>
> On Wed, Dec 12, 2012 at 12:02 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>> On 12 December 2012 07:53, Linus Walleij <linus.walleij@linaro.org> wrote:
>
>>> 1) Turn on MMC_CLKGATE for this driver (select from Kconfig)
>>> which means that the ios will be called with f=0 whenever
>>> the card is unused, taking into account the required number
>>> of clocks to the card.
>>
>> I think MMC_CLKGATE was a good initiative in the past. But that was
>> before runtime pm was there to use. Runtime pm suits much better for
>> handling clock gating and other runtime power save actions that could
>> be possible for a host driver to do.
>>
>> I would even suggest the MMC_CLKGATE should be removed from the
>> protocol layer, once we see that all host drivers that used it has
>> switch to runtime pm.
>
> Ah now I remember that you've actually even explained this to me ...
> memory is too short sometimes. But I follow this idea.
>
> Then we have only the coordination between runtime suspend
> and suspend proper to iron out.
>
> Russell's concern is valid if suspend() will not wait for runtime_suspend()
> to complete the last cycle before suspending.
>

pm_runtime_get_noresume is called before suspend and there are
sdhci_runtime_pm_get/sdhci_runtime_pm_put within sdhci suspend/resume
function. So the actual runtime_suspend won't be called after suspend
finished. So it's same as original code without pm_runtime during
suspend/resume.

> Hm this sounds scaringly familiar to what we've discussed with
> Kevin Hilman et al recently...
>
