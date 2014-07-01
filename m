From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 01 Jul 2014 18:38:12 +0200
Subject: [PATCH 22/24] ARM64:ILP32: Use a seperate syscall table as a few
 syscalls need to be using the compat syscalls.
In-Reply-To: <800835FF-E10A-4C0C-A68F-0ED1434F1CE2@caviumnetworks.com>
References: <1400914939-9708-1-git-send-email-apinski@cavium.com>
 <20140701150539.GA18309@arm.com>
 <800835FF-E10A-4C0C-A68F-0ED1434F1CE2@caviumnetworks.com>
Message-ID: <4268617.3t49DXZOBa@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 01 July 2014 15:30:51 Pinski, Andrew wrote:
> > On Jul 1, 2014, at 8:07 AM, "Catalin Marinas" <catalin.marinas@arm.com> wrote:
> >> On Sat, May 24, 2014 at 12:02:17AM -0700, Andrew Pinski wrote:
> >> diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
> >> index 1e1ebfc..8241ffe 100644
> >> --- a/arch/arm64/kernel/entry.S
> >> +++ b/arch/arm64/kernel/entry.S
> >> @@ -620,9 +620,14 @@ ENDPROC(ret_from_fork)
> >>  */
> >>    .align    6
> >> el0_svc:
> >> -    adrp    stbl, sys_call_table        // load syscall table pointer
> >>    uxtw    scno, w8            // syscall number in w8
> >>    mov    sc_nr, #__NR_syscalls
> >> +#ifdef CONFIG_ARM64_ILP32
> >> +    get_thread_info tsk
> >> +    ldr    x16, [tsk, #TI_FLAGS]
> >> +    tbnz    x16, #TIF_32BIT_AARCH64, el0_ilp32_svc // We are using ILP32
> >> +#endif
> >> +    adrp    stbl, sys_call_table        // load syscall table pointer
> > 
> > This adds a slight penalty on the AArch64 SVC entry path. I can't tell
> > whether that's visible or not but I think the x86 guys decided to set an
> > extra bit to the syscall number to distinguish it from native calls.

IIRC the intention on x86 was that you should always be able to call
any of the three syscall ABIs (x86-32, x86-64, x32) from any process
by passing the right number, for flexibility.

	Arnd
