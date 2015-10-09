From: ganguly.s@samsung.com (Sarbojit Ganguly)
Date: Fri, 09 Oct 2015 11:10:05 +0000 (GMT)
Subject: [PATCH v3] arm: Adding support for atomic half word exchange
Message-ID: <254593560.800231444389001687.JavaMail.weblogic@epmlwas03b>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Will,

Thank you so much for your patience. My sincere apologies with the issues with
formatting. I have taken care of them and hope now things are ok.

- Included patchesATarm.linux.org.uk.
- Removed the changelog from commit message.
- Moved the patch to "superseded" in patch system.
- Corrected the truncated Signed-off line.

KernelVersion: 4.3-rc4

Since support for half-word atomic exchange was not there and Qspinlock on ARM
requires it, modified __xchg() to add support for that as well. ARMv6 and lower
does not support ldrex{b,h} so, added a guard code to prevent build breaks.

Signed-off-by: Sarbojit Ganguly <ganguly.s@samsung.com>
---
 arch/arm/include/asm/cmpxchg.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/include/asm/cmpxchg.h b/arch/arm/include/asm/cmpxchg.h
index 916a274..97882f9 100644
--- a/arch/arm/include/asm/cmpxchg.h
+++ b/arch/arm/include/asm/cmpxchg.h
@@ -39,6 +39,7 @@ static inline unsigned long __xchg(unsigned long x, volatile void *ptr, int size
 
 	switch (size) {
 #if __LINUX_ARM_ARCH__ >= 6
+#ifndef CONFIG_CPU_V6 /* MIN ARCH >= V6K */
 	case 1:
 		asm volatile("@	__xchg1\n"
 		"1:	ldrexb	%0, [%3]\n"
@@ -49,6 +50,17 @@ static inline unsigned long __xchg(unsigned long x, volatile void *ptr, int size
 			: "r" (x), "r" (ptr)
 			: "memory", "cc");
 		break;
+	case 2:
+		asm volatile("@	__xchg2\n"
+		"1:	ldrexh	%0, [%3]\n"
+		"	strexh	%1, %2, [%3]\n"
+		"	teq	%1, #0\n"
+		"	bne	1b"
+			: "=&r" (ret), "=&r" (tmp)
+			: "r" (x), "r" (ptr)
+			: "memory", "cc");
+		break;
+#endif
 	case 4:
 		asm volatile("@	__xchg4\n"
 		"1:	ldrex	%0, [%3]\n"
-- 
1.9.1

Sarbojit

------- Original Message -------
Sender : Will Deacon<will.deacon@arm.com>
Date : Oct 08, 2015 22:26 (GMT+05:30)
Title : Re: Re: Re: Re: Re: [PATCH v3] arm: Adding support for atomic half word exchange

On Wed, Oct 07, 2015 at 02:36:41PM +0000, Sarbojit Ganguly wrote:
> Please have a look at this patch, please let me know if any modification
> is required.
> I have also submitted the same in your patch system.

There are some problems with the version in the patch system[1]:

  (1) You still have the changelog in the commit message (I asked you to
      remove this last time).

  (2) The commit message isn't line-wrapper appropriately

  (3) Your Signed-off-by line is truncated

The patch system does actually support git, so you can add:

  KernelVersion: 4.3-rc4

or whatever kernel you based your patch on somewhere after your SoB but
before the diff and then mail it to patchesATarm.linux.org.uk. You
probably also want to move the current patch to "superseded" so Russell
doesn't end up with two copies.

Will

[1] http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=8442/1
