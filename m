From: julien.thierry@arm.com (Julien Thierry)
Date: Tue, 14 Aug 2018 09:33:52 +0100
Subject: [PATCH 1/3] arm64: implement ftrace with regs
In-Reply-To: <20180813220315.6e8dfc9c@vmware.local.home>
References: <20180810160043.9E45568C76@newverein.lst.de>
 <20180810160223.D360D68C76@newverein.lst.de>
 <2b5c1092-2cc0-00ec-ba3d-341dc61452b4@arm.com>
 <20180813220315.6e8dfc9c@vmware.local.home>
Message-ID: <a19d9e23-3dfa-ba9b-a177-cdc0d1035964@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 14/08/18 03:03, Steven Rostedt wrote:
> On Mon, 13 Aug 2018 11:54:06 +0100
> Julien Thierry <julien.thierry@arm.com> wrote:
> 
>>> --- a/arch/arm64/Makefile
>>> +++ b/arch/arm64/Makefile
>>> @@ -78,6 +78,15 @@ ifeq ($(CONFIG_ARM64_MODULE_PLTS),y)
>>>    KBUILD_LDFLAGS_MODULE	+= -T $(srctree)/arch/arm64/kernel/module.lds
>>>    endif
>>>    
>>> +ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
>>> +  CC_FLAGS_FTRACE := -fpatchable-function-entry=2
>>> +  KBUILD_CPPFLAGS += -DCC_USING_PATCHABLE_FUNCTION_ENTRY
>>> +  ifeq ($(call cc-option,-fpatchable-function-entry=2),)
>>> +    $(warning Cannot use CONFIG_DYNAMIC_FTRACE_WITH_REGS: \
>>> +             -fpatchable-function-entry not supported by compiler)
>>
>> Shouldn't this be an error? The option -fpatchable-function-entry has
>> been added to the CC_FLAGS_FTRACE, so any call to the compiler is gonna
>> break anyway. Or am I missing something?
> 
> I'm guessing this adds a more informative message on that error. One
> will know why -fpatchable-function-entry was added to the CFLAGS. I'm
> for more informative error messages being a victim of poor error
> messages causing me to dig deep into the guts of the build
> infrastructure to figure out simple issues.
> 

Yes, I agree it is better to have this message. My point was that we 
could have "$error" instead of "$warning" to stop the compilation right 
away since we know everything is gonna break (and on parallel builds 
this warning is gonna be drowned in compiler errors).

-- 
Julien Thierry
