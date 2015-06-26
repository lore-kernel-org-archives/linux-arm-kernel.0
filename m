From: will.deacon@arm.com (Will Deacon)
Date: Fri, 26 Jun 2015 11:08:05 +0100
Subject: arm64 allmodconfig failure in =?utf-8?Q?ex?=
 =?utf-8?B?cGFuc2lvbiBvZiBtYWNybyDigJhfWOKAmQ==?=
Message-ID: <20150626100805.GC1568@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

arm64 allmodconfig fails to build with mainline due to the following:


  In file included from include/acpi/platform/aclinux.h:74:0,
                   from include/acpi/platform/acenv.h:173,
                   from include/acpi/acpi.h:56,
                   from include/linux/acpi.h:37,
                   from ./arch/arm64/include/asm/dma-mapping.h:21,
                   from include/linux/dma-mapping.h:86,
                   from include/linux/skbuff.h:34,
                   from include/crypto/algapi.h:18,
                   from crypto/asymmetric_keys/rsa.c:16:
  include/linux/ctype.h:15:12: error: expected ?;?, ?,? or ?)? before numeric constant
   #define _X 0x40 /* hex digit */
              ^
  crypto/asymmetric_keys/rsa.c:123:47: note: in expansion of macro ?_X?
   static int RSA_I2OSP(MPI x, size_t xLen, u8 **_X)
                                                 ^
  crypto/asymmetric_keys/rsa.c: In function ?RSA_verify_signature?:
  crypto/asymmetric_keys/rsa.c:256:2: error: implicit declaration of function ?RSA_I2OSP? [-Werror=implicit-function-declaration]
    ret = RSA_I2OSP(m, k, &EM);


This is thanks to the following function type:

  static int RSA_I2OSP(MPI x, size_t xLen, u8 **__X)

conflicting with the _X #define in linux/ctype.h:

  #define _X      0x40    /* hex digit */

Simple patch below, but solving this problem with more underscores feels
slightly inhumane.

Will

--->8

diff --git a/crypto/asymmetric_keys/rsa.c b/crypto/asymmetric_keys/rsa.c
index 459cf97a75e2..a4e53239448b 100644
--- a/crypto/asymmetric_keys/rsa.c
+++ b/crypto/asymmetric_keys/rsa.c
@@ -120,7 +120,7 @@ static int RSAVP1(const struct public_key *key, MPI s, MPI *_m)
 /*
  * Integer to Octet String conversion [RFC3447 sec 4.1]
  */
-static int RSA_I2OSP(MPI x, size_t xLen, u8 **_X)
+static int RSA_I2OSP(MPI x, size_t xLen, u8 **__X)
 {
 	unsigned X_size, x_size;
 	int X_sign;
@@ -147,7 +147,7 @@ static int RSA_I2OSP(MPI x, size_t xLen, u8 **_X)
 		return -EBADMSG;
 	}
 
-	*_X = X;
+	*__X = X;
 	return 0;
 }
 
