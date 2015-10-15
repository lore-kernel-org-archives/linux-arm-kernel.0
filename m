From: Suzuki.Poulose@arm.com (Suzuki K. Poulose)
Date: Thu, 15 Oct 2015 13:58:57 +0100
Subject: [PATCHv3 08/11] arm64: Check for selected granule support
In-Reply-To: <20151015123727.GH8825@leverpostej>
References: <1444821634-1689-1-git-send-email-suzuki.poulose@arm.com>
 <1444821634-1689-9-git-send-email-suzuki.poulose@arm.com>
 <561EC58B.9080408@arm.com> <20151015104515.GE8825@leverpostej>
 <20151015112532.GA16125@e106634-lin.cambridge.arm.com>
 <20151015123727.GH8825@leverpostej>
Message-ID: <561FA311.3020802@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/10/15 13:37, Mark Rutland wrote:
> On Thu, Oct 15, 2015 at 12:25:33PM +0100, Suzuki K. Poulose wrote:
>> On Thu, Oct 15, 2015 at 11:45:15AM +0100, Mark Rutland wrote:
>>> On Wed, Oct 14, 2015 at 04:13:47PM -0500, Jeremy Linton wrote:
>>>> On 10/14/2015 06:20 AM, Suzuki K. Poulose wrote:


>>
>> ----8>----
>>
>> Author: Suzuki K. Poulose <suzuki.poulose@arm.com>
>> Date:   Wed Oct 14 11:25:16 2015 +0100
>>
>>      arm64: Check for selected granule support
>>
>>      Ensure that the selected page size is supported by the CPU(s). If it isn't
>>      park the CPU. A check is added to the EFI stub to detect if the boot CPU
>>      supports the page size, failing which, we fail the boot gracefully, with
>>      an error message.
>>
>>      Signed-off-by: Suzuki K. Poulose <suzuki.poulose@arm.com>
>>      [ Added a check to EFI stub ]
>>      Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
>
> Your sign-off should be last, given you are taking resposibility for
> Jeremy's patch.

OK, I was a bit confused about how it should look like. I kept it on top
so that I could add [ ] for Jeremy's contribution.

>
> However, I would prefer that the EFI stub addition were a separate/later
> patch.

OK, that makes sense.

>
>> diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
>> index a7f3d4b..72d814c 100644
>> --- a/arch/arm64/include/asm/sysreg.h
>> +++ b/arch/arm64/include/asm/sysreg.h

>> +#define ID_AA64MMFR0_TGRAN4_NI		0xf
>> +#define ID_AA64MMFR0_TGRAN4_ON		0x0
>> +#define ID_AA64MMFR0_TGRAN64_NI		0xf
>> +#define ID_AA64MMFR0_TGRAN64_ON		0x0
>> +#define ID_AA64MMFR0_TGRAN16_NI		0x0
>> +#define ID_AA64MMFR0_TGRAN16_ON		0x1
>
> I still don't like "ON" here -- I thought these would also be changed
> s/ON/SUPPORTED/.

I know and I expected that. I have "_ON" in my 'CPU feature' series, which
will/can be reused here. Hence kept it _ON. I can change it everywhere to
_SUPPORTED, since I may need to spin another version for that.


>>   #include <linux/efi.h>
>>   #include <asm/efi.h>
>> +#include <asm/sysreg.h>
>>   #include <asm/sections.h>
>
> Nit: include order.

OK

>
>>
>> +#if defined(CONFIG_ARM64_4K_PAGES)
>> +#define PAGE_SIZE_STR	"4K"
>> +#elif defined(CONFIG_ARM64_64K_PAGES)
>> +#define PAGE_SIZE_STR	"64K"
>> +#endif
>> +
>>   efi_status_t __init handle_kernel_image(efi_system_table_t *sys_table_arg,
>>   					unsigned long *image_addr,
>>   					unsigned long *image_size,
>> @@ -25,6 +32,17 @@ efi_status_t __init handle_kernel_image(efi_system_table_t *sys_table_arg,
>>   	unsigned long kernel_size, kernel_memsize = 0;
>>   	unsigned long nr_pages;
>>   	void *old_image_addr = (void *)*image_addr;
>> +	u64 aa64mmfr0_el1;
>> +
>> +	/*
>> +	 * Check to see if the CPU supports the requested pagesize
>> +	 */
>> +	asm volatile("mrs %0, ID_AA64MMFR0_EL1" : "=r" (aa64mmfr0_el1));
>
> Can we not use read_cpuid() or similar here?

Yes, I will try that out. I didn't want to include additional header-files
in efi-stub.c.


>> +	aa64mmfr0_el1 >>= ID_AA64MMFR0_TGRAN_SHIFT;
>
> ... and can we not do the shift and mask in one go?
>

>> +	if ((aa64mmfr0_el1 & 0xf) != ID_AA64MMFR0_TGRAN_SUPPORTED) {
>> +		pr_efi_err(sys_table_arg, PAGE_SIZE_STR" granule not supported by the CPU\n");
>
> Nit: space before the first quote, please.

Will do

Thanks
Suzuki
