From: Dave.Martin@arm.com (Dave Martin)
Date: Wed, 28 Mar 2018 10:50:47 +0100
Subject: [PATCH v2 0/2] arm64: uaccess: Fix omissions from usercopy whitelist
Message-ID: <1522230649-22008-1-git-send-email-Dave.Martin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When the hardend usercopy support was added for arm64, it was
concluded [1] that all cases of usercopy into and out of
thread_struct were statically sized and so didn't require explicit
whitelisting of the appropriate fields in thread_struct.

Testing with usercopy hardening enabled has revealed that this is not
the case for certain ptrace regset manipulation calls on arm64.  This
series attempts to fix the usercopy whitelist so that such copies can
be policed correctly.  See patch 2 for a more detailed explanation of
the change.

I wrote patch 1 recently for unrelated reasons, but it turns out to be
useful here since it splits the user-copiable cpu field out from
struct fpsimd_state.  Mixing user and non-user fields in that struct
has proven awkard in a variety of situations now, so it is a good
opportunity to separate them.


Bug reproduced, and fix tested, on Arm Juno r0, with defconfig +
CONFIG_HARDENED_USERCOPY=y
CONFIG_HARDENED_USERCOPY_FALLBACK=y

Not tested in many configurations.  Edits were done by the equivalent of
the following shell commands (plus some rewrapping and a few manual
fixups).

	s='\(\.\|->\)\(fpsimd_state\|tp2\?_value\)'
	git grep -l "$s" -- arch/arm64/ | xargs -d'\n' sed -i "s/$s/\1uw.\2/g"


The bug can be reproduced by running up to a breakpoint in gdb (or
anything else that does a PTRACE_GETREGSET on NT_PRFPREG or
NT_ARM_TLS).

Without the fix, reading an affected regset resulting in a WARN_ON()
splat from the usercopy hardening code, similar to the following:

[   37.429560] ------------[ cut here ]------------
[   37.434220] Bad or missing usercopy whitelist? Kernel memory exposure attempt detected from SLUB object 'task_struct' (offset 2664, size 8)!
[   37.446895] WARNING: CPU: 4 PID: 2431 at mm/usercopy.c:81 usercopy_warn+0x7c/0xc8
[   37.454387] Modules linked in:
[   37.457449] CPU: 4 PID: 2431 Comm: gdb Not tainted 4.16.0-rc6 #10
[   37.463550] Hardware name: ARM LTD ARM Juno Development Platform/ARM Juno Development Platform, BIOS EDK II Dec 15 2016
[   37.474352] pstate: 60000005 (nZCv daif -PAN -UAO)
[   37.479149] pc : usercopy_warn+0x7c/0xc8
[   37.483075] lr : usercopy_warn+0x7c/0xc8
[   37.486998] sp : ffff00000e0fbcb0
[   37.490313] x29: ffff00000e0fbcc0 x28: ffff8009759c0000
[   37.495637] x27: ffff000008a71000 x26: 0000000000000075
[   37.500959] x25: 0000000000000124 x24: 0000000000000015
[   37.506280] x23: ffff7e0025d04880 x22: ffff800974122670
[   37.511601] x21: 0000000000000001 x20: 0000000000000008
[   37.516923] x19: ffff800974122668 x18: 0000000000000006
[   37.522244] x17: 0000ffff8f89ed40 x16: ffff0000080deb58
[   37.527565] x15: ffff0000091864dd x14: 6620646574636574
[   37.532885] x13: 65642074706d6574 x12: 746120657275736f
[   37.538206] x11: ffff0000085c5960 x10: ffff000009029df8
[   37.543527] x9 : 4b203f7473696c65 x8 : 657a6973202c3436
[   37.548848] x7 : 3632207465736666 x6 : 000000000000012f
[   37.554169] x5 : 0000000000000000 x4 : 0000000000000000
[   37.559489] x3 : 0000000000000000 x2 : ffff8009759c0000
[   37.564810] x1 : 73ce9fcbba171400 x0 : 0000000000000000
[   37.570131] Call trace:
[   37.572577]  usercopy_warn+0x7c/0xc8
[   37.576156]  __check_heap_object+0xc4/0x130
[   37.580343]  __check_object_size+0x184/0x1e0
[   37.584618]  tls_get+0x6c/0xd0
[   37.587674]  ptrace_regset+0x11c/0x160
[   37.591426]  ptrace_request+0x590/0x638
[   37.595265]  arch_ptrace+0xc/0x18
[   37.598581]  SyS_ptrace+0xc8/0x120
[   37.601985]  el0_svc_naked+0x30/0x34
[   37.605561] ---[ end trace 28b009f07d48b579 ]---

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2018-January/554362.html

Dave Martin (2):
  arm64: fpsimd: Split cpu field out from struct fpsimd_state
  arm64: uaccess: Fix omissions from usercopy whitelist

 arch/arm64/include/asm/fpsimd.h    | 29 ++-------------
 arch/arm64/include/asm/processor.h | 40 +++++++++++++--------
 arch/arm64/kernel/fpsimd.c         | 73 ++++++++++++++++++++------------------
 arch/arm64/kernel/process.c        |  6 ++--
 arch/arm64/kernel/ptrace.c         | 30 ++++++++--------
 arch/arm64/kernel/signal.c         |  2 +-
 arch/arm64/kernel/signal32.c       |  2 +-
 arch/arm64/kernel/sys_compat.c     |  2 +-
 8 files changed, 88 insertions(+), 96 deletions(-)

-- 
2.1.4
