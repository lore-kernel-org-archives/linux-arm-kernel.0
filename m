From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Fri, 30 Aug 2013 19:55:26 +0100
Subject: [PATCH 14/19] ARM: set --be8 when linking modules
In-Reply-To: <20130828163852.GB3842@localhost.localdomain>
References: <1377639509-22778-1-git-send-email-ben.dooks@codethink.co.uk>
 <1377639509-22778-15-git-send-email-ben.dooks@codethink.co.uk>
 <20130828163852.GB3842@localhost.localdomain>
Message-ID: <5220EA9E.7080000@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28/08/13 17:38, Dave Martin wrote:
> On Tue, Aug 27, 2013 at 10:38:24PM +0100, Ben Dooks wrote:
>> To avoid having to make every text section swap the instruction order
>> of all instructions, make sure modules are built also built with --be8
>> (as is the current kernel final link).
>>
>> If we do not do this, we would end up having to swap all instructions
>> when loading a module, instead of just the instructions that we are
>> applying ELF relocations to.
>
> Someone on one of the previous threads asked about whether we need
> module vermagic for BE8.

Don't think so, although we could do this if needed. I would like to
get this series merged and then think about updates.

> I'm a bit hazy on whether this is needed.  The interesting scenario
> would be if someone tried to load a BE32 module into a BE8 kernel
> or vice versa.
>
> Currently the kernel does not seem to check ELF endianness at all
> either for modules or userspace binaries -- they load get loaded/
> fixed up/executed just is if they were native endianness.

I've not tried BE32 binaries on BE8 kernels, although it would
probably produce an undefined instruction quite quickly.

> So BE8 doesn't add any new brokenness here.  Fixing all that stuff
> falls outside the scope of this series.

think so.

> Any thoughts?
>
>
> For this patch though:
>
> Reviewed-by: Dave Martin<Dave.Martin@arm.com>
>
> Cheers
> ---Dave
>
>> Signed-off-by: Ben Dooks<ben.dooks@codethink.co.uk>
>> ---
>>   arch/arm/Makefile |    1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm/Makefile b/arch/arm/Makefile
>> index 6fd2cea..2c659f9 100644
>> --- a/arch/arm/Makefile
>> +++ b/arch/arm/Makefile
>> @@ -16,6 +16,7 @@ LDFLAGS		:=
>>   LDFLAGS_vmlinux	:=-p --no-undefined -X
>>   ifeq ($(CONFIG_CPU_ENDIAN_BE8),y)
>>   LDFLAGS_vmlinux	+= --be8
>> +LDFLAGS_MODULE	+= --be8
>>   endif
>>
>>   OBJCOPYFLAGS	:=-O binary -R .comment -S
>> --
>> 1.7.10.4
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel


-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
