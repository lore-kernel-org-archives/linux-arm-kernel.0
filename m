From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Fri, 20 Jul 2018 10:04:25 +0100
Subject: [PATCH v2 09/10] coresight: perf: Remove set_buffer call back
In-Reply-To: <20180719203630.GC9421@xps15>
References: <1531847501-22226-1-git-send-email-suzuki.poulose@arm.com>
 <1531847501-22226-10-git-send-email-suzuki.poulose@arm.com>
 <20180719203630.GC9421@xps15>
Message-ID: <a68cff9d-51d3-7d86-0a73-c1d3cbbaced3@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mathieu,

On 19/07/18 21:36, Mathieu Poirier wrote:
> On Tue, Jul 17, 2018 at 06:11:40PM +0100, Suzuki K Poulose wrote:
>> In coresight perf mode, we need to prepare the sink before
>> starting a session, which is done via set_buffer call back.
>> We then proceed to enable the tracing. If we fail to start
>> the session successfully, we leave the sink configuration
>> unchanged. This was fine for the existing backends as they
>> don't have any state associated with the buffers. But with
>> ETR, we need to keep track of the buffer details and need
>> to be cleaned up if we fail. In order to make the operation
>> atomic and to avoid yet another call back, we get rid of
>> the "set_buffer" call back and pass the buffer details
>> via enable() call back to the sink.
> 
> Suzuki,
> 
> I'm not sure I understand the problem you're trying to fix there.  From the
> implementation of tmc_enable_etr_sink_perf() in the next patch, wouldn't the
> same result been achievable using a callback?

We can definitely achieve the results using "set_buffer". But for ETR,
we track the "perf_buf" in drvdata->perf_data when we do "set_buffer".
But if we failed to enable_path(), we leave the drvdata->perf_data
and doesn't clean it up. Now when another session is about to set_buf,
we check if perf_data is empty and WARNs otherwise.
Because we can't be sure if it belongs to an abandoned session or
another active session and we completely messed somewhere in the driver.
So, we need a clear_buffer call back if the enable fails, something
not really worth. Anyways, there is no point in separating set_buffer
and enabling the sink, as the error handling becomes cumbersome as explained
above.

> 
> I'm fine with this patch and supportive of getting rid of callbacks if we can, I
> just need to understand the exact problem you're after.  From looking a your
> code (and the current implementation), if we succeed in setting the memory for
> the sink but fail in any of the subsequent steps i.e, enabling the rest of the
> compoment on the path or the source, the sink is left unchanged.

Yes, thats right. And we should WARN (which I missed in this version) if
there is a perf_data already for a disabled ETR. Please see my response to the
next patch.

>> diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
>> index 3cc4a0b..12a247d 100644
>> --- a/drivers/hwtracing/coresight/coresight-etm-perf.c
>> +++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
>> @@ -269,16 +269,11 @@ static void etm_event_start(struct perf_event *event, int flags)
>>   	path = etm_event_cpu_path(event_data, cpu);
>>   	/* We need a sink, no need to continue without one */
>>   	sink = coresight_get_sink(path);
>> -	if (WARN_ON_ONCE(!sink || !sink_ops(sink)->set_buffer))
>> -		goto fail_end_stop;
>> -
>> -	/* Configure the sink */
>> -	if (sink_ops(sink)->set_buffer(sink, handle,
>> -				       event_data->snk_config))
>> +	if (WARN_ON_ONCE(!sink))
>>   		goto fail_end_stop;
>>   
>>   	/* Nothing will happen without a path */
>> -	if (coresight_enable_path(path, CS_MODE_PERF))
>> +	if (coresight_enable_path(path, CS_MODE_PERF, handle))
> 
> Here we already have a handle on "event_data".  As such I think this is what we
> should feed to coresight_enable_path() rather than the handle.  That way we
> don't need to call etm_perf_sink_config(), we just use the data.

The advantage of passing on the handle is, we could get all the way upto the
"perf_event" for the given session. Passing the event_data will loose that
information.

i.e, perf_event-> |perf_ouput_handle | -> |event_data | -> sink_config
                   |  <-event         |    |           |

The purpose of the wrapper "etm_perf_sink_config()" is to abstract the way we
handle the information under the event_data. i.e, if we decide to make some
changes in the way we store event_data, we need to spill the changes every
where. But the perf_ouput_handle has much more stable ABI than event_data,
hence the choice of passing handle.

Cheers
Suzuki
