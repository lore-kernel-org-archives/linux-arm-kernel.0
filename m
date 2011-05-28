From: ak@linux.intel.com (Andi Kleen)
Date: Sat, 28 May 2011 08:34:17 -0700
Subject: [PATCH] Disable -fconserve-stack on ARM
In-Reply-To: <yw1xlixse2fl.fsf@unicorn.mansr.com>
References: <20110525124348.GA2340@arm.com>
	<yw1xaaeanbxe.fsf@unicorn.mansr.com>
	<BANLkTim2TOZgB-3Vkv5RcK572Qr07s3=CA@mail.gmail.com>
	<1306429854.26735.9.camel@e102144-lin.cambridge.arm.com>
	<alpine.LFD.2.00.1105261650330.3207@xanadu.home>
	<20110526215101.GL24876@n2100.arm.linux.org.uk>
	<20110527083806.GA21100@e102109-lin.cambridge.arm.com>
	<20110527085414.GP24876@n2100.arm.linux.org.uk>
	<20110527095111.GC21100@e102109-lin.cambridge.arm.com>
	<yw1xlixse2fl.fsf@unicorn.mansr.com>
Message-ID: <20110528153417.GB25869@alboin.amr.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here's a untested but straight forward patch to disable it.
-Andi

---

Disable -fconserve-stack on ARM

There are reports that -fconserve-stack misaligns variables on the stack.
Disable it for ARM to work around this gcc bug.

Signed-off-by: Andi Kleen <ak@linux.intel.com>

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 25750bc..0883cff 100644
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
