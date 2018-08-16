From: saiprakash.ranjan@codeaurora.org (Sai Prakash Ranjan)
Date: Thu, 16 Aug 2018 14:05:05 +0530
Subject: [RFC PATCH 1/3] tracing: Add support for logging data to uncached
 buffer
In-Reply-To: <20180815225955.38d21271@vmware.local.home>
References: <cover.1533211508.git.saiprakash.ranjan@codeaurora.org>
 <6b62fd3a5abf1baf48a07ba8a31a92d17f501f77.1533211509.git.saiprakash.ranjan@codeaurora.org>
 <20180815225955.38d21271@vmware.local.home>
Message-ID: <56b9f127-3d11-9997-c34b-bc542fdbd52a@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8/16/2018 8:29 AM, Steven Rostedt wrote:
> 
> Sorry for the late reply, I actually wrote this email over a week ago,
> but never hit send. And the email was pushed back behind other
> windows. :-/
> 
> 

Thanks for the review Steven.
And no problem on late reply, I was working on Will's comment about 
instrumentation in arch code and was about to respin a v2 patch. I have 
replied inline, let me know if any more corrections or improvements can 
be done. I would also like if Kees or someone from pstore could comment 
on patch 2.

> On Fri,  3 Aug 2018 19:58:42 +0530
> Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org> wrote:
> 
>> diff --git a/kernel/trace/trace_rtb.c b/kernel/trace/trace_rtb.c
>> new file mode 100644
>> index 000000000000..e8c24db71a2d
>> --- /dev/null
>> +++ b/kernel/trace/trace_rtb.c
>> @@ -0,0 +1,160 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (C) 2018 The Linux Foundation. All rights reserved.
>> + */
>> +#include <linux/atomic.h>
>> +#include <linux/dma-mapping.h>
>> +#include <linux/export.h>
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/of_device.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/rtb.h>
>> +#include <linux/sched/clock.h>
>> +
>> +static struct platform_device *rtb_dev;
>> +static atomic_t rtb_idx;
>> +
>> +struct rtb_state {
>> +	struct rtb_layout *rtb;
>> +	phys_addr_t phys;
>> +	unsigned int nentries;
>> +	unsigned int size;
>> +	int enabled;
>> +};
>> +
>> +static struct rtb_state rtb = {
>> +	.enabled = 0,
>> +};
> 
> No need for the initialization, you could just have:
> 
> static struct rtb_state rtb;
> 
> And it will be initialized to all zeros. Or did you do that to document
> that it is not enabled at boot?
>

I will correct it in v2. RTB will not be enabled until pstore is 
registered since we use pstore for logs. I will add a comment above the 
static declaration saying so.

>> +
>> +static int rtb_panic_notifier(struct notifier_block *this,
>> +					unsigned long event, void *ptr)
>> +{
>> +	rtb.enabled = 0;
>> +	return NOTIFY_DONE;
>> +}
>> +
>> +static struct notifier_block rtb_panic_blk = {
>> +	.notifier_call  = rtb_panic_notifier,
>> +	.priority = INT_MAX,
>> +};
>> +
>> +static void rtb_write_type(const char *log_type,
>> +			struct rtb_layout *start)
>> +{
>> +	start->log_type = log_type;
>> +}
>> +
>> +static void rtb_write_caller(u64 caller, struct rtb_layout *start)
>> +{
>> +	start->caller = caller;
>> +}
>> +
>> +static void rtb_write_data(u64 data, struct rtb_layout *start)
>> +{
>> +	start->data = data;
>> +}
>> +
>> +static void rtb_write_timestamp(struct rtb_layout *start)
>> +{
>> +	start->timestamp = sched_clock();
>> +}
> 
> Why have the above static functions? They are not very helpful, and
> appear to be actually confusing. They are used once.
> 

Yes you are right, will remove those.

>> +
>> +static void uncached_logk_pc_idx(const char *log_type, u64 caller,
>> +				u64 data, int idx)
>> +{
>> +	struct rtb_layout *start;
>> +
>> +	start = &rtb.rtb[idx & (rtb.nentries - 1)];
>> +
>> +	rtb_write_type(log_type, start);
>> +	rtb_write_caller(caller, start);
>> +	rtb_write_data(data, start);
>> +	rtb_write_timestamp(start);
> 
> How is the above better than:
> 
> 	start->log_type = log_type;
> 	start->caller = caller;
> 	start->data = data;
>   	start->timestamp = sched_clock();
> 
> ??
> 

Sure, will change it to above and post v2.

>> +	/* Make sure data is written */
>> +	mb();
>> +}
>> +
>> +static int rtb_get_idx(void)
>> +{
>> +	int i, offset;
>> +
>> +	i = atomic_inc_return(&rtb_idx);
>> +	i--;
>> +
>> +	/* Check if index has wrapped around */
>> +	offset = (i & (rtb.nentries - 1)) -
>> +		 ((i - 1) & (rtb.nentries - 1));
>> +	if (offset < 0) {
>> +		i = atomic_inc_return(&rtb_idx);
>> +		i--;
>> +	}
>> +
>> +	return i;
>> +}
>> +
>> +noinline void notrace uncached_logk(const char *log_type, void *data)
> 
> BTW, all files in this directory have their functions notrace by
> default.
> 

Oh I missed it. Will remove notrace.

- Sai Prakash
