From: s-anna@ti.com (Suman Anna)
Date: Wed, 10 Aug 2016 15:11:11 -0500
Subject: [PATCH 1/9] remoteproc: core: Ensure error message is clear
In-Reply-To: <20160809181243.GC1581@dell>
References: <20160804092153.23032-1-lee.jones@linaro.org>
 <20160804092153.23032-2-lee.jones@linaro.org> <20160809172825.GB26240@tuxbot>
 <20160809181243.GC1581@dell>
Message-ID: <68ec0dd7-676d-47a9-19ba-9dcfc9569902@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/09/2016 01:12 PM, Lee Jones wrote:
> On Tue, 09 Aug 2016, Bjorn Andersson wrote:
> 
>> On Thu 04 Aug 02:21 PDT 2016, Lee Jones wrote:
>>
>>> Before this patch, the dma_alloc_coherent() failure path printed out:
>>>
>>>   "dma_alloc_coherent err: 16760832"
>>>
>>> ... alluding to the Linux error code being 16760832, but seeing as
>>> Linux error codes are all negative, this looks like a signed/unsigned
>>> issue.  In fact, the message is trying to print the length of the
>>> requested memory region.  Let's clear that up.
>>>
>>> While we're at it, let's standardise the way 'len' is printed.  In
>>> all other locations 'len' is in hex prefixed by a '0x' for clarity.
>>>
>>> Signed-off-by: Lee Jones <lee.jones@linaro.org>
>>
>> Acked-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> 
> Again, this can just be applied.
> 
>>> ---
>>>  drivers/remoteproc/remoteproc_core.c | 5 +++--
>>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
>>> index aea29a75c..3566dc9 100644
>>> --- a/drivers/remoteproc/remoteproc_core.c
>>> +++ b/drivers/remoteproc/remoteproc_core.c
>>> @@ -581,7 +581,7 @@ static int rproc_handle_carveout(struct rproc *rproc,
>>>  		return -EINVAL;
>>>  	}
>>>  
>>> -	dev_dbg(dev, "carveout rsc: da %x, pa %x, len %x, flags %x\n",
>>> +	dev_dbg(dev, "carveout rsc: da %x, pa %x, len 0x%x, flags %x\n",
>>>  			rsc->da, rsc->pa, rsc->len, rsc->flags);

If you are modifying this trace, it's better to following the leading 0x
convention on all arguments rather than just the length.

regards
Suman

>>>  
>>>  	carveout = kzalloc(sizeof(*carveout), GFP_KERNEL);
>>> @@ -590,7 +590,8 @@ static int rproc_handle_carveout(struct rproc *rproc,
>>>  
>>>  	va = dma_alloc_coherent(dev->parent, rsc->len, &dma, GFP_KERNEL);
>>>  	if (!va) {
>>> -		dev_err(dev->parent, "dma_alloc_coherent err: %d\n", rsc->len);
>>> +		dev_err(dev->parent,
>>> +			"failed to allocate dma memory: len 0x%x\n", rsc->len);
>>>  		ret = -ENOMEM;
>>>  		goto free_carv;
>>>  	}
> 
