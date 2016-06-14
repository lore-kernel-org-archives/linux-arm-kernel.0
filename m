From: robin.murphy@arm.com (Robin Murphy)
Date: Tue, 14 Jun 2016 16:04:22 +0100
Subject: [PATCH v2 1/7] iommu/of: Respect disabled IOMMUs
In-Reply-To: <20160614141148.GH19407@arm.com>
References: <cover.1464966939.git.robin.murphy@arm.com>
 <aca0b44206c87f6cb75d156a53e08aa968981119.1464966939.git.robin.murphy@arm.com>
 <20160614141148.GH19407@arm.com>
Message-ID: <57601CF6.6000308@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/06/16 15:11, Will Deacon wrote:
> On Fri, Jun 03, 2016 at 06:15:36PM +0100, Robin Murphy wrote:
>> If an IOMMU node is present in the DT but marked as disabled, we should
>> avoid trying to do anything with it. We currently sort-of get away with
>> this by virtue of a disabled device probably not having called
>> of_iommu_set_ops(), but that is hardly safe to rely upon in general, and
>> either way we don't want to treat it as an error condition with the
>> resulting "Failed to initialise IOMMU" message.
>
> What's the use-case for this? I ask because epapr says that the device
> binding should provide details as to exactly what "disabled" means for
> that device.

Right now, it's mostly a case of making things behave as expected - the 
OF platform code is already assigning the implicit meaning of "don't 
probe or do anything with this device", so playing along with that 
prevents slightly confusing errors or potential null-dereference-style 
crashes as above.

Longer term, I was also thinking back to the probe ordering problem, and 
the sticky case of differentiating "this IOMMU isn't probed yet" from 
"this IOMMU will never probe, continue without it". Being able to make 
that decision from the bootloader (by disabling nodes) in at least a 
subset of cases seemed like a useful tool. I'm still open to other 
points of view, though.

Robin.

>
> Will
>
