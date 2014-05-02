From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 02 May 2014 16:52:46 +0100
Subject: [PATCH] arm64: debug: avoid accessing mdscr_el1 on fault paths
 where possible
In-Reply-To: <1399045580-20750-1-git-send-email-will.deacon@arm.com> (Will
 Deacon's message of "Fri, 2 May 2014 16:46:20 +0100")
References: <1399045580-20750-1-git-send-email-will.deacon@arm.com>
Message-ID: <87r44c5ga9.fsf@sofa.wild-wind.fr.eu.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 02 2014 at  4:46:20 pm BST, Will Deacon <will.deacon@arm.com> wrote:
> Since mdscr_el1 is part of the debug register group, it is highly likely
> to be trapped by a hypervisor to prevent virtual machines from debugging
> (buggering?) each other. Unfortunately, this absolutely destroys our
> performance, since we access the register on many of our low-level
> fault handling paths to keep track of the various debug state machines.
>
> This patch removes our dependency on mdscr_el1 in the case that debugging
> is not being used. More specifically we:
>
>   - Use TIF_SINGLESTEP to indicate that a task is stepping at EL0 and
>     avoid disabling step in the MDSCR when we don't need to.
>     MDSCR_EL1.SS handling is moved to kernel_entry, when trapping from
>     userspace.
>
>   - Ensure debug exceptions are re-enabled on *all* exception entry
>     paths, even the debug exception handling path (where we re-enable
>     exceptions after invoking the handler). Since we can now rely on
>     MDSCR_EL1.SS being cleared by the entry code, exception handlers can
>     usually enable debug immediately before enabling interrupts.
>
>   - Remove all debug exception unmasking from ret_to_user and
>     el1_preempt, since we will never get here with debug exceptions
>     masked.
>
> This results in a slight change to kernel debug behaviour, where we now
> step into interrupt handlers and data aborts from EL1 when debugging the
> kernel, which is actually a useful thing to do. A side-effect of this is
> that it *does* potentially prevent stepping off {break,watch}points when
> there is a high-frequency interrupt source (e.g. a timer), so a debugger
> would need to use either breakpoints or manually disable interrupts to
> get around this issue.
>
> With this patch applied, guest performance is restored under KVM when
> debug register accesses are trapped (and we get a measurable performance
> increase on the host on Cortex-A57 too).
>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>

Tried with KVM on Cortex-A57 (and a set of yet to be posted patches to
support debug in a VM), and very pleased with it. This patch makes it
fly! ;-)

Tested-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
AAAFNRAA
