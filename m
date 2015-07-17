From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 17 Jul 2015 11:49:54 +0100
Subject: [PATCH] arm64: Better native ptrace support for compat tasks
In-Reply-To: <20150717102629.GI18994@arm.com>
References: <1436887217-13158-1-git-send-email-catalin.marinas@arm.com>
 <20150717102629.GI18994@arm.com>
Message-ID: <20150717104953.GA13712@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

On Fri, Jul 17, 2015 at 11:26:29AM +0100, Will Deacon wrote:
> On Tue, Jul 14, 2015 at 04:20:17PM +0100, Catalin Marinas wrote:
> > The compat ptrace interface allows access to the TLS register, hardware
> > breakpoints and watchpoints, syscall number. However, a native task
> > using the native ptrace interface to debug compat tasks (e.g. multi-arch
> > gdb) only has access to the general and VFP register sets. The compat
> > ptrace interface cannot be accessed from a native task.
> > 
> > This patch adds a new user_aarch32_ptrace_view which contains the TLS,
> > hardware breakpoint/watchpoint and syscall number regsets in addition to
> > the existing GPR and VFP regsets. This view is backwards compatible with
> > the previous kernels. Core dumping of 32-bit tasks and compat ptrace are
> > not affected since the original user_aarch32_view is preserved.
> 
> [...]
> 
> > +static const struct user_regset aarch32_ptrace_regsets[] = {
> > +	[REGSET_GPR] = {
> > +		.core_note_type = NT_PRSTATUS,
> > +		.n = COMPAT_ELF_NGREG,
> > +		.size = sizeof(compat_elf_greg_t),
> > +		.align = sizeof(compat_elf_greg_t),
> > +		.get = compat_gpr_get,
> > +		.set = compat_gpr_set
> > +	},
> > +	[REGSET_FPR] = {
> > +		.core_note_type = NT_ARM_VFP,
> > +		.n = VFP_STATE_SIZE / sizeof(compat_ulong_t),
> > +		.size = sizeof(compat_ulong_t),
> > +		.align = sizeof(compat_ulong_t),
> > +		.get = compat_vfp_get,
> > +		.set = compat_vfp_set
> 
> 
> I don't see how this is "backwards compatible with the previous kernels".

The first two entries of aarch32_ptrace_regsets are the same as the two
aarch32_regsets entries currently in use before this patch (I just
dropped "COMPAT" from REGSET_* for consistency with the rest of the
array).

> If there is some userspace out there that expects a native view onto the
> registers of a compat task, then that's no longer the case, right? For
> example, NT_PRFPREG requests will no longer work afaict.

But this never worked since task_user_regset_view() always returned
user_aarch32_view (with the aarch32_regsets) if the ptrace'd task was
compat. So a native gdb debugging compat task is expected to use
NT_ARM_VFP before and after this patch.

I don't think it's worth adding another regset for NT_PRFPREG just to
access the 128-bit FP registers since the compat task doesn't see them
anyway. It's the same reason NT_PRSTATUS above would not return 64-bit
registers.

> I'm not sure if it matters that the NT_PRSTATUS regset is now limited
> to COMPAT_ELF_NGREG.

Already commented above. I don't really think it matters, nor can we do
it without breaking the ABI. And it also makes you think a bit more
about security (though we should be safe as we sanitise the top part of
the 64-bit registers).

-- 
Catalin
