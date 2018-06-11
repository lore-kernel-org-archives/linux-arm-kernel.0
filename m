From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Mon, 11 Jun 2018 10:18:22 +0100
Subject: [PATCH 02/20] coresight: of: Fix refcounting for graph nodes
In-Reply-To: <20180608195530.GB30587@xps15>
References: <1528235011-30691-1-git-send-email-suzuki.poulose@arm.com>
 <1528235011-30691-3-git-send-email-suzuki.poulose@arm.com>
 <20180608195530.GB30587@xps15>
Message-ID: <d06e9fdc-44c3-95bd-63d1-ff4e6f9f282e@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/06/18 20:55, Mathieu Poirier wrote:
> On Tue, Jun 05, 2018 at 10:43:13PM +0100, Suzuki K Poulose wrote:
>> The coresight driver doesn't drop the references on the
>> remote endpoint/port nodes. Add the missing of_node_put()
>> calls. To make it easier to handle different corner cases
>> cleanly, move the parsing of an endpoint to separate
>> function.
> 
> Please split this as those are two different things.

Mathieu,

I can do that, its only that if someone were to backport
the fix for an older kernel, they would need to pick up these
two patches, which is still fine.

> 
>>
>> Reported-by: Mathieu Poirier <mathieu.poirier@linaro.org>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>> ---
>>   drivers/hwtracing/coresight/of_coresight.c | 139 +++++++++++++++++------------
>>   1 file changed, 84 insertions(+), 55 deletions(-)
>>
>> diff --git a/drivers/hwtracing/coresight/of_coresight.c b/drivers/hwtracing/coresight/of_coresight.c
>> index a33a92e..8a23c63 100644
>> --- a/drivers/hwtracing/coresight/of_coresight.c
>> +++ b/drivers/hwtracing/coresight/of_coresight.c

>> +static int of_coresight_parse_endpoint(struct device_node *ep,
>> +				       struct coresight_platform_data *pdata,
>> +				       int *i)
>> +{
>> +	int ret = 0;
>> +	struct of_endpoint endpoint, rendpoint;
>> +	struct device_node *rparent = NULL;
>> +	struct device_node *rport = NULL;
>> +	struct device *rdev = NULL;
>> +
>> +	do {

...

>> +	} while (0);
> 
> That's a clever way of coding a classic 'goto' block.
> 
>> +
>> +	if (rparent)
>> +		of_node_put(rparent);
>> +	if (rport)
>> +		of_node_put(rport);
> 
> Perfect - thank you for that.
> 

>>   	pdata->name = dev_name(dev);
>> +	pdata->cpu = of_coresight_get_cpu(node);
>>   
>>   	/* Get the number of input and output port for this component */
>>   	of_coresight_get_ports(node, &pdata->nr_inport, &pdata->nr_outport);
>>   
>> -	if (pdata->nr_outport) {
>> -		ret = of_coresight_alloc_memory(dev, pdata);
>> +	/* If there are not output connections, we are done */
> 
> /not/no

Thanks for spotting.

Suzuki
