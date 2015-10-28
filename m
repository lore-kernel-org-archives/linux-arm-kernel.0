From: dinguyen@opensource.altera.com (Dinh Nguyen)
Date: Wed, 28 Oct 2015 14:59:39 -0500
Subject: [PATCHv7 1/2] ARM: socfpga: enable L2 cache ECC on startup
In-Reply-To: <20151028105830.GM1166@pengutronix.de>
References: <1445979581-8080-1-git-send-email-dinguyen@opensource.altera.com>
 <20151028105830.GM1166@pengutronix.de>
Message-ID: <5631292B.7090603@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/28/2015 05:58 AM, Steffen Trumtrar wrote:
> Hi!
> 
> On Tue, Oct 27, 2015 at 03:59:40PM -0500, dinguyen at opensource.altera.com wrote:
>> From: Dinh Nguyen <dinguyen@opensource.altera.com>
>>
>> This patch enables the ECC for L2 cache on machine startup. The ECC has to
>> be enabled before data is stored in memory otherwise the ECC will fail on
>> reads.
>>
>> Signed-off-by: Thor Thayer <tthayer@opensource.altera.com>
>> Signed-off-by: Dinh Nguyen <dinguyen@opensource.altera.com>
>> ---
>> v7: unmap locally scoped mapped_l2_edac_addr and add of_node_put(np)
>> v6: Remove pr_debug() & update year in header.
>> ---
>>  arch/arm/mach-socfpga/Makefile   |  1 +
>>  arch/arm/mach-socfpga/core.h     |  1 +
>>  arch/arm/mach-socfpga/l2_cache.c | 42 ++++++++++++++++++++++++++++++++++++++++
>>  arch/arm/mach-socfpga/socfpga.c  |  2 ++
>>  4 files changed, 46 insertions(+)
>>  create mode 100644 arch/arm/mach-socfpga/l2_cache.c
>>
>> diff --git a/arch/arm/mach-socfpga/Makefile b/arch/arm/mach-socfpga/Makefile
>> index b8f9e23..e9ab7c9 100644
>> --- a/arch/arm/mach-socfpga/Makefile
>> +++ b/arch/arm/mach-socfpga/Makefile
>> @@ -5,3 +5,4 @@
>>  obj-y					:= socfpga.o
>>  obj-$(CONFIG_SMP)	+= headsmp.o platsmp.o
>>  obj-$(CONFIG_SOCFPGA_SUSPEND)	+= pm.o self-refresh.o
>> +obj-$(CONFIG_EDAC_ALTERA_L2C)	+= l2_cache.o
>> diff --git a/arch/arm/mach-socfpga/core.h b/arch/arm/mach-socfpga/core.h
>> index 5bc6ea8..eb55d66 100644
>> --- a/arch/arm/mach-socfpga/core.h
>> +++ b/arch/arm/mach-socfpga/core.h
>> @@ -36,6 +36,7 @@
>>  
>>  extern void socfpga_init_clocks(void);
>>  extern void socfpga_sysmgr_init(void);
>> +void socfpga_init_l2_ecc(void);
>>  
>>  extern void __iomem *sys_manager_base_addr;
>>  extern void __iomem *rst_manager_base_addr;
>> diff --git a/arch/arm/mach-socfpga/l2_cache.c b/arch/arm/mach-socfpga/l2_cache.c
>> new file mode 100644
>> index 0000000..7712e162
>> --- /dev/null
>> +++ b/arch/arm/mach-socfpga/l2_cache.c
>> @@ -0,0 +1,42 @@
>> +/*
>> + * Copyright Altera Corporation (C) 2015. All rights reserved.
>> + *
>> + * This program is free software; you can redistribute it and/or modify it
>> + * under the terms and conditions of the GNU General Public License,
>> + * version 2, as published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope it will be useful, but WITHOUT
>> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
>> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
>> + * more details.
>> + *
>> + * You should have received a copy of the GNU General Public License along with
>> + * this program.  If not, see <http://www.gnu.org/licenses/>.
>> + */
>> +#include <linux/io.h>
>> +#include <linux/of_platform.h>
>> +#include <linux/of_address.h>
>> +
>> +void socfpga_init_l2_ecc(void)
>> +{
>> +	struct device_node *np;
>> +	void __iomem *mapped_l2_edac_addr;
>> +
>> +	np = of_find_compatible_node(NULL, NULL, "altr,l2-edac");
>> +	if (!np) {
>> +		pr_err("SOCFPGA: Unable to find altr,l2-edac in dtb\n");
> 
> The "SOCFPGA" part of the log message is pretty obvious, isn't it?
> Can't we get rid of it?
>

Sure, I can remove it.

>> +		return;
>> +	}
>> +
>> +	mapped_l2_edac_addr = of_iomap(np, 0);
>> +	if (!mapped_l2_edac_addr) {
>> +		pr_err("SOCFPGA: Unable to find L2 ECC mapping in dtb\n");
> 
> How about using of_node_full_name here as long as we don't have a device
> as reference?
> 

Hmm...I'm not sure if adding "/soc/soc_ecc/l2edac at ffd08140" would help
the error statement.

Dinh
