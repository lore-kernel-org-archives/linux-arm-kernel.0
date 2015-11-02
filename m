From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Mon, 02 Nov 2015 19:58:47 +0800
Subject: [PATCH V5 1/9] ACPI: Honor ACPI _CCA attribute setting
In-Reply-To: <20151102040224.GA16979@arm.org>
References: <20151102040224.GA16979@arm.org>
Message-ID: <56374FF7.6050008@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dennis,

On 11/02/2015 12:02 PM, Dennis Chen wrote:
> On Thu, Oct 29, 2015 at 6:50 AM, Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com> wrote:
>> From: Jeremy Linton <jeremy.linton@arm.com>
>>
>> ACPI configurations can now mark devices as noncoherent,
>> support that choice.
>>
>> NOTE: This is required to support USB on ARM Juno Development Board.
>>
>> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
>> Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
>> CC: Bjorn Helgaas <bhelgaas@google.com>
>> CC: Catalin Marinas <catalin.marinas@arm.com>
>> CC: Rob Herring <robh+dt@kernel.org>
>> CC: Will Deacon <will.deacon@arm.com>
>> CC: Rafael J. Wysocki <rjw@rjwysocki.net>
>> ---
>>   include/acpi/acpi_bus.h | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
>> index d11eff8..0f131d2 100644
>> --- a/include/acpi/acpi_bus.h
>> +++ b/include/acpi/acpi_bus.h
>> @@ -407,7 +407,7 @@ static inline bool acpi_check_dma(struct acpi_device *adev, bool *coherent)
>>   	 * case 1. Do not support and disable DMA.
>>   	 * case 2. Support but rely on arch-specific cache maintenance for
>>   	 *         non-coherence DMA operations.
>> -	 * Currently, we implement case 1 above.
>> +	 * Currently, we implement case 2 above.
>>   	 *
>>   	 * For the case when _CCA is missing (i.e. cca_seen=0) and
>>   	 * platform specifies ACPI_CCA_REQUIRED, we do not support DMA,
>> @@ -415,7 +415,8 @@ static inline bool acpi_check_dma(struct acpi_device *adev, bool *coherent)
>>   	 *
>>   	 * See acpi_init_coherency() for more info.
>>   	 */
>> -	if (adev->flags.coherent_dma) {
>> +	if (adev->flags.coherent_dma ||
>> +	    (adev->flags.cca_seen && IS_ENABLED(CONFIG_ARM64))) {
>>   		ret = true;
>>   		if (coherent)
>>   			*coherent = adev->flags.coherent_dma;
>
> Hi Suravee,
>
> The acpi_check_dma function has been removed in patch 6 of this patch set, why it is still be used
> here, am I missing something? If the acpi_check_dma will be used in the future, personally I'd like

I think this patch just to let people know that there is
case that arch-specific cache maintenance is still needed
for ACPI (such as Juno board), and in the later patches will
cover this case.

acpi_check_dma() will be replaced by acpi_get_dma_attr(),
and in acpi_get_dma_attr() will cover that case and will
be easily understood. (Suravee, correct me if I'm wrong :) )

> to use IS_ENABLED(CONFIG_ACPI_CCA_REQUIRED) while not CONFIG_ARM64 macro here, or since _CCA attribute
> is arch-specific, it's reasonable to leave the _CCA handling policy to the arch-specific code. For example,
> with a link weak function like acpi_arch_check_dma() as a default handling if no arch-specific code
> provided, the actual _CCA handling will be implemented in the ARM, Intel or other Arch if required.

Actually Intel platform don't need _CCA and it's coherent
in default, since _CCA is in ACPI spec, I would like it's
handled in ACPI core.

Thanks
Hanjun
