From: mikpe@it.uu.se (Mikael Pettersson)
Date: Fri, 11 Sep 2009 11:36:45 +0200
Subject: [PATCH RESEND 2.6.31] ixp4xx: arch_idle() documentation fixup
Message-ID: <19114.6701.7384.620663@pilspetsen.it.uu.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[2nd attempt to send this, we seem to be having major issues
with outgoing email, my apologies if you see this twice]

The body of the mach-ixp4xx arch_idle() is mysteriously
disabled by an #if 0 .. #endif. Normally one would expect
to find a call to cpu_do_idle() there, but that call is
disabled, even though cpu_do_idle() is implemented for
XScale cores (and ixp4xx is one).

The explanation can be found in the ixp42x developer's manual
which states that the XScale core clock and power management
registers aren't implemented on ixp42x [3.5.2.2].

Also, the disabled code has suffered from bit rot:
- it checks hlt_counter which is obsolete, as that variable
  and all related code now is private to kernel/process.c
- it passes too many parameters to cpu_do_idle()

So this patch:
- adds a comment before the #if 0 to explain why
  cpu_do_idle() mustn't be called on ixp4xx
- removes the obsolete test of hlt_counter and the
  obsolete parameter to cpu_do_idle()

This is purely a documentation fixup and changes no
generated code. Even so, it has been tested on an
ixp420 machine (ds101).

Signed-off-by: Mikael Pettersson <mikpe@it.uu.se>
---
 arch/arm/mach-ixp4xx/include/mach/system.h |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff -rupN linux-2.6.31/arch/arm/mach-ixp4xx/include/mach/system.h linux-2.6.31.arm-ixp4xx-arch_idle-cleanup/arch/arm/mach-ixp4xx/include/mach/system.h
--- linux-2.6.31/arch/arm/mach-ixp4xx/include/mach/system.h	2009-06-10 12:00:43.000000000 +0200
+++ linux-2.6.31.arm-ixp4xx-arch_idle-cleanup/arch/arm/mach-ixp4xx/include/mach/system.h	2009-09-10 23:38:04.000000000 +0200
@@ -13,9 +13,11 @@
 
 static inline void arch_idle(void)
 {
+	/* ixp4xx does not implement the XScale PWRMODE register,
+	 * so it must not call cpu_do_idle() here.
+	 */
 #if 0
-	if (!hlt_counter)
-		cpu_do_idle(0);
+	cpu_do_idle();
 #endif
 }
 
