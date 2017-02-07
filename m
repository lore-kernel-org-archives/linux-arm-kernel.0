From: spjoshi@codeaurora.org (Sarangdhar Joshi)
Date: Tue, 7 Feb 2017 10:55:38 -0800
Subject: [RFC][PATCH 1/2] remoteproc: Reduce asynchronous request_firmware
 to auto-boot only
In-Reply-To: <20170206210837.GH31134@builder>
References: <1485299581-30476-1-git-send-email-spjoshi@codeaurora.org>
 <20170206210837.GH31134@builder>
Message-ID: <3513076d-0292-93ce-efac-e2f6b8491f0f@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bjorn,

On 02/06/2017 01:08 PM, Bjorn Andersson wrote:
> On Tue 24 Jan 15:13 PST 2017, Sarangdhar Joshi wrote:
>
>> The rproc_add_virtio_devices() requests firmware asynchronously and
>> triggers boot if the auto_boot flag is set. However, this
>> asynchronous call seems to be redundant for non auto-boot scenario
>> since the rproc_boot() would call request_firmware() anyways. Move
>> the auto_boot check to rproc_add() so that a redundant call to
>> _request_firmware can be avoided for non auto-boot case.
>>
>> Signed-off-by: Sarangdhar Joshi <spjoshi@codeaurora.org>
>
> Looks good, applied both patches.

Thanks for the review and applying these(and couple others) patches.

Regards,
Sarang
>
> Regards,
> Bjorn
>
>> ---
>>
>> I'm requesting RFC on this patch since I'm not aware of any scenario
>> where we might need asynchronous firmware loading for non auto-boot case.
>>
>>  drivers/remoteproc/remoteproc_core.c | 14 ++++++++------
>>  1 file changed, 8 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
>> index f58e634..16242b0 100644
>> --- a/drivers/remoteproc/remoteproc_core.c
>> +++ b/drivers/remoteproc/remoteproc_core.c
>> @@ -970,9 +970,7 @@ static void rproc_fw_config_virtio(const struct firmware *fw, void *context)
>>  {
>>  	struct rproc *rproc = context;
>>
>> -	/* if rproc is marked always-on, request it to boot */
>> -	if (rproc->auto_boot)
>> -		rproc_boot(rproc);
>> +	rproc_boot(rproc);
>>
>>  	release_firmware(fw);
>>  }
>> @@ -1286,9 +1284,13 @@ int rproc_add(struct rproc *rproc)
>>
>>  	/* create debugfs entries */
>>  	rproc_create_debug_dir(rproc);
>> -	ret = rproc_add_virtio_devices(rproc);
>> -	if (ret < 0)
>> -		return ret;
>> +
>> +	/* if rproc is marked always-on, request it to boot */
>> +	if (rproc->auto_boot) {
>> +		ret = rproc_add_virtio_devices(rproc);
>> +		if (ret < 0)
>> +			return ret;
>> +	}
>>
>>  	/* expose to rproc_get_by_phandle users */
>>  	mutex_lock(&rproc_list_mutex);
>> --
>> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
>> a Linux Foundation Collaborative Project
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-remoteproc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
