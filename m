From: james.morse@arm.com (James Morse)
Date: Wed, 16 May 2018 09:34:41 +0100
Subject: [PATCH v9 07/11] arm64: kexec_file: add crash dump support
In-Reply-To: <f8d8305d-42f5-e1e2-20c4-733cb38cbb8d@arm.com>
References: <20180425062629.29404-1-takahiro.akashi@linaro.org>
 <20180425062629.29404-8-takahiro.akashi@linaro.org>
 <f8d8305d-42f5-e1e2-20c4-733cb38cbb8d@arm.com>
Message-ID: <3d70c7d1-4985-a427-ecc6-a7edc84edfff@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Akashi,

On 15/05/18 18:11, James Morse wrote:
> On 25/04/18 07:26, AKASHI Takahiro wrote:
>> Enabling crash dump (kdump) includes
>> * prepare contents of ELF header of a core dump file, /proc/vmcore,
>>   using crash_prepare_elf64_headers(), and
>> * add two device tree properties, "linux,usable-memory-range" and
>>   "linux,elfcorehdr", which represent repsectively a memory range
>>   to be used by crash dump kernel and the header's location

>> diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
>> index 37c0a9dc2e47..ec674f4d267c 100644
>> --- a/arch/arm64/kernel/machine_kexec_file.c
>> +++ b/arch/arm64/kernel/machine_kexec_file.c
>> @@ -76,6 +81,78 @@ int arch_kexec_walk_mem(struct kexec_buf *kbuf,

>> +static void fill_property(void *buf, u64 val64, int cells)
>> +{
>> +	u32 val32;
>> +
>> +	if (cells == 1) {
>> +		val32 = cpu_to_fdt32((u32)val64);
>> +		memcpy(buf, &val32, sizeof(val32));
>> +	} else {
> 
>> +		memset(buf, 0, cells * sizeof(u32) - sizeof(u64));
>> +		buf += cells * sizeof(u32) - sizeof(u64);
> 
> Is this trying to clear the 'top' cells and shuffle the pointer to point at the
> 'bottom' 2? I'm pretty sure this isn't endian safe.

It came to me at 2am: this only works on big-endian, which is exactly what you
want as that is the DT format.


> Do we really expect a system to have #address-cells > 2?


Thanks,

James
