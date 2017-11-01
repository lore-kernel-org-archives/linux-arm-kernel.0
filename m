From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Wed, 1 Nov 2017 10:01:35 +0000
Subject: [PATCH 03/17] coresight: Add helper for inserting synchronization
 packets
In-Reply-To: <20171030214403.GA25098@xps15>
References: <20171019171553.24056-1-suzuki.poulose@arm.com>
 <20171019171553.24056-4-suzuki.poulose@arm.com>
 <20171030214403.GA25098@xps15>
Message-ID: <bd051ca6-106b-df67-00f9-6c473f22b671@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30/10/17 21:44, Mathieu Poirier wrote:
> On Thu, Oct 19, 2017 at 06:15:39PM +0100, Suzuki K Poulose wrote:
>> Right now we open code filling the trace buffer with synchronization
>> packets when the circular buffer wraps around in different drivers.
>> Move this to a common place.
>>
>> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
>> Cc: Mike Leach <mike.leach@linaro.org>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>> ---
>>   drivers/hwtracing/coresight/coresight-etb10.c   | 10 +++------
>>   drivers/hwtracing/coresight/coresight-priv.h    |  8 ++++++++
>>   drivers/hwtracing/coresight/coresight-tmc-etf.c | 27 ++++++++-----------------
>>   drivers/hwtracing/coresight/coresight-tmc-etr.c | 13 +-----------
>>   4 files changed, 20 insertions(+), 38 deletions(-)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
>> index 56ecd7aff5eb..d7164ab8e229 100644
>> --- a/drivers/hwtracing/coresight/coresight-etb10.c
>> +++ b/drivers/hwtracing/coresight/coresight-etb10.c
>> @@ -203,7 +203,6 @@ static void etb_dump_hw(struct etb_drvdata *drvdata)
>>   	bool lost = false;
>>   	int i;
>>   	u8 *buf_ptr;
>> -	const u32 *barrier;
>>   	u32 read_data, depth;
>>   	u32 read_ptr, write_ptr;
>>   	u32 frame_off, frame_endoff;
>> @@ -234,19 +233,16 @@ static void etb_dump_hw(struct etb_drvdata *drvdata)
>>   
>>   	depth = drvdata->buffer_depth;
>>   	buf_ptr = drvdata->buf;
>> -	barrier = barrier_pkt;
>>   	for (i = 0; i < depth; i++) {
>>   		read_data = readl_relaxed(drvdata->base +
>>   					  ETB_RAM_READ_DATA_REG);
>> -		if (lost && *barrier) {
>> -			read_data = *barrier;
>> -			barrier++;
>> -		}
>> -
>>   		*(u32 *)buf_ptr = read_data;
>>   		buf_ptr += 4;
>>   	}
>>   
>> +	if (lost)
>> +		coresight_insert_barrier_packet(drvdata->buf);
>> +
>>   	if (frame_off) {
>>   		buf_ptr -= (frame_endoff * 4);
>>   		for (i = 0; i < frame_endoff; i++) {
>> diff --git a/drivers/hwtracing/coresight/coresight-priv.h b/drivers/hwtracing/coresight/coresight-priv.h
>> index f1d0e21d8cab..d12f64928c00 100644
>> --- a/drivers/hwtracing/coresight/coresight-priv.h
>> +++ b/drivers/hwtracing/coresight/coresight-priv.h
>> @@ -65,6 +65,7 @@ static DEVICE_ATTR_RO(name)
>>   	__coresight_simple_func(type, NULL, name, lo_off, hi_off)
>>   
>>   extern const u32 barrier_pkt[5];
>> +#define CORESIGHT_BARRIER_PKT_SIZE (sizeof(barrier_pkt) - sizeof(u32))
> 
> When using a memcpy() there is no need to have a 0x0 at the end of the
> barrier_pkt array.  A such I suggest you remove that and simply use sizeof()
> in coresight_insert_barrier_packet().

There is one place where can't simply do a memcpy(), in tmc_update_etf_buffer(),
where we could potentially move over to the next PAGE while filling the barrier packets.
This is why I didn't trim it off. However, I believe this shouldn't trigger as the trace
data should always be aligned to the frame size of the TMC and the perf buffer size is
page aligned. So, we should be able use memcpy() in that case too. I will fix it
in the next version.

Thanks
Suzuki
