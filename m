From: ganguly.s@samsung.com (Sarbojit Ganguly)
Date: Fri, 04 Sep 2015 03:06:29 +0000 (GMT)
Subject: [PATCH v2] arm: Adding support for atomic half word exchange
Message-ID: <320411514.5779181441335987727.JavaMail.weblogic@ep2mlwas01a>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This is the second version of the patch previously posted.

v1-->v2 : Extended the guard code to cover the byte exchange case as well
following opinion of Will Deacon. Checkpatch has been run and issues
were taken care of.

From: Sarbojit Ganguly <ganguly.s@samsung.com>
Date: Thu, 3 Sep 2015 13:00:27 +0530
Subject: [PATCHv2] ARM: Add support for half-word atomic exchange

Since support for half-word atomic exchange was not there and Qspinlock
on ARM requires it, modified __xchg() to add support for that as well.
ARMv6 and lower does not support ldrex{b,h} so, added a guard code
to prevent build breaks.

Signed-off-by: Sarbojit Ganguly <ganguly.s@samsung.com>
---
 arch/arm/include/asm/cmpxchg.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm/include/asm/cmpxchg.h b/arch/arm/include/asm/cmpxchg.h
index 916a274..a53cbeb 100644
--- a/arch/arm/include/asm/cmpxchg.h
+++ b/arch/arm/include/asm/cmpxchg.h
@@ -39,6 +39,7 @@ static inline unsigned long __xchg(unsigned long x, volatile void *ptr, int size
 
  switch (size) {
 #if __LINUX_ARM_ARCH__ >= 6
+#if !defined(CONFIG_CPU_V6)
  case 1:
   asm volatile("@ __xchg1\n"
   "1: ldrexb %0, [%3]\n"
@@ -49,6 +50,22 @@ static inline unsigned long __xchg(unsigned long x, volatile void *ptr, int size
    : "r" (x), "r" (ptr)
    : "memory", "cc");
   break;
+
+  /*
+   * Half-word atomic exchange, required
+   * for Qspinlock support on ARM.
+   */
+ case 2:
+  asm volatile("@ __xchg2\n"
+  "1: ldrexh %0, [%3]\n"
+  " strexh %1, %2, [%3]\n"
+  " teq %1, #0\n"
+  " bne 1b"
+   : "=&r" (ret), "=&r" (tmp)
+   : "r" (x), "r" (ptr)
+   : "memory", "cc");
+  break;
+#endif
  case 4:
   asm volatile("@ __xchg4\n"
   "1: ldrex %0, [%3]\n"
-- 

Regards,
Sarbojit

------- Original Message -------
Sender : Sarbojit Ganguly<ganguly.s@samsung.com> Technical Lead/SRI-Bangalore-AP Systems 1/Samsung Electronics
Date : Aug 20, 2015 19:55 (GMT+05:30)
Title : Re: Re: Re: [PATCH] arm: Adding support for atomic half word exchange

>> My apologies, the e-mail editor was not configured properly.
>> CC'ed to relevant maintainers and reposting once again with proper formatting.
>> 
>> Since 16 bit half word exchange was not there and MCS based qspinlock 
>> by Waiman's xchg_tail() requires an atomic exchange on a half word, 
>> here is a small modification to __xchg() code to support the exchange.
>> ARMv6 and lower does not have support for LDREXH, so we need to make 
>> sure things do not break when we're compiling on ARMv6.
>> 
>> Signed-off-by: Sarbojit Ganguly >
>> ---
>>  arch/arm/include/asm/cmpxchg.h | 18 ++++++++++++++++++
>>  1 file changed, 18 insertions(+)
>> 
>> diff --git a/arch/arm/include/asm/cmpxchg.h 
>> b/arch/arm/include/asm/cmpxchg.h index 1692a05..547101d 100644
>> --- a/arch/arm/include/asm/cmpxchg.h
>> +++ b/arch/arm/include/asm/cmpxchg.h
>> @@ -50,6 +50,24 @@ static inline unsigned long __xchg(unsigned long x, volatile void *ptr, int size
>>                         : "r" (x), "r" (ptr)
>>                         : "memory", "cc");
>>                 break;
>> +#if !defined (CONFIG_CPU_V6)
>> +               /*
>> +                * Halfword exclusive exchange
>> +                * This is new implementation as qspinlock
>> +                * wants 16 bit atomic CAS.
>> +                * This is not supported on ARMv6.
>> +                */

>I don't think you need this comment. We don't use qspinlock on arch/arm/.

Yes, till date mainline ARM does not support but I've ported Qspinlock on ARM hence I think that comment
might be required.

>> +       case 2:
>> +               asm volatile("@ __xchg2 "
>> +               "1:     ldrexh  %0, [%3] "
>> +               "       strexh  %1, %2, [%3] "
>> +               "       teq     %1, #0 "
>> +               "       bne     1b"
>> +               : "=&r" (ret), "=&r" (tmp)
>> +               : "r" (x), "r" (ptr)
>> +               : "memory", "cc");
>> +               break;
>> +#endif
>>         case 4:
>>                 asm volatile("@ __xchg4 "
>>                 "1:     ldrex   %0, [%3] "

>We have the same issue with the byte exclusives, so I think you need to extend the guard you're adding to cover that case too (which is a bug in current mainline).

Ok, I will work on this and release a v2 soon. 

>Will

- Sarbojit


?????
???   ??   ?? ??
----------------------------------------------------------------------+
The Tao lies beyond Yin and Yang. It is silent and still as a pool of water.      |
It does not seek fame, therefore nobody knows its presence.                       |
It does not seek fortune, for it is complete within itself.                       |
It exists beyond space and time.                                                  |
----------------------------------------------------------------------+
