From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Tue, 7 Nov 2017 10:52:42 +0000
Subject: [PATCH 17/17] coresight perf: Add ETR backend support for etm-perf
In-Reply-To: <20171107002404.GC12148@xps15>
References: <20171019171553.24056-1-suzuki.poulose@arm.com>
 <20171019171553.24056-18-suzuki.poulose@arm.com>
 <20171107002404.GC12148@xps15>
Message-ID: <1188dd39-3f03-777b-7930-9e16edd04b99@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/11/17 00:24, Mathieu Poirier wrote:
> On Thu, Oct 19, 2017 at 06:15:53PM +0100, Suzuki K Poulose wrote:
>> Add necessary support for using ETR as a sink in ETM perf tracing.
>> We try make the best use of the available modes of buffers to
>> try and avoid software double buffering.
>>
>> We can use the perf ring buffer for ETR directly if all of the
>> conditions below are met :
>>   1) ETR is DMA coherent
>>   2) perf is used in snapshot mode. In full tracing mode, we cannot
>>      guarantee that the ETR will stop before it overwrites the data
>>      which may not have been consumed by the user.
>>   3) ETR supports save-restore with a scatter-gather mechanism
>>      which can use a given set of pages we use the perf ring buffer
>>      directly. If we have an in-built TMC ETR Scatter Gather unit,
>>      we make use of a circular SG list to restart from a given head.
>>      However, we need to align the starting offset to 4K in this case.
>>
>> If the ETR doesn't support either of this, we fallback to software
>> double buffering.
>>
>> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>

  
>> +/*
>> + * etr_perf_buffer - Perf buffer used for ETR
>> + * @etr_buf		- Actual buffer used by the ETR
>> + * @snaphost		- Perf session mode
>> + * @head		- handle->head at the beginning of the session.
>> + * @nr_pages		- Number of pages in the ring buffer.
>> + * @pages		- Pages in the ring buffer.
>> + * @flags		- Capabilities of the hardware buffer used in the
>> + *			  session. If flags == 0, we use software double
>> + *			  buffering.
>> + */
>> +struct etr_perf_buffer {
>> +	struct etr_buf		*etr_buf;
>> +	bool			snapshot;
>> +	unsigned long		head;
>> +	int			nr_pages;
>> +	void			**pages;
>> +	u32			flags;
>> +};
> 
> Please move this to the top, just below the declaration for etr_sg_table.

Sure.


>> +
>> +/*
>> + * XXX: What is the expected behavior here in the following cases ?
>> + *  1) Full trace mode, without double buffering : What should be the size
>> + *     reported back when the buffer is full and has wrapped around. Ideally,
>> + *     we should report for the lost trace to make sure the "head" in the ring
>> + *     buffer comes back to the position as in the trace buffer, rather than
>> + *     returning "total size" of the buffer.
>> + * 2) In snapshot mode, should we always return "full buffer size" ?
>> + */
>> +static unsigned long
>> +tmc_etr_update_perf_buffer(struct coresight_device *csdev,
>> +			   struct perf_output_handle *handle,
>> +			   void *config)
>> +{
>> +	bool double_buffer, lost = false;
>> +	unsigned long flags, offset, size = 0;
>> +	struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
>> +	struct etr_perf_buffer *etr_perf = config;
>> +	struct etr_buf *etr_buf = etr_perf->etr_buf;
>> +
>> +	double_buffer = (etr_perf->flags == 0);
>> +
>> +	spin_lock_irqsave(&drvdata->spinlock, flags);
>> +	if (WARN_ON(drvdata->perf_data != etr_perf)) {
>> +		lost = true;
> 
> If we are here something went seriously wrong - I don't think much more can be
> done other than a WARN_ON()...
> 

right. I will do it for the case below as well.

>>   static int tmc_enable_etr_sink_perf(struct coresight_device *csdev)
>>   {
...
>> +
>> +	etr_perf = drvdata->perf_data;
>> +	if (!etr_perf || !etr_perf->etr_buf) {
>> +		rc = -EINVAL;
> 
> This is a serious malfunction - I would WARN_ON() before unlocking.
> 


>> diff --git a/drivers/hwtracing/coresight/coresight-tmc.h b/drivers/hwtracing/coresight/coresight-tmc.h
>> index 2c5b905b6494..06386ceb7866 100644
>> --- a/drivers/hwtracing/coresight/coresight-tmc.h
>> +++ b/drivers/hwtracing/coresight/coresight-tmc.h
>> @@ -198,6 +198,7 @@ struct etr_buf {
>>    * @trigger_cntr: amount of words to store after a trigger.
>>    * @etr_caps:	Bitmask of capabilities of the TMC ETR, inferred from the
>>    *		device configuration register (DEVID)
>> + * @perf_data:	PERF buffer for ETR.
>>    * @sysfs_data:	SYSFS buffer for ETR.
>>    */
>>   struct tmc_drvdata {
>> @@ -219,6 +220,7 @@ struct tmc_drvdata {
>>   	u32			trigger_cntr;
>>   	u32			etr_caps;
>>   	struct etr_buf		*sysfs_buf;
>> +	void			*perf_data;
> 
> This is a temporary place holder while an event is active, i.e theoretically it
> doesn't stay the same for the entire trace session.  In situations where there
> could be one ETR per CPU, the same ETR could be used to serve more than one
> trace session (since only one session can be active at a time on a CPU).  As
> such I would call it curr_perf_data or something similar.  I'd also make that
> clear in the above documentation.

You're right. However, from the ETR's perspective, it doesn't care how the perf
uses it. So from the ETR driver side, it still is something used by the perf mode.
All it stands for is the buffer to be used when enabled in perf mode. I could
definitely add some comment to describe this. But I am not sure if we have to
rename the variable.

> 
> Have you tried your implementation on a dragonboard or a Hikey?

No, I haven't. But Mike and Rob are trying on the Draonboard & Hikey respectively.
We are hitting some issues in the Scatter Gather mode, which is under debugging.
The SG table looks correct, just that the ETR hangs up. It works fine in the
flat memory mode. So, it is something to do with the READ  (sg table pointers) vs
WRITE (write trace data) pressure on the ETR.

One change I am working on with the perf buffer is to limit the "size" of the
trace buffer used by the ETR (in case of the perf-ring buffer) to the handle->size.
Otherwise we could be corrupting the collected trace waiting for consumption by
the user. This is easily possible with our SG table. But with the flat buffer, we have to
limit the size the minimum of (handle->size, space-in-circular-buffer-before wrapping).

In either case, we could loose data if we overflow the buffer, something we can't help
at the moment.


Suzuki


> 
> Thanks,
> Mathieu
> 
>>   };
>>   
>>   struct etr_buf_operations {
>> -- 
>> 2.13.6
>>
