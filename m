From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 31 May 2016 15:55:02 +0100
Subject: [PATCH 0/2] arm64: /proc/cpuinfo updates for compat tasks
Message-ID: <1464706504-25224-1-git-send-email-catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The first patch is relatively simple, adding the "model name" line which
is present in the arm32 /proc/cpuinfo.

The second patch is up for discussion. When arm64 support was merged, we
concluded that "uname -m" should report "aarch64" even for compat tasks.
The only way to change the output to "armv8l" was to set the PER_LINUX32
personality (and I think this is in line with x86).

We followed a similar personality approach for /proc/cpuinfo where the
compat one is only exposed if the task sets/inherits PER_LINUX32. The
downside is that apparently some 32-bit applications started making use
of the 64-bit /proc/cpuinfo format. To prevent further spread, I'm
proposing the second patch in this series to force compat /proc/cpuinfo
for 32-bit tasks. This is a departure from the "uname -m" behaviour but
maybe they don't need to be coupled anyway.

Thoughts?

Catalin Marinas (2):
  arm64: Provide "model name" in /proc/cpuinfo for PER_LINUX32 tasks
  arm64: Always provide compat /proc/cpuinfo for 32-bit tasks

 arch/arm64/include/asm/elf.h | 4 ++--
 arch/arm64/kernel/cpuinfo.c  | 9 ++++++++-
 2 files changed, 10 insertions(+), 3 deletions(-)
