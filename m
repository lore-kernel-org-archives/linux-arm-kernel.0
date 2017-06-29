From: luc.vanoostenryck@gmail.com (Luc Van Oostenryck)
Date: Thu, 29 Jun 2017 16:31:40 +0200
Subject: [PATCH v2] arm64: add missing conversion to __wsum in ip_fast_csum()
In-Reply-To: <20170629100743.GD14607@arm.com>
References: <20170628145814.24763-1-luc.vanoostenryck@gmail.com>
 <20170629100743.GD14607@arm.com>
Message-ID: <20170629143138.gn6gwwoyllsolzcp@ltop.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM64 implementation of ip_fast_csum() do most of the work
in 128 or 64 bit and call csum_fold() to finalize. csum_fold()
itself take a __wsum argument, to insure that this value is
always a 32bit native-order value.

Fix this by adding the sadly needed '__force' to cast the native
'sum' to the type '__wsum'.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

---
Change since v1:
- use the simple __force cast instead of an intermediate helper.
---
 arch/arm64/include/asm/checksum.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/checksum.h b/arch/arm64/include/asm/checksum.h
index 09f65339d..0b6f5a7d4 100644
--- a/arch/arm64/include/asm/checksum.h
+++ b/arch/arm64/include/asm/checksum.h
@@ -42,7 +42,7 @@ static inline __sum16 ip_fast_csum(const void *iph, unsigned int ihl)
 	} while (--ihl);
 
 	sum += ((sum >> 32) | (sum << 32));
-	return csum_fold(sum >> 32);
+	return csum_fold((__force u32)(sum >> 32));
 }
 #define ip_fast_csum ip_fast_csum
 
-- 
2.13.0
