From: sdu.liu@huawei.com (Liu hua)
Date: Mon, 14 Jul 2014 11:22:26 +0800
Subject: [RFC PATCH 0/2] irqchip: GIC: check and clear GIC interupt active
 status
In-Reply-To: <20140711123507.GE12899@arm.com>
References: <1405061177-43834-1-git-send-email-sdu.liu@huawei.com>
 <20140711123507.GE12899@arm.com>
Message-ID: <53C34CF2.5050209@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2014/7/11 20:35, Will Deacon wrote:
> [adding Marc]
> 
> On Fri, Jul 11, 2014 at 07:46:15AM +0100, Liu Hua wrote:
>> For this version of GIC codes, kernel assumes that all the interrupt
>> status of GIC is inactive. So the kernel does not check this when 
>> booting.
>>
>> This is no problem on must sitations. But when kdump is deplayed.
>> And a panic occurs when a interrupt is being handled (may be PPI 
>> and SPI). We have no chance to write relative bit to GICC_EOIR.
>> So this interrupt remains active. And GIC will not deliver this
>> type interrupt to cpu interface. And the capture kernel may 
>> fail to boot becase of lacking of certain interrupt (such as timer 
>> interupt).
>>
>>
>> I glanced over the GIC Architecture Specification, but did not 
>> find a simple way to deactive state of all interrupts. For GICv1,
>> I can only deal with one abnormal interrupt state one time. For 
>> GICv2, I can deactive 32 one time.
>>
>>
>> So guys, Do you know a better way to do that? 
> 
> What happens if, in the crash kernel, you disable the CPU interfaces
> (GICC_CTLR.ENABLE) then disable the distributor (GICD_CTLR.ENABLE) before
> enabling everything again in the reverse order? Is that enough to cause the
> GIC to drop any active states? It's not clear to me from a quick look at
> the TRM.
> 
Hi Will,

Thanks for your reply!

I did what you said at the beginning of "gic_dist_init". The active states
remained (panic in local timer interrupt (PPI))and the kernel failed to boot,
Did I do that at wrong place?

-------------------
diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index b6b0a81..94d6352 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -454,6 +455,7 @@ static void __init gic_dist_init(struct gic_chip_data *gic)
        void __iomem *base = gic_data_dist_base(gic);
        void __iomem *cpu_base = gic_data_cpu_base(gic);

+ writel_relaxed(0, base + GIC_CPU_CTRL);
        writel_relaxed(0, base + GIC_DIST_CTRL);

        /*
------------------------

As shown in GIC Architecture Specification manual,I think that the GICC_CTLR.ENABLE
and GICD_CTLR.ENABLE only control the delivering of the interrupt, not the active
states.

As GIC manual says "For every read of a valid Interrupt ID from the GICC_IAR, the
connected processor must perform a matching write to the GICC_EOIR". So we should
find a way to drop the active states when booting, if we do not remain these active
states by design.

Thanks,
Liu Hua




> Will
> 
> .
> 
