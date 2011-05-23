From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 23 May 2011 14:25:13 +0100
Subject: [PATCH] ARM: Do not allow unaligned accesses when
	CONFIG_ALIGNMENT_TRAP
In-Reply-To: <yw1x8vtxr43w.fsf@unicorn.mansr.com>
References: <20110523111648.10474.78396.stgit@e102109-lin.cambridge.arm.com>
	<yw1x8vtxr43w.fsf@unicorn.mansr.com>
Message-ID: <20110523132513.GJ17672@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 23, 2011 at 01:30:43PM +0100, M?ns Rullg?rd wrote:
> Catalin Marinas <catalin.marinas@arm.com> writes:
> 
> > Newer versions of gcc generate unaligned accesses by default, causing
> > kernel panics when CONFIG_ALIGNMENT_TRAP is enabled. This patch adds the
> > -mno-unaligned-access option to gcc.
> 
> Wouldn't it make more sense to disable strict alignment checking in
> kernel mode regardless of this option.  I can't imagine why it would
> ever be desirable.  IMO the usermode default should also be changed to
> allow unaligned accesses on ARMv6 and up.

We do disable strict alignment checking but only at alignment fault
handler init time:

        /*
         * ARMv6 and later CPUs can perform unaligned accesses for
         * most single load and store instructions up to word size.
         * LDM, STM, LDRD and STRD still need to be handled.
         *
         * Ignoring the alignment fault is not an option on these
         * CPUs since we spin re-faulting the instruction without
         * making any progress.
         */
        if (cpu_architecture() >= CPU_ARCH_ARMv6 && (cr_alignment & CR_U)) {
                cr_alignment &= ~CR_A;
                cr_no_alignment &= ~CR_A;
                set_cr(cr_alignment);
                ai_usermode = UM_FIXUP;
        }

If we need that CR bit disabled earlier, then that's what we need to do,
not bodge around it in silly ways which only _partially_ address the
issue.

I also believe the commit message to be entirely misleading and wrong.
Until we have the information on what this patch is _trying_ to address
I don't think there's much more that can be said about it.
