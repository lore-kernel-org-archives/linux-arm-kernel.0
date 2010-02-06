From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 6 Feb 2010 10:32:30 +0000
Subject: [RFC PATCH v2 1/2] ARM: VFP: add support to sync the VFP state
	of the current thread
In-Reply-To: <b8a1d37c5f981cdd2e83c9fd98198832324cd57d.1265315249.git.imre.deak@nokia.com>
References: <b8a1d37c5f981cdd2e83c9fd98198832324cd57c.1265315249.git.imre.deak@nokia.com>
	<b8a1d37c5f981cdd2e83c9fd98198832324cd57d.1265315249.git.imre.deak@nokia.com>
Message-ID: <20100206103230.GC1923@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 04, 2010 at 11:38:02PM +0200, Imre Deak wrote:
> So far vfp_sync_state worked only for threads other than the current
> one. This worked for tracing other threads, but not for PTRACE_TRACEME.
> Syncing for the current thread will also be needed by an upcoming patch
> adding support for VFP context save / restore around signal handlers.
> 
> For SMP we need get_cpu now, since we have to protect the FPEXC
> register, other than this things remained the same for threads other
> than the current.

I don't think we should make this function any more complicated than it
already is.

For entering signal handlers, the situation is a lot more simple than
that found in vfp_sync_state() - since we know that we're always going
to be running the thread we're concerned with:

	- if VFP is enabled
		- use vfp_save_state() to save a copy of VFP state
		- disable VFP
	- if VFP is disabled
		- save a copy of ti->vfp_state

On signal return:

	- restore copy of ti->vfp_state
	- atomically (wrt preemption)
		- if last_VFP_context[cpu] is &ti->vfp_state
			- NULL out last_VFP_context[cpu]
		- disable VFP

There's no need to fiddle with ti->vfp_state.hard.cpu.

Note that saving the vfp_hard_struct to userspace is not on since it
then becomes a userspace API; it has to be translated into something
that we can keep better control over for userspace.  Moreover,
vfp_hard_struct contains state private to the kernel; allowing userspace
to have control over things like 'cpu' is a very bad idea.
