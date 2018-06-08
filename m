From: palmer@sifive.com (Palmer Dabbelt)
Date: Fri, 08 Jun 2018 15:33:51 -0700 (PDT)
Subject: [PATCH 04/24] 32-bit userspace ABI: introduce ARCH_32BIT_OFF_T
 config option
In-Reply-To: <20180608173207.nwoi25jee52gpdwy@armageddon.cambridge.arm.com>
Message-ID: <mhng-e1922456-a05b-46f9-8644-d45ad70a55e5@palmer-si-x1c4>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 08 Jun 2018 10:32:07 PDT (-0700), catalin.marinas at arm.com wrote:
> On Wed, May 16, 2018 at 11:18:49AM +0300, Yury Norov wrote:
>> diff --git a/arch/Kconfig b/arch/Kconfig
>> index 76c0b54443b1..ee079244dc3c 100644
>> --- a/arch/Kconfig
>> +++ b/arch/Kconfig
>> @@ -264,6 +264,21 @@ config ARCH_THREAD_STACK_ALLOCATOR
>>  config ARCH_WANTS_DYNAMIC_TASK_STRUCT
>>  	bool
>>
>> +config ARCH_32BIT_OFF_T
>> +	bool
>> +	depends on !64BIT
>> +	help
>> +	  All new 32-bit architectures should have 64-bit off_t type on
>> +	  userspace side which corresponds to the loff_t kernel type. This
>> +	  is the requirement for modern ABIs. Some existing architectures
>> +	  already have 32-bit off_t. This option is enabled for all such
>> +	  architectures explicitly. Namely: arc, arm, blackfin, cris, frv,
>> +	  h8300, hexagon, m32r, m68k, metag, microblaze, mips32, mn10300,
>> +	  nios2, openrisc, parisc32, powerpc32, score, sh, sparc, tile32,
>> +	  unicore32, x86_32 and xtensa. This is the complete list. Any
>> +	  new 32-bit architecture should declare 64-bit off_t type on user
>> +	  side and so should not enable this option.
>
> Do you know if this is the case for riscv and nds32, merged in the
> meantime? If not, I suggest you drop this patch altogether and just
> define force_o_largefile() for arm64/ilp32 as we don't seem to stick to
> "all new 32-bit architectures should have 64-bit off_t".

We (RISC-V) don't have support for rv32i in glibc yet, so there really isn't a 
fixed ABI there yet.  From my understanding the rv32i port as it currently 
stands has a 32-bit off_t (via __kernel_off_t being defined as long), so this 
change would technically be a kernel ABI break.

Since we don't have rv32i glibc yet I'm not fundamentally opposed to an ABI 
break.  Is there a concrete advantage to this?
