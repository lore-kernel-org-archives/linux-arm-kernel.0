From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Fri, 22 Jul 2016 14:00:33 +0300
Subject: [PATCH 2/7] dmaengine: omap-dma: Complete the cookie first on
 transfer completion
In-Reply-To: <20160721094704.GL5783@n2100.arm.linux.org.uk>
References: <20160714124242.7579-1-peter.ujfalusi@ti.com>
 <20160714124242.7579-3-peter.ujfalusi@ti.com>
 <20160718103409.GH5783@n2100.arm.linux.org.uk>
 <923b54d6-c7fc-66c2-1c20-d8d74ebed912@ti.com> <877fcg25c4.fsf@belgarion.home>
 <f18ced07-39e4-c336-b788-254c2c130f82@ti.com>
 <20160721094704.GL5783@n2100.arm.linux.org.uk>
Message-ID: <a4b6fc99-13a9-b78f-b395-8b3e5eb30642@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/21/16 12:47, Russell King - ARM Linux wrote:
> On Thu, Jul 21, 2016 at 12:33:12PM +0300, Peter Ujfalusi wrote:
>> On 07/20/16 09:26, Robert Jarzmik wrote:
>>> Speaking of which, from a purely design point of view, as long as you think
>>> beforehand what is your sequence, ie. what is the sequence of your link
>>> chaining, completion handling, etc ..., both marking before or after next tx
>>> start should be fine IMHO.
>>
>> Yes, it might be a bit better from performance point of view if we first start
>> the pending descriptor (if there is one) then do the vchan_cookie_complete().
>> On the other hand if we care more about latency and accuracy we should
>> complete the transfer first then look for pending descriptors. But since
>> virt_dma is using a tasklet for the real completion, the latency is always
>> going to be when the tasklet is given the chance to execute.
> 
> I think this shows a slight misunderstanding of the DMA engine API.  The
> DMA completion is defined by the API to always happen in tasklet context,
> which is why the virt-dma stuff does it that way - and all other DMA
> engine drivers.  It's one of the fundamentals of the API.
> 
> As it happens in tasklet context, tasklets can be scheduled to run with
> variable latency, so any use of the DMA engine API which has a predictable
> latency around the completion handling is going to be unreliable.
> 
> Remember also that with circular buffers, there's no guarantee of getting
> period-based completion callbacks - several periods can complete and you
> are only guaranteed to get one completion callback.
> 
> So, the idea that completion callbacks can have anything to do with low
> latency or accuracy is totally incorrect.

Thanks for refreshing my memory, you are absolutely right.

-- 
P?ter
