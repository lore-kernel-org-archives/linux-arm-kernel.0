From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Tue, 06 Jan 2015 19:11:07 +0800
Subject: [PATCH v5 18/18] Documentation: ACPI for ARM64
In-Reply-To: <20150105110533.GA14967@e104818-lin.cambridge.arm.com>
References: <1413553034-20956-1-git-send-email-hanjun.guo@linaro.org>
 <1413553034-20956-19-git-send-email-hanjun.guo@linaro.org>
 <20141224171815.GD13399@e104818-lin.cambridge.arm.com>
 <54A90A4C.60908@linaro.org>
 <20150105110533.GA14967@e104818-lin.cambridge.arm.com>
Message-ID: <54ABC2CB.6@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015?01?05? 19:05, Catalin Marinas wrote:
> On Sun, Jan 04, 2015 at 09:39:24AM +0000, Hanjun Guo wrote:
>> On 2014?12?25? 01:18, Catalin Marinas wrote:
>> [...]
>>>
>>> In addition to the above and _DSD requirements/banning, I would also add
>>> some clear statements around:
>>>
>>> _OSC: only global/published capabilities are allowed. For
>>> device-specific _OSC we need a process or maybe we can ban them entirely
>>> and rely on _DSD once we clarify the process.
>>>
>>> _OSI: firmware must not check for certain _OSI strings. Here I'm not
>>> sure what we would have to do for ARM Linux. Reporting "Windows" does
>>> not make any sense but not reporting anything can, as Matthew Garrett
>>> pointed out, can be interpreted by firmware as "Linux". In addition to
>>> any statements in this document, I suggest you patch
>>> drivers/acpi/acpica/utosi.c accordingly, maybe report "Linux" for ARM
>>> and print a kernel warning so that we notice earlier.
>>>
>>> ACPI_OS_NAME: this is globally defined as "Microsoft Windows NT". It
>>> doesn't make much sense in the ARM context. Could we change it to
>>> "Linux" when CONFIG_ARM64?

I think we can introduce a Kconfig such as CONFIG_ACPI_OS_NAME_LINUX,
selected by ARM64 and change ACPI_OS_NAME to "Linux" when
CONFIG_ACPI_OS_NAME_LINUX defined. (we can not add CONFIG_ARM64 in
ACPICA code directly since it will be used by windows too)

some code like below:

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index b1f9a20..de567a3 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1,5 +1,6 @@
  config ARM64
         def_bool y
+       select ACPI_OS_NAME_LINUX if ACPI
         select ARCH_BINFMT_ELF_RANDOMIZE_PIE
         select ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE
         select ARCH_HAS_GCOV_PROFILE_ALL
diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 8951cef..11a10ac 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -369,6 +369,10 @@ config ACPI_REDUCED_HARDWARE_ONLY

           If you are unsure what to do, do not enable this option.

+config ACPI_OS_NAME_LINUX
+       bool "Using Linux for _OS method" if EXPERT
+       def_bool n
+
  source "drivers/acpi/apei/Kconfig"

  config ACPI_EXTLOG
diff --git a/include/acpi/acconfig.h b/include/acpi/acconfig.h
index 5a0a3e5..db5e13e 100644
--- a/include/acpi/acconfig.h
+++ b/include/acpi/acconfig.h
@@ -69,7 +69,11 @@
   * code that will not execute the _OSI method unless _OS matches the 
string
   * below.  Therefore, change this string at your own risk.
   */
+#ifndef ACPI_OS_NAME_USING_LINUX
  #define ACPI_OS_NAME                    "Microsoft Windows NT"
+#else
+#define ACPI_OS_NAME                    "Linux"
+#endif

  /* Maximum objects in the various object caches */

diff --git a/include/acpi/platform/aclinux.h 
b/include/acpi/platform/aclinux.h
index 1ba7c19..45d51d2 100644
--- a/include/acpi/platform/aclinux.h
+++ b/include/acpi/platform/aclinux.h
@@ -69,6 +69,10 @@
  #define ACPI_REDUCED_HARDWARE 1
  #endif

+#ifdef CONFIG_ACPI_OS_NAME_LINUX
+#define ACPI_OS_NAME_USING_LINUX 1
+#endif
+
  #include <linux/string.h>
  #include <linux/kernel.h>
  #include <linux/ctype.h>

>>
>> We will work on this both on ASWG and linux ACPI driver side, as Dong
>> and Charles pointed out, _OSI things can be solved in ACPI spec, when
>> that is done, we can modify the kernel driver to fix the problems above.
>
> Which driver?

the ACPICA core driver as you suggested, sorry for the confusion.

>
> What about ACPI_OS_NAME? Would you suggest it is fine to report
> "Microsoft Windows NT" on an ARM system? That _OS_ not _OSI.

No, not at all. I prefer "Linux"
In include/acpi/acconfig.h, when ACPI_OS_NAME defined, it says:
"OS name, used for the _OS object.  The _OS object is essentially
obsolete,..."
for some legacy reasons, we needed  "Microsoft Windows NT", but ACPI
for ARM64 on linux is totally new, I think we can change it to
"Linux" when CONFIG_ARM64 as you suggested.

Thanks
Hanjun
