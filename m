From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 17 Oct 2017 10:34:15 +0100
Subject: [PATCH 06/10] KVM: arm/arm64: Only clean the dcache on
 translation fault
In-Reply-To: <20171016200811.GH1845@lvm>
References: <20171009152032.27804-1-marc.zyngier@arm.com>
 <20171009152032.27804-7-marc.zyngier@arm.com> <20171016200811.GH1845@lvm>
Message-ID: <210cf2dc-2566-a29b-637e-901f3dcc80b6@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16/10/17 21:08, Christoffer Dall wrote:
> On Mon, Oct 09, 2017 at 04:20:28PM +0100, Marc Zyngier wrote:
>> The only case where we actually need to perform a dache maintenance
>> is when we map the page for the first time, and subsequent permission
>> faults do not require cache maintenance. Let's make it conditional
>> on not being a permission fault (and thus a translation fault).
> 
> Why do we actually need to do any dcache maintenance when faulting in a
> page?
> 
> Is this for the case when the stage 1 MMU is disabled, or to support
> guest mappings using uncached attributes?

These are indeed the two cases that require cleaning the dcache to PoC.

> Can we do better, for example
> by only flushing the cache if the guest MMU is disabled?

The guest MMU being disabled is easy. But the uncached mapping is much
trickier, and would involve parsing the guest page tables. Not something
I'm really eager to implement.

> 
> Beyond that:
> 
> Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
Thanks!

	M.
-- 
Jazz is not dead. It just smells funny...
