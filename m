From: dinguyen@opensource.altera.com (Dinh Nguyen)
Date: Wed, 28 Oct 2015 15:15:19 -0500
Subject: [PATCHv7 2/2] ARM: socfpga: Enable OCRAM ECC on startup
In-Reply-To: <20151028105957.GN1166@pengutronix.de>
References: <1445979581-8080-1-git-send-email-dinguyen@opensource.altera.com>
 <1445979581-8080-2-git-send-email-dinguyen@opensource.altera.com>
 <20151028105957.GN1166@pengutronix.de>
Message-ID: <56312CD7.5050104@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/28/2015 05:59 AM, Steffen Trumtrar wrote:
> On Tue, Oct 27, 2015 at 03:59:41PM -0500, dinguyen at opensource.altera.com wrote:
>> From: Dinh Nguyen <dinguyen@opensource.altera.com>
>>
>> This patch enables the ECC for On-Chip RAM on machine startup. The ECC
>> has to be enabled before data is stored in memory otherwise the ECC will
>> fail on reads.
>>
>> Signed-off-by: Thor Thayer <tthayer@opensource.altera.com>
>> Signed-off-by: Dinh Nguyen <dinguyen@opensource.altera.com>
>> ---
>> v7: enable OCRAM ECC during platform init
>> v6: Implement OCRAM discovery changes from community. Add
>>     of_node_put(). Remove be32_to_cpup(). Use __init() which
>>     allows removal of .init_machine(). Update year in header.
>> ---
>>  arch/arm/mach-socfpga/Makefile  |  1 +
>>  arch/arm/mach-socfpga/core.h    |  1 +
>>  arch/arm/mach-socfpga/ocram.c   | 50 +++++++++++++++++++++++++++++++++++++++++
>>  arch/arm/mach-socfpga/socfpga.c |  3 +++
>>  4 files changed, 55 insertions(+)
>>  create mode 100644 arch/arm/mach-socfpga/ocram.c
>>
>> diff --git a/arch/arm/mach-socfpga/Makefile b/arch/arm/mach-socfpga/Makefile
>> index e9ab7c9..ed15db1 100644
>> --- a/arch/arm/mach-socfpga/Makefile
>> +++ b/arch/arm/mach-socfpga/Makefile
>> @@ -6,3 +6,4 @@ obj-y					:= socfpga.o
>>  obj-$(CONFIG_SMP)	+= headsmp.o platsmp.o
>>  obj-$(CONFIG_SOCFPGA_SUSPEND)	+= pm.o self-refresh.o
>>  obj-$(CONFIG_EDAC_ALTERA_L2C)	+= l2_cache.o
>> +obj-$(CONFIG_EDAC_ALTERA_OCRAM)	+= ocram.o
>> diff --git a/arch/arm/mach-socfpga/core.h b/arch/arm/mach-socfpga/core.h
>> index eb55d66..575195b 100644
>> --- a/arch/arm/mach-socfpga/core.h
>> +++ b/arch/arm/mach-socfpga/core.h
>> @@ -37,6 +37,7 @@
>>  extern void socfpga_init_clocks(void);
>>  extern void socfpga_sysmgr_init(void);
>>  void socfpga_init_l2_ecc(void);
>> +void socfpga_init_ocram_ecc(void);
>>  
>>  extern void __iomem *sys_manager_base_addr;
>>  extern void __iomem *rst_manager_base_addr;
>> diff --git a/arch/arm/mach-socfpga/ocram.c b/arch/arm/mach-socfpga/ocram.c
>> new file mode 100644
>> index 0000000..336e165
>> --- /dev/null
>> +++ b/arch/arm/mach-socfpga/ocram.c
>> @@ -0,0 +1,50 @@
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
>> +#include <linux/genalloc.h>
>> +#include <linux/module.h>
>> +#include <linux/of_address.h>
>> +#include <linux/of_platform.h>
>> +
>> +#define ALTR_OCRAM_CLEAR_ECC          0x00000018
>> +#define ALTR_OCRAM_ECC_EN             0x00000019
>> +
>> +void socfpga_init_ocram_ecc(void)
>> +{
>> +	struct device_node *np;
>> +	void __iomem *mapped_ocr_edac_addr;
>> +
>> +	/* Find the OCRAM EDAC device tree node */
>> +	np = of_find_compatible_node(NULL, NULL, "altr,ocram-edac");
>> +	if (!np) {
>> +		pr_err("%s: Unable to find altr,ocram-edac\n", __func__);
> 
> Do we need the __func__ info here?
> 

Will remove..
>> +		return;
>> +	}
>> +
>> +	mapped_ocr_edac_addr = of_iomap(np, 0);
>> +	if (!mapped_ocr_edac_addr) {
>> +		of_node_put(np);

I need to remove this of_node_put() here.

>> +		pr_err("%s: Unable to map OCRAM ecc regs.\n", __func__);
> 
> of_node_full_name?
> 

Similar to my comment to the 1/2 patch, not sure if adding
of_node_full_name(np) will help with this error statement.

Dinh
