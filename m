From: jussi.kivilinna@mbnet.fi (Jussi Kivilinna)
Date: Tue, 30 Oct 2012 12:07:43 +0200
Subject: [PATCH] [RFC] crypto: sha1/arm - fix build with CONFIG_THUMB2_KERNEL
Message-ID: <20121030100742.17910.70241.stgit@localhost6.localdomain6>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Building cryptodev-2.6 tree with CONFIG_THUMB2_KERNEL=y and
CONFIG_CRYPTO_SHA1_ARM=y give following error:

   AS      arch/arm/crypto/sha1-armv4-large.o
arch/arm/crypto/sha1-armv4-large.S: Assembler messages:
arch/arm/crypto/sha1-armv4-large.S:197: Error: r13 not allowed here --
`teq r14,sp'
arch/arm/crypto/sha1-armv4-large.S:377: Error: r13 not allowed here --
`teq r14,sp'
arch/arm/crypto/sha1-armv4-large.S:469: Error: r13 not allowed here --
`teq r14,sp'

Build can be fixed with adding '.arm' at head of sha1-armv4-large.S.
However I'm not sure if this correct fix as this is my first stab
at arm assembler and I could not get CONFIG_THUMB2_KERNEL boot up
on 'qemu-system-arm -M vexpress-a9' to verify correctness. So this
is only build tested.

Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-crypto at vger.kernel.org
Cc: David McCullough <ucdevel@gmail.com>
---
 arch/arm/crypto/sha1-armv4-large.S |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/crypto/sha1-armv4-large.S b/arch/arm/crypto/sha1-armv4-large.S
index 7050ab1..e8a55eb 100644
--- a/arch/arm/crypto/sha1-armv4-large.S
+++ b/arch/arm/crypto/sha1-armv4-large.S
@@ -53,6 +53,8 @@
 
 .text
 
+.arm
+
 .global	sha1_block_data_order
 .type	sha1_block_data_order,%function
 
