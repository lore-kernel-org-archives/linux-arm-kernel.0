From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Wed, 11 Jul 2018 10:30:33 +0100
Subject: [PATCH 00/14] ARM BPF jit compiler improvements
Message-ID: <20180711093033.GP17271@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This series improves the ARM BPF JIT compiler by:
- enumerating the stack layout rather than using constants that happen
  to be multiples of four
- rejig the BPF "register" accesses to use negative numbers instead of
  positive, which could be confused with register numbers in the bpf2a32
  array.
- since we maintain the ARM FP register as a pointer to the top of our
  scratch space (or, with frame pointers enabled, a valid ARM frame
  pointer register), we can access our scratch space using FP, which is
  constant across all BPF programs, including tail-called programs.
- use immediate forms of ARM instructions where possible, rather than
  first loading the immediate into an ARM register.
- use load-with-shift instruction rather than seperate shift instruction
  followed by load
- avoid reloading index and array in the tail-call code
- use double-word load/store instructions where available

Version 2:
- Fix ARMv5 test pointed out by Olof
- Fix build error found by 0-day (adding an additional patch)

 arch/arm/net/bpf_jit_32.c | 982 ++++++++++++++++++++++++----------------------
 arch/arm/net/bpf_jit_32.h |  42 +-
 2 files changed, 543 insertions(+), 481 deletions(-)

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 13.8Mbps down 630kbps up
According to speedtest.net: 13Mbps down 490kbps up
