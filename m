From: geethasowjanya.akula@gmail.com (Geetha Akula)
Date: Tue, 27 Jun 2017 20:28:14 +0530
Subject: [Devel] [RESEND PATCH v9 3/3] iommu/arm-smmu-v3: Add workaround
 for Cavium ThunderX2 erratum #126
In-Reply-To: <20170627140559.GK14041@arm.com>
References: <1498224876-5200-1-git-send-email-gakula@caviumnetworks.com>
 <20170627135610.GX658@rric.localdomain> <20170627140559.GK14041@arm.com>
Message-ID: <CANHdaibSGtbdQfZ2kv1E9t4eE+JY2wtsDP7=rEw-mj059yhyHA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 27, 2017 at 7:36 PM, Will Deacon <will.deacon@arm.com> wrote:
> On Tue, Jun 27, 2017 at 03:56:10PM +0200, Robert Richter wrote:
>> On 23.06.17 19:04:36, Geetha sowjanya wrote:
>> > From: Geetha Sowjanya <geethasowjanya.akula@cavium.com>
>> >
>> > Cavium ThunderX2 SMMU doesn't support MSI and also doesn't have unique irq
>> > lines for gerror, eventq and cmdq-sync.
>> >
>> > New named irq "combined" is set as a errata workaround, which allows to
>> > share the irq line by register single irq handler for all the interrupts.
>> >
>> > Signed-off-by: Geetha sowjanya <gakula@caviumnetworks.com>
>> > ---
>> >  Documentation/arm64/silicon-errata.txt             |    1 +
>> >  .../devicetree/bindings/iommu/arm,smmu-v3.txt      |    6 +
>> >  drivers/acpi/arm64/iort.c                          |   57 ++++++++---
>> >  drivers/iommu/arm-smmu-v3.c                        |  100 ++++++++++++++-----
>> >  4 files changed, 121 insertions(+), 43 deletions(-)
>>
>> > +static int arm_smmu_setup_irqs(struct arm_smmu_device *smmu)
>> > +{
>> > +   int ret, irq;
>> > +   u32 irqen_flags = IRQ_CTRL_EVTQ_IRQEN | IRQ_CTRL_GERROR_IRQEN;
>> > +
>> > +   /* Disable IRQs first */
>> > +   ret = arm_smmu_write_reg_sync(smmu, 0, ARM_SMMU_IRQ_CTRL,
>> > +                                 ARM_SMMU_IRQ_CTRLACK);
>> > +   if (ret) {
>> > +           dev_err(smmu->dev, "failed to disable irqs\n");
>> > +           return ret;
>> > +   }
>> > +
>> > +   irq = smmu->combined_irq;
>> > +   if (irq) {
>> > +           /*
>> > +            * Cavium ThunderX2 implementation doesn't not support unique
>> > +            * irq lines. Use single irq line for all the SMMUv3 interrupts.
>> > +            */
>> > +           ret = devm_request_threaded_irq(smmu->dev, irq,
>> > +                                   arm_smmu_combined_irq_handler,
>> > +                                   arm_smmu_combined_irq_thread,
>> > +                                   IRQF_ONESHOT,
>>
>> Without the IRQF_SHARED flag set I see the following on a dual node
>> system now:
Node1 SMMU interrupts are programmed wrong in the firmware.
Node 0 and Node1 SMMU do not share interrupts.
I have verified the patch on dual node with correct interrupt numbers
programmed in firmware.


Thanks,
Geetha.
>
> We asked about that before:
>
> https://marc.info/?l=linux-arm-kernel&m=149803613513068&w=2
> https://marc.info/?l=linux-acpi&m=149803744713475&w=2
>
> and Geetha didn't reply, but the next version of the patch dropped the flag.
> Is it just that firmware is misprogramming something here, or something
> more fundamental?
>
> Will
