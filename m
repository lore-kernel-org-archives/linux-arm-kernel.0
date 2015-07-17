From: will.deacon@arm.com (Will Deacon)
Date: Fri, 17 Jul 2015 11:26:29 +0100
Subject: [PATCH] arm64: Better native ptrace support for compat tasks
In-Reply-To: <1436887217-13158-1-git-send-email-catalin.marinas@arm.com>
References: <1436887217-13158-1-git-send-email-catalin.marinas@arm.com>
Message-ID: <20150717102629.GI18994@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Catalin,

On Tue, Jul 14, 2015 at 04:20:17PM +0100, Catalin Marinas wrote:
> The compat ptrace interface allows access to the TLS register, hardware
> breakpoints and watchpoints, syscall number. However, a native task
> using the native ptrace interface to debug compat tasks (e.g. multi-arch
> gdb) only has access to the general and VFP register sets. The compat
> ptrace interface cannot be accessed from a native task.
> 
> This patch adds a new user_aarch32_ptrace_view which contains the TLS,
> hardware breakpoint/watchpoint and syscall number regsets in addition to
> the existing GPR and VFP regsets. This view is backwards compatible with
> the previous kernels. Core dumping of 32-bit tasks and compat ptrace are
> not affected since the original user_aarch32_view is preserved.

[...]

> +static const struct user_regset aarch32_ptrace_regsets[] = {
> +	[REGSET_GPR] = {
> +		.core_note_type = NT_PRSTATUS,
> +		.n = COMPAT_ELF_NGREG,
> +		.size = sizeof(compat_elf_greg_t),
> +		.align = sizeof(compat_elf_greg_t),
> +		.get = compat_gpr_get,
> +		.set = compat_gpr_set
> +	},
> +	[REGSET_FPR] = {
> +		.core_note_type = NT_ARM_VFP,
> +		.n = VFP_STATE_SIZE / sizeof(compat_ulong_t),
> +		.size = sizeof(compat_ulong_t),
> +		.align = sizeof(compat_ulong_t),
> +		.get = compat_vfp_get,
> +		.set = compat_vfp_set


I don't see how this is "backwards compatible with the previous kernels".
If there is some userspace out there that expects a native view onto the
registers of a compat task, then that's no longer the case, right? For
example, NT_PRFPREG requests will no longer work afaict. I'm not sure if
it matters that the NT_PRSTATUS regset is now limited to COMPAT_ELF_NGREG.

Will
