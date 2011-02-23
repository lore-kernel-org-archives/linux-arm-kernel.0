From: jamie@jamieiles.com (Jamie Iles)
Date: Wed, 23 Feb 2011 14:40:20 +0000
Subject: CPU_V6K build failure in next-20110223
Message-ID: <20110223144020.GE2796@pulham.picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

Building todays next tree for my board (CPU_V6K) results in the 
following build error:

  CC      arch/arm/kernel/asm-offsets.s
In file included from /home/jamiei/src/linux-2.6/arch/arm/include/asm/cacheflush.h:15,
                 from arch/arm/kernel/asm-offsets.c:16:
/home/jamiei/src/linux-2.6/arch/arm/include/asm/glue-cache.h:129:2: error: #error Unknown cache maintainence model
make[1]: *** [arch/arm/kernel/asm-offsets.s] Error 1
make: *** [prepare0] Error 2

Building dove_defconfig also results in the same error.  The patch below 
appears to fix the issue.

Jamie

8<----

diff --git a/arch/arm/include/asm/glue-cache.h b/arch/arm/include/asm/glue-cache.h
index 0591d35..c7afbc5 100644
--- a/arch/arm/include/asm/glue-cache.h
+++ b/arch/arm/include/asm/glue-cache.h
@@ -109,7 +109,7 @@
 # define MULTI_CACHE 1
 #endif
 
-#if defined(CONFIG_CPU_V6)
+#if defined(CONFIG_CPU_V6) || defined(CONFIG_CPU_V6K)
 //# ifdef _CACHE
 #  define MULTI_CACHE 1
 //# else
 //
---->8
