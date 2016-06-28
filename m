From: vinod.koul@intel.com (Vinod Koul)
Date: Tue, 28 Jun 2016 09:44:41 +0530
Subject: [PATCH v10 2/2] dmaengine: Add Xilinx zynqmp dma engine driver
 support
In-Reply-To: <03CA77BA8AF6F1469AEDFBDA1322A7B74A18BB82@XAP-PVEXMBX02.xlnx.xilinx.com>
References: <20160607070841.GJ16910@localhost>
 <C246CAC1457055469EF09E3A7AC4E11A4A5B4FA9@XAP-PVEXMBX01.xlnx.xilinx.com>
 <20160613055012.GC16910@localhost>
 <C246CAC1457055469EF09E3A7AC4E11A4A5B6441@XAP-PVEXMBX01.xlnx.xilinx.com>
 <20160615165004.GC16910@localhost>
 <C246CAC1457055469EF09E3A7AC4E11A4A5B6CAD@XAP-PVEXMBX01.xlnx.xilinx.com>
 <20160621154103.GA16910@localhost>
 <03CA77BA8AF6F1469AEDFBDA1322A7B74A18BAE8@XAP-PVEXMBX02.xlnx.xilinx.com>
 <20160621163854.GF16910@localhost>
 <03CA77BA8AF6F1469AEDFBDA1322A7B74A18BB82@XAP-PVEXMBX02.xlnx.xilinx.com>
Message-ID: <20160628041441.GQ22564@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 21, 2016 at 05:29:42PM +0000, Punnaiah Choudary Kalluri wrote:
> 
> Ok agree with you for the scenario that I have mentioned above.
> 
> Other simple dma mode feature that I missed to explain is configuring the 
> Dma descriptors. It provides a register interface for configuring the dma transaction.
> So, no need to maintain the descriptors in memory and it will be useful for the system 
> that are in crunch of memory.  

And why are these not coming out in the first place, which makes me think it
is fishy!

Do you mean programming DMA descriptors to hardware and you can use
registers instead of memory?

> 
> How do you want us to handle this case?
> 

> > Okay I am convince now this is not right approach. Please remove this
> > custom interface and then implement slave for required slave scenarios!
> >
> 
> Assume controller is having 8 channels and four of them are used for slave
> Dma and others are for memcpy.
> Controller didn't have the per channel priority control but providing the rate control
> Mechanism. 

How does the use of few for memcpy and few for slave change things? IMO it
doesn't, you program the channel accordingly

> 
> So, I need some interface for configuring the rate control per channel at run time irrespective
> Of whether the channel is allocated for slave dma or memcpy dma.

why?

> Is it wrong having the configurable dma parameters for dma memcpy operation? We are exposing the
> Hw capabilities to the user for better dma transaction management.

For memcpy yes. Memcpy is a generic case where people do not do driver
specific stuff. So I tend ot push back on that..

For slave, existing APIs allow you to program the additional parameters..
FWIW, rate control is a generic parameter which if you justify enough can be
added to dma_slave_config

Thanks
-- 
~Vinod
