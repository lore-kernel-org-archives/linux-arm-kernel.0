From: raghavendra.kt@linux.vnet.ibm.com (Raghavendra K T)
Date: Tue, 02 Jun 2015 11:41:56 +0530
Subject: [RFC] arm: Add for atomic half word exchange
In-Reply-To: <1357570181.391771433224164775.JavaMail.weblogic@epmlwas06d>
References: <1357570181.391771433224164775.JavaMail.weblogic@epmlwas06d>
Message-ID: <556D492C.1050403@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/02/2015 11:19 AM, Sarbojit Ganguly wrote:
> I made the CONFIG_ARCH_MULTI_V6=y and
> CONFIG_CPU_V6K=y
> CONFIG_CPU_32v6=y
> CONFIG_CPU_32v6K=y
>
> and compiled 4.0.4 with the patch. Result is a compilation success.
>
> Regards,
> Sarbojit
>

Hi Sarbojit,

I am not familiar about the implication of setting those options
unconditionally, But from Kconfig point of view
Arnd was expecting something like below IIUC
with the patch: (a quick example)

---8<---
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 9f1f09a..194fc13 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -812,6 +812,8 @@ config ARCH_MULTI_V6
         bool "ARMv6 based platforms (ARM11)"
         select ARCH_MULTI_V6_V7
         select CPU_V6K
+       select CPU_32v6
+       select CPU_32v6k

  config ARCH_MULTI_V7
         bool "ARMv7 based platforms (Cortex-A, PJ4, Scorpion, Krait)"



> ------- Original Message -------
> Sender : Arnd Bergmann<arnd@arndb.de>
> Date : May 19, 2015 18:51 (GMT+09:00)
> Title : Re: [RFC] arm: Add for atomic half word exchange
>
> On Tuesday 19 May 2015 09:39:33 Sarbojit Ganguly wrote:
>> Since 16 bit half word exchange was not there and MCS based qspinlock by Waiman's xchg_tail() requires an atomic exchange on a half word,
>> here is a small modification to __xchg() code.
>
> We have discussed a similar patch before, see
> https://lkml.org/lkml/2015/2/25/390
>
>>   #if __LINUX_ARM_ARCH__ >= 6
>> @@ -50,6 +52,23 @@
>>                          : "r" (x), "r" (ptr)
>>                          : "memory", "cc");
>>                  break;
>> +               /*
>> +                * halfword exclusive exchange
>> +                * This is new implementation as qspinlock
>> +                * wants 16 bit atomic CAS.
>> +                */
>> +       case 2:
>> +               asm volatile("@ __xchg2\n"
>> +               "1:     ldrexh  %0, [%3]\n"
>> +               "       strexh  %1, %2, [%3]\n"
>> +               "       teq     %1, #0\n"
>> +               "       bne     1b"
>> +                       : "=&r" (ret), "=&r" (tmp)
>> +                       : "r" (x), "r" (ptr)
>> +                       : "memory", "cc");
>> +               break;
>>          case 4:
>>                  asm volatile("@ __xchg4\n"
>>                  "1:     ldrex   %0, [%3]\n"
>
> Please try to find a way to make this compile when CONFIG_CPU_V6
> is set.
>
> Arnd
>
