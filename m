From: oliver+list@schinagl.nl (Olliver Schinagl)
Date: Wed, 12 Aug 2015 15:19:20 +0200
Subject: [linux-sunxi] [PATCH 3/3] mmc: sunxi: use controller automatic
 clock gating.
In-Reply-To: <55CB3D92.6040403@redhat.com>
References: <cover.1439381423.git.hramrach@gmail.com>
 <c33b221f9b622e3bad9d855a7ad1887b82827244.1439381423.git.hramrach@gmail.com>
 <55CB3D92.6040403@redhat.com>
Message-ID: <55CB47D8.4010207@schinagl.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hey,

On 12-08-15 14:35, Hans de Goede wrote:
> Hi,
>
> On 12-08-15 14:23, Michal Suchanek wrote:
>> When core does not set the MMC_QUIRK_BROKEN_CLK_GATING flag enable
>> automatic hardware controlled clock gating on the mmc interface.
>>
>> Signed-off-by: Michal Suchanek <hramrach@gmail.com>
>
> In general this looks good, but I wonder how intensively this has
> been tested ?
It doesn't matter actually, it took some time longer, but the mmc still 
craps out even with Michal's 3 patches. I'll revert hans's earlier patch 
again and do a bit more extensive testing.
> Also given the long latencies when using manual
> clock on/off support, have you done any testing to check what
> sort of latencies this adds, e.g. Both with and without
> the patch, dump all the filesystem caches:
>
> echo 3 > /proc/sys/vm/drop_caches
>
> And then do:
>
> time cat /some/small/file/on/the/sdcard
>
> Do this at least 3 time both with and without the patch, and see
> if there are any noticable differences ?
>
> Regards,
>
> Hans
>
>
>
>> ---
>>   drivers/mmc/host/sunxi-mmc.c | 7 ++++++-
>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
>> index f808a02..443cab5 100644
>> --- a/drivers/mmc/host/sunxi-mmc.c
>> +++ b/drivers/mmc/host/sunxi-mmc.c
>> @@ -601,8 +601,13 @@ static int sunxi_mmc_oclk_onoff(struct 
>> sunxi_mmc_host *host, u32 oclk_en)
>>       rval = mmc_readl(host, REG_CLKCR);
>>       rval &= ~(SDXC_CARD_CLOCK_ON | SDXC_LOW_POWER_ON);
>>
>> -    if (oclk_en)
>> +    if (oclk_en) {
>>           rval |= SDXC_CARD_CLOCK_ON;
>> +        if (!host->mmc->card ||
>> +             !(host->mmc->card->quirks & MMC_QUIRK_BROKEN_CLK_GATING))
>> +
>> +            rval |= SDXC_LOW_POWER_ON;
>> +    }
>>
>>       start = jiffies;
>>       end = start + msecs_to_jiffies(750);
>>
>
