From: nschichan@freebox.fr (Nicolas Schichan)
Date: Wed, 24 Apr 2013 19:27:06 +0200
Subject: [PATCH V3] Support for JIT in Seccomp BPF filters.
Message-ID: <1366824429-26652-1-git-send-email-nschichan@freebox.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This patch serie adds support for jitted seccomp BPF filters, with the
required modifications to make it work on the ARM architecture.

- The first patch in the serie adds the required boiler plate in the
  core kernel seccomp code to invoke the JIT compilation/free code.

- The second patch reworks the ARM BPF JIT code to make the generation
  process less dependent on struct sk_filter.

- The last patch actually implements the ARM part in the BPF jit code.

Some benchmarks, on a 1.6Ghz 88f6282 CPU:

Each system call is tested in two way (fast/slow):

 - on the fast version, the tested system call is accepted immediately
   after checking the architecture (5 BPF instructions).

 - on the slow version, the tested system call is accepted after
   previously checking for 85 syscall (90 instructions, including the
   architecture check).

The tested syscall is invoked in a loop 1000000 time, the reported
time is the time spent in the loop in seconds.

Without Seccomp JIT:

Syscall		Time-Fast  Time-Slow
--------------- ---------- ----------
gettimeofday	0.389	   1.633
getpid		0.406	   1.688
getresuid	1.003	   2.266
getcwd		1.342	   2.128

With Seccomp JIT:

Syscall		Time-Fast  Time-Slow
--------------- ----------- ---------
gettimeofday	0.348	    0.428
getpid		0.365	    0.480
getresuid	0.981	    1.060
getcwd		1.237	    1.294

For reference, the same code without any seccomp filter:

Syscall		Time
--------------- -----
gettimeofday	0.119
getpid		0.137
getresuid	0.747
getcwd		1.021

The activation of the BPF JIT for seccomp is still controled with the
/proc/sys/net/core/bpf_jit_enable sysctl knob.

Those changes are based on the latest rmk-for-next branch.

V2 Changes:
- Document the @bpf_func field in struct seccomp_filter as recommended
  by Kees Cook.
- Invoke seccomp_bpf_load directly from generated code without going
  via a wrapper.

V3 Changes:
- add accessors giving access to the fields in struct seccomp_filter
  as recommended by Andrew Morton. This avoids having to include
  <linux/filter.h> in <linux/seccomp.h>, and fixes broken include
  dependencies on x86_64 allmodconfig build.
- checkpatch fixes (void*) -> (void *)

Regards,
