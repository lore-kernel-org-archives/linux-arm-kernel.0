From: s-anna@ti.com (Suman Anna)
Date: Mon, 8 Oct 2018 11:33:46 -0500
Subject: [PATCH] samples/rpmsg: Introduce a module parameter for message
 count
In-Reply-To: <20181006062231.GF12063@builder>
References: <20180911174643.26199-1-s-anna@ti.com>
 <20181006062231.GF12063@builder>
Message-ID: <d14448ad-21c1-0a1a-0264-2efece209fc6@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bjorn,

On 10/06/2018 01:22 AM, Bjorn Andersson wrote:
> On Tue 11 Sep 10:46 PDT 2018, Suman Anna wrote:
> 
>> The current rpmsg_client_sample uses a fixed number of messages to
>> be sent to each instance. This is currently set at 100. Introduce
>> an optional module parameter 'count' so that the number of messages
>> to be exchanged can be made flexible.
>>
> 
> Rather than sending N messages as fast as possible to any sample channel
> that comes up, how about making the sample create a debugfs entry that
> we can write messages to from user space?

This sample demonstrates a kernel-level rpmsg usage, and I would prefer
to maintain the current simplicity, and not add in any userspace
interaction. That perhaps can be done as a different sample. I use this
sample to serve as the basic test for checking the rpmsg transport
functionality with multiple remoteprocs and/or multiple instances per
remoteproc at the same time. The count parameter helps me with both
early Silicon development, as well as exercising increased message
exchanges so that the vring buffers are cycled.

> 
> That would make it possible to improve the handling of multiple
> remoteprocs and would allow for a variation in message lengths etc.

FWIW, this already support multiple instances from the same remoteproc
or different remoteproc.

regards
Suman


> 
> Regards,
> Bjorn
> 
>> Signed-off-by: Suman Anna <s-anna@ti.com>
>> ---
>>  samples/rpmsg/rpmsg_client_sample.c | 6 ++++--
>>  1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/samples/rpmsg/rpmsg_client_sample.c b/samples/rpmsg/rpmsg_client_sample.c
>> index f161dfd3e70a..9b6b27ea504f 100644
>> --- a/samples/rpmsg/rpmsg_client_sample.c
>> +++ b/samples/rpmsg/rpmsg_client_sample.c
>> @@ -22,7 +22,9 @@
>>  #include <linux/rpmsg.h>
>>  
>>  #define MSG		"hello world!"
>> -#define MSG_LIMIT	100
>> +
>> +static int count = 100;
>> +module_param(count, int, 0644);
>>  
>>  struct instance_data {
>>  	int rx_count;
>> @@ -41,7 +43,7 @@ static int rpmsg_sample_cb(struct rpmsg_device *rpdev, void *data, int len,
>>  		       data, len,  true);
>>  
>>  	/* samples should not live forever */
>> -	if (idata->rx_count >= MSG_LIMIT) {
>> +	if (idata->rx_count >= count) {
>>  		dev_info(&rpdev->dev, "goodbye!\n");
>>  		return 0;
>>  	}
>> -- 
>> 2.18.0
>>
