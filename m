From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Sat,  4 Aug 2018 20:46:23 +0200
Subject: [PATCH 0/2] crypto: arm64/ghash-ce - performance improvements
Message-ID: <20180804184625.28523-1-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Another bit of performance work on the GHASH driver: this time it is not
the combined AES/GCM algorithm but the bare GHASH driver that gets updated.

Even though ARM cores that implement the polynomical multiplication
instructions that these routines depend on are guaranteed to also support
the AES instructions, and can thus use the AES/GCM driver, there could
be reasons to use the accelerated GHASH in isolation, e.g., with another
symmetric blockcipher, with a faster h/w accelerator, or potentially with
an accelerator that does not expose the AES key to the OS.

The resulting code runs at 1.1 cycles per byte on Cortex-A53 (down from
2.4 cycles per byte)

Ard Biesheuvel (2):
  crypto: arm64/ghash-ce - replace NEON yield check with block limit
  crypto: arm64/ghash-ce - implement 4-way aggregation

 arch/arm64/crypto/ghash-ce-core.S | 153 ++++++++++++++------
 arch/arm64/crypto/ghash-ce-glue.c |  87 ++++++-----
 2 files changed, 161 insertions(+), 79 deletions(-)

-- 
2.18.0
