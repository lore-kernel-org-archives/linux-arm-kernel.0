From: michael.weiser@gmx.de (Michael Weiser)
Date: Mon, 22 Jan 2018 22:20:24 +0100
Subject: [PATCH 0/2] arm64: Unimplemented syscall kernel message
In-Reply-To: <20180122131851.GA28638@arm.com>
References: <20180122131851.GA28638@arm.com>
Message-ID: <20180122212026.26262-1-michael.weiser@gmx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

I'm not pretending to fully understand the semantics of what I've done
but I've tried to make a start on implementing both changes anyway.

The first is straightforward in dropping the offending log message from
do_ni_syscall().

The second mirrors arm behaviour in compat_arm_syscall() in raising
SIGILL for (most) unimplemented syscalls. I've intentionally kept the
arm message format in case anyone has a script filtering for it.

Syncing __dump_instr() with arm to support thumb instructions was done
on the assumption that arm-eabi code may obviously contain thumb
instructions.

Both are compile-tested as well as manually prodded with some randomly
chosen syscall numbers from aarch64 and arm-eabi binaries while running
under qemu-system-aarch64.

Thanks,
Michael

Michael Weiser (2):
  arm64: Remove unimplemented syscall log message
  arm64: Mirror arm for unimplemented compat syscalls

 arch/arm64/include/asm/system_misc.h |  1 +
 arch/arm64/kernel/sys_compat.c       | 27 ++++++++++++++++++++++++++-
 arch/arm64/kernel/traps.c            | 22 ++++++++++------------
 3 files changed, 37 insertions(+), 13 deletions(-)

-- 
2.16.0
