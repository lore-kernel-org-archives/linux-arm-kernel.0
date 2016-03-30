From: eric.auger@linaro.org (Eric Auger)
Date: Wed, 30 Mar 2016 17:37:27 +0200
Subject: [PATCH 11/13] dtb: amd: Add PCIe SMMU device tree node
In-Reply-To: <20160128142751.GA775@arm.com>
References: <1453929121-12171-1-git-send-email-Suravee.Suthikulpanit@amd.com>
 <20160128111453.GG17123@leverpostej> <56AA07AA.7050701@arm.com>
 <6645680.g0j8d12m6d@wuerfel> <20160128142751.GA775@arm.com>
Message-ID: <56FBF2B7.8090601@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear all,
On 01/28/2016 03:27 PM, Will Deacon wrote:
> On Thu, Jan 28, 2016 at 03:17:33PM +0100, Arnd Bergmann wrote:
>> On Thursday 28 January 2016 12:20:58 Robin Murphy wrote:
>>>>
>>>> Will, Robin, thoughts?
>>>
>>> Any IDs specified here would only apply to DMA by the "platform device" 
>>> side of the host controller itself (as would an equivalent "iommus" 
>>> property on pcie0 once I finish the SMMUv2 generic binding support I'm 
>>> working on). In terms of PCI devices, the "mmu-masters" property is 
>>> overloaded such that only its existence matters, to identify that there 
>>> _is_ a relationship between the SMMU and the PCI bus(es) behind that 
>>> host controller.
>>
>> I wasn't aware that this was actually still specified. I had hoped
>> we were getting rid of mmu-masters before anyone actually started
>> using it, but now I see it in ns2.dtsi and fsl-ls2080a.dtsi.
>>
>> Does anyone know what happened to the plan to use the iommu DT binding
>> for the ARM SMMU instead? Do we now have to support both ways indefinitely?
> 
> We always did -- Seattle used the mmu-masters binding before the generic
> binding even existed. Robin has been working on patches to get of_xlate
> up and running, but it got held up by Laurent's series which didn't end
> up going anywhere.
> 
> Will
Up to now I have used the PCI smmu description as described in Suravee's
patch and this does not work anymore with 4.6-rc1 since the default
domain was introduced. So now I see 2 SMRs matching a single streamid
(in my case 256, one steming from the "platform device" side of the host
controller and one steming from the PCI device) and this causes SMCF
(stream match conflict fault). So PCIe PF does not work.

I observe the fault only when I override the PCIe ACS property in my
case which was pretty confusing (each PF/VF is put in a separate group).

What is the correct syntax then: mmu-masters = <&pcie0>?

instead of

+			 mmu-masters = <&pcie0
+				/* 1:00:[0,3] */ 256 257 258 259
+				/* 2:00:[0,3] */ 512 513 514 515
+				/* 3:00:[0,3] */ 768 769 770 771
+				/* 4:00:[0,3] */ 1024 1025 1026 1027>

Is there a plan to update/upstream the dt description for PCIe smmu.

Thank you in advance

Best Regards

Eric


> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
