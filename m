From: david.daney@cavium.com (David Daney)
Date: Thu, 15 Jun 2017 15:35:40 -0700
Subject: [PATCH RFC 0/3] bpf/arm64/mips: Avoid inline asm in BPF
Message-ID: <20170615223543.22867-1-david.daney@cavium.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To build samples/bpf on MIPS we need to avoid some inline asm that
causes llvm to fail.

Looking at the code, it seems that arm64 had the same problem and
avoided it by defining the header guard symbol.  This approach does
not scale, so I invented a preprocessor define to identify the case of
building with a BPF target that can be used instead.

It is an RFC at this point as I haven't yet tested the arm64 change,
and I wanted to see if others think this is the proper way to handle
avoidance of inline asm.

David Daney (3):
  arm64: Gate inclusion of asm/sysreg.h by __EMITTING_BPF__
  samples/bpf: Add define __EMITTING_BPF__ when building BPF
  MIPS: Include file changes to enable building BPF code with llvm

 arch/arm64/include/asm/sysreg.h   | 4 +++-
 arch/mips/Makefile                | 1 +
 arch/mips/cavium-octeon/Platform  | 3 +++
 arch/mips/include/asm/checksum.h  | 2 +-
 arch/mips/include/uapi/asm/swab.h | 2 +-
 samples/bpf/Makefile              | 8 ++++----
 6 files changed, 13 insertions(+), 7 deletions(-)

-- 
2.11.0
