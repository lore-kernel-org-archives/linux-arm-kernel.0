From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 20 Feb 2018 22:15:23 -0500 (EST)
Subject: [PATCH 3/7] [HACK] pass endianess flag to LTO linker
In-Reply-To: <20180220215954.4092811-4-arnd@arndb.de>
References: <20180220215954.4092811-1-arnd@arndb.de>
 <20180220215954.4092811-4-arnd@arndb.de>
Message-ID: <nycvar.YSQ.7.76.1802202213560.31644@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 20 Feb 2018, Arnd Bergmann wrote:

> We need some way to pass -mbig-endian to the linker during the
> LTO link stage, otherwise we get a waning like
> 
> arm-linux-gnueabi/bin/ld: arch/arm/lib/clearbit.o: compiled for a big endian system and target is little endian
> 
> for each file we link in.
> 
> There is probably a better method of passing that flag, I'm just
> adding it to a different hack that I added earlier for x86 LTO
> here.

Didn't the patch below fix it for you already?

----- >8
Date: Fri, 1 Sep 2017 18:37:52 -0400
Subject: [PATCH] scripts/gcc-ld: LTO on ARM needs arch specific gcc flags

Otherwise the final link where code generation happens produces code
for the wrong ISA when the default CPU configured into gcc is not the
one we need.

Also display the actual command when invoked with "make V=1".

Signed-off-by: Nicolas Pitre <nico@linaro.org>

diff --git a/scripts/gcc-ld b/scripts/gcc-ld
index d95dd0be38..fa53be2a34 100755
--- a/scripts/gcc-ld
+++ b/scripts/gcc-ld
@@ -27,4 +27,10 @@ while [ "$1" != "" ] ; do
 	shift
 done
 
-exec $CC $ARGS
+case "${KBUILD_VERBOSE}" in
+*1*)
+	set -x
+	;;
+esac
+
+exec $CC $KBUILD_CFLAGS $ARGS
