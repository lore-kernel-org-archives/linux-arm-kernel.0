From: laurentiu.tudor@nxp.com (Laurentiu Tudor)
Date: Mon, 17 Jul 2017 13:46:31 +0000
Subject: [PATCH 2/7] staging: fsl-mc: use generic memory barriers
In-Reply-To: <56caf454-3ca6-f07b-0930-b2a6b3d04cea@arm.com>
References: <20170717132646.3020-1-laurentiu.tudor@nxp.com>
 <20170717132646.3020-3-laurentiu.tudor@nxp.com>
 <56caf454-3ca6-f07b-0930-b2a6b3d04cea@arm.com>
Message-ID: <596CBFB6.9090500@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/17/2017 04:38 PM, Robin Murphy wrote:
> On 17/07/17 14:26, laurentiu.tudor at nxp.com wrote:
>> From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
>>
>> No need to use arch-specific memory barriers; switch to using generic
>> ones. The rmb()s were useless so drop them.
>>
>> Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
>> ---
>>   drivers/staging/fsl-mc/bus/mc-sys.c | 6 ++----
>>   1 file changed, 2 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/staging/fsl-mc/bus/mc-sys.c b/drivers/staging/fsl-mc/bus/mc-sys.c
>> index a1704c3..012abd5 100644
>> --- a/drivers/staging/fsl-mc/bus/mc-sys.c
>> +++ b/drivers/staging/fsl-mc/bus/mc-sys.c
>> @@ -127,7 +127,8 @@ static inline void mc_write_command(struct mc_command __iomem *portal,
>>   	/* copy command parameters into the portal */
>>   	for (i = 0; i < MC_CMD_NUM_OF_PARAMS; i++)
>>   		__raw_writeq(cmd->params[i], &portal->params[i]);
>> -	__iowmb();
>> +	/* ensure command params are committed before submitting it */
>> +	wmb();
>>
>>   	/* submit the command by writing the header */
>>   	__raw_writeq(cmd->header, &portal->header);
>
> AFAICS, just using writeq() here should ensure sufficient order against
> the previous iomem accessors, without the need for explicit barriers.

Endianess is handled in the callers, this function should leave the raw 
data unchanged. So the raw version was chosen on purpose.

> Also, note that the __raw_*() variants aren't endian-safe, so consider
> updating things to *_relaxed() where ordering doesn't matter.
>

That's what i tried in the first place but encountered compilation 
errors on 32-bit powerpc & 32-bit x86 having to do with writeq/readq 
variants not being available (IIRC). So that's why i switched to the 
32-bit variants in the end.

---
Thanks & Best Regards, Laurentiu
