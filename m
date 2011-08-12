From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 12 Aug 2011 11:52:50 -0700
Subject: Relinking zImage when nothing changes
In-Reply-To: <20110812183410.GA28589@merkur.ravnborg.org>
References: <4E4566F0.4020001@codeaurora.org>
	<20110812180209.GA28520@merkur.ravnborg.org>
	<4E456CFB.3080206@codeaurora.org>
	<20110812183410.GA28589@merkur.ravnborg.org>
Message-ID: <4E457682.5020107@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/12/2011 11:34 AM, Sam Ravnborg wrote:
> On Fri, Aug 12, 2011 at 11:12:11AM -0700, Stephen Boyd wrote:
>>
>> Hm... that fixes the shipped part. But now we still reassemble lib1funcs.o.
>>
>>   Kernel: arch/arm/boot/Image is ready
>>   AS      arch/arm/boot/compressed/lib1funcs.o - due to lib1funcs.o not in $(targets)
>>   LD      arch/arm/boot/compressed/vmlinux - due to: arch/arm/boot/compressed/lib1funcs.o
>>   OBJCOPY arch/arm/boot/zImage - due to: arch/arm/boot/compressed/vmlinux
>>   Kernel: arch/arm/boot/zImage is ready
>>
>>
>> Is it correct to add lib1funcs.o to targets?
> Yes - it is a bug this was not done before.
>

Ok. I've also added lib1funcs.S because I assume I want to clean that
out too with make clean.

>
>>  # For __aeabi_uidivmod
>>  lib1funcs = $(obj)/lib1funcs.o
> While touching the file I would kill this assignment - it confused me.

Sure. I've expanded $(lib1funcs) into $(obj)/lib1funcs.o in the vmlinux
rule.

>>  
>> -$(obj)/lib1funcs.S: $(srctree)/arch/$(SRCARCH)/lib/lib1funcs.S FORCE
>> +$(obj)/lib1funcs.S: $(srctree)/arch/$(SRCARCH)/lib/lib1funcs.S
>>         $(call cmd,shipped)
>>  
>>  # We need to prevent any GOTOFF relocs being used with references
> If you prepare a patch with the changes then you can add my "Acked-by".
>

Thanks will do.

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
