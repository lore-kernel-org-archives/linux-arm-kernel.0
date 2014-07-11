From: will.deacon@arm.com (Will Deacon)
Date: Fri, 11 Jul 2014 13:35:07 +0100
Subject: [RFC PATCH 0/2] irqchip: GIC: check and clear GIC interupt
 active status
In-Reply-To: <1405061177-43834-1-git-send-email-sdu.liu@huawei.com>
References: <1405061177-43834-1-git-send-email-sdu.liu@huawei.com>
Message-ID: <20140711123507.GE12899@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[adding Marc]

On Fri, Jul 11, 2014 at 07:46:15AM +0100, Liu Hua wrote:
> For this version of GIC codes, kernel assumes that all the interrupt
> status of GIC is inactive. So the kernel does not check this when 
> booting.
> 
> This is no problem on must sitations. But when kdump is deplayed.
> And a panic occurs when a interrupt is being handled (may be PPI 
> and SPI). We have no chance to write relative bit to GICC_EOIR.
> So this interrupt remains active. And GIC will not deliver this
> type interrupt to cpu interface. And the capture kernel may 
> fail to boot becase of lacking of certain interrupt (such as timer 
> interupt).
> 
> 
> I glanced over the GIC Architecture Specification, but did not 
> find a simple way to deactive state of all interrupts. For GICv1,
> I can only deal with one abnormal interrupt state one time. For 
> GICv2, I can deactive 32 one time.
> 
> 
> So guys, Do you know a better way to do that? 

What happens if, in the crash kernel, you disable the CPU interfaces
(GICC_CTLR.ENABLE) then disable the distributor (GICD_CTLR.ENABLE) before
enabling everything again in the reverse order? Is that enough to cause the
GIC to drop any active states? It's not clear to me from a quick look at
the TRM.

Will
