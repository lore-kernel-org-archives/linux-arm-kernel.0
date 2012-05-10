From: vinod.koul@linux.intel.com (Vinod Koul)
Date: Thu, 10 May 2012 16:31:15 +0530
Subject: Cyclic DMA - callback properties and tx_status residue
In-Reply-To: <20120510094205.GM3908@opensource.wolfsonmicro.com>
References: <20120502144555.GA4456@n2100.arm.linux.org.uk>
 <1335974475.1593.20.camel@vkoul-udesk3>
 <20120502162702.GE3548@n2100.arm.linux.org.uk>
 <CACRpkdYTpP_nW+CJiJNPLgU6fXtR6ku3-OQaA4ceYtB3ZM5sqQ@mail.gmail.com>
 <20120509093334.GS26481@n2100.arm.linux.org.uk>
 <20120509111614.GH3955@opensource.wolfsonmicro.com>
 <20120509121945.GT26481@n2100.arm.linux.org.uk>
 <1336621458.1540.280.camel@vkoul-udesk3>
 <20120510094205.GM3908@opensource.wolfsonmicro.com>
Message-ID: <1336647675.15424.390.camel@vkoul-udesk3>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2012-05-10 at 10:42 +0100, Mark Brown wrote:
> On Thu, May 10, 2012 at 09:14:18AM +0530, Vinod Koul wrote:
> 
> > For audio needs I think it is fine if we miss, as long as subsequent
> > comes untill we get underrun/overrun.
> 
> No, - this is what Russell has been reporting.  Due to the lack of
> position callbacks the ASoC dmaengine stuff is counting completions to
> work out where it is in the buffer.  If we miss completions then the
> drivers will start to loose track of where they are in the buffer.  If
> we had usable position reporting this would work OK, or if the ASoC code
> were changed to remember where each buffer ends and get that information
> passed back in the completion argument then it could recover that way
> (but that's fairly painful).

This should not be in ASoC library. The driver should be able to detect
if a tasklet was called for many dma completions and notify the client
(soc-lib) accordingly.

One way to do this would be to ensure that the descriptor is marked in
irq_handler and then all descriptor completed notified in tasklet.


-- 
~Vinod
