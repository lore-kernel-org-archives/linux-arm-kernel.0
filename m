From: robherring2@gmail.com (Rob Herring)
Date: Wed, 20 Nov 2013 14:22:25 -0600
Subject: Report from 2013 ARM kernel summit
In-Reply-To: <20131120103111.GB19352@mudshark.cambridge.arm.com>
References: <20131111.114723.1885845500744256130.hdoyu@nvidia.com>
 <20131115070627.6CF65C4079B@trevor.secretlab.ca>
 <20131119.114054.663999769447782808.hdoyu@nvidia.com>
 <20131119173524.GK11778@mudshark.cambridge.arm.com>
 <528BCDCE.6070006@gmail.com>
 <20131120103111.GB19352@mudshark.cambridge.arm.com>
Message-ID: <CAL_JsqKCLLXenthmuKxqDqqMUCH6=sZJxoiQK9dJDySpJQ5fHw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 20, 2013 at 4:31 AM, Will Deacon <will.deacon@arm.com> wrote:
> On Tue, Nov 19, 2013 at 08:45:02PM +0000, Rob Herring wrote:
>> On 11/19/2013 11:35 AM, Will Deacon wrote:
>> > Adding Andreas and Rob for input on potential binding additions to the SMMU.
>>
>> The above proposal would be an incompatible change. However, I think we
>> could still deal with a change in this binding at this stage.
>>
>> One way approach to handle this without changing the binding would be to
>> scan the DT for all iommu's up front and create a list of all nodes and
>> their iommu parent. The fact that the hierarchy is described in a way
>> that doesn't fit Linux well is really a Linux implementation detail.
>>
>> If changing the binding, a simple approach would be to allow
>> 'smmu-parent' to be a bus and/or device property and not just for
>> chained iommu's. This could be a global or bus property that is
>> inherited. Like interrupt-parent, you would have to deal with the parent
>> being itself. Also, perhaps iommu-parent would be a better name. In any
>> case, I'd like to see this all be a generic iommu binding.
>
> I like that idea. I've recently been toying with removing the chained IOMMU
> support, since I don't think anybody is using it who is interested in
> mainline. However, making it more general sounds like a better idea.
>
> One potential issue is that I think the nvidia guys want to describe masters
> that master via multiple SMMUs (which I believe was the motivation for
> moving the stream-ids out into the master nodes, rather than keeping them in
> the SMMU). Again, that's not something we can easily add to the arm-smmu,
> because the incoming stream-ids are a property of the SMMU node.

For stream-ids, I think that is debatable. It is not a property of the
SMMU. The AXI ID is determined by the master. Yes, AXI ID is only part
of it and the SMMU determines the full stream-id, but that doesn't
really matter. Look at interrupts properties as a comparison. The
number of cells and the meaning of the cell values is determined by
the interrupt controller, not the node with the interrupts property.

Rob

> So the question is: do we actually need to describe masters that master
> through multiple SMMUs as a single node in the devicetree?
>
> Will
