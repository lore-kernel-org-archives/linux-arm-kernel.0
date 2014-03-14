From: lauraa@codeaurora.org (Laura Abbott)
Date: Thu, 13 Mar 2014 17:50:41 -0700
Subject: [PATCH] arm64: Add ARCH_HAS_SG_CHAIN
In-Reply-To: <20140313180105.GG25472@mudshark.cambridge.arm.com>
References: <1394732963-12174-1-git-send-email-lauraa@codeaurora.org>
 <20140313180105.GG25472@mudshark.cambridge.arm.com>
Message-ID: <53225261.7080608@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3/13/2014 11:01 AM, Will Deacon wrote:
> On Thu, Mar 13, 2014 at 05:49:23PM +0000, Laura Abbott wrote:
>> It's useful to be able to chain scatterlists together for very large
>> scatter allocations. Define ARCH_HAS_SG_CHAIN to let this happen.
>>
>> Signed-off-by: Laura Abbott <lauraa@codeaurora.org>
>> ---
>>   arch/arm64/include/asm/scatterlist.h | 21 +++++++++++++++++++++
>>   1 file changed, 21 insertions(+)
>>   create mode 100644 arch/arm64/include/asm/scatterlist.h
>>
>> diff --git a/arch/arm64/include/asm/scatterlist.h b/arch/arm64/include/asm/scatterlist.h
>> new file mode 100644
>> index 0000000..7b2602a
>> --- /dev/null
>> +++ b/arch/arm64/include/asm/scatterlist.h
>> @@ -0,0 +1,21 @@
>> +/*
>> + * Copyright (c) 2014, The Linux Foundation. All rights reserved.
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 and
>> + * only version 2 as published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + */
>> +
>> +#ifndef __ASM_SCATTERLIST_H
>> +#define __ASM_SCATTERLIST_H
>> +
>> +#include <asm-generic/scatterlist.h>
>> +
>> +#define ARCH_HAS_SG_CHAIN
>
> Hmm, I wonder if this should be a Kconfig option instead, to avoid the need
> for the dummy header?
>
> Will
>

Yeah, it does seem non-standard at this point. Something like the
following perhaps?

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 1594945..8122294 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -82,6 +82,7 @@ config ARM
  	  <http://www.arm.linux.org.uk/>.

  config ARM_HAS_SG_CHAIN
+	select ARCH_HAS_SG_CHAIN
  	bool

  config NEED_SG_DMA_LENGTH
diff --git a/arch/arm/include/asm/scatterlist.h 
b/arch/arm/include/asm/scatterlist.h
index cefdb8f..2f87870 100644
--- a/arch/arm/include/asm/scatterlist.h
+++ b/arch/arm/include/asm/scatterlist.h
@@ -1,10 +1,6 @@
  #ifndef _ASMARM_SCATTERLIST_H
  #define _ASMARM_SCATTERLIST_H

-#ifdef CONFIG_ARM_HAS_SG_CHAIN
-#define ARCH_HAS_SG_CHAIN
-#endif
-
  #include <asm/memory.h>
  #include <asm/types.h>
  #include <asm-generic/scatterlist.h>
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 27bbcfc..f2f95f4 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -2,6 +2,7 @@ config ARM64
  	def_bool y
  	select ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE
  	select ARCH_USE_CMPXCHG_LOCKREF
+	select ARCH_HAS_SG_CHAIN
  	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
  	select ARCH_WANT_OPTIONAL_GPIOLIB
  	select ARCH_WANT_COMPAT_IPC_PARSE_VERSION
diff --git a/arch/ia64/Kconfig b/arch/ia64/Kconfig
index 0c8e553..13e2e8b 100644
--- a/arch/ia64/Kconfig
+++ b/arch/ia64/Kconfig
@@ -44,6 +44,7 @@ config IA64
  	select HAVE_MOD_ARCH_SPECIFIC
  	select MODULES_USE_ELF_RELA
  	select ARCH_USE_CMPXCHG_LOCKREF
+	select ARCH_HAS_SG_CHAIN
  	default y
  	help
  	  The Itanium Processor Family is Intel's 64-bit successor to
diff --git a/arch/ia64/include/asm/scatterlist.h 
b/arch/ia64/include/asm/scatterlist.h
index 08fd93b..c19b59d 100644
--- a/arch/ia64/include/asm/scatterlist.h
+++ b/arch/ia64/include/asm/scatterlist.h
@@ -2,6 +2,5 @@
  #define _ASM_IA64_SCATTERLIST_H

  #include <asm-generic/scatterlist.h>
-#define ARCH_HAS_SG_CHAIN

  #endif /* _ASM_IA64_SCATTERLIST_H */
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 957bf34..659aee2 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -141,6 +141,7 @@ config PPC
  	select HAVE_DEBUG_STACKOVERFLOW
  	select HAVE_IRQ_EXIT_ON_IRQ_STACK
  	select ARCH_USE_CMPXCHG_LOCKREF if PPC64
+	select ARCH_HAS_SG_CHAIN

  config GENERIC_CSUM
  	def_bool CPU_LITTLE_ENDIAN
diff --git a/arch/powerpc/include/asm/scatterlist.h 
b/arch/powerpc/include/asm/scatterlist.h
index de1f620..1f51af5 100644
--- a/arch/powerpc/include/asm/scatterlist.h
+++ b/arch/powerpc/include/asm/scatterlist.h
@@ -12,6 +12,4 @@
  #include <asm/dma.h>
  #include <asm-generic/scatterlist.h>

-#define ARCH_HAS_SG_CHAIN
-
  #endif /* _ASM_POWERPC_SCATTERLIST_H */
diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 65a0775..d6c2059 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -142,6 +142,7 @@ config S390
  	select SYSCTL_EXCEPTION_TRACE
  	select VIRT_CPU_ACCOUNTING
  	select VIRT_TO_BUS
+	select ARCH_HAS_SG_CHAIN

  config SCHED_OMIT_FRAME_POINTER
  	def_bool y
diff --git a/arch/s390/include/asm/scatterlist.h 
b/arch/s390/include/asm/scatterlist.h
index 6d45ef6..4aaea56 100644
--- a/arch/s390/include/asm/scatterlist.h
+++ b/arch/s390/include/asm/scatterlist.h
@@ -1,3 +1,2 @@
  #include <asm-generic/scatterlist.h>

-#define ARCH_HAS_SG_CHAIN
diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 7d8b7e9..7a179fe 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -42,6 +42,7 @@ config SPARC
  	select MODULES_USE_ELF_RELA
  	select ODD_RT_SIGACTION
  	select OLD_SIGSUSPEND
+	select ARCH_HAS_SG_CHAIN

  config SPARC32
  	def_bool !64BIT
diff --git a/arch/sparc/include/asm/scatterlist.h 
b/arch/sparc/include/asm/scatterlist.h
index 92bb638..6eab378 100644
--- a/arch/sparc/include/asm/scatterlist.h
+++ b/arch/sparc/include/asm/scatterlist.h
@@ -3,6 +3,4 @@

  #include <asm-generic/scatterlist.h>

-#define ARCH_HAS_SG_CHAIN
-
  #endif /* !(_SPARC_SCATTERLIST_H) */
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 0af5250..76997dc 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -127,6 +127,7 @@ config X86
  	select HAVE_DEBUG_STACKOVERFLOW
  	select HAVE_IRQ_EXIT_ON_IRQ_STACK if X86_64
  	select HAVE_CC_STACKPROTECTOR
+	select ARCH_HAS_SG_CHAIN

  config INSTRUCTION_DECODER
  	def_bool y
diff --git a/arch/x86/include/asm/scatterlist.h 
b/arch/x86/include/asm/scatterlist.h
index 4240878..b08f91d 100644
--- a/arch/x86/include/asm/scatterlist.h
+++ b/arch/x86/include/asm/scatterlist.h
@@ -3,6 +3,4 @@

  #include <asm-generic/scatterlist.h>

-#define ARCH_HAS_SG_CHAIN
-
  #endif /* _ASM_X86_SCATTERLIST_H */
diff --git a/include/linux/scatterlist.h b/include/linux/scatterlist.h
index a964f72..4b152c8 100644
--- a/include/linux/scatterlist.h
+++ b/include/linux/scatterlist.h
@@ -136,7 +136,7 @@ static inline void sg_set_buf(struct scatterlist 
*sg, const void *buf,
  static inline void sg_chain(struct scatterlist *prv, unsigned int 
prv_nents,
  			    struct scatterlist *sgl)
  {
-#ifndef ARCH_HAS_SG_CHAIN
+#ifndef CONFIG_ARCH_HAS_SG_CHAIN
  	BUG();
  #endif

diff --git a/include/scsi/scsi.h b/include/scsi/scsi.h
index 0a4edfe..d34cf2d 100644
--- a/include/scsi/scsi.h
+++ b/include/scsi/scsi.h
@@ -31,7 +31,7 @@ enum scsi_timeouts {
   * Like SCSI_MAX_SG_SEGMENTS, but for archs that have sg chaining. 
This limit
   * is totally arbitrary, a setting of 2048 will get you at least 8mb ios.
   */
-#ifdef ARCH_HAS_SG_CHAIN
+#ifdef CONFIG_ARCH_HAS_SG_CHAIN
  #define SCSI_MAX_SG_CHAIN_SEGMENTS	2048
  #else
  #define SCSI_MAX_SG_CHAIN_SEGMENTS	SCSI_MAX_SG_SEGMENTS
diff --git a/lib/Kconfig b/lib/Kconfig
index 991c98b..32c68d3 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -451,4 +451,11 @@ config UCS2_STRING

  source "lib/fonts/Kconfig"

+#
+# sg chaining option
+#
+
+config ARCH_HAS_SG_CHAIN
+	def_bool n
+
  endmenu
diff --git a/lib/scatterlist.c b/lib/scatterlist.c
index 3a8e8e8..4251cbd 100644
--- a/lib/scatterlist.c
+++ b/lib/scatterlist.c
@@ -73,7 +73,7 @@ EXPORT_SYMBOL(sg_nents);
   **/
  struct scatterlist *sg_last(struct scatterlist *sgl, unsigned int nents)
  {
-#ifndef ARCH_HAS_SG_CHAIN
+#ifndef CONFIG_ARCH_HAS_SG_CHAIN
  	struct scatterlist *ret = &sgl[nents - 1];
  #else
  	struct scatterlist *sg, *ret = NULL;
@@ -251,7 +251,7 @@ int __sg_alloc_table(struct sg_table *table, 
unsigned int nents,

  	if (nents == 0)
  		return -EINVAL;
-#ifndef ARCH_HAS_SG_CHAIN
+#ifndef CONFIG_ARCH_HAS_SG_CHAIN
  	if (WARN_ON_ONCE(nents > max_ents))
  		return -EINVAL;
  #endif

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
