From: al.stone@linaro.org (Al Stone)
Date: Wed, 04 Dec 2013 12:47:54 -0700
Subject: [RFC part1 PATCH 5/7] ARM64 / ACPI: Introduce arm_core.c and
 its related head file
In-Reply-To: <529F5013.4050502@linaro.org>
References: <1386088611-2801-1-git-send-email-hanjun.guo@linaro.org>
 <1386088611-2801-6-git-send-email-hanjun.guo@linaro.org>
 <1AE640813FDE7649BE1B193DEA596E88024941A4@SHSMSX101.ccr.corp.intel.com>
 <529F5013.4050502@linaro.org>
Message-ID: <529F86EA.4010805@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/04/2013 08:53 AM, Hanjun Guo wrote:
> On 2013?12?04? 13:46, Zheng, Lv wrote:
>>> From: linux-acpi-owner at vger.kernel.org
>>> [mailto:linux-acpi-owner at vger.kernel.org] On Behalf Of Hanjun Guo
>>> Sent: Wednesday, December 04, 2013 12:37 AM
>>>
>>> introduce arm_core.c and its related head file, after this patch,
>>> we can get ACPI tables from BIOS on ARM64 now.
>>>
>>> Signed-off-by: Al Stone <al.stone@linaro.org>
>>> Signed-off-by: Graeme Gregory <graeme.gregory@linaro.org>
>>> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
>>> ---
>>>   arch/arm64/include/asm/acpi.h |   57 +++++++++++
>>>   arch/arm64/kernel/setup.c     |    8 ++
>>>   drivers/acpi/Makefile         |    2 +
>>>   drivers/acpi/plat/Makefile    |    1 +
>>>   drivers/acpi/plat/arm-core.c  |  219
>>> +++++++++++++++++++++++++++++++++++++++++
>>>   5 files changed, 287 insertions(+)
>>>   create mode 100644 drivers/acpi/plat/Makefile
>>>   create mode 100644 drivers/acpi/plat/arm-core.c
>>>

[...]

>>
>> I'm not sure if all global lock code blocks are not referenced by
>> ACPI_REDUCED_HARDWARE and I'm not sure what mechanism is implemented
>> on ARM ACPI platforms to offer the synchronization mechanism between
>> firmware and OSPM.  So you may need to implement the following
>> synchronization protocol in <asm/acpi.h>:
>> 58 #define ACPI_ACQUIRE_GLOBAL_LOCK(facs, Acq)
>> 61 #define ACPI_RELEASE_GLOBAL_LOCK(facs, Acq)
>
> In reduced hardware mode, No hardware resource sharing between
> OSPM and other asynchronous operating environments, such as
> UEFI Runtime Services or System Management Mode. (The Global Lock
> is not supported)
>
> please refer to chapter 3.11.1 of ACPI 5.0.

I agree with Hanjun; the spec clearly states that the ACPI global lock
is not supported in reduced HW mode.  The only similar lock I recall
from the spec is for ECs (Embedded Controllers, section 12) but is very
specific to controlling the interaction with the EC.

If the intent is to use SMI, again, in reduced HW mode, 3.11.1 does
not allow SMI_CMD, and 5.2.9 indicates SMI_CMD is to be ignored.


-- 
ciao,
al
-----------------------------------
Al Stone
Software Engineer
Linaro Enterprise Group
al.stone at linaro.org
-----------------------------------
