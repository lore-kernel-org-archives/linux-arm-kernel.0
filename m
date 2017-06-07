From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 7 Jun 2017 10:16:29 +0100
Subject: [PATCH 2/3] arm64: KVM: Allow unaligned accesses at EL2
In-Reply-To: <20170606200912.GQ9464@cbox>
References: <20170606180835.14421-1-marc.zyngier@arm.com>
 <20170606180835.14421-3-marc.zyngier@arm.com> <20170606200912.GQ9464@cbox>
Message-ID: <73f039f7-7597-fd34-367c-1cc6fdda3673@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/06/17 21:09, Christoffer Dall wrote:
> On Tue, Jun 06, 2017 at 07:08:34PM +0100, Marc Zyngier wrote:
>> We currently have the SCTLR_EL2.A bit set, trapping unaligned accesses
>> at EL2, but we're not really prepared to deal with it. So far, this
>> has been unnoticed, until GCC 7 started emitting those (in particular
>> 64bit writes on a 32bit boundary).
>>
>> Since the rest of the kernel is pretty happy about that, let's follow
>> its example and set SCTLR_EL2.A to zero. Modern CPUs don't really
>> care.
> 
> Why do we set the A flag via SCTLR_ELx_FLAGS in the first place, only to
> drop that flag later on for both EL1 and EL2 ?

That flag is always cleared at EL1, never set. Actually, only EL2 uses
that macro to *set* flags. An alternative would be to do away with the
macro and use the individual flags, like the 32bit side does.

What do you think?

	M.
-- 
Jazz is not dead. It just smells funny...
