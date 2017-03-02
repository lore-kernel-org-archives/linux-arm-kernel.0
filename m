From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 2 Mar 2017 17:11:01 +0000
Subject: [PATCH] arm64: restore get_current() optimisation
In-Reply-To: <59947507-e4bb-dd20-343f-f9f27dee1508@arm.com>
References: <1483468021-8237-1-git-send-email-mark.rutland@arm.com>
 <ee26a4f0-e3e9-fb44-fe7c-c40a15c33b38@nvidia.com>
 <20170302123507.GD19632@leverpostej>
 <086dff0b-126d-b5b7-e877-d3d46efce618@nvidia.com>
 <59947507-e4bb-dd20-343f-f9f27dee1508@arm.com>
Message-ID: <20170302171101.GA11970@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 02, 2017 at 04:12:08PM +0000, Robin Murphy wrote:
> On 02/03/17 15:30, Jon Hunter wrote:
> > On 02/03/17 12:35, Mark Rutland wrote:
> >> On Thu, Mar 02, 2017 at 11:35:06AM +0000, Jon Hunter wrote:

> >>> [  184.523390] Unable to handle kernel paging request at virtual address ffff8001bb7a2800
> 
> Notably, this is x4 + x23, where I'd bet on x4 being the address of
> "cache", and x23 being the index, except that apparently the top half of
> a pointer has somehow got in there instead - the stack contents at b9c8
> and b9e8 also stand out in that regard.

Indeed.

This could be indicative of an uninitialise reg value being passed in
from above, assuming map->reg_stride_order is 0.

> I'm wondering if the removal of volatile means we get some stack
> access hoisted before an earlier swizzling of current, the effect of
> which only makes itself known way down the line.

I don't see how that can happen, as current is never swizzled from the
PoV of the thread.

We switch it in assembly, in cpu_switch_to(), along with the other regs.
It's also initialsied in assembly, so at no point should C code be able
to observe a stale value.

> The KASAN version below is also interesting in that the
> reasonable-looking duff address is x0 + x1, but neither of those looks
> like anything sane on their own.

This is just an edge-case of KASAN. Anything that's outside of a mapped
area can also fall outside of the mapped shadow for that area.

> >>> [  184.582802] sp : ffff8000b964b970
> >>> [  184.586108] x29: ffff8000b964b970 x28: ffff8000b9584800 
> >>> [  184.591412] x27: ffff8000b964bcc8 x26: ffff8000b9461000 
> >>> [  184.596716] x25: 0000000000000000 x24: 0000000000000000 
> >>> [  184.602019] x23: 00000000ffff8000 x22: ffff8000b964ba1c 
> >>> [  184.607322] x21: ffff8000b964ba1c x20: 00000000ffff8000 
> >>> [  184.612626] x19: ffff8000bb7dc400 x18: 0000000000000000 
> >>> [  184.617928] x17: 0000000000000001 x16: ffff0000081f79e8 
> >>> [  184.623230] x15: 0000000000497000 x14: 0000000000000000 
> >>> [  184.628532] x13: 0000000000000001 x12: 0000000005cc6000 
> >>> [  184.633835] x11: 0000000000000000 x10: ffff8000bc16bf00 
> >>> [  184.639138] x9 : 0000000000000000 x8 : 0000000000000000 
> >>> [  184.644441] x7 : ffff8000bff68908 x6 : 0000000000000000 
> >>> [  184.649742] x5 : ffff000008fc9f00 x4 : ffff8000bb7aa800 
> >>> [  184.655044] x3 : 0000000000000002 x2 : ffff8000b964ba1c 
> >>> [  184.660347] x1 : 000000003fffe000 x0 : 0000000000000000 

> >> If the commit in question is resulting in get_current() behaving differently,
> >> it *might* be possible to detect with the hack below. I haven't seen it blow up
> >> on my test systems.
> > 
> > Unfortunately, that did not catch it :-(

Just to check, did it still blow up with that patch applied, or did it
function without any warning?

Thanks,
Mark.
