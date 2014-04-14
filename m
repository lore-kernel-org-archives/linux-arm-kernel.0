From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Mon, 14 Apr 2014 14:56:03 +0300
Subject: [PATCH v2 05/14] arm: common: edma: Select event queue 1 as
 default when booted with DT
In-Reply-To: <20140411124641.GC32284@intel.com>
References: <1396357575-30585-1-git-send-email-peter.ujfalusi@ti.com>
 <1396357575-30585-6-git-send-email-peter.ujfalusi@ti.com>
 <5347A4FD.1030803@ti.com> <5347ACDE.7040407@ti.com> <5347AE49.5020109@ti.com>
 <5347B7F8.2000508@ti.com> <20140411094217.GA32284@intel.com>
 <5347D2CC.4030407@ti.com> <20140411113154.GB32284@intel.com>
 <5347DEDA.2060008@ti.com> <20140411124641.GC32284@intel.com>
Message-ID: <534BCCD3.9060805@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vinod,

On 04/11/2014 03:46 PM, Vinod Koul wrote:
> I think the number shouldn't be viewed in absolute terms. If we decide that (lets
> say) 0-7, then any controller should map 0 to lowest and 7 to highest.
> 
> For your case you can do this and then intermediate numbers would be medium
> priority. Such a system might work well...
> 
> Also how would a client driver know which priority to use? Would it come from
> DT?

I think DT would be the best place.
Not sure if we should set the range for this either. What I was thinking is to
add an optional new property to be set by the client nodes, using DMA:

mcasp0: mcasp at 48038000 {
	compatible = "ti,am33xx-mcasp-audio";
	...
	dmas =	<&edma 8>,
		<&edma 9>;
	dma-names = "tx", "rx";
	dma-priorities = <2>, <2>;
};

We could agree that lower number means lower priority, higher is - well -
higher priority.
If the dma-priority is missing we should assume lowest priority (0).
The highest priority depends on the platform. For eDMA3 in AM335x it is three
level. For designware controller you might have the range 0-8 as valid.

The question is how to get this information into use?
We can take the priority number in the core when the dma channel is requested
and add field to "struct dma_chan" in order to store it and the DMA drivers
could have access to it.
In this way we only need to update the nodes which needs non default priority
for DMA.

What do you think?

-- 
P?ter
