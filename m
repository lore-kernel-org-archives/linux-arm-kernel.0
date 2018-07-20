From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Fri, 20 Jul 2018 10:07:10 +0100
Subject: [PATCH v2 10/10] coresight: etm-perf: Add support for ETR backend
In-Reply-To: <20180719195949.GA9421@xps15>
References: <1531847501-22226-1-git-send-email-suzuki.poulose@arm.com>
 <1531847501-22226-11-git-send-email-suzuki.poulose@arm.com>
 <20180719195949.GA9421@xps15>
Message-ID: <2e3a1a45-d71c-2f63-0ec9-9a8071a491f1@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19/07/18 20:59, Mathieu Poirier wrote:
> On Tue, Jul 17, 2018 at 06:11:41PM +0100, Suzuki K Poulose wrote:
>> Add support for using TMC-ETR as backend for ETM perf tracing.
>> We use software double buffering at the moment. i.e, the TMC-ETR
>> uses a separate buffer than the perf ring buffer. The data is
>> copied to the perf ring buffer once a session completes.
>>
>> The TMC-ETR would try to match the larger of perf ring buffer
>> or the ETR buffer size configured via sysfs, scaling down to
>> a minimum limit of 1MB.
>>
>> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>> ---

>> +	CS_UNLOCK(drvdata->base);
>> +
>> +	tmc_flush_and_stop(drvdata);
>> +	tmc_sync_etr_buf(drvdata);
>> +
>> +	CS_UNLOCK(drvdata->base);
> 
> This is a copy/paste oversight, here you want to lock again.

Thanks for catching that, will fix it.

> 
>> +	/* Reset perf specific data */
>> +	drvdata->perf_data = NULL;
>> +	spin_unlock_irqrestore(&drvdata->spinlock, flags);
>> +
>> +	size = etr_buf->len;
>> +	tmc_etr_sync_perf_buffer(etr_perf);
>> +
>> +	/*
>> +	 * Update handle->head in snapshot mode. Also update the size to the
>> +	 * hardware buffer size if there was an overflow.
>> +	 */
>> +	if (etr_perf->snapshot) {
>> +		handle->head += size;
>> +		if (etr_buf->full)
>> +			size = etr_buf->size;
>> +	}
>> +
>> +	lost |= etr_buf->full;
>> +out:
>> +	if (lost)
>> +		perf_aux_output_flag(handle, PERF_AUX_FLAG_TRUNCATED);
>> +	return size;
>> +}
>> +
>>   static int tmc_enable_etr_sink_perf(struct coresight_device *csdev, void *data)
>>   {
>> -	/* We don't support perf mode yet ! */
>> -	return -EINVAL;
>> +	int rc = 0;
>> +	unsigned long flags;
>> +	struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
>> +	struct perf_output_handle *handle = data;
>> +	struct etr_perf_buffer *etr_perf = etm_perf_sink_config(handle);
>> +
>> +	spin_lock_irqsave(&drvdata->spinlock, flags);
>> +	/*
>> +	 * There can be only one writer per sink in perf mode. If the sink
>> +	 * is already open in SYSFS mode, we can't use it.
>> +	 */
>> +	if (drvdata->mode != CS_MODE_DISABLED || drvdata->perf_data) {
>> +		rc = -EBUSY;

As discussed in the previous patch, I am missing a WARN_ON here : i.e,

    +	if (drvdata->mode != CS_MODE_DISABLED || WARN_ON(drvdata->perf_data))

which was there in the previous version in set_buffer, which triggered some
warnings for me with testing.

>> +		goto unlock_out;
>> +	}
>> +
>> +	if (WARN_ON(!etr_perf || !etr_perf->etr_buf)) {
>> +		rc = -EINVAL;
>> +		goto unlock_out;
>> +	}
>> +
>> +	etr_perf->head = PERF_IDX2OFF(handle->head, etr_perf);
>> +	drvdata->perf_data = etr_perf;
>> +	drvdata->mode = CS_MODE_PERF;
>> +	tmc_etr_enable_hw(drvdata, etr_perf->etr_buf);
>> +
>> +unlock_out:
>> +	spin_unlock_irqrestore(&drvdata->spinlock, flags);
>> +	return rc;
>>   }
>>   
>>   static int tmc_enable_etr_sink(struct coresight_device *csdev,
>> @@ -1148,6 +1389,9 @@ static void tmc_disable_etr_sink(struct coresight_device *csdev)
>>   static const struct coresight_ops_sink tmc_etr_sink_ops = {
>>   	.enable		= tmc_enable_etr_sink,
>>   	.disable	= tmc_disable_etr_sink,
>> +	.alloc_buffer	= tmc_etr_alloc_perf_buffer,
>> +	.update_buffer	= tmc_etr_update_perf_buffer,
>> +	.free_buffer	= tmc_etr_free_perf_buffer,
> 
> 
> 	.alloc_buffer	= tmc_alloc_etr_buffer,
> 	.update_buffer	= tmc_update_etr_buffer,
> 	.free_buffer	= tmc_free_etr_buffer,
> 
> To be consistant with .enable and .disable along with the naming convention on
> the ETF side.


Sure, I can change them.

Cheers
Suzuki
