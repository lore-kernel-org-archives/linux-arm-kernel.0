From: philipp.tomsich@theobroma-systems.com (Dr. Philipp Tomsich)
Date: Wed, 15 Apr 2015 12:31:44 +0200
Subject: [PATCH v4 00/24] ILP32 for ARM64
In-Reply-To: <20150414165459.GG14546@e104818-lin.cambridge.arm.com>
References: <cover.1428953303.git.philipp.tomsich@theobroma-systems.com>
 <332955D5-3122-437B-93A1-E1973BE09FCA@theobroma-systems.com>
 <AC03A80E-49F8-4A08-9DDA-0B9F8B734F51@theobroma-systems.com>
 <17844053.vZiPCu4un3@wuerfel>
 <20150414144702.GD14546@e104818-lin.cambridge.arm.com>
 <9F7FC15C-EED1-4939-B66A-1BC3119E0D9C@theobroma-systems.com>
 <20150414165459.GG14546@e104818-lin.cambridge.arm.com>
Message-ID: <B66B5217-1F57-4D81-8658-B6B170968C21@theobroma-systems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Catalin,

even though this may now be moot, as we?ll out a 32bit time_t on ILP32 (making it
very similar to n32 on MIPS), here?s the the info on what would be affected by 
changing timespec.

Below is a (hopefully) full list of system calls, helper functions and exposed data 
structures (with some comments on what will need to be done to resolve this change)
that would be affected by introducing an other timespec (let?s call it ilp32_timespec
for the ease of discussion) consisting of a 64bit time_t and a 32bit integer.

> On 14 Apr 2015, at 18:55, Catalin Marinas <catalin.marinas@arm.com> wrote:
> 
> As I mentioned above, timespec and possibly other structures no longer
> like any of the existing ABIs. Do we know how many syscalls are
> affected?

Here?s everything that affected (details on how to resolve are below) in no particular
order:
> syscall: utimensat
> syscall: io_getevents
> syscall: select
> internal: poll_select_copy_remaining (via select) [+on stack: struct compat_timespec rts;]
> syscall: pselect6
> internal: do_compat_pselect (via pselect6) [+on stack: struct compat_timespec ts;]
> syscall: ppoll [+on stack: struct compat_timespec ts;]
> syscall: nanosleep
> internal: compat_nanosleep_restart (via nanosleep)
> syscall: clock_gettime
> syscall: clock_settime
> syscall: clock_getres
> syscall: clock_nanosleep
> syscall: rt_sigtimedwait
> syscall: sched_rr_get_interval
> internal: compat_get_timespec
> internal: compat_put_timespec
> syscall: futex
> syscall: recvmmsg
> file_operations: compat_sock_ioctl
> internal: do_siocgstampns (via compat_sock_ioctl_trans via compat_sock_ioctl)
> syscall: semtimedop
> syscall: mq_timedsend
> syscall: mq_timedreceive
> internal: compat_convert_timespec
> syscall: timer_settime
> syscall: timer_gettime
> syscall: timerfd_settime
> syscall: timerfd_gettime
> struct: itimerspec
> internal: get_compat_itimerspec
> internal: put_compat_itimerspec
> struct: snd_pcm_status32
> internal: snd_pcm_ioctl_sync_ptr_compat
> struct: snd_pcm_mmap_status32
> internal: snd_pcm_status_user_compat
> struct: v4l2_event32
> internal: put_v4l2_event32 (via do_video_ioctl)
> struct: restart_block [simple change: additional field; for nanosleep]
> internal: put_cmsg_compat [on stack: struct compat_timespec cts[3];]
> struct: snd_rawmidi_status32
> internal: snd_rawmidi_ioctl_status_compat (handles snd_rawmidi_status32)
> struct: snd_timer_status32
> internal: snd_timer_user_status_compat
> struct: struct snd_pcm_mmap_status32
> internal: snd_pcm_ioctl_sync_ptr_compat (handles snd_pcm_mmap_status32)
> struct: snd_pcm_status32
> internal: snd_pcm_status_user_compat (handles snd_pcm_status32)

For dealing with them, we can roughly use the following strategy (I may have lost 
1.	The timespec/compat_timespec/ilp32_timespec is ever only referenced through
	its memory address and used for userspace/kernel-transfers.  For these cases
	we mere need to extend the compat_get_timespec and compat_put_timespec
	functions to recognize the ILP32-case? same for compat_convert_timespec

	For the affected syscalls, the ILP32 implementation should route through the 
	compat-layer. This can be done in the following cases (I?m leaving the compat 
	off for readability):
		utimensat
		io_getevents
		nanosleep
		clock_gettime
		clock_settime
		clock_getres
		clock_nanosleep
		rt_sigtimedwait
		sched_rr_get_interval
		recvmmsg
		futex
		semtimedop
		mq_timedsend
		mq_timedreceive

	One helper called through an ioctl will also need to pick this us:
		do_siocgstampns (through compat_sock_ioctl)

	A special case is the nanosleep syscall and its restart-helper: even though less
	apparent, this would be covered by the changes to compat_get_timespec and 
	compat_put_timespec also (as there?s only a pointer to a compat_timespec
	involved).

2.	An similar change will be required for anything that uses itimerspec (as that
	structure contains two timespec elements):
		timer_settime
		timer_gettime
		timerfd_settime
		timerfd_gettime	

3.	A compat_timespec is currently created on the stack, even though it?s used
	only for a get_user/put_user in a few cases; this can be resolved by changing
	to use compat_get_timespec/compat_put_timespec. Once this has been 
	done, then the changes from step 1 should also extend to these case.

	Instances include:
		poll_select_copy_remaining (helper function called from ?select?)
		do_compat_pselect (helper function called from ?pselect6?)
		ppoll

	The syscalls associated with these helper-functions need to be passed
	through the compat-layer for ILP32 also (as functions in their call chain 
	are affected):
		select
		pselect6

4.	There?s some limited expose in the v4l and snd subsystems, primarily in
	ioctl data-structures. For these, there?s typically already a compat-layer
	function and a compat-ioctl. So these will require a few (5 by my count) of
	individual fixes.


Hope this answers the question,
Phil.
