From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 27 Aug 2018 13:02:42 +0200
Subject: [PATCH 1/4] lib/crc32: make core crc32() routines weak so they can be
 overridden
In-Reply-To: <20180827110245.14812-1-ard.biesheuvel@linaro.org>
References: <20180827110245.14812-1-ard.biesheuvel@linaro.org>
Message-ID: <20180827110245.14812-2-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allow architectures to drop in accelerated CRC32 routines by making
the crc32_le/__crc32c_le entry points weak, and exposing non-weak
aliases for them that may be used by the accelerated versions as
fallbacks in case the instructions they rely upon are not available.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 lib/crc32.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/lib/crc32.c b/lib/crc32.c
index a6c9afafc8c8..45b1d67a1767 100644
--- a/lib/crc32.c
+++ b/lib/crc32.c
@@ -183,21 +183,21 @@ static inline u32 __pure crc32_le_generic(u32 crc, unsigned char const *p,
 }
 
 #if CRC_LE_BITS == 1
-u32 __pure crc32_le(u32 crc, unsigned char const *p, size_t len)
+u32 __pure __weak crc32_le(u32 crc, unsigned char const *p, size_t len)
 {
 	return crc32_le_generic(crc, p, len, NULL, CRC32_POLY_LE);
 }
-u32 __pure __crc32c_le(u32 crc, unsigned char const *p, size_t len)
+u32 __pure __weak __crc32c_le(u32 crc, unsigned char const *p, size_t len)
 {
 	return crc32_le_generic(crc, p, len, NULL, CRC32C_POLY_LE);
 }
 #else
-u32 __pure crc32_le(u32 crc, unsigned char const *p, size_t len)
+u32 __pure __weak crc32_le(u32 crc, unsigned char const *p, size_t len)
 {
 	return crc32_le_generic(crc, p, len,
 			(const u32 (*)[256])crc32table_le, CRC32_POLY_LE);
 }
-u32 __pure __crc32c_le(u32 crc, unsigned char const *p, size_t len)
+u32 __pure __weak __crc32c_le(u32 crc, unsigned char const *p, size_t len)
 {
 	return crc32_le_generic(crc, p, len,
 			(const u32 (*)[256])crc32ctable_le, CRC32C_POLY_LE);
@@ -206,6 +206,9 @@ u32 __pure __crc32c_le(u32 crc, unsigned char const *p, size_t len)
 EXPORT_SYMBOL(crc32_le);
 EXPORT_SYMBOL(__crc32c_le);
 
+u32 crc32_le_base(u32, unsigned char const *, size_t) __alias(crc32_le);
+u32 __crc32c_le_base(u32, unsigned char const *, size_t) __alias(__crc32c_le);
+
 /*
  * This multiplies the polynomials x and y modulo the given modulus.
  * This follows the "little-endian" CRC convention that the lsbit
-- 
2.18.0
