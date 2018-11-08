From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 8 Nov 2018 17:54:46 +0000
Subject: [PATCH 3/4] arm64: KVM: Install stage-2 translation before
 enabling traps on VHE
In-Reply-To: <20181106080657.GG12057@e113682-lin.lund.arm.com>
References: <20181105143617.120602-1-marc.zyngier@arm.com>
 <20181105143617.120602-4-marc.zyngier@arm.com>
 <20181106080657.GG12057@e113682-lin.lund.arm.com>
Message-ID: <0aba0f09-d299-2f65-9e08-63424776c29c@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/11/18 08:06, Christoffer Dall wrote:
> On Mon, Nov 05, 2018 at 02:36:15PM +0000, Marc Zyngier wrote:
>> It is a bit odd that we only install stage-2 translation after having
>> cleared HCR_EL2.TGE, which means that there is a window during which
>> AT requests could fail as stage-2 is not configured yet.
>>
>> Let's move stage-2 configuration before we clear TGE, making the
>> guest entry sequence clearer: we first configure all the guest stuff,
>> then only switch to the guest translation regime.
>>
>> Non-VHE doesn't have that kind of behaviour, and is left alone.
> 
> I'm a bit confused about this statement.  You can still issue a S12E1x
> AT instruction after activating traps (setting HCR_EL2.VM) on non-VHE
> and get at the same behavior, right?
> 
> Is the point here that we are not aware of any non-VHE implementations
> that speculate AT instructions in this window, or am I missing some
> architectural nugget that prevents problems on non-VHE systems?

You're right. This is not an issue on non-VHE so far because we don't
know of any such system that is broken in such a way (speculative AT
instruction leading to inconsistent TLBs).

> In any case, why not change the non-VHE code as well to preserve
> symmetry for both types of systems?

Happy to change that too.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
