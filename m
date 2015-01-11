From: r.peniaev@gmail.com (Roman Pen)
Date: Sun, 11 Jan 2015 23:32:29 +0900
Subject: [PATCH 0/2] ARM: set thread_info->syscall just before sys_* execution
Message-ID: <1420986751-30364-1-git-send-email-r.peniaev@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

It turned out to be that on ARM 'syscall_get_nr' call and
corresponding userspace proc access '/proc/*/syscall' always
return 0 instead of correct syscall number:

 # cat /proc/*/syscall
 0 0xffffffff 0x0 0x0 0x0 0x0 0x0 0xbea33cc0 0xb6f32f2c
 0 0x5 0x16e99a8 0x0 0x0 0x0 0xbeec03b4 0xbeec02a0 0xb6cc85e0
 0 0x3 0xbeee5d44 0xbeee5d40 0xbeee5d40 0x0 0x0 0xbeee5d3c 0xb6ef40ac
 0 0xffffffff 0xbed757f8 0x2 0x0 0x2 0xbed757f8 0xbed757e0 0xb6e4af2c
 [snip]

Where first digit should be not 0, but correct syscall number.

The first patch fixes this and the second one does minor tweaks.

Roman Pen (2):
  ARM: entry-common: fix forgotten set of thread_info->syscall
  ARM: entry-common,ptrace: do not pass scno to syscall_trace_enter

 arch/arm/kernel/asm-offsets.c  | 1 +
 arch/arm/kernel/entry-common.S | 2 +-
 arch/arm/kernel/ptrace.c       | 6 ++++--
 3 files changed, 6 insertions(+), 3 deletions(-)

Signed-off-by: Roman Pen <r.peniaev@gmail.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Christoffer Dall <christoffer.dall@linaro.org>
Cc: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
Cc: Sekhar Nori <nsekhar@ti.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Eric Paris <eparis@redhat.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: stable at vger.kernel.org

-- 
2.1.3
