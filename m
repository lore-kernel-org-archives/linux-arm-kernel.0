From: vw@iommu.org (Wan Zongshun)
Date: Tue, 5 Jul 2016 15:38:23 +0800
Subject: [PATCH 1/6] ARM: NUC900: Add nuc970 machine support
In-Reply-To: <4806020.41AJ9s5VGu@wuerfel>
References: <1466851042-22239-1-git-send-email-vw@iommu.org>
 <1466851042-22239-2-git-send-email-vw@iommu.org> <4806020.41AJ9s5VGu@wuerfel>
Message-ID: <577B63EF.6030906@iommu.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2016?06?29? 23:19, Arnd Bergmann wrote:
> On Saturday, June 25, 2016 6:37:17 PM CEST Wan Zongshun wrote:
>> NUC970 is a new SoC of Nuvoton nuc900 series, this patch is
>> to add machine file support for it.
>>
>> Signed-off-by: Wan Zongshun <mcuos.com@gmail.com>
>
> Nice to see some activity on the port!
>
>> ---
>>   arch/arm/mach-w90x900/Kconfig                      |  25 ++++
>>   arch/arm/mach-w90x900/Makefile                     |   3 +
>>   .../mach-w90x900/include/mach/nuc970-regs-gcr.h    |  56 ++++++++
>>   arch/arm/mach-w90x900/mach-nuc970.c                | 144 +++++++++++++++++++++
>>   4 files changed, 228 insertions(+)
>>   create mode 100644 arch/arm/mach-w90x900/include/mach/nuc970-regs-gcr.h
>>   create mode 100644 arch/arm/mach-w90x900/mach-nuc970.c
>>
>> diff --git a/arch/arm/mach-w90x900/Kconfig b/arch/arm/mach-w90x900/Kconfig
>> index 69bab32..050833e 100644
>> --- a/arch/arm/mach-w90x900/Kconfig
>> +++ b/arch/arm/mach-w90x900/Kconfig
>> @@ -15,6 +15,21 @@ config CPU_NUC960
>>   	help
>>   	  Support for NUCP960 of Nuvoton NUC900 CPUs.
>>
>> +config SOC_NUC970
>> +	bool
>> +        select GENERIC_IRQ_CHIP
>> +        select SOC_BUS
>> +        select IRQ_DOMAIN
>> +        select MULTI_IRQ_HANDLER
>> +        select USE_OF
>> +        select HAVE_CLK_PREPARE
>> +        select HAVE_MACH_CLKDEV
>> +	select COMMON_CLK
>> +        select NUC900_TIMER
>> +	help
>> +	  Support for NUCP970 of Nuvoton NUC900 CPUs.
>> +
>
> [style] This looks whitespace damaged, and please sort the line alphabetically.

Sure, changed.

>
> I see you have done this in a way that is basically compatible with
> CONFIG_ARCH_MULTIPLATFORM, good.
>
> What is HAVE_MACH_CLKDEV for?
>
>> @@ -46,4 +61,14 @@ config MACH_W90N960EVB
>>
>>   endmenu
>>
>> +menu "NUC970 Machines"
>> +
>> +config MACH_NUC970EVB
>> +	bool "Nuvoton NUC970 Evaluation Board"
>> +	select SOC_NUC970
>> +	help
>> +	   Say Y here if you are using the Nuvoton NUC970EVB
>> +
>> +endmenu
>
> I'd leave out this entry, with the way have have structured the code (correctly),
> there is no need to separate SoC-specific code from board specific code, since
> they are the same.
>

Sure, removed it.

>> diff --git a/arch/arm/mach-w90x900/include/mach/nuc970-regs-gcr.h b/arch/arm/mach-w90x900/include/mach/nuc970-regs-gcr.h
>> new file mode 100644
>> index 0000000..e7eb653
>> --- /dev/null
>> +++ b/arch/arm/mach-w90x900/include/mach/nuc970-regs-gcr.h
>
> Can you move the new headers to arch/arm/mach-w90x900/ directly?
>
>> +static int __init nuc900_restart_init(void)
>> +{
>> +	struct device_node *np;
>> +
>> +	np = of_find_compatible_node(NULL, NULL, "nuvoton,gcr");
>> +	wtcr_addr = of_iomap(np, 0);
>> +	if (!wtcr_addr)
>> +		return -ENODEV;
>> +
>> +	of_node_put(np);
>> +
>> +	return 0;
>> +}
>
> Is this a watchdog node? If it is, the restart logic should just
> move into the watchdog driver.

It is not watchdog node, just be global System control register node.

>
>
>> +	if (of_machine_is_compatible("nuvoton,nuc970evb"))
>> +		nuc970_init();
>
> What is this for?

Currently, no used, remove it.

>
>> +	of_platform_populate(NULL, of_default_bus_match_table, NULL, parent);
>
> We have actually moved away from using the soc_device as using the parent
> for the other devices, just probe them separately. In fact the soc_device
> could be handled by a driver in drivers/soc/nuvoton/

Do you think I should add nuc900 soc driver in this folder?
If I want to add nuc900 soc driver in drivers/soc/nuvoton/, can I keep 
my current dts structure no change, or Must I add a new node name soc {}?

I went through the code:soc-realview.c for reference, but I have no idea
about how to re-structure my dts file to match this type soc driver.

>
>> +static const char *nuc970_dt_compat[] __initconst = {
>> +	"nuvoton,nuc970evb",
>> +	NULL,
>> +};
>> +
>> +void nuc970_restart(enum reboot_mode mode, const char *cmd)
>> +{
>> +	if (wtcr_addr) {
>> +		while (__raw_readl(wtcr_addr + REG_WRPRTR) != 1) {
>> +			__raw_writel(0x59, wtcr_addr + REG_WRPRTR);
>> +			__raw_writel(0x16, wtcr_addr + REG_WRPRTR);
>> +			__raw_writel(0x88, wtcr_addr + REG_WRPRTR);
>> +		}
>> +
>> +		__raw_writel(1, wtcr_addr + REG_AHBIPRST);
>> +	}
>
> Please use writel() instead of __raw_writel().

Does this change apply to all others drivers? or just machine file to 
use writel()?

>
>> +	soft_restart(0);
>> +}
>> +
>> +DT_MACHINE_START(nuc970_dt, "Nuvoton nuc970 evb")
>> +	.atag_offset	= 0x100,

Removed it, thanks!

>
> The .atag_offset can be removed here.
>
> 	Arnd
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
>
