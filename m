From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon,  7 Oct 2013 14:12:26 +0200
Subject: [RFC PATCH 0/5] ARM64: NEON/CE based crypto in atomic contexts
Message-ID: <1381147951-7609-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I am probably going to be flamed for bringing this up, but here it goes ...

This is more of a request for discussion rather than a request for comments on
these patches.

After floating point and SIMD we now have a third class of instructions that use
the NEON register file, the AES and SHA instructions that are present in the v8
Crypto Extensions.

This series uses CCMP as an example to make the case for having limited support
for the use of the NEON register file in atomic context. CCMP is the encryption
standard used in WPA2, and it is based on AES in CCM mode, which is basically
both encryption and authentication by passing all the data through AES twice.

The mac80211 layer, which performs this encryption and decryption, does so in a
context which does not allow the use of asynchronous ciphers, which in practice
means that it uses the C implementation (on ARM64), which I expect to be around
an order of magnitude slower than the dedicated instructions(*).

I have included two ways of working around this: patch #3 implements the core
AES cipher using only registers q0 and q1. Patch #4 implements the CCM chaining
mode using registers q0 - q3. (The significance of the latter is that I expect a
certain degree of interleaving to be required to run the AES instructions at
full speed, and CCM -while difficult to parallelize- can easily be implemented
with a 2-way interleave of the encryption and authentication parts.)

Patch #1 implements the stacking of 4 NEON registers (but note that patch #3
only needs 2 registers). Patch #2 implements emulation of the AES instructions
(considering how few of us have access to the Fast Model plugin). Patch #5
modifies the mac80211 code so it relies on the crypto api to supply a CCM
implementation rather than cooking up its own (latter is compile tested only and
included for reference)

* On ARM, we have the C implementation which runs in ~64 cycles per round and
  an accelerated synchronous implementation which runs in ~32 cycles per round
  (on Cortex-A15), but the latter relies heavily on the barrel shifter so its
  performance is difficult to extrapolate to ARMv8. It should also be noted that
  the table based C implementation uses 16kB in lookup tables (8 kB each way).


Ard Biesheuvel (5):
  ARM64: allow limited use of some NEON registers in exceptions
  ARM64: add quick-n-dirty emulation for AES instructions
  ARM64: add Crypto Extensions based synchronous core AES cipher
  ARM64: add Crypto Extensions based synchronous AES in CCM mode
  mac80211: Use CCM crypto driver for CCMP

 arch/arm64/Kconfig              |  14 ++
 arch/arm64/Makefile             |   1 +
 arch/arm64/crypto/Makefile      |  16 ++
 arch/arm64/crypto/aes-sync.c    | 410 ++++++++++++++++++++++++++++++++++++++++
 arch/arm64/crypto/aesce-ccm.S   | 159 ++++++++++++++++
 arch/arm64/crypto/aesce-emu.c   | 221 ++++++++++++++++++++++
 arch/arm64/include/asm/ptrace.h |   3 +
 arch/arm64/include/asm/traps.h  |  10 +
 arch/arm64/kernel/asm-offsets.c |   3 +
 arch/arm64/kernel/entry.S       |  12 +-
 arch/arm64/kernel/traps.c       |  49 +++++
 net/mac80211/Kconfig            |   1 +
 net/mac80211/aes_ccm.c          | 159 +++++-----------
 net/mac80211/aes_ccm.h          |   8 +-
 net/mac80211/key.h              |   2 +-
 net/mac80211/wpa.c              |  21 +-
 16 files changed, 961 insertions(+), 128 deletions(-)
 create mode 100644 arch/arm64/crypto/Makefile
 create mode 100644 arch/arm64/crypto/aes-sync.c
 create mode 100644 arch/arm64/crypto/aesce-ccm.S
 create mode 100644 arch/arm64/crypto/aesce-emu.c

-- 
1.8.1.2
