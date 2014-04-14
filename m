From: nsekhar@ti.com (Sekhar Nori)
Date: Mon, 14 Apr 2014 17:42:37 +0530
Subject: [PATCH v2 05/14] arm: common: edma: Select event queue 1 as
 default when booted with DT
In-Reply-To: <534BCCD3.9060805@ti.com>
References: <1396357575-30585-1-git-send-email-peter.ujfalusi@ti.com>
 <1396357575-30585-6-git-send-email-peter.ujfalusi@ti.com>
 <5347A4FD.1030803@ti.com> <5347ACDE.7040407@ti.com> <5347AE49.5020109@ti.com>
 <5347B7F8.2000508@ti.com> <20140411094217.GA32284@intel.com>
 <5347D2CC.4030407@ti.com> <20140411113154.GB32284@intel.com>
 <5347DEDA.2060008@ti.com> <20140411124641.GC32284@intel.com>
 <534BCCD3.9060805@ti.com>
Message-ID: <534BD0B5.5000004@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 14 April 2014 05:26 PM, Peter Ujfalusi wrote:
> Hi Vinod,
> 
> On 04/11/2014 03:46 PM, Vinod Koul wrote:
>> I think the number shouldn't be viewed in absolute terms. If we decide that (lets
>> say) 0-7, then any controller should map 0 to lowest and 7 to highest.
>>
>> For your case you can do this and then intermediate numbers would be medium
>> priority. Such a system might work well...
>>
>> Also how would a client driver know which priority to use? Would it come from
>> DT?
> 
> I think DT would be the best place.

In the strict sense of what DT is supposed to represent, DT is not the
best place for this. Priority is usecase driven rather that hardware
description driven. So on a reasonably less loaded system, I am sure you
could run audio even with a lower priority DMA queue.

Moreover, IMHO, encoding it in DT now will make it an ABI. Without a
wide variety of example use cases, I think it is too early to commit to
an ABI.

> Not sure if we should set the range for this either. What I was thinking is to
> add an optional new property to be set by the client nodes, using DMA:
> 
> mcasp0: mcasp at 48038000 {
> 	compatible = "ti,am33xx-mcasp-audio";
> 	...
> 	dmas =	<&edma 8>,
> 		<&edma 9>;
> 	dma-names = "tx", "rx";
> 	dma-priorities = <2>, <2>;
> };
> 
> We could agree that lower number means lower priority, higher is - well -
> higher priority.
> If the dma-priority is missing we should assume lowest priority (0).
> The highest priority depends on the platform. For eDMA3 in AM335x it is three
> level. For designware controller you might have the range 0-8 as valid.
> 
> The question is how to get this information into use?
> We can take the priority number in the core when the dma channel is requested
> and add field to "struct dma_chan" in order to store it and the DMA drivers
> could have access to it.
> In this way we only need to update the nodes which needs non default priority
> for DMA.
> 
> What do you think?

If we are using dma_slave_config, I think it will be easiest to define
two levels of priority (HIGH and LOW, as thats all we see a need for
right now), and have the audio driver select the HIGH priority. If
nothing is set, EDMA can default to LOW.

Thanks,
Sekhar
