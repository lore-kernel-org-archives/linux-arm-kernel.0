From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Thu, 11 Jun 2015 20:55:09 +0800
Subject: [PATCH 02/11] ACPI / irqchip: Add self-probe infrastructure to
 initialize IRQ controller
In-Reply-To: <557858AC.6010701@arm.com>
References: <1431953961-22706-1-git-send-email-hanjun.guo@linaro.org>
 <1431953961-22706-3-git-send-email-hanjun.guo@linaro.org>
 <557858AC.6010701@arm.com>
Message-ID: <5579852D.1010509@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

On 06/10/2015 11:33 PM, Marc Zyngier wrote:
> Hi Hanjun,
>
> On 18/05/15 13:59, Hanjun Guo wrote:
>> From: Tomasz Nowicki <tomasz.nowicki@linaro.org>
>>
>> This self-probe infrastructure works in the similar way as OF,
>> but there is some different in the mechanism:
>>
>> For OF, the init fn will be called once it finds comptiable strings
>> in DT,  but for ACPI, we init irqchips by static tables, and in
>> static ACPI tables, there are no comptiable strings to indicate
>> irqchips, so every init function with IRQCHIP_ACPI_DECLARE in the
>> same table will be called, but thanks to the GIC version presented
>> in ACPI table, we can init different GIC irqchips with this framework.
>
> This triggers an immediate question: If we can find out the GIC version
> in the ACPI tables, which can't we just call the irqchips that implement
> the support for this version?

This is really a good question and triggers me to rethink about
the implementation.

>
> i.e: the GICv2 irqchip code would have a line like:
>
> IRQCHIP_ACPI_DECLARE(gic_v2, ACPI_MADT_GIC_VER_V2, gic_v2_acpi_init);
>
> and the probing code would simply call the drivers that have declared
> their interest for this version code.

if we want to achieve this, we can redefine the strut for acpi_table_id:

#define ACPI_TABLE_ID_LEN	5

struct acpi_table_id {
	__u8 id[ACPI_TABLE_ID_LEN];
	const void *handler;
	kernel_ulong_t driver_data;
};

then pass the ACPI_MADT_GIC_VER_V2 as the driver_data, it will
work as you suggested.

>
> Having code that tests for the version in each driver is not an option
> (this is exactly what we're trying to avoid).

I also think it's awkward to do that in each driver, thanks for the
suggestion!

Thanks
Hanjun
