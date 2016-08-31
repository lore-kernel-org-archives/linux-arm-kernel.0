From: afd@ti.com (Andrew F. Davis)
Date: Wed, 31 Aug 2016 11:40:20 -0500
Subject: [PATCH v11 3/4] tee: add OP-TEE driver
In-Reply-To: <20160831135015.GB25472@ermac>
References: <1471870856-18684-1-git-send-email-jens.wiklander@linaro.org>
 <1471870856-18684-4-git-send-email-jens.wiklander@linaro.org>
 <050a2ce4-e175-d09e-ddff-3b0cbe766d88@ti.com> <20160831135015.GB25472@ermac>
Message-ID: <fe88749e-82c7-c310-b2bc-4e73bf76302b@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/31/2016 08:50 AM, Jens Wiklander wrote:
> On Tue, Aug 30, 2016 at 03:23:24PM -0500, Andrew F. Davis wrote:
>> On 08/22/2016 08:00 AM, Jens Wiklander wrote:
>>> +static struct tee_shm_pool *
>>> +optee_config_shm_ioremap(struct device *dev, optee_invoke_fn *invoke_fn,
>>> +			 void __iomem **ioremaped_shm)
>>> +{
>>> +	struct arm_smccc_res res;
>>> +	struct tee_shm_pool *pool;
>>> +	unsigned long vaddr;
>>> +	phys_addr_t paddr;
>>> +	size_t size;
>>> +	phys_addr_t begin;
>>> +	phys_addr_t end;
>>> +	void __iomem *va;
>>> +	struct tee_shm_pool_mem_info priv_info;
>>> +	struct tee_shm_pool_mem_info dmabuf_info;
>>> +
>>> +	invoke_fn(OPTEE_SMC_GET_SHM_CONFIG, 0, 0, 0, 0, 0, 0, 0, &res);
>>> +	if (res.a0 != OPTEE_SMC_RETURN_OK) {
>>> +		dev_info(dev, "shm service not available\n");
>>> +		return ERR_PTR(-ENOENT);
>>> +	}
>>> +
>>> +	if (res.a3 != OPTEE_SMC_SHM_CACHED) {
>>> +		dev_err(dev, "only normal cached shared memory supported\n");
>>> +		return ERR_PTR(-EINVAL);
>>> +	}
>>> +
>>> +	begin = roundup(res.a1, PAGE_SIZE);
>>> +	end = rounddown(res.a1 + res.a2, PAGE_SIZE);
>>
>> res.a1/2/3 is really hard to review and understand, would it work better
>> to use a union or cast for the output of invoke_fn based on the function
>> type?
>>
>> In the header that defines what the returned info from these calls means
>> add:
>>
>> struct OPTEE_SMC_GET_SHM_CONFIG_RESULT {
>> 	unsigned long status;
>> 	unsigned long start;
>> 	unsigned long size;
>> 	unsigned long settings;
>> };
>>
>> then:
>>
>> union something result;
>>
>> begin = roundup(result.ret.start, PAGE_SIZE);
>> end = rounddown(result.ret.start + result.ret.size, PAGE_SIZE);
>>
>> or similar with just casting to the better named struct type.
> 
> optee_smc.h describes what's passed in the registers during an SMC I'd
> rather not clutter it with structs that doesn't add any information
> there. I'm not that happy with casting or using unions to alias struct
> arm_smccc_res either. How about a simple wrapper function for this call
> to deal with the details instead?
> 

I think that would be a good idea anyway, for instance, someday if the
interface changes slightly then you will be able to contain the
compatibility fixes in the wrapper and not out here in the main driver.

>>> +static int optee_remove(struct platform_device *pdev)
>>> +{
>>> +	struct optee *optee = platform_get_drvdata(pdev);
>>> +
>>> +	optee_disable_shm_cache(optee);
>>> +
>>> +	tee_device_unregister(optee->teedev);
>>> +	tee_device_unregister(optee->supp_teedev);
>>> +	tee_shm_pool_free(optee->pool);
>>> +	if (optee->ioremaped_shm)
>>> +		iounmap(optee->ioremaped_shm);
>>> +	optee_wait_queue_exit(&optee->wait_queue);
>>> +	optee_supp_uninit(&optee->supp);
>>> +	mutex_destroy(&optee->call_queue.mutex);
>>
>> Can these be reordered to match the reverse of the order they are used
>> in probe?
> 
> Not entirely, optee->teedev and optee->supp_teedev can be unregisterted
> in the reverse order but both has to complete before we can get any
> further.  I'll add some comments.
> 

That would be great, thanks.

>>
>>> +	return 0;
>>> +}
>>> +
>>
>> [snip]
>>
>>> +#define OPTEE_MSG_ATTR_CACHE_SHIFT		16
>>> +#define OPTEE_MSG_ATTR_CACHE_MASK		0x7
>>
>> GENMASK
> 
> Do you mean that OPTEE_MSG_ATTR_CACHE_MASK should be defined using the
> GENMASK() macro? If so I guess I should update OPTEE_MSG_ATTR_TYPE_MASK
> also.
> 

Right, I can tell what bits 0x7 mask, but sometimes it's not so easy
(7F8, etc) so I find it's best to use GENMASKS for all masks so I don't
have to ever think about it at all.

Also I like to mask then shift, so it would be:

#define OPTEE_MSG_ATTR_CACHE_SHIFT	16
#define OPTEE_MSG_ATTR_CACHE_MASK	GENMASK(18, 16)

Then we can see at a glance the actual bits we are looking for (18-16)
and verify the shift is the right amount.

Thanks,
Andrew
