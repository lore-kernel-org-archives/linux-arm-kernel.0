From: ak@linux.intel.com (Andi Kleen)
Date: Tue, 31 May 2011 11:01:07 -0700
Subject: [PATCH] Disable -fconserve-stack on ARM
In-Reply-To: <20110531163026.GB771@e102109-lin.cambridge.arm.com>
References: <BANLkTim2TOZgB-3Vkv5RcK572Qr07s3=CA@mail.gmail.com>
	<1306429854.26735.9.camel@e102144-lin.cambridge.arm.com>
	<alpine.LFD.2.00.1105261650330.3207@xanadu.home>
	<20110526215101.GL24876@n2100.arm.linux.org.uk>
	<20110527083806.GA21100@e102109-lin.cambridge.arm.com>
	<20110527085414.GP24876@n2100.arm.linux.org.uk>
	<20110527095111.GC21100@e102109-lin.cambridge.arm.com>
	<yw1xlixse2fl.fsf@unicorn.mansr.com>
	<20110528153417.GB25869@alboin.amr.corp.intel.com>
	<20110531163026.GB771@e102109-lin.cambridge.arm.com>
Message-ID: <20110531180107.GA9261@alboin.amr.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Didn't work, on the gcc command line we get -fno-conserve-stack followed
> by -fconserve-stack from the top makefile and it seems that the latter
> takes priority.

Ah ok need to move it up then too in the top level Makefile.
Like this.

-Andi

---
Disable -fconserve-stack on ARM v2

There are reports that -fconserve-stack misaligns variables on the stack.
Disable it for ARM to work around this gcc bug.

v2: Move top level flags definition up
Signed-off-by: Andi Kleen <ak@linux.intel.com>

diff --git a/Makefile b/Makefile
index 529d93f..08d848f 100644
--- a/Makefile
+++ b/Makefile
@@ -564,6 +564,10 @@ else
 KBUILD_CFLAGS	+= -O2
 endif
 
+# conserve stack if available
+# do this early so that an architecture can override it.
+KBUILD_CFLAGS   += $(call cc-option,-fconserve-stack)
+
 include $(srctree)/arch/$(SRCARCH)/Makefile
 
 ifneq ($(CONFIG_FRAME_WARN),0)
@@ -629,9 +633,6 @@ KBUILD_CFLAGS += $(call cc-disable-warning, pointer-sign)
 # disable invalid "can't wrap" optimizations for signed / pointers
 KBUILD_CFLAGS	+= $(call cc-option,-fno-strict-overflow)
 
-# conserve stack if available
-KBUILD_CFLAGS   += $(call cc-option,-fconserve-stack)
-
 # use the deterministic mode of AR if available
 KBUILD_ARFLAGS := $(call ar-option,D)
 
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index f5b2b39..902fec9 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -41,6 +41,10 @@ ifeq ($(CONFIG_CC_STACKPROTECTOR),y)
 KBUILD_CFLAGS	+=-fstack-protector
 endif
 
+# ARM gcc developers unfortunately broke -fconserve-stack. It misaligns
+# variables on the stack
+KBUILD_CFLAGS += $(call cc-option,-fno-conserve-stack)
+
 ifeq ($(CONFIG_CPU_BIG_ENDIAN),y)
 KBUILD_CPPFLAGS	+= -mbig-endian
 AS		+= -EB
