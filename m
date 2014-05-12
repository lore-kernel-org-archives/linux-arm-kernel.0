From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 12 May 2014 10:19:16 -0600
Subject: [RFC] Describing arbitrary bus mastering relationships in DT
In-Reply-To: <20140509105638.GB3921@e103592.cambridge.arm.com>
References: <20140501173248.GD3732@e103592.cambridge.arm.com>
 <20140502132327.GA14612@ulmo> <5363E8E9.6000908@wwwdotorg.org>
 <4356389.0gMcB71fJD@wuerfel>
 <20140509105638.GB3921@e103592.cambridge.arm.com>
Message-ID: <5370F484.9030209@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/09/2014 04:56 AM, Dave Martin wrote:
> On Fri, May 02, 2014 at 09:06:43PM +0200, Arnd Bergmann wrote:
>> On Friday 02 May 2014 12:50:17 Stephen Warren wrote:
...
>>> Now, perhaps there are devices which themselves control whether
>>> transactions are sent to the IOMMU or direct to RAM, but I'm not
>>> familiar with them. Is the GPU in that category, since it has its own
>>> GMMU, albeit chained into the SMMU IIRC?
>>
>> Devices with a built-in IOMMU such as most GPUs are also easy enough
>> to handle: There is no reason to actually show the IOMMU in DT and
>> we can just treat the GPU as a black box.
> 
> It's impossible for such a built-in IOMMU to be shared with other
> devices, so that's probably reasonable.

I don't believe that's true.

For example, on Tegra, the CPU (and likely anything that can bus-master
the relevant bus) can send transactions into the GPU, which can then
turn them around towards RAM, and those likely then go through the MMU
inside the GPU.

IIRC, the current Nouveau support for Tegra even makes use of that
feature, although I think that's a temporary thing that we're hoping to
get rid of once the Tegra support in Nouveau gets more mature.
