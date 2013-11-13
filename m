From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 13 Nov 2013 10:53:36 -0700
Subject: [PATCHv4 2/7] driver/core: Populate IOMMU'able devices in order
In-Reply-To: <20131113173142.GF11928@mudshark.cambridge.arm.com>
References: <1384158718-4756-3-git-send-email-hdoyu@nvidia.com>
 <5282BAFC.8070405@wwwdotorg.org>
 <20131113143804.GA11928@mudshark.cambridge.arm.com>
 <20131113.180610.823304139654159769.hdoyu@nvidia.com>
 <20131113173142.GF11928@mudshark.cambridge.arm.com>
Message-ID: <5283BCA0.40300@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/13/2013 10:31 AM, Will Deacon wrote:
> On Wed, Nov 13, 2013 at 04:06:10PM +0000, Hiroshi Doyu wrote:
>> Will Deacon <will.deacon@arm.com> wrote @ Wed, 13 Nov 2013 15:38:04 +0100:
>>
>>> On Tue, Nov 12, 2013 at 11:34:20PM +0000, Stephen Warren wrote:
>>>> SMMU:
>>>>     smmu: smmu at xxxxxx {
>>>>         #smmu-cells = <1>;
>>>>     }
>>>>
>>>> Affected device:
>>>>     smmus = <&smmu 1>;
>>>>     (perhaps with smmu-names too)
>>>>
>>>> That would allow the DT to represent basically arbitrary HW configurations.
>>>>
>>>> The implementation of this patch would then be almost as trivial; you'd
>>>> just need to walk the smmus property to find each phandle in turn, just
>>>> like any other phandle+specifier property, and validate that the SMMU
>>>> driver was already probe()d for each.
>>>
>>> There are a few problems with that:
>>>
>>>   1.) It assumes all devices sharing an SMMU have the same number of
>>>       "smmu cells"
>>
>> This can be solved with introducing the fixed size of bitmap. The size
>> of bitmap can be fixed even per SoC. In tegra we used 64(2 cells)
>> which I expect at most.
> 
> That really doesn't sound like a good idea where you have bridges (like a
> PCIe host controller) which could have a significant chunk of StreamID
> space. You'd also need to pad everything out with some dummy IDs for parsing
> purposes. Yuck!

Can't you solve this by having the SMMU include a stream ID mapping
table. In the case of stream IDs having a large "address" space, then
just define the mapping table syntax to allow easy specification of
ranges using start/length, start/end, or value/mask pairs. Similar to
ranges or PCI's interrupt-map{,-mask}.
