From: pranav.sawargaonkar@gmail.com (Pranav Sawargaonkar)
Date: Mon, 20 Jun 2016 21:12:58 +0530
Subject: [PATCH v9 0/7] KVM PCIe/MSI passthrough on ARM/ARM64: kernel part
 3/3: vfio changes
In-Reply-To: <e379ffed-6a73-d18a-1af9-a49b096d3f60@redhat.com>
References: <1462362858-2925-1-git-send-email-eric.auger@linaro.org>
 <573F34CA.5080308@linaro.org>
 <875b5791-f7c9-97ca-46de-4b1474fe65e0@linaro.org>
 <20160608150609.7e28d63d@ul30vt.home>
 <e379ffed-6a73-d18a-1af9-a49b096d3f60@redhat.com>
Message-ID: <CAP_HG2umBnV_88WGW20_oQ2X9zMxZKQJ952tQY_0=023R2AKjg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Eric,

Tested this series on APM X-Gene2 with E1000 and sata sil card.
Tested-By: Pranavkumar Sawargaonkar <psawargaonkar@apm.com>

Thanks,
Pranav


On Thu, Jun 9, 2016 at 1:25 PM, Auger Eric <eric.auger@redhat.com> wrote:
> Alex,
>> On Wed, 8 Jun 2016 10:29:35 +0200
>> Auger Eric <eric.auger@linaro.org> wrote:
>>
>>> Dear all,
>>> Le 20/05/2016 ? 18:01, Eric Auger a ?crit :
>>>> Alex, Robin,
>>>>
>>>> While my 3 part series primarily addresses the problematic of mapping
>>>> MSI doorbells into arm-smmu, it fails in :
>>>>
>>>> 1) determining whether the MSI controller is downstream or upstream to
>>>> the IOMMU,
>>>>     => indicates whether the MSI doorbell must be mapped
>>>>     => participates in the decision about 2)
>>>>
>>>> 2) determining whether it is safe to assign a PCIe device.
>>>>
>>>> I think we share this understanding with Robin. All above of course
>>>> stands for ARM.
>>>>
>>>> I get stuck with those 2 issues and I have few questions about iommu
>>>> group setup, PCIe, iommu dt/ACPI description. I would be grateful to you
>>>> if you could answer part of those questions and advise about the
>>>> strategy to fix those.
>>>
>>> gentle reminder about the questions below; hope I did not miss any reply.
>>> If anybody has some time to spent on this topic...
>>>
>>>>
>>>> Best Regards
>>>>
>>>> Eric
>>>>
>>>> QUESTIONS:
>>>>
>>>> 1) Robin, you pointed some host controllers which also are MSI
>>>> controllers
>>>> (http://thread.gmane.org/gmane.linux.kernel.pci/47174/focus=47268). In
>>>> that case MSIs never reach the IOMMU. I failed in finding anything about
>>>> MSIs in PCIe ACS spec. What should be the iommu groups in that
>>>> situation. Isn't the upstreamed code able to see some DMA transfers are
>>>> not properly isolated and alias devices in the same group? According to
>>>> your security warning, Alex, I would think the code does not recognize
>>>> it, can you confirm please?
>>> my current understanding is end points would be in separate groups (assuming
>>> ACS support) although MSI controller frame is not properly protected.
>>
>> We don't currently consider MSI differently from other DMA and we don't
>> currently have any sort of concept of a device within the intermediate
>> fabric as being a DMA target.  We expect fabric devices to only be
>> transaction routers.  We use ACS to determine whether there's any
>> possibility of DMA being redirected before it reaches the IOMMU, but it
>> seems that a DMA being consumed by an interrupt controller before it
>> reaches the IOMMU would be another cause for an isolation breach.
>>
> OK thank you for the confirmation
>>>> 2) can other PCIe components be MSI controllers?
>>
>> I'm not even entirely sure what this means.  Would a DMA write from an
>> endpoint target the MMIO space of an intermediate, fabric device?
> With the example provided by Robin we have a host controller acting as
> an MSI controller. I wondered whether we could have some other fabric
> devices (downstream to the host controller in PCIe terminology) also
> likely to act as MSI controllers.
>>
>>>> 3) Am I obliged to consider arbitrary topologies where an MSI controller
>>>> stands between the PCIe host and the iommu? in the PCIe space or
>>>> platform space? If this only relates to PCIe couldn' I check if an MSI
>>>> controller exists in the PCIe tree?
>>> In my last series, I consider the assignment of platform device unsafe as
>>> soon as there is a GICv2m. This is a change in the user experience compared to
>>> what we have before.
>>
>> If the MSI controller is downstream of our DMA translation, it doesn't
>> seem like we have much choice but to mark it unsafe.  The endpoint is
>> fully able to attempt to exploit it.
> OK the orginal question was related to non PCIe topologies:
>
> - we know some PCIe fabric topologies where the PCIe host controller
> implements MSI controller.
> - Shall we be prepared to address the same kind of issues with platform
> MSI controllers. Are there some SOCs where we would put an unsafe MSI
> platform controller before IOMMU translation. Or do we consider it is a
> platform topology we don't support for assignment?
>
>>
>>>> 4) Robin suggested in a private thread to enumerate through a list of
>>>> "registered" doorbells and if any belongs to an unsafe MSI controller,
>>>> consider the assignment is unsafe. This would be a first step before
>>>> doing something more complex. Alex, would that be acceptable to you for
>>>> issue #2?
>>> I implemented this technique in my last series waiting for more discussion
>>> on 4, 5.
>>
>> Seems sufficient.  I don't mind taking a broad swing versus all the
>> extra complexity of defining which devices are safe vs unsafe.
> OK
>>
>>>> 5) About issue #1: don't we miss tools in dt/ACPI to describe the
>>>> location of the iommu on ARM? This is not needed on x86 because
>>>> irq_remapping and IOMMU are at the same place but my understanding is
>>>> that it is on ARM where
>>>> - there is no connection between the MSI controller - which implements
>>>> irq remapping - and the iommu
>>>> - MSI are conveyed on the same address space as standard memory
>>>> transactions.
>>
>> It seems pretty dubious to me to have fixed address, unprotected MSI
>> controllers sitting in the DMA space of a device before IOMMU
>> translation.
> same for me ;-)
>   Seems like you not only need to mark interrupts as
>> unsafe, but exclude the address space of the MSI controller from the
>> available IOVA space to the user.
> I currently do not see how to achieve that. The guest can program the
> assigned device DMA target address with the MSI frame PA. there is no
> IOMMU to protect. How can we make it if we don't trap on DMA programming?
>>
>>>> 6)  can't we live with iommu/MSI controller respective location uncertainty?
>>>>
>>>> - in my current series, with the above Xilinx MSI controller, I would
>>>> see there is an arm-smmu requiring mapping behind the PCI host, would
>>>> query the characteristics of the MSI doorbell (not implemented by that
>>>> controller), so no mapping would be done. So it would work I think.
>>>> - However in case we have this topology: PCIe host -> MSI controller
>>>> generally used behind an IOMMU (so registering a doorbell) -> IOMMU,
>>>> this wouldn't work since the doorbell would be mapped.
>>
>> I'm a little confused which direction "behind" is here, but it seems
>> like any time the MSI controller lives in the DMA address space of the
>> endpoint, both interfering with the available IOVA space to the user
>> and potentially an attack vector for the user, we need to call it out
>> as unsafe.  Maybe some of them are for exclusive use of the device and
>> the attack vector is relatively contained, but they still affect the
>> IOVA space of the user.  Such a configuration might be safe, but as I
>> said I'm not opposed to being pretty liberal in applying the unsafe
>> requirement if the platform has done something unfriendly.  Thanks,
> OK that's clear.
>
> Thank you for your feedbacks
>
> Best Regards
>
> Eric
>>
>> Alex
>>
