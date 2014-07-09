From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 09 Jul 2014 17:20:22 +0100
Subject: [PATCH v3 3/9] arm64: KVM: add trap handlers for AArch64 debug
 registers
In-Reply-To: <20140709145232.GA20459@cbox> (Christoffer Dall's message of
 "Wed, 9 Jul 2014 15:52:32 +0100")
References: <1403269207-1625-1-git-send-email-marc.zyngier@arm.com>
 <1403269207-1625-4-git-send-email-marc.zyngier@arm.com>
 <20140709093813.GB19801@cbox> <87lhs27pqu.fsf@why.wild-wind.fr.eu.org>
 <20140709145232.GA20459@cbox>
Message-ID: <871ttu7bcp.fsf@why.wild-wind.fr.eu.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 09 2014 at  3:52:32 pm BST, Christoffer Dall <christoffer.dall@linaro.org> wrote:
> On Wed, Jul 09, 2014 at 12:09:29PM +0100, Marc Zyngier wrote:
>> On Wed, Jul 09 2014 at 10:38:13 am BST, Christoffer Dall
>> <christoffer.dall@linaro.org> wrote:
>> > On Fri, Jun 20, 2014 at 02:00:01PM +0100, Marc Zyngier wrote:
>> >> Add handlers for all the AArch64 debug registers that are accessible
>> >> from EL0 or EL1. The trapping code keeps track of the state of the
>> >> debug registers, allowing for the switch code to implement a lazy
>> >> switching strategy.
>> >>
>> >> Reviewed-by: Anup Patel <anup.patel@linaro.org>
>> >> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>> >> ---
>> >>  arch/arm64/include/asm/kvm_asm.h  |  28 ++++++--
>> >>  arch/arm64/include/asm/kvm_host.h |   3 +
>> >>  arch/arm64/kvm/sys_regs.c         | 137 +++++++++++++++++++++++++++++++++++++-
>> >>  3 files changed, 159 insertions(+), 9 deletions(-)

[...]

>> >> +/*
>> >> + * We want to avoid world-switching all the DBG registers all the
>> >> + * time. For this, we use a DIRTY but, indicating the guest has
>> >
>> > a DIRTY but?  (at least there's only one t in there).
>>
>> The whole debug architecture makes me feel very dirty.
>>
>> >> + * modified the debug registers, and only restore the registers once,
>> >> + * disabling traps.
>> >
>> > I don't think I understand the "only restore the registers once" bit
>> > here.  I know I'm being incredibly stupid, but I forgot since the last
>> > review round how this actually works; when we return from the guest and
>> > the guest has somehow enabled certain DBG functionality, then we
>> > set the dirty
>> > flag, which means we should stop trapping and context switch all the
>> > registers on world-switches, but if we see when returning from the guest
>> > that the guest doesn't appear to be using the registers we enable
>> > trapping and stop world-switching, right?
>>
>> Almost. We always decide on the trapping when entering the guest:
>> - If the dirty bit is set (because we're coming back from trapping),
>>   disable the traps, restore the registers
>> - If debug is actively in use (DBG_MDSCR_KDE or DBG_MDSCR_MDE set),
>>   disable the traps, restore the registers
>
> this also sets the dirty bit then?

Indeed. I'll mention it.

>
>> - Otherwise, enable the traps
>>
>> When exiting the guest: If the dirty bit is set, save the registers and
>> clear the dirty bit.
>
> because the host should always be able to freely use the debug registers
> so we always have to restore the host registers on coming out of the VM,
> right?

Yes. The host may have its own debug state active, and we want to
preserve that.

>>
>> > Do we clearly define which state triggers the world-switching and why
>> > that's a good rationale? (sorry, the debug architecture is not my
>> > favorite part of the ARM ARM).
>>
>> I thing the above comment describes the state precisely. My rational is:
>> - If we've touched any debug register, it is likely that we're going to
>>   touch more of them. It then makes sense to disable the traps and start
>>   doing the save/restore dance
>> - If debug is active (DBG_MDSCR_KDE or DBG_MDSCR_MDE set), it is then
>>   mandatory to save/restore the registers, as the guest depends on them.
>>
>> Does this make the process clearer? If so, I can add it to the comment.
>>
>
> yes, the above comments help a lot.  thanks!!
>
> [if I don't see your response because you already left for vacation, I'm
> going to incorporate your comments in the patches to apply to
> kvmarm/next].

I'm not quite gone yet! ;-) Just enough time left to respin the branch
on top of what's already queued, push it out and post the series.

	M.
-- 
Without deviation from the norm, progress is not possible.
