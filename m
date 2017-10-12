From: f.fainelli@gmail.com (Florian Fainelli)
Date: Thu, 12 Oct 2017 09:53:36 -0700
Subject: [PATCH 1/9] SOC: brcmstb: add memory API
In-Reply-To: <b6be2073-7a90-f83f-4e25-79ef04827bd7@arm.com>
References: <1507761269-7017-1-git-send-email-jim2101024@gmail.com>
 <1507761269-7017-2-git-send-email-jim2101024@gmail.com>
 <b6be2073-7a90-f83f-4e25-79ef04827bd7@arm.com>
Message-ID: <425b3363-1977-87e1-644e-68a28f648fb0@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/12/2017 07:41 AM, Julien Thierry wrote:
> Hi Jim,
> 
> On 11/10/17 23:34, Jim Quinlan wrote:
>> From: Florian Fainelli <f.fainelli@gmail.com>
>>
>> This commit adds a memory API suitable for ascertaining the sizes of
>> each of the N memory controllers in a Broadcom STB chip.  Its first
>> user will be the Broadcom STB PCIe root complex driver, which needs
>> to know these sizes to properly set up DMA mappings for inbound
>> regions.
>>
>> We cannot use memblock here or anything like what Linux provides
>> because it collapses adjacent regions within a larger block, and here
>> we actually need per-memory controller addresses and sizes, which is
>> why we resort to manual DT parsing.
>>
>> Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
>> ---
>>   drivers/soc/bcm/brcmstb/Makefile |   2 +-
>>   drivers/soc/bcm/brcmstb/memory.c | 183
>> +++++++++++++++++++++++++++++++++++++++
>>   include/soc/brcmstb/memory_api.h |  25 ++++++
>>   3 files changed, 209 insertions(+), 1 deletion(-)
>>   create mode 100644 drivers/soc/bcm/brcmstb/memory.c
>>   create mode 100644 include/soc/brcmstb/memory_api.h
>>
>> diff --git a/drivers/soc/bcm/brcmstb/Makefile
>> b/drivers/soc/bcm/brcmstb/Makefile
>> index 9120b27..4cea7b6 100644
>> --- a/drivers/soc/bcm/brcmstb/Makefile
>> +++ b/drivers/soc/bcm/brcmstb/Makefile
>> @@ -1 +1 @@
>> -obj-y                += common.o biuctrl.o
>> +obj-y                += common.o biuctrl.o memory.o
>> diff --git a/drivers/soc/bcm/brcmstb/memory.c
>> b/drivers/soc/bcm/brcmstb/memory.c
>> new file mode 100644
>> index 0000000..cb6bf73
>> --- /dev/null
>> +++ b/drivers/soc/bcm/brcmstb/memory.c
>> @@ -0,0 +1,183 @@
>> +/*
>> + * Copyright ? 2015-2017 Broadcom
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
>> + * GNU General Public License for more details.
>> + *
>> + * A copy of the GPL is available at
>> + * http://www.broadcom.com/licenses/GPLv2.php or from the Free Software
>> + * Foundation at https://www.gnu.org/licenses/ .
>> + */
>> +
>> +#include <linux/device.h>
>> +#include <linux/io.h>
>> +#include <linux/libfdt.h>
>> +#include <linux/of_address.h>
>> +#include <linux/of_fdt.h>
>> +#include <linux/sizes.h>
>> +#include <soc/brcmstb/memory_api.h>
>> +
>> +/* -------------------- Constants -------------------- */
>> +
>> +/* Macros to help extract property data */
>> +#define U8TOU32(b, offs) \
>> +    ((((u32)b[0 + offs] << 0)  & 0x000000ff) | \
>> +     (((u32)b[1 + offs] << 8)  & 0x0000ff00) | \
>> +     (((u32)b[2 + offs] << 16) & 0x00ff0000) | \
>> +     (((u32)b[3 + offs] << 24) & 0xff000000))
>> +
>> +#define DT_PROP_DATA_TO_U32(b, offs) (fdt32_to_cpu(U8TOU32(b, offs)))
>> +
> 
> I fail to understand why this is not:
> 
> #define DT_PROP_DATA_TO_U32(b, offs) (fdt32_to_cpu(*(u32*)(b + offs)))
> 
> 
> If I understand correctly, fdt data is in big endian, the macro U8TOU32
> reads it as little endian. My guess is that this won't work on big
> endian kernels but should work on little endian since fdt32_to_cpu will
> revert the bytes again.
> 
> Am I missing something?

No, your point is valid, there is no reason why this cannot be
fdt32_to_cpu() here.
-- 
Florian
