From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Fri, 13 Jul 2018 12:23:02 +0100
Subject: [PATCH 6/6] coresight: etm-perf: Add support for ETR backend
In-Reply-To: <20180712205740.GA22128@xps15>
References: <1531318599-8840-1-git-send-email-suzuki.poulose@arm.com>
 <1531318599-8840-7-git-send-email-suzuki.poulose@arm.com>
 <20180712205740.GA22128@xps15>
Message-ID: <cf11b93e-6e57-7309-5364-6c1d00ff8381@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/07/18 21:57, Mathieu Poirier wrote:
> Hi Suzuki,
> 
> On Wed, Jul 11, 2018 at 03:16:39PM +0100, Suzuki K Poulose wrote:
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
>>   drivers/hwtracing/coresight/coresight-tmc-etr.c | 265 +++++++++++++++++++++++-
>>   drivers/hwtracing/coresight/coresight-tmc.h     |   2 +
>>   2 files changed, 265 insertions(+), 2 deletions(-)

>> +/*
>> + * tmc_etr_sync_perf_buffer: Copy the actual trace data from the hardware
>> + * buffer to the perf ring buffer.
>> + */
>> +static void tmc_etr_sync_perf_buffer(struct etr_perf_buffer *etr_perf)
>> +{
>> +	long bytes, to_copy;
>> +	long pg_idx, pg_offset, src_offset;
>> +	unsigned long head = etr_perf->head;
>> +	char **dst_pages, *src_buf;
>> +	struct etr_buf *etr_buf = etr_perf->etr_buf;
>> +
>> +	head = PERF_IDX2OFF(etr_perf->head, etr_perf);
> 
> I'm puzzled here.  Since etr_perf->head is set in tmc_etr_set_perf_buffer() to
> the value of handle->head, its value is always within the range of the perf ring

IIUC, the handle->head is not necessarily guaranteed to be within the aux-ring buffer.

> buffer.  In tmc_etr_alloc_perf_buffer() etr_perf->nr_pages is set to the number
> of pages present in that ring buffer.  As such I'm not sure as to why we need
> the PERF_IDX2OFF() macro.
> 
> It seems to me that "head = etr_perf->head;" above is sufficient.
> 

We need to do the step at some point, which could be moved to set_perf_buffer.

>> +	pg_idx = head >> PAGE_SHIFT;
>> +	pg_offset = head & (PAGE_SIZE - 1);
>> +	dst_pages = (char **)etr_perf->pages;
>> +	src_offset = etr_buf->offset;
>> +	to_copy = etr_buf->len;
>> +
>> +	while (to_copy > 0) {
>> +		/*
>> +		 * We can copy minimum of :
> 
> s/We can copy minimum of :/In one iteration we can copy a minimum of:/
> 
> If I'm wrong about the PERF_IDX2OFF(), don't bother respinning just for that.

I have some more fixes for handling the different modes (sysfs vs perf),
which I can include in the v2.

Suzuki
