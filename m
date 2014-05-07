From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 07 May 2014 16:57:36 +0100
Subject: [PATCH 0/9] arm64: KVM: debug infrastructure support
In-Reply-To: <CAFEAcA8XwVLevHhAZXPijoSk3Dw=BaoUT+qUNj3QkQZm2n5EPA@mail.gmail.com>
References: <1399476054-21571-1-git-send-email-marc.zyngier@arm.com>
 <CAFEAcA8XwVLevHhAZXPijoSk3Dw=BaoUT+qUNj3QkQZm2n5EPA@mail.gmail.com>
Message-ID: <536A57F0.7050806@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/05/14 16:42, Peter Maydell wrote:
> On 7 May 2014 16:20, Marc Zyngier <marc.zyngier@arm.com> wrote:
>> This patch series adds debug support, a key feature missing from the
>> KVM/arm64 port.
>>
>> The main idea is to keep track of whether the debug registers are
>> "dirty" (changed by the guest) or not. In this case, perform the usual
>> save/restore dance, for one run only. It means we only have a penalty
>> if a guest is actually using the debug registers.
>>
>> The huge amount of registers is properly frightening, but CPUs
>> actually only implement a subset of them. Also, there is a number of
>> registers we don't bother emulating (things having to do with external
>> debug and OSlock).
> 
> Presumably these registers now appear in the userspace
> interface too, yes? Did you check that they all cope with
> the "migration reads all register values on the source and then
> writes them on the destination in arbitrary order" semantics without
> further fiddling? (I have a note that says that at least
> OSLAR_EL1/OSLSR_EL1 won't work that way, for instance.)

The only registers that are exported to userspace are MDSCR_EL1,
DBG{BW}{CV}Rn_EL1 and MDCCINT_EL1 (and their 32bit counterparts). They
should be fine being saved/restored in any order, as long as you're not
running the vcpu in between.

The OSL*_EL1 registers are just ignored so far. So far, it is unclear
how they would be supported in a guest, and I don't have any test
environment for them. Should the need arise, support can be added on top
of what we have now.

	M.
-- 
Jazz is not dead. It just smells funny...
