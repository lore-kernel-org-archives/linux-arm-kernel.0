From: jean-philippe.brucker@arm.com (Jean-Philippe Brucker)
Date: Wed, 6 Sep 2017 10:57:34 +0100
Subject: [RFC PATCH 0/6] Add platform device SVM support for ARM SMMUv3
In-Reply-To: <caf68193-6aff-1e1c-86cd-9cc7069b0e37@huawei.com>
References: <1504167642-14922-1-git-send-email-xieyisheng1@huawei.com>
 <95d1a9e2-1816-ff7d-9a8d-98406a6c2c22@arm.com>
 <caf68193-6aff-1e1c-86cd-9cc7069b0e37@huawei.com>
Message-ID: <2874a1f3-22f1-20d4-4009-50add127a10f@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/09/17 02:02, Bob Liu wrote:
> On 2017/9/5 20:56, Jean-Philippe Brucker wrote:
>> On 31/08/17 09:20, Yisheng Xie wrote:
>>> Jean-Philippe has post a patchset for Adding PCIe SVM support to ARM SMMUv3:
>>> https://www.spinics.net/lists/arm-kernel/msg565155.html
>>>
>>> But for some platform devices(aka on-chip integrated devices), there is also
>>> SVM requirement, which works based on the SMMU stall mode.
>>> Jean-Philippe has prepared a prototype patchset to support it:
>>> git://linux-arm.org/linux-jpb.git svm/stall
>>
>> Only meant for testing at that point, and unfit even for an RFC.
>>
> 
> Sorry for the misunderstanding.
> The PRI mode patches is in RFC even no hardware for testing, so I thought it's fine for "Stall mode" patches sent as RFC.
> We have tested the Stall mode on our platform.
> Anyway, I should confirm with you in advance.
> 
> Btw, Would you consider the "stall mode" upstream at first? Since there is no hardware for testing the PRI mode.
> (We can provide you the hardware which support SMMU stall mode if necessary.)

Yes. What's blocking the ATS, PRI and PASID patches at the moment is the
lack of endpoints for testing. There has been lots of discussion on the
API side since my first RFC and I'd like to resubmit the API changes soon.
It is the same API for ATS+PRI+PASID and SSID+Stall, so the backend
doesn't matter.

I'm considering upstreaming SSID+Stall first if it can be tested on
hardware (having direct access to it would certainly speed things up).
This would require some work in moving the PCI bits at the end of the
series. I can reserve some time in the coming months to do it, but I need
to know what to focus on. Are you able to test SSID as well?

>>> We tested this patchset with some fixes on a on-chip integrated device. The
>>> basic function is ok, so I just send them out for review, although this
>>> patchset heavily depends on the former patchset (PCIe SVM support for ARM
>>> SMMUv3), which is still under discussion.
>>>
>>> Patch Overview:
>>> *1 to 3 prepare for device tree or acpi get the device stall ability and pasid bits
>>> *4 is to realise the SVM function for platform device
>>> *5 is fix a bug when test SVM function while SMMU donnot support this feature
>>> *6 avoid ILLEGAL setting of STE and CD entry about stall
>>>
>>> Acctually here, I also have a question about SVM on SMMUv3:
>>>
>>> 1. Why the SVM feature on SMMUv3 depends on BTM feature? when bind a task to device,
>>>    it will register a mmu_notify. Therefore, when a page range is invalid, we can
>>>    send TLBI or ATC invalid without BTM?
>>
>> We could, but the end goal for SVM is to perfectly mirror the CPU page
>> tables. So for platform SVM we would like to get rid of MMU notifiers
>> entirely.
>>
>>> 2. According to ACPI IORT spec, named component specific data has a node flags field
>>>    whoes bit0 is for Stall support. However, it do not have any field for pasid bit.
>>>    Can we use other 5 bits[5:1] for pasid bit numbers, so we can have 32 pasid bit for
>>>    a single platform device which should be enough, because SMMU only support 20 bit pasid
>>>
> 
> Any comment on this?
> The ACPI IORT spec may need be updated?

I suppose that the Named Component Node could be used for SSID and stall
capability bits. Can't the ACPI namespace entries be extended to host
these capabilities in a more generic way? Platforms with different IOMMUs
might also need this information some day.

Thanks,
Jean
