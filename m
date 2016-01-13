From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 13 Jan 2016 23:24:02 +0100
Subject: lib: sw842: select crc32
Message-ID: <4168537.6I1FVkp3DA@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The sw842 library code was merged in linux-4.1 and causes a very rare randconfig
failure when CONFIG_CRC32 is not set:
    
    lib/built-in.o: In function `sw842_compress':
    oid_registry.c:(.text+0x12ddc): undefined reference to `crc32_be'
    lib/built-in.o: In function `sw842_decompress':
    oid_registry.c:(.text+0x137e4): undefined reference to `crc32_be'

This adds an explict 'select CRC32' statement, similar to what the other users
of the crc32 code have. In practice, CRC32 is always enabled anyway because
over 100 other symbols select it.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 2da572c959dd ("lib: add software 842 compression/decompression")

diff --git a/lib/Kconfig b/lib/Kconfig
index 1ce5af9cc418..ee38a3fd2814 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -217,9 +217,11 @@ config RANDOM32_SELFTEST
 # compression support is select'ed if needed
 #
 config 842_COMPRESS
+	select CRC32
 	tristate
 
 config 842_DECOMPRESS
+	select CRC32
 	tristate
 
 config ZLIB_INFLATE
