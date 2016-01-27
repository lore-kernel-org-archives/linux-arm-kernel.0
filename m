From: Tirumalesh.Chalamarla@caviumnetworks.com (Chalamarla, Tirumalesh)
Date: Wed, 27 Jan 2016 19:06:48 +0000
Subject: iommu/arm-smmu-v2 ASID/VMID calculation
In-Reply-To: <20160126115435.GB21553@arm.com>
References: <198F501C-8D30-4EB5-BC40-4F40BB75D40B@caviumnetworks.com>
 <20160125170312.GJ22927@arm.com>
 <E978AB4F-5CB0-42D8-8152-04C77DB664A1@caviumnetworks.com>
 <6F24A28A-6302-4C48-A933-B47A9735808C@caviumnetworks.com>
 <20160126115435.GB21553@arm.com>
Message-ID: <E0484253-BE37-476A-9F4A-ABE6B74EC174@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org






On 1/26/16, 3:54 AM, "Will Deacon" <will.deacon@arm.com> wrote:

>On Tue, Jan 26, 2016 at 03:11:27AM +0000, Chalamarla, Tirumalesh wrote:
>> one my colleague points out, ASIDPNE also implementation defined. 
>
>It looks pretty well defined to me, despite being a hint:
>
>  This ASIDPNE indication is only a hint, and an SMMU can ignore it. In
>  particular, if the SMMU implementation does not support the ASIDPNE
>  feature, broadcast TLB invalidate operations ignore this hint and
>  invalidate matching TLB entries when broadcast TLB invalidation is
>  enabled.
>
>But what does this have to do with the problem at hand?
>
>> >I don?t think it followed spec.
>> >
>> >The SMMU spec (IHI0062C) says (section 2.2):
>> >
>> >   - The exact behavior of any TLB functionality is IMPLEMENTATION DEFINED
>
>... and immediately qualifies that with:
>
>  The SMMU architecture does not limit how a TLB is implemented, provided
>  it obeys the TLB Invalidate operations.
>
>which is to say, you can build the TLB how you like, providing that it
>follows the programmers model for invalidation. Otherwise portable
>software will break and people will send patches to "fix" it.
>
>> >Section 2.2 describes the constraints on sharing (e.g. multiple contexts
>> >using the same ASID says):
>> >
>> >      "If multiple context banks have hte same attributes but describe
>> >       different translations, the results of a TLB lookup are UNPREDICTABLE".
>
>That's describing a TLB conflict. These don't occur, because we ensure
>each of your 128 context banks has different attributes (i.e. ASID/VMID).
>
>The problem is that you have shared state between multiple SMMU instances,
>which I don't think is correct. I'm fine with a workaround, but I don't
>want this logic to be used on other implementations where it is not
>needed.

Ok, I will treat it as Errata and provide a patch for workaround this. 
>
>> >The present smmu driver assumes ASID should only be unique per SMMU, this
>> >might not be true for all Implementations. 
>
>So far, it appears to be true for all Implementations apart from yours
>and therefore needs to be quirked.
>
>Will
