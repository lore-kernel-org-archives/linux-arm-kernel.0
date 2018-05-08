From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Tue, 8 May 2018 17:21:22 +0100
Subject: [PATCH v2 19/27] coresight: catu: Plug in CATU as a backend for
 ETR buffer
In-Reply-To: <20180507220249.GA22194@xps15>
References: <1525165857-11096-1-git-send-email-suzuki.poulose@arm.com>
 <1525165857-11096-20-git-send-email-suzuki.poulose@arm.com>
 <20180507220249.GA22194@xps15>
Message-ID: <6145aae1-8d0c-2720-5e3b-bcbd4d4ddb58@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/05/18 23:02, Mathieu Poirier wrote:
> On Tue, May 01, 2018 at 10:10:49AM +0100, Suzuki K Poulose wrote:
>> Now that we can use a CATU with a scatter gather table, add support
>> for the TMC ETR to make use of the connected CATU in translate mode.
>> This is done by adding CATU as new buffer mode. CATU's SLADDR must
>> always be 4K aligned. Thus the INADDR (base VA) is always 1M aligned
>> and we adjust the DBA for the ETR to align to the "offset" within
>> the 1MB page.


>> diff --git a/drivers/hwtracing/coresight/coresight-catu.h b/drivers/hwtracing/coresight/coresight-catu.h
>> index cd58d6f..b673a73 100644
>> --- a/drivers/hwtracing/coresight/coresight-catu.h
>> +++ b/drivers/hwtracing/coresight/coresight-catu.h
>> @@ -29,6 +29,32 @@

>>   
>> +extern const struct etr_buf_operations etr_catu_buf_ops;
>> +

>> diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
>> index 25e7feb..41dde0a 100644
>> --- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
>> +++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
>> @@ -941,6 +941,9 @@ static const struct etr_buf_operations etr_sg_buf_ops = {
>>   static const struct etr_buf_operations *etr_buf_ops[] = {
>>   	[ETR_MODE_FLAT] = &etr_flat_buf_ops,
>>   	[ETR_MODE_ETR_SG] = &etr_sg_buf_ops,
>> +#ifdef CONFIG_CORESIGHT_CATU
>> +	[ETR_MODE_CATU] = &etr_catu_buf_ops,
>> +#endif

...

>>   static inline int tmc_etr_mode_alloc_buf(int mode,
>> @@ -953,6 +956,9 @@ static inline int tmc_etr_mode_alloc_buf(int mode,
>>   	switch (mode) {
>>   	case ETR_MODE_FLAT:
>>   	case ETR_MODE_ETR_SG:
>> +#ifdef CONFIG_CORESIGHT_CATU
>> +	case ETR_MODE_CATU:
>> +#endif
> 
> I really wish we could avoid doing something like this (and the above) but every
> alternate solution I come up with is either uglier or on par with it...
> Unless someone comes up with a bright idea we'll simply have to let it be.

We could do a little trick in the coresight-catu.h :

#ifdef CONFIG_CORESIGHT_CATU
extern struct etr_buf_operations etr_catu_buf_ops;
#else
static struct etr_buf_opertaions etr_catu_buf_ops;
#endif

And then add the following check to get rid of the #ifdef above in tmc_etr_mode_alloc_buf().

		if (etr_buf_ops[mode]->alloc)
			rc = etr_buf_ops[mode]->alloc(drvdata, etr_buf, node, pages);

>>   		rc = etr_buf_ops[mode]->alloc(drvdata, etr_buf, node, pages);

> 
> While looking for a solution I noticed that tmc_etr_get_catu_device()
> could be moved to coresight-catu.h.  That way we wouldn't have to include
> coresight-catu.h every time coresight-tmc.h is present in a file.

Yes, we could do that. I don't remember if there was a specific reason behind it.
May be it is a left over from the rebases and how the CATU link was evolved. I
will clean it up.


Cheers
Suzuki
