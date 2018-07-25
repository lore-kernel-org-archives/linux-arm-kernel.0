From: robin.murphy@arm.com (Robin Murphy)
Date: Wed, 25 Jul 2018 14:34:42 +0100
Subject: [PATCH 3/3] arm64: dts: stratix10: Add SMMU Node
In-Reply-To: <847f8f94-5108-47a3-bb08-c5f50b64e6e6@linux.intel.com>
References: <1531499278-32132-1-git-send-email-thor.thayer@linux.intel.com>
 <1531499278-32132-4-git-send-email-thor.thayer@linux.intel.com>
 <2d17b3b1-96a1-8a0a-521e-134de9df72d0@arm.com>
 <847f8f94-5108-47a3-bb08-c5f50b64e6e6@linux.intel.com>
Message-ID: <ac809d43-7c70-6a3f-1139-5e0cb6ebfae6@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16/07/18 19:56, Thor Thayer wrote:
[...]
>>> @@ -332,6 +342,36 @@
>>> ????????????? altr,modrst-offset = <0x20>;
>>> ????????? };
>>> +??????? smmu: iommu at fa000000 {
>>> +??????????? compatible = "arm,mmu-500", "arm,smmu-v2";
>>> +??????????? reg = <0xfa000000 0x40000>;
>>> +??????????? #global-interrupts = <9>;
>>> +??????????? #iommu-cells = <1>;
>>> +??????????? clocks = <&clkmgr STRATIX10_L4_MAIN_CLK>;
>>> +??????????? clock-names = "smmu_clk";
>>> +??????????? interrupt-parent = <&intc>;
>>> +??????????? interrupts = <0 128 4>,??? /* Global Secure Fault */
>>> +??????????????? <0 129 4>, /* Global Non-secure Fault */
>>> +??????????????? <0 130 4>, /* FPGA Performance Counter */
>>> +??????????????? <0 131 4>, /* DMA Performance Counter */
>>> +??????????????? <0 132 4>, /* EMAC Performance Counter */
>>> +??????????????? <0 133 4>, /* IO Performance Counter */
>>> +??????????????? <0 134 4>, /* SDM Performance Counter */
>>
>> Note that there isn't much benefit to adding the secure or PMU 
>> interrupts here other than to document the hardware - FWIW I have 
>> actually been working on a PMU driver, and needless to say it turns 
>> out not to be sufficient just having those munged into the SMMU global 
>> fault handler.
>>
> Thanks for pointing this out. I was following other SMMU-500 device 
> trees. Just to clarify, how should I simplify this? Should I replace all 
> the above with the following?
> 
>  ????<0 129 4>, /* Global Non-secure Fault */
> 
> Or will your upcoming PMU driver need the PMU units? It sounded like 
> using the just Global fault was not sufficient.

No, you had it right - what I meant was it's only worth including the 
actual global fault signals themselves here (there's no harm in leaving 
the secure one in if you like, it just won't do anything if the GIC is 
configured correctly). What I found was that the current SMMU binding 
leaves no reasonable way to encode the PMU interrupts in this interrupt 
list that doesn't break at least one of the possible old/new driver/DT 
combinations, so whatever happens they will need to be specified 
separately once a PMU binding is defined.

>>> +??????????????? <0 136 4>, /* Non-secure Combined Interrupt */
>>> +??????????????? <0 137 4>, /* Secure Combined Interrupt */
>>
>> Similarly the combined interrupt; that's literally just all these 
>> other interrupt lines ORed together at the SMMU end, and would 
>> generally only be useful if you *didn't* have the individual lines 
>> wired up. As it stands with everything listed, any event will also 
>> generate a spurious global fault IRQ, which isn't ideal (not that you 
>> should get many interrupts during normal operation, but still...)
>>
> And I'd remove both of these then, right?

Indeed.

> Thanks for the review and helpful comments (and also pointing out the 
> existing clock patch in my patch series summary)!

Cheers,
Robin.
