From: jh80.chung@samsung.com (Jaehoon Chung)
Date: Tue, 04 Nov 2014 11:15:54 +0900
Subject: [PATCH v3] mmc: dw_mmc: add support for the other bit of sdio
 interrupt
In-Reply-To: <3540679.aQ4QUeBEJd@diego>
References: <1414666240-16782-1-git-send-email-addy.ke@rock-chips.com>
 <1414977633-3196-1-git-send-email-addy.ke@rock-chips.com>
 <5457440E.3070002@samsung.com> <3540679.aQ4QUeBEJd@diego>
Message-ID: <545836DA.90905@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Heiko.

On 11/03/2014 07:23 PM, Heiko St?bner wrote:
> Hi Jaehoon,
> 
> Am Montag, 3. November 2014, 17:59:58 schrieb Jaehoon Chung:
>> Hi, Addy.
>>
>> On 11/03/2014 10:20 AM, Addy Ke wrote:
>>> The bit of sdio interrupt is 16 in designware implementation,
>>> but it is 24 on Rockchip SoCs.This patch add sdio_id0 for the
>>> number of slot0 in the SDIO interrupt registers.
>>>
>>> Signed-off-by: Addy Ke <addy.ke@rock-chips.com>
>>> ---
>>> Changes in v2:
>>> - rebase on http://git.linaro.org/git/people/ulf.hansson/mmc.git, next
>>> branch Changes in v3:
>>> - Remove dts for sdio_id0, just replace this with 8, suggested by Doug
>>> - Change to support all Rockchip Socs, suggested by Heiko
>>>
>>>  drivers/mmc/host/dw_mmc-rockchip.c | 10 ++++++++++
>>>  drivers/mmc/host/dw_mmc.c          | 12 +++++++-----
>>>  drivers/mmc/host/dw_mmc.h          |  2 ++
>>>  include/linux/mmc/dw_mmc.h         |  3 +++
>>>  4 files changed, 22 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/mmc/host/dw_mmc-rockchip.c
>>> b/drivers/mmc/host/dw_mmc-rockchip.c index bbb4ec3..b997c8f 100644
>>> --- a/drivers/mmc/host/dw_mmc-rockchip.c
>>> +++ b/drivers/mmc/host/dw_mmc-rockchip.c
>>> @@ -68,14 +68,24 @@ static void dw_mci_rk3288_set_ios(struct dw_mci *host,
>>> struct mmc_ios *ios)> 
>>>  	}
>>>  
>>>  }
>>>
>>> +static int dw_mci_rockchip_parse_dt(struct dw_mci *host)
>>> +{
>>> +	/* It is slot 8 on Rockchip SoCs */
>>> +	host->sdio_id0 = 8;
>>> +
>>> +	return 0;
>>> +}
>>
>> Well, function is "__parse_dt__", but this function don't parse anything.
>> If All rockchip soc is supported, i think that it can be located to other
>> place.
> 
> do you have a suggestion for a location?
> 
> The only alternative I can see right now would be using the init-hook in 
> dw_mci_drv_data or adding a new field to it holding the slot-offset.
> [with using the init-hook being my personal preference of the two]

init-hook can be used, then, in future, it can also included other specific code for rock-chip.

Best Regards,
Jaehoon Chung
> 
> 
> Heiko
> 
