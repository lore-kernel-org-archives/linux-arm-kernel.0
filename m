From: mathieu.desnoyers@polymtl.ca (Mathieu Desnoyers)
Date: Wed, 10 Mar 2010 15:02:36 -0500
Subject: [PATCH] ARM support single byte cmpxchg and cmpxchg_local on ARMv6
In-Reply-To: <20100310173503.GC12345@n2100.arm.linux.org.uk>
References: <20100310162221.GA19201@localhost>
	<20100310173503.GC12345@n2100.arm.linux.org.uk>
Message-ID: <20100310200235.GA29827@Krystal>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Russell King - ARM Linux (linux at arm.linux.org.uk) wrote:
> On Wed, Mar 10, 2010 at 06:22:21PM +0200, Imre Deak wrote:
> > recently you've added support for __cmpxchg for ARMv6+. There the assumption
> > is that ldrex[bh]/strex[bh] is only supported on platforms with the 32v6K
> > extension.
> > 
> > Currently the __xchg code uses these even without the extension. Should this
> > be fixed?
> 
> From what I remember, the half-word versions definitely aren't supported
> on anything without V6K extensions.  I think that the byte and word
> versions are supported on V6 and up though.
> 
> That'd make both __cmpxchg and __xchg slightly buggy, in different ways.
> 
> What it does mean is that atomic operations on unsigned shorts using
> ldrex/strex will only be possible on V6K and up.

Does the following help (addressing the single byte cmpxchg part of the
problem) ?


ARM support single byte cmpxchg and cmpxchg_local on ARMv6

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC: Russell King - ARM Linux <linux@arm.linux.org.uk>
CC: Imre Deak <imre.deak@nokia.com>
---
 arch/arm/include/asm/system.h |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

Index: linux-2.6-lttng.git/arch/arm/include/asm/system.h
===================================================================
--- linux-2.6-lttng.git.orig/arch/arm/include/asm/system.h	2010-03-10 14:49:59.000000000 -0500
+++ linux-2.6-lttng.git/arch/arm/include/asm/system.h	2010-03-10 14:57:41.000000000 -0500
@@ -352,7 +352,6 @@
 	unsigned long oldval, res;
 
 	switch (size) {
-#ifdef CONFIG_CPU_32v6K
 	case 1:
 		do {
 			asm volatile("@ __cmpxchg1\n"
@@ -365,6 +364,7 @@
 				: "memory", "cc");
 		} while (res);
 		break;
+#ifdef CONFIG_CPU_32v6K
 	case 2:
 		do {
 			asm volatile("@ __cmpxchg1\n"
@@ -424,7 +424,6 @@
 
 	switch (size) {
 #ifndef CONFIG_CPU_32v6K
-	case 1:
 	case 2:
 		ret = __cmpxchg_local_generic(ptr, old, new, size);
 		break;


-- 
Mathieu Desnoyers
Operating System Efficiency Consultant
EfficiOS Inc.
http://www.efficios.com
