From: robin.murphy@arm.com (Robin Murphy)
Date: Fri, 11 Nov 2016 14:34:39 +0000
Subject: [RFC v2 8/8] iommu/arm-smmu: implement add_reserved_regions
 callback
In-Reply-To: <20161110161619.GK2078@8bytes.org>
References: <1478258646-3117-1-git-send-email-eric.auger@redhat.com>
 <1478258646-3117-9-git-send-email-eric.auger@redhat.com>
 <20161110154606.GH2078@8bytes.org>
 <b347ddbc-5066-641c-8101-289fb28624a3@arm.com>
 <20161110161619.GK2078@8bytes.org>
Message-ID: <479aeac0-71f9-a6b8-af6d-e2c25184a818@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/11/16 16:16, Joerg Roedel wrote:
> On Thu, Nov 10, 2016 at 04:07:08PM +0000, Robin Murphy wrote:
>> On 10/11/16 15:46, Joerg Roedel wrote:
>>> On Fri, Nov 04, 2016 at 11:24:06AM +0000, Eric Auger wrote:
>>>> +	resource_list_for_each_entry(window, &bridge->windows) {
>>>> +		if (resource_type(window->res) != IORESOURCE_MEM &&
>>>> +		    resource_type(window->res) != IORESOURCE_IO)
>>>> +			continue;
>>>
>>> Why do you care about IO resources?
>>
>> [since this is essentially code I wrote]
>>
>> Because they occupy some area of the PCI address space, therefore I
>> assumed that, like memory windows, they would be treated as P2P. Is that
>> not the case?
> 
> No, not at all. The IO-space is completly seperate from the MEM-space.
> They are two different address-spaces, addressing different things. And
> the IO-space is also not translated by any IOMMU I am aware of.

OK. On the particular root complex I have to hand, though, any DMA to
IOVAs between 0x5f800000 and 0x5fffffff sends an error back to the
endpoint, and that just so happens to be where the I/O window is placed
(both on the PCI side and the AXI (i.e. CPU MMIO) side. Whether it's
that the external MMIO view of the RC's I/O window is explicitly
duplicated in its PCI memory space as some side-effect of the PCI/AXI
bridge, or that the thing just doesn't actually respect the access type
on the PCI side I don't know, but that's how it is (and I spent this
morning recreating it to make sure I wasn't mistaken).

This thing's ECAM space is similarly visible from the PCI side and
aborts DMA the same way - I've not tried decoding the "PCI hardware
error (0x1010)" that the sky2 network driver reports, but I do note it's
a slightly different number from the one it gives when trying to access
an address matching another device's BAR (actual peer-to-peer is
explicitly unsupported). Admittedly that's not something we can detect
from the host bridge windows at all.

Anyway, you are of course right that in the normal case this should only
matter if devices were doing I/O accesses in the first place, which
makes especially no sense in the context of the DMA API, so perhaps we
could drop the unintuitive IORESOURCE_IO check from here and consider
weird PCI controllers a separate problem to solve.

Robin.
